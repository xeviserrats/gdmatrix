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
package org.santfeliu.matrix.client;

import java.awt.Desktop;
import java.awt.Image;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.ConnectException;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URL;
import java.text.MessageFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.ResourceBundle;
import java.util.UUID;
import java.util.logging.FileHandler;
import java.util.logging.Handler;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.logging.SimpleFormatter;
import javax.imageio.ImageIO;
import javax.swing.SwingUtilities;
import javax.swing.UIManager;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import static org.santfeliu.matrix.client.Command.COMMAND;
import org.santfeliu.matrix.client.ui.util.SelectItem;
import org.santfeliu.util.IOUtils;
import org.santfeliu.util.TextUtils;

/**
 *
 * @author realor
 */
public class MatrixClient extends javax.swing.JFrame
{
  public static final String CLIENT_VERSION_HEADER = "CVERSION";
  public static final String CLIENT_SESSION_HEADER = "CSESSIONID";
  public static final String MATRIX_PROTOCOL = "matrix://";
  private static final ResourceBundle bundle = ResourceBundle.getBundle(
    "org/santfeliu/matrix/client/ui/resources/MatrixClient");
  private String clientId;
  private List<String> knownHosts;
  private String servletUrl = "http://localhost/commands";
  private String updateUrl = "http://localhost/matrix-client/update.html";
  private Thread thread;
  private float version = 0;
  private long inactionTimeout = 300; //default timeout in seconds
  private boolean end;
  private Properties setupProperties;
  private final HashMap runningCommands = new HashMap();
  private long lastCommandTime;
  private boolean setupComplete = false;
  private boolean minimize = false;

  /**
   * Creates new form MatrixClient
   */
  public MatrixClient()
  {
    this(null);
  }

  public MatrixClient(String configURL)
  {
    initLogger();
    initComponents();
    loadSetup(configURL);
  }

  private void initLogger()
  {
    try
    {
      File dir = new File("logs");
      if (!dir.exists())
        dir.mkdir();
      SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
      String today = df.format(new Date());
      Handler handler = new FileHandler("logs/" + today + ".log", true);
      handler.setFormatter(new SimpleFormatter());
      Logger logger = Logger.getLogger("");
      logger.addHandler(handler);
    }
    catch (Exception ex)
    {
      ex.printStackTrace();
    }
  }

