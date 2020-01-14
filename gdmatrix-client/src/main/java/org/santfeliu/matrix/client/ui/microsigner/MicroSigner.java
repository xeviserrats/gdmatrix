/*
 * GDMatrix
 *  
 * Copyright (C) 2020, Ajuntament de Sant Feliu de Llobregat
 *  
 * This program is licensed and may be used, modified and redistributed under 
 * the terms of the European Public License (EUPL), either version 1.1 or (at 
 * your option) any later version as soon as they are approved by the European 
 * Commission.
 *  
 * Alternatively, you may redistribute and/or modify this program under the 
 * terms of the GNU Lesser General Public License as published by the Free 
 * Software Foundation; either  version 3 of the License, or (at your option) 
 * any later version. 
 *   
 * Unless required by applicable law or agreed to in writing, software 
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT 
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 
 *    
 * See the licenses for the specific language governing permissions, limitations 
 * and more details.
 *    
 * You should have received a copy of the EUPL1.1 and the LGPLv3 licenses along 
 * with this program; if not, you may find them at: 
 *    
 * https://joinup.ec.europa.eu/software/page/eupl/licence-eupl
 * http://www.gnu.org/licenses/ 
 * and 
 * https://www.gnu.org/licenses/lgpl.txt
 */
package org.santfeliu.matrix.client.ui.microsigner;

import java.awt.BorderLayout;
import java.awt.Cursor;
import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.security.KeyStore;
import java.security.PrivateKey;
import java.security.Provider;
import java.security.Security;
import java.security.Signature;
import java.security.cert.X509Certificate;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Locale;
import java.util.MissingResourceException;
import java.util.ResourceBundle;
import java.util.logging.Logger;
import javax.imageio.ImageIO;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.SwingUtilities;
import javax.swing.UIManager;
import javax.swing.tree.DefaultMutableTreeNode;

/**
 *
 * @author unknown
 */
public class MicroSigner extends JFrame
{
  public static final String TITLE = "MicroSigner";
  public static final String VERSION = "1.4";
  public static final String CREDITS =
    "Copyright (c) 2017. Ajuntament de Sant Feliu de Llobregat";

  public static final String CONFIG_KEY = "CONFIG";
  public static final String KEYSTORE_TAG = "KEYSTORE";
  public static final String END_TAG = "END";

  public static final String ERROR_PREFIX = "ERROR: ";

  // must be static to prevent provider reloading
  private static final HashMap providers = new HashMap();
  static private ResourceBundle bundle;

  // swing elements
  private BorderLayout borderLayout = new BorderLayout();
  private MainPanel mainPanel;
  private JPanel buttonsPanel;
  private JButton signButton;
  private JButton cancelButton;
  private SignatureServletClient sigClient = new SignatureServletClient();
  private boolean end = false;

  // signatute properties;
  private String sigId;
  private String signatureServletUrl;
  private CertificateNode certificateNode;
  private byte[] dataToSign;
  private char[] password;
  private byte[] signatureData;
  private String signResult;
  private Exception swingException;

  public MicroSigner()
  {
    init();
  }

  public static void main(String[] args)
  {
    try
    {
      // set native look and feel
      UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
    }
    catch (Exception ex)
    {
      // ignore
    }

    SwingUtilities.invokeLater(new Runnable()
    {
      public void run()
      {
        MicroSigner microSigner = new MicroSigner();
        microSigner.setSize(600, 300);
        microSigner.setLocationRelativeTo(null);
        microSigner.setVisible(true);
      }
    });
  }

  private void init()
  {
    try
    {
      Locale locale = null;
      String language = null;
      if (language == null) locale = Locale.getDefault();
      else locale = new Locale(language);

      bundle = ResourceBundle.getBundle(
        "org.santfeliu.matrix.client.ui.microsigner.resources.MicroSignerBundle", locale);

      // setup components
      jbInit();

      // load configuration
      if (!loadConfiguration())
      {
        // if no config exists then autoSetup
        autoSetup();
      }
      Logger.getLogger(getClass().getName()).info("done.");
    }
    catch (Throwable t)
    {
      t.printStackTrace();
    }
  }

  // signature methods

  public void setSigId(String sigId)
  {
    this.sigId = sigId;
  }

  public String getSigId()
  {
    return sigId;
  }

  public String getSignatureServletUrl()
  {
    return signatureServletUrl;
  }