  private void loadSetup(String configURL)
  {
    Logger.getLogger(getClass().getName()).info("Trying setup file " + configURL);
    Image iconImage = null;
    try
    {
      //clientId, version & hosts properties
      loadClientProperties();
      if (knownHosts == null) knownHosts = new ArrayList();
      else
      {
        hostsComboBox.removeAllItems();

        for (String hostname : knownHosts)
        {
          SelectItem item = new SelectItem(hostname, getHostname(hostname));
          hostsComboBox.addItem(item);
        }
        if (hostsComboBox.getItemCount() > 1)
          hostsComboBox.setVisible(true);
      }

      //config file properties
      setupProperties = new Properties();
      if (configURL != null)
      {
        int index = configURL.lastIndexOf("?show");
        if (index != -1)
        {
          configURL = configURL.substring(0, index);
        }
        else
        {
          minimize = clientId != null;
        }
      }

      InputStream is;
      if (configURL != null && !configURL.startsWith(MATRIX_PROTOCOL))
        is = new FileInputStream(configURL);
      else
      {
        is = getClass().getResourceAsStream("conf/setup.properties");
      }

      if (is != null)
      {
        try
        {
          setupProperties.load(is);
        }
        finally
        {
          is.close();
        }
        String url;
        if (configURL != null && configURL.startsWith(MATRIX_PROTOCOL) &&
            configURL.length() > MATRIX_PROTOCOL.length() + 1) //avoid '/' separator
        {
          servletUrl = configURL.substring(MATRIX_PROTOCOL.length());
        }
        else
        {
          url = setupProperties.getProperty("servletUrl");
          if (url != null)
          {
            servletUrl = url;
          }
        }

        if (!knownHosts.contains(servletUrl))
        {
          //Add to combo
          SelectItem item = new SelectItem(servletUrl, getHostname(servletUrl));
          hostsComboBox.addItem(item);
          //Store to file
          knownHosts.add(servletUrl);
          saveClientProperties();
        }
        hostsComboBox.setSelectedItem(
          new SelectItem(servletUrl, getHostname(servletUrl)));

        url = setupProperties.getProperty("updateUrl");
        if (url != null)
        {
          updateUrl = url;
        }
        String title = setupProperties.getProperty("title");
        if (title != null)
        {
          setTitle(title);
        }

        String timeout = setupProperties.getProperty("inactionTimeout");
        if (timeout != null)
        {
          inactionTimeout = Long.valueOf(timeout);
        }

        String trustStore = setupProperties.getProperty("trustStoreFile");
        if (trustStore != null)
        {
          File trustStoreFile = new File(trustStore);
          if (!trustStoreFile.exists())
          {
            InputStream tis = getClass().getResourceAsStream("conf/truststore.jks");
            if (tis != null)
              IOUtils.writeToFile(tis, trustStoreFile);
          }

          if (trustStoreFile.exists())
          {
            System.setProperty("javax.net.ssl.trustStore",
              trustStoreFile.getAbsolutePath());

            String password = setupProperties.getProperty("trustStorePassword");
            if (password != null)
            {
              System.setProperty("javax.net.ssl.trustStorePassword", password);
            }
          }
        }

        String value = setupProperties.getProperty("version");
        if (value != null)
        {
          version = Float.parseFloat(value);
          String pattern = bundle.getString("VERSION");
          versionLabel.setText(MessageFormat.format(pattern, 
            String.valueOf(version)));
        }
      }
      if (iconImage == null)
      {
        try
        {
          iconImage = ImageIO.read(getClass().getResourceAsStream(
          "conf/icon.png"));
        }
        catch (Exception ex)
        {
          if (iconImage == null)
            iconImage = ImageIO.read(getClass().getResourceAsStream(
              "ui/resources/icon.png"));
        }
      }
      setIconImage(iconImage);

      setupComplete = true;
    }
    catch (Exception ex)
    {
      ex.printStackTrace();
      setupComplete = false;
    }
  }