  public void setSignatureServletUrl(String signatureServletUrl)
  {
    this.signatureServletUrl = signatureServletUrl;
  }

  public void showFrame()
  {
    addWindowListener(new WindowAdapter()
    {
      @Override
      public void windowActivated(WindowEvent e)
      {
        setAlwaysOnTop(false);
      }
    });
    setLocationRelativeTo(null);
    setVisible(true);
    setAlwaysOnTop(true);
  }
  
  public void signDocument()
  {
    sigClient.setTargetEndPointAddress(signatureServletUrl);

    this.certificateNode = null;
    this.dataToSign = null;
    this.password = null;
    this.signResult = "";

    Thread workThread = new Thread(new Runnable()
    {
      public void run()
      {
        doSignatureProcess();
      }
    });
    workThread.start();
  }

  public synchronized void terminate() // ET
  {
    mainPanel.setEnableInputs(true);
    mainPanel.stopSignature();
    setCursor(Cursor.getDefaultCursor());
    setVisible(false);
    end = true;
    dispose();
    notify();
  }

  public String getSignResult()
  {
    return signResult;
  }

  public synchronized void waitForTermination()
  {
    while (!end)
    {
      try
      {
        wait();
      }
      catch (InterruptedException ex)
      {
      }
    }
  }

  // private methods

  private void autoSetup() throws Throwable
  {
    // autosetup in Windows
    if (System.getProperty("os.name").contains("Windows"))
    {
      String providerClassName = "be.cardon.cryptoapi.provider.CryptoAPIProvider";
      String ksType = "CryptoAPI";
      String ksPath = null;
      String ksPassword = null;
      KeyStoreNode ksNode = loadKeyStore(providerClassName, ksType,
                                         ksPath, ksPassword, null);
      mainPanel.addKeyStoreNode(ksNode);
    }
    else
    {
      mainPanel.setInfo(getLocalizedText("SetupKeyStore"));
    }
  }

  private File getConfigFile()
  {
    String userDir = System.getProperty("user.home");
    if (userDir == null) return null;
    return new File(userDir + "/MicroSigner.cfg");
  }

  public boolean loadConfiguration() throws Throwable
  {
    File file = getConfigFile();
    if (file == null || !file.exists()) return false;

    Logger.getLogger(getClass().getName()).info("loading configuration...");
    InputStream is = new FileInputStream(file);
    if (is == null) return false;

    ObjectInputStream ois = new ObjectInputStream(is);
    String tag = String.valueOf(ois.readObject());
    while (!tag.equals(END_TAG))
    {
      Logger.getLogger(getClass().getName()).info("tag: " + tag);
      if (tag.equals(KEYSTORE_TAG))
      {
        String provClassName = (String)ois.readObject();
        String ksType = (String)ois.readObject();
        String ksPath = (String)ois.readObject();
        String ksPassword = (String)ois.readObject();
        try
        {
          KeyStoreNode ksNode = loadKeyStore(provClassName, ksType,
                                             ksPath, ksPassword, null);
          mainPanel.addKeyStoreNode(ksNode);
        }
        catch (Throwable t)
        {
          Logger.getLogger(getClass().getName()).info(t.getMessage());
        }
      }
      else throw new IOException("Invalid tag");
      tag = String.valueOf(ois.readObject());
    }
    ois.close();
    return true;
  }

  public void saveConfiguration() throws Exception
  {
    File file = getConfigFile();
    if (file == null) return;

    Logger.getLogger(getClass().getName()).info("saving configuration...");
    OutputStream os = new FileOutputStream(file);
    ObjectOutputStream oos = new ObjectOutputStream(os);
    DefaultMutableTreeNode root = mainPanel.getRoot();
    int numKeyStores = root.getChildCount();
    for (int i = 0; i < numKeyStores; i++)
    {
      KeyStoreNode ksNode = (KeyStoreNode)root.getChildAt(i);
      String provClassName = ksNode.getProviderClassName();
      String ksType = ksNode.getKeyStoreType();
      String ksPath = ksNode.getKeyStorePath();
      String ksPassword = ksNode.getKeyStorePassword();

      oos.writeObject(KEYSTORE_TAG);
      oos.writeObject(provClassName);
      oos.writeObject(ksType);
      oos.writeObject(ksPath);
      oos.writeObject(ksPassword);
    }
    oos.writeObject(END_TAG);
    oos.close();
  }

  private void jbInit() throws Exception
  {
    setTitle("MicroSigner");
    setIconImage(ImageIO.read(getClass().getResource("resources/signature.gif")));
    setPreferredSize(new Dimension(600, 300));
    setSize(new Dimension(600, 300));
    mainPanel = new MainPanel(this);
    buttonsPanel = new JPanel();
    signButton = new JButton(bundle.getString("Sign"));
    cancelButton = new JButton(bundle.getString("Cancel"));
    buttonsPanel.add(signButton);
    signButton.setIcon(new ImageIcon(getClass().getResource("resources/signature.gif")));
    cancelButton.setIcon(new ImageIcon(getClass().getResource("resources/cancel.gif")));
    buttonsPanel.add(cancelButton);
    signButton.addActionListener(new ActionListener()
    {
      @Override
      public void actionPerformed(ActionEvent event)
      {
        signDocument();
        signButton.setEnabled(false);
      }
    });
    cancelButton.addActionListener(new ActionListener()
    {
      @Override
      public void actionPerformed(ActionEvent event)
      {
        signResult = "CANCEL";
        terminate();
      }
    });
    this.addWindowListener(new WindowAdapter()
    {
      @Override
      public void windowClosing(WindowEvent event)
      {
        terminate();
      }
    });
    this.getContentPane().setLayout(borderLayout);
    this.getContentPane().add(mainPanel, BorderLayout.CENTER);
    this.getContentPane().add(buttonsPanel, BorderLayout.SOUTH);
    this.setDefaultCloseOperation(JFrame.DO_NOTHING_ON_CLOSE);
  }

  private void doSignatureProcess() // WT
  {
    Logger.getLogger(getClass().getName()).info("Signature process: started.");
    try
    {
      selectCertificate(); // ET-wait
      sendCertificate();
      try
      {
        enterPIN(); // ET-wait
        sign();
        showSignature(); // ET-later
        sendSignature();
      }
      catch (Exception ex)
      {
        abortSignature();
        throw ex;
      }
    }
    catch (Exception ex)
    {
      signResult = ERROR_PREFIX + ex.getLocalizedMessage();
      ex.printStackTrace();
    }
    finally
    {
      close(); // ET-later
    }
    Logger.getLogger(getClass().getName()).info("Signature process: ended.");
  }

  private void selectCertificate() throws Exception // ET-wait
  {
    swingException = null;
    SwingUtilities.invokeAndWait(new Runnable()
    {
      public void run()
      {
        certificateNode = mainPanel.getSelectedCertificateNode();
        if (certificateNode == null)
        {
          swingException =
            new Exception(MicroSigner.getLocalizedText("NoCertSelected"));
        }
        else
        {
          mainPanel.setEnableInputs(false);
          setCursor(Cursor.getPredefinedCursor(Cursor.WAIT_CURSOR));
          String message = MicroSigner.getLocalizedText("ValidatingCertificate");
          mainPanel.showMessage(message);
        }
      }
    });
    if (swingException != null) throw swingException;
  }

  private void sendCertificate() throws Exception // WT
  {
    X509Certificate certificate = certificateNode.getCertificate();
    dataToSign = sigClient.addSignature(sigId, certificate.getEncoded());
  }

  private void enterPIN() throws Exception // ET-wait
  {
    swingException = null;
    SwingUtilities.invokeAndWait(new Runnable()
    {
      public void run()
      {
        String message = MicroSigner.getLocalizedText("EnteringPIN");
        mainPanel.showMessage(message);
        KeyStoreNode keyStoreNode = (KeyStoreNode)certificateNode.getParent();
        password = null;
        boolean cancel = false;
        if (keyStoreNode.isAskForPIN())
        {
          SecretDialog dialog = new SecretDialog(mainPanel.getFrame());
          dialog.setText(MicroSigner.getLocalizedText("EnterPIN"));
          dialog.setLocationRelativeTo(mainPanel);
          dialog.setVisible(true);
          String PIN = dialog.getSecret();
          if (PIN != null)
          {
            password = PIN.toCharArray();
          }
          else cancel = true;
        }
        if (cancel)
        {
          swingException =
            new Exception(MicroSigner.getLocalizedText("PINNotEntered"));
        }
        else
        {
          message = MicroSigner.getLocalizedText("Signing");
          mainPanel.showMessage(message);
        }
      }
    });
    if (swingException != null) throw swingException;
  }