  /**
   * This method is called from within the constructor to initialize the form.
   * WARNING: Do NOT modify this code. The content of this method is always
   * regenerated by the Form Editor.
   */
  @SuppressWarnings("unchecked")
  // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
  private void initComponents()
  {
    java.awt.GridBagConstraints gridBagConstraints;

    statusPanel = new javax.swing.JPanel();
    statusValueLabel = new javax.swing.JLabel();
    hostsComboBox = new javax.swing.JComboBox();
    centerPanel = new javax.swing.JPanel();
    clientIdTextField = new javax.swing.JTextField();
    clientIdLabel = new javax.swing.JLabel();
    buttonsPanel = new javax.swing.JPanel();
    copyClientIdButton = new javax.swing.JButton();
    updateButton = new javax.swing.JButton();
    versionPanel = new javax.swing.JPanel();
    versionLabel = new javax.swing.JLabel();

    setDefaultCloseOperation(javax.swing.WindowConstants.DO_NOTHING_ON_CLOSE);
    setTitle("MatrixClient");
    setMinimumSize(new java.awt.Dimension(400, 100));
    setResizable(false);
    addWindowListener(new java.awt.event.WindowAdapter()
    {
      public void windowClosing(java.awt.event.WindowEvent evt)
      {
        formWindowClosing(evt);
      }
    });

    java.awt.GridBagLayout statusPanelLayout = new java.awt.GridBagLayout();
    statusPanelLayout.rowHeights = new int[] {40};
    statusPanel.setLayout(statusPanelLayout);

    statusValueLabel.setHorizontalAlignment(javax.swing.SwingConstants.LEFT);
    statusValueLabel.setAlignmentX(0.5F);
    statusValueLabel.setHorizontalTextPosition(javax.swing.SwingConstants.LEFT);
    statusValueLabel.setMaximumSize(null);
    statusValueLabel.setMinimumSize(null);
    statusValueLabel.setName(""); // NOI18N
    statusValueLabel.setPreferredSize(null);
    gridBagConstraints = new java.awt.GridBagConstraints();
    gridBagConstraints.gridx = 0;
    gridBagConstraints.gridy = 0;
    gridBagConstraints.ipadx = 10;
    gridBagConstraints.anchor = java.awt.GridBagConstraints.WEST;
    statusPanel.add(statusValueLabel, gridBagConstraints);

    hostsComboBox.setMaximumSize(null);
    hostsComboBox.setMinimumSize(null);
    hostsComboBox.setName(""); // NOI18N
    hostsComboBox.setPreferredSize(null);
    hostsComboBox.addActionListener(new java.awt.event.ActionListener()
    {
      public void actionPerformed(java.awt.event.ActionEvent evt)
      {
        hostsComboBoxActionPerformed(evt);
      }
    });
    gridBagConstraints = new java.awt.GridBagConstraints();
    gridBagConstraints.gridx = 1;
    gridBagConstraints.gridy = 0;
    statusPanel.add(hostsComboBox, gridBagConstraints);
    hostsComboBox.setVisible(false);

    getContentPane().add(statusPanel, java.awt.BorderLayout.NORTH);

    centerPanel.setBorder(javax.swing.BorderFactory.createEmptyBorder(2, 2, 2, 2));
    centerPanel.setLayout(new java.awt.BorderLayout());

    clientIdTextField.setEditable(false);
    clientIdTextField.setBackground(new java.awt.Color(255, 255, 255));
    clientIdTextField.setFont(new java.awt.Font("Monospaced", 0, 16)); // NOI18N
    clientIdTextField.setHorizontalAlignment(javax.swing.JTextField.CENTER);
    clientIdTextField.setMinimumSize(new java.awt.Dimension(300, 40));
    clientIdTextField.setPreferredSize(new java.awt.Dimension(300, 40));
    clientIdTextField.addMouseListener(new java.awt.event.MouseAdapter()
    {
      public void mouseClicked(java.awt.event.MouseEvent evt)
      {
        clientIdTextFieldMouseClicked(evt);
      }
    });
    centerPanel.add(clientIdTextField, java.awt.BorderLayout.CENTER);

    java.util.ResourceBundle bundle = java.util.ResourceBundle.getBundle("org/santfeliu/matrix/client/ui/resources/MatrixClient"); // NOI18N
    clientIdLabel.setText(bundle.getString("CLIENTID")); // NOI18N
    centerPanel.add(clientIdLabel, java.awt.BorderLayout.NORTH);

    buttonsPanel.setBorder(javax.swing.BorderFactory.createEmptyBorder(10, 10, 0, 10));
    buttonsPanel.setLayout(new java.awt.GridLayout(1, 0, 10, 10));

    copyClientIdButton.setIcon(new javax.swing.ImageIcon(getClass().getResource("/org/santfeliu/matrix/client/ui/resources/copy.png"))); // NOI18N
    copyClientIdButton.setText(bundle.getString("COPY_CLIENTID")); // NOI18N
    copyClientIdButton.setMargin(new java.awt.Insets(2, 2, 2, 2));
    copyClientIdButton.addActionListener(new java.awt.event.ActionListener()
    {
      public void actionPerformed(java.awt.event.ActionEvent evt)
      {
        copyClientIdButtonActionPerformed(evt);
      }
    });
    buttonsPanel.add(copyClientIdButton);

    updateButton.setIcon(new javax.swing.ImageIcon(getClass().getResource("/org/santfeliu/matrix/client/ui/resources/setup.png"))); // NOI18N
    updateButton.setText(bundle.getString("UPDATE")); // NOI18N
    updateButton.setMargin(new java.awt.Insets(2, 2, 2, 2));
    updateButton.addActionListener(new java.awt.event.ActionListener()
    {
      public void actionPerformed(java.awt.event.ActionEvent evt)
      {
        updateButtonActionPerformed(evt);
      }
    });
    buttonsPanel.add(updateButton);

    centerPanel.add(buttonsPanel, java.awt.BorderLayout.SOUTH);

    getContentPane().add(centerPanel, java.awt.BorderLayout.CENTER);

    versionPanel.setBorder(javax.swing.BorderFactory.createEmptyBorder(0, 10, 0, 10));
    versionPanel.setLayout(new java.awt.FlowLayout(java.awt.FlowLayout.RIGHT, 1, 1));

    versionLabel.setForeground(new java.awt.Color(102, 102, 102));
    versionLabel.setText("Version");
    versionPanel.add(versionLabel);

    getContentPane().add(versionPanel, java.awt.BorderLayout.PAGE_END);

    pack();
  }// </editor-fold>//GEN-END:initComponents

  private void copyClientIdButtonActionPerformed(java.awt.event.ActionEvent evt)//GEN-FIRST:event_copyClientIdButtonActionPerformed
  {//GEN-HEADEREND:event_copyClientIdButtonActionPerformed
    copyClientId();
  }//GEN-LAST:event_copyClientIdButtonActionPerformed

  private void updateButtonActionPerformed(java.awt.event.ActionEvent evt)//GEN-FIRST:event_updateButtonActionPerformed
  {//GEN-HEADEREND:event_updateButtonActionPerformed
    showUpdatePage();
  }//GEN-LAST:event_updateButtonActionPerformed

  private void formWindowClosing(java.awt.event.WindowEvent evt)//GEN-FIRST:event_formWindowClosing
  {//GEN-HEADEREND:event_formWindowClosing
    setVisible(false);
    stop();
  }//GEN-LAST:event_formWindowClosing

  private void hostsComboBoxActionPerformed(java.awt.event.ActionEvent evt)//GEN-FIRST:event_hostsComboBoxActionPerformed
  {//GEN-HEADEREND:event_hostsComboBoxActionPerformed
    try
    {
      // TODO add your handling code here:
      if (hostsComboBox.getItemCount() > 1 && !hostsComboBox.isVisible())
        hostsComboBox.setVisible(true);

      if (setupComplete) //Only if client setup is complete to avoid change events in combo first load
      {
        String url = ((SelectItem) hostsComboBox.getSelectedItem()).getId();
        if (url != null && !url.equals(servletUrl))
        {
          servletUrl = url;
          restart();
        }
      }
    }
    catch (Exception ex)
    {
      Logger.getLogger(MatrixClient.class.getName()).log(Level.SEVERE, ex.getMessage(), ex);
    }
  }//GEN-LAST:event_hostsComboBoxActionPerformed

  private void clientIdTextFieldMouseClicked(java.awt.event.MouseEvent evt)//GEN-FIRST:event_clientIdTextFieldMouseClicked
  {//GEN-HEADEREND:event_clientIdTextFieldMouseClicked
    if (evt.getClickCount() == 2)
    {
      copyClientId();
    }
  }//GEN-LAST:event_clientIdTextFieldMouseClicked

  private void copyClientId()
  {
    clientIdTextField.requestFocus();
    clientIdTextField.selectAll();
    clientIdTextField.copy();
  }

  public String getClientId()
  {
    return clientId;
  }

  public void setClientId(String clientId)
  {
    this.clientId = clientId;
  }

  public String getServletUrl()
  {
    return servletUrl;
  }

  public void setServletUrl(String servletUrl)
  {
    this.servletUrl = servletUrl;
  }

  public void start()
  {
    if (thread == null)
    {
      thread = new Thread(new Runnable()
      {
        @Override
        public void run()
        {
          loop();
        }
      });
      thread.start();
    }
  }

  public void restart()
  {
    if (thread != null)
    {
      thread.interrupt();
    }
    thread = null;
    start();
  }