  private void sign() throws Exception // WT
  {
    KeyStoreNode keyStoreNode = (KeyStoreNode)certificateNode.getParent();
    KeyStore keyStore = keyStoreNode.getKeyStore();
    String alias = certificateNode.getAlias();    
    Signature signature = 
      Signature.getInstance("SHA1withRSA", keyStore.getProvider());
    signature.initSign((PrivateKey)keyStore.getKey(alias, password));
    signature.update(dataToSign);
    signatureData = signature.sign();
  }

  private void showSignature() // ET-later
  {
    SwingUtilities.invokeLater(new Runnable()
    {
      public void run()
      {
        mainPanel.showSignature(
          certificateNode.getCertificate(), signatureData);
      }
    });
  }

  private void sendSignature() throws Exception // WT
  {
    signResult = sigClient.endSignature(sigId, signatureData);
  }

  private void abortSignature() throws Exception // WT
  {
    Logger.getLogger(getClass().getName()).info("aborting signature...");
    sigClient.abortSignature(sigId);
    Logger.getLogger(getClass().getName()).info("done.");
  }

  private void close() // ET-later
  {
    SwingUtilities.invokeLater(new Runnable()
    {
      public void run()
      {
        terminate();
      }
    });
  }

  //******************************************************************

  public static KeyStoreNode loadKeyStore(String provClassName,
                                          String ksType,
                                          String ksPath,
                                          String ksPassword,
                                          KeyStoreNode ksNode) throws Throwable
  {
    // load provider
    Provider provider = null;
    KeyStore keyStore = null;
    char[] password = (ksPassword == null || ksPassword.length() == 0) ?
       null : ksPassword.toCharArray();
    if (ksPath != null && ksPath.trim().length() == 0) ksPath = null;

    provider = loadProvider(provClassName);
    InputStream is = (ksPath == null) ? null : new FileInputStream(ksPath);

    // install provider
    String providerName = provider.getName();
    Security.removeProvider(providerName);
    Security.insertProviderAt(provider, 1);

    // create a KeyStore
    keyStore = KeyStore.getInstance(ksType, provider);

    // load KeyStore
    keyStore.load(is, password);

    if (ksNode == null) ksNode = new KeyStoreNode();
    ksNode.setKeyStore(keyStore);
    ksNode.setKeyStorePath(ksPath);
    Logger.getLogger(MicroSigner.class.getName()).info("Provider: " + providerName);
    ksNode.setAskForPIN(
     !(providerName.equals("assembla") ||
       providerName.equals("SunMSCAPI") ||
       providerName.equals("MicrosoftCryptoAPIBridge")));

    if (password != null)
      ksNode.setKeyStorePassword(String.valueOf(password));

    loadCertificates(ksNode);

    return ksNode;
  }

  public static void loadCertificates(KeyStoreNode ksNode) throws Exception
  {
    ksNode.removeAllChildren();
    KeyStore keyStore = ksNode.getKeyStore();
    if (keyStore != null)
    {
      Enumeration enu = keyStore.aliases();
      while (enu.hasMoreElements())
      {
        String alias = (String)enu.nextElement();
        if (keyStore.isKeyEntry(alias))
        {
          X509Certificate cert =
            (X509Certificate)keyStore.getCertificate(alias);
          if (cert != null)
          {
            boolean[] usage = cert.getKeyUsage();
            if (usage == null || usage[0]) //digital signature;
            {
              CertificateNode certNode = new CertificateNode();
              certNode.setAlias(alias);
              certNode.setCertificate(cert);
              ksNode.add(certNode);
            }
          }
        }
      }
    }
  }

  public static Provider loadProvider(String provClassName) throws Throwable
  {
    Provider provider = (Provider)providers.get(provClassName);
    if (provider != null) return provider;

    try
    {
      Logger.getLogger(MicroSigner.class.getName()).info("Loading class " + provClassName);
      provider = (Provider)Class.forName(provClassName).newInstance();
      Logger.getLogger(MicroSigner.class.getName()).info(provider.toString());
    }
    finally
    {
      if (provider != null) providers.put(provClassName, provider);
    }
    return provider;
  }

  public static String getLocalizedText(Throwable t)
  {
    String value = null;
    try
    {
      value = bundle.getString(t.getMessage());
    }
    catch (MissingResourceException ex)
    {
      value = t.toString();
    }
    return value;
  }

  public static String getLocalizedText(String key)
  {
    String value = null;
    try
    {
      value = bundle.getString(key);
    }
    catch (MissingResourceException ex)
    {
      value = key;
    }
    return value;
  }
}