  public void stop()
  {
    end = true;
    Logger.getLogger(getClass().getName()).info("Closing client...");
    try
    {
      disconnect();
      Logger.getLogger(getClass().getName()).info("Done.");
    }
    catch (Exception ex)
    {
    }
    finally
    {
      System.exit(0);
    }    
  }

  private void loadClientProperties()
  {
    try
    {
      Properties properties = new Properties();
      File clientFile = getClientFile();
      if (clientFile.exists())
      {
        FileInputStream is = new FileInputStream(clientFile);
        try
        {
          properties.load(is);
          clientId = properties.getProperty("clientId");
          String hosts = properties.getProperty("hosts");
          knownHosts = TextUtils.stringToList(hosts, ",");
        }
        finally
        {
          is.close();
        }
      }
    }
    catch (Exception ex)
    {
    }
  }

  private void saveClientProperties()
  {
    try
    {
      Properties properties = new Properties();
      File clientFile = getClientFile();
      FileOutputStream os = new FileOutputStream(clientFile);
      try
      {
        properties.setProperty("clientId", clientId);
        properties.setProperty("hosts", TextUtils.collectionToString(knownHosts));
        properties.store(os, "MatrixClient");
      }
      finally
      {
        os.close();
      }
    }
    catch (Exception ex)
    {
    }
  }

  public void loop()
  {
    Logger.getLogger(getClass().getName()).info("Started");
    try
    {
      if (clientId == null)
      {
        Logger.getLogger(getClass().getName()).info("Generating clientId...");
        clientId = UUID.randomUUID().toString();
        saveClientProperties();
        Logger.getLogger(getClass().getName()).info("Registering clientId...");
      };
      updateClientId();
      lastCommandTime = System.currentTimeMillis();
      boolean connected = false;
      while (!end)
      {
        try
        {
          if (!connected)
          {
            updateStatus(bundle.getString("CONNECTING_STATE") +
              (!hostsComboBox.isVisible() ? " " + getHostname(servletUrl) : ""));
            Logger.getLogger(getClass().getName()).info("connecting " + servletUrl + "...");
            Map properties = connect();
            if (isOldClient(properties))
            {
              showUpdatePage();
              stop();
            }
            connected = true;
            updateStatus(bundle.getString("CONNECTED_STATE") +
              (!hostsComboBox.isVisible() ? " " + getHostname(servletUrl) : ""));
            if (minimize) setState(java.awt.Frame.ICONIFIED);
          }

          Logger.getLogger(getClass().getName()).info("readNextCommandParameters "
            + Thread.currentThread().getId() + "] "
            + runningCommands.size() + " "
            + (System.currentTimeMillis() - lastCommandTime));

          Map properties = readNextCommandProperties();
          String commandClassName = (String)properties.get(COMMAND);
          if (commandClassName != null)
          {
            Class<Command> commandClass =
              (Class<Command>)Class.forName(commandClassName);
            Command command = commandClass.newInstance();
            command.setClient(this);
            command.getProperties().putAll(properties);
            String commandProperty = setupProperties.getProperty(commandClassName);
            if (commandProperty != null)
            {
              JSONParser jsonParser = new JSONParser();
              command.getProperties().putAll((Map)jsonParser.parse(commandProperty));
            }

            Logger.getLogger(getClass().getName()).info("Execute " + commandClassName);
            command.execute(); // start thread
            runningCommands.put(command.getId(), command);
          }
        }
        catch (ConnectException ex)
        {
          connected = false;
          Logger.getLogger(getClass().getName()).info("Disconnected");
          updateStatus(bundle.getString("DISCONNECTED_STATE"));
          Thread.sleep(10000);
        }
        catch (Exception ex)
        {
          Logger.getLogger(getClass().getName()).severe(ex.toString());
          Thread.sleep(10000);
        }

        if (runningCommands.isEmpty() &&
          (System.currentTimeMillis() - lastCommandTime > (inactionTimeout * 1000)))
        {
          Logger.getLogger(getClass().getName()).info("Closing by inaction timeout");
          stop();
        } //Inaction timeout

        if (Thread.interrupted())
        {
          Logger.getLogger(getClass().getName()).info(
            "Closing abandoned thread " + Thread.currentThread().getId());
          end = true;
        }
      }
    }
    catch (InterruptedException iex)
    {
      Logger.getLogger(getClass().getName()).info(
        "Sleep interrupted to change connecting host");
    }
    catch (Exception ex)
    {
      Logger.getLogger(getClass().getName()).severe(ex.toString());
    }
  }

  public void showUpdatePage()
  {
    try
    {
      Desktop desktop = Desktop.getDesktop();
      desktop.browse(new URI(updateUrl + "?version=" + version));
    }
    catch (Exception ex)
    {
    }
  }

  public void updateClientId()
  {
    SwingUtilities.invokeLater(new Runnable()
    {
      public void run()
      {
        clientIdTextField.setText(clientId);
      }
    });
  }

  public void updateStatus(final String status)
  {
    SwingUtilities.invokeLater(new Runnable()
    {
      public void run()
      {
        statusValueLabel.setText(status);
      }
    });
  }

  public Map connect() throws Exception
  {
    return getData("GET", "");
  }

  public Map readNextCommandProperties() throws Exception
  {
    return getData("GET", "clientid=" + clientId);
  }

  public void terminateCommand(Map properties) throws Exception
  {
    Logger.getLogger(getClass().getName()).info("Terminate command");
    String commandId = (String) properties.get("commandId");
    runningCommands.remove(commandId);
    lastCommandTime = System.currentTimeMillis();
    sendData("POST", properties);
  }

  private Map disconnect() throws Exception
  {
    return getData("DELETE", "clientid=" + clientId);
  }

  private Map getData(String method, String parameters) throws Exception
  {
    URL url = new URL(servletUrl + "?" + parameters);
    HttpURLConnection conn = (HttpURLConnection)url.openConnection();
    conn.setRequestMethod(method);
    setRequestProperties(conn);
    conn.connect();
    InputStreamReader reader =
      new InputStreamReader(conn.getInputStream(), "UTF-8");
    try
    {
      JSONParser parser = new JSONParser();
      return (Map)parser.parse(reader);
    }
    finally
    {
      reader.close();
    }
  }

  private boolean isOldClient(Map properties)
  {
    boolean old = false;
    String value = (String)properties.get("minClientVersion");
    if (value != null)
    {
      float minVersion = Float.parseFloat(value);
      old = minVersion > version;
    }
    return old;
  }
  
  private Map sendData(String method, Map properties)
    throws Exception
  {
    Map result = null;
    String json = JSONObject.toJSONString(properties);

    URL url = new URL(servletUrl);
    HttpURLConnection conn = (HttpURLConnection)url.openConnection();
    conn.setRequestMethod(method);
    setRequestProperties(conn);
    conn.setRequestProperty("Content-Type", "application/json;charset=UTF-8");
    conn.setDoOutput(true);
    conn.setDoInput(true);

    OutputStream os = conn.getOutputStream();
    os.write(json.getBytes("UTF-8"));
    os.flush();
    os.close();

    int responseCode = conn.getResponseCode();
    if (responseCode == 200)
    {
      BufferedReader reader = new BufferedReader(
        new InputStreamReader(conn.getInputStream()));
      StringBuilder buffer = new StringBuilder();
      String line = reader.readLine();
      while (line != null)
      {
        buffer.append(line);
        line = reader.readLine();
      }
      JSONParser parser = new JSONParser();
      result = (Map)parser.parse(buffer.toString());
      reader.close();
      conn.disconnect();
    }
    return result;
  }

  private void setRequestProperties(HttpURLConnection conn)
  {
    conn.setRequestProperty(CLIENT_VERSION_HEADER, String.valueOf(version));
    if (clientId != null)
    {
      conn.setRequestProperty(CLIENT_SESSION_HEADER, clientId);
    }
  }

  public File getBaseDir()
  {
    String userHome = System.getProperty("user.home");
    File dir = new File(userHome + "/.matrix");
    if (!dir.exists())
    {
      dir.mkdirs();
    }
    return dir;
  }

  public File getClientFile()
  {
    return new File(getBaseDir(), "client.properties");
  }

//  private void checkNewRelease() throws IOException
//  {
//    boolean isNewVersion = false;
//
//    if (downloadUrl != null)
//    {
//      Properties release = new Properties();
//      URL url = new URL(downloadUrl + "/release.properties");
//      HttpURLConnection conn = (HttpURLConnection)url.openConnection();
//      conn.setRequestMethod("GET");
//      writeSessionId(conn);
//      conn.connect();
//      InputStream is = conn.getInputStream();
//      try
//      {
//        release.load(is);
//        String date = (String) release.get("date");
//        String type = (String) release.get("type");
//        isNewVersion = (date != null && date.compareTo(this.release) > 0);
//      }
//      finally
//      {
//        is.close();
//      }
//    }
//
//    if (isNewVersion)
//    {
//      // html content
//      String downloadMessage = bundle.getString("DOWNLOAD_MESSAGE");
//      downloadMessage = MessageFormat.format(downloadMessage, getTitle());
//
//      // show
//      int option = JOptionPane.showConfirmDialog(null, downloadMessage,
//        getTitle(), JOptionPane.YES_NO_OPTION);
//      if (option == JOptionPane.YES_OPTION)
//      {
//        try
//        {
//          //Execute updater
//          Runtime.getRuntime()
//            .exec("java -cp lib/matrix-client-updater.jar org.santfeliu.matrix.client.updater.MatrixClientUpdater " + downloadUrl);
//          Logger.getLogger(MatrixClient.class.getName()).info("Launching updater");
//          Thread.sleep(1000);
//        }
//        catch (Exception ex)
//        {
//          JOptionPane.showMessageDialog(null, ex.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
//          Logger.getLogger(MatrixClient.class.getName()).severe(ex.getMessage());
//        }
//        finally
//        {
//          Logger.getLogger(MatrixClient.class.getName()).info("Closing client to update");
//          System.exit(0);
//        }
//      }
//    }
//  }

  private String getHostname(String url)
  {
    String protocol = null;

    if (url != null && (url.indexOf("https://") > 0 || url.startsWith("https://")))
      protocol = "https";
    else if (url != null && (url.indexOf("http://") > 0 || url.startsWith("http://")))
      protocol = "http";

    String host = url;
    if (protocol != null)
    {
      host = url.replace(protocol + "://", "");
      host = host.substring(0, host.indexOf("/"));
    }
    return host;
  }
  
  class InvalidClientException extends Exception
  {
  }

  /**
   * @param args the command line arguments
   */
  public static void main(String args[])
  {
    try
    {
      UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
    }
    catch (Exception ex)
    {
    }

    final String configURL = args.length > 0 ? args[0] : null;
    java.awt.EventQueue.invokeLater(new Runnable()
    {
      @Override
      public void run()
      {
        MatrixClient client = new MatrixClient(configURL);
        client.start();
        client.pack();
        client.setLocationRelativeTo(null);
        client.setVisible(true);
      }
    });
  }

  // Variables declaration - do not modify//GEN-BEGIN:variables
  private javax.swing.JPanel buttonsPanel;
  private javax.swing.JPanel centerPanel;
  private javax.swing.JLabel clientIdLabel;
  private javax.swing.JTextField clientIdTextField;
  private javax.swing.JButton copyClientIdButton;
  private javax.swing.JComboBox hostsComboBox;
  private javax.swing.JPanel statusPanel;
  private javax.swing.JLabel statusValueLabel;
  private javax.swing.JButton updateButton;
  private javax.swing.JLabel versionLabel;
  private javax.swing.JPanel versionPanel;
  // End of variables declaration//GEN-END:variables
}
