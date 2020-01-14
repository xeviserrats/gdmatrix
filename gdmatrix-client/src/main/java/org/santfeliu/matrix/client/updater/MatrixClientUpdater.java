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
package org.santfeliu.matrix.client.updater;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Logger;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JProgressBar;
import javax.swing.UIManager;

/**
 *
 * @author blanquepa
 */
public class MatrixClientUpdater extends javax.swing.JFrame
{
  private static final java.util.ResourceBundle bundle = 
    java.util.ResourceBundle.getBundle("org/santfeliu/matrix/client/updater/MatrixClientUpdater");

  /**
   * Creates new form Updater
   */
  public MatrixClientUpdater()
  {
    initComponents();
  }
  
  public MatrixClientUpdater(int steps)
  {
    this();
    progressBar.setMinimum(0);
    progressBar.setMaximum(steps);
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

    progressBar = new javax.swing.JProgressBar();
    label = new javax.swing.JLabel();

    setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
    setUndecorated(true);

    java.util.ResourceBundle bundle = java.util.ResourceBundle.getBundle("org/santfeliu/matrix/client/updater/MatrixClientUpdater"); // NOI18N
    label.setText(bundle.getString("MatrixClientUpdater.label.text")); // NOI18N

    javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
    getContentPane().setLayout(layout);
    layout.setHorizontalGroup(
      layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
      .addGroup(layout.createSequentialGroup()
        .addContainerGap()
        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
          .addComponent(progressBar, javax.swing.GroupLayout.DEFAULT_SIZE, 380, Short.MAX_VALUE)
          .addComponent(label, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        .addContainerGap())
    );
    layout.setVerticalGroup(
      layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
      .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
        .addContainerGap()
        .addComponent(label)
        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
        .addComponent(progressBar, javax.swing.GroupLayout.PREFERRED_SIZE, 27, javax.swing.GroupLayout.PREFERRED_SIZE)
        .addContainerGap())
    );

    label.getAccessibleContext().setAccessibleName(bundle.getString("MatrixClientUpdater.label.AccessibleContext.accessibleName")); // NOI18N

    pack();
  }// </editor-fold>//GEN-END:initComponents

  public void updateBar(String text, int newValue) 
  {
    label.setText(text);
    progressBar.setValue(newValue);
  }
  
  public void updateBar(String text)
  {
    updateBar(text, progressBar.getValue() + 1);
  }
  
  public JLabel getLabel()
  {
    return label;
  }

  public void setLabel(JLabel label)
  {
    this.label = label;
  }
  
  public void setText(String text)
  {
    this.label.setText(text);
  }

  public JProgressBar getProgressBar()
  {
    return progressBar;
  }

  public void setProgressBar(JProgressBar progressBar)
  {
    this.progressBar = progressBar;
  }

  public void downloadFile(String fileURL, String saveDir, String destFile)
    throws IOException
  {
    URL url = new URL(fileURL);
    HttpURLConnection httpConn = (HttpURLConnection) url.openConnection();
    int responseCode = httpConn.getResponseCode();

    // always check HTTP response code first
    if (responseCode == HttpURLConnection.HTTP_OK)
    {
      String fileName = "";
      String disposition = httpConn.getHeaderField("Content-Disposition");
      String contentType = httpConn.getContentType();
      int contentLength = httpConn.getContentLength();

      if (disposition != null)
      {
        // extracts file name from header field
        int index = disposition.indexOf("filename=");
        if (index > 0)
        {
          fileName = disposition.substring(index + 10,
            disposition.length() - 1);
        }
      }
      else
      {
        // extracts file name from URL
        fileName = fileURL.substring(fileURL.lastIndexOf("/") + 1,
          fileURL.length());
      }

      Logger.getLogger(getClass().getName()).info("Content-Type = " + contentType);
      Logger.getLogger(getClass().getName()).info("Content-Disposition = " + disposition);
      Logger.getLogger(getClass().getName()).info("Content-Length = " + contentLength);
      Logger.getLogger(getClass().getName()).info("fileName = " + fileName);

      // opens input stream from the HTTP connection
      InputStream inputStream = httpConn.getInputStream();
      if (destFile == null)
        destFile = fileName;
      String saveFilePath = saveDir + File.separator + destFile;

      // opens an output stream to save into file
      FileOutputStream outputStream = new FileOutputStream(saveFilePath);

      int bytesRead = -1;
      byte[] buffer = new byte[4096];
      while ((bytesRead = inputStream.read(buffer)) != -1)
      {
        outputStream.write(buffer, 0, bytesRead);
      }

      outputStream.close();
      inputStream.close();

      Logger.getLogger(getClass().getName()).info("File downloaded");
    }
    else
    {
      Logger.getLogger(getClass().getName()).info("No file to download. Server replied HTTP code: " + responseCode);
    }
    httpConn.disconnect();
  }    
  /**
   * @param args the command line arguments
   */
  public static void main(String args[])
  {
    /* Set the Nimbus look and feel */
    //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
    /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
     */
    try
    {
      for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels())
      {
        if ("Nimbus".equals(info.getName()))
        {
          javax.swing.UIManager.setLookAndFeel(info.getClassName());
          break;
        }
      }
    }
    catch (ClassNotFoundException ex)
    {
      java.util.logging.Logger.getLogger(MatrixClientUpdater.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
    }
    catch (InstantiationException ex)
    {
      java.util.logging.Logger.getLogger(MatrixClientUpdater.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
    }
    catch (IllegalAccessException ex)
    {
      java.util.logging.Logger.getLogger(MatrixClientUpdater.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
    }
    catch (javax.swing.UnsupportedLookAndFeelException ex)
    {
      java.util.logging.Logger.getLogger(MatrixClientUpdater.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
    }
    //</editor-fold>
    //</editor-fold>
    //</editor-fold>
    //</editor-fold>
    try
    {
      UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
    }
    catch (Exception ex)
    {
    }
    
    final String downloadUrl = (args.length == 0 ? "http://localhost/santfeliu/download" : args[0]);

    final MatrixClientUpdater updater = new MatrixClientUpdater(3); 
    updater.pack();
    updater.setLocationRelativeTo(null);
    updater.setVisible(true);

    /* Create and display the form */
    java.awt.EventQueue.invokeLater(new Runnable()
    {
      public void run()
      {
        try
        {
          updater.setVisible(true);

          String jarname = "matrix-client";
          
          //1. Download file
          String filename = jarname + ".jar";
          String url = downloadUrl + "/" + filename;
          String currentFolder = System.getProperty("user.dir");
          updater.updateBar(bundle.getString("MatrixClientUpdater.downloading"));          
          updater.downloadFile(url, currentFolder, jarname + "-update.jar");

          //2. Rename jars
          String timestamp = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
          updater.updateBar(bundle.getString("MatrixClientUpdater.updating"));
          File currentJar = new File(currentFolder, jarname + ".jar");
          File renamedJar = new File(currentFolder, jarname + "-old-" + timestamp + ".jar");
          currentJar.renameTo(renamedJar);
          File updatedJar = new File(currentFolder, jarname + "-update.jar");
          updatedJar.renameTo(currentJar);
          
          //3. Execute
          updater.updateBar(bundle.getString("MatrixClientUpdater.updated"));          
          JOptionPane.showMessageDialog(null, bundle.getString("MatrixClientUpdater.updated")); 
          File file = new File(currentFolder + "/../MatrixClient.exe");
          if (file.exists())
            Runtime.getRuntime().exec(currentFolder + "/../MatrixClient.exe");
          else
            Runtime.getRuntime().exec("java -jar matrix-client.jar org.santfeliu.matrix.client.MatrixClient");
          Thread.sleep(1000);
        }
        catch (Exception ex)
        {
          JOptionPane.showMessageDialog(null, ex.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
        }
        finally
        {
          System.exit(0);          
        }
      }
    });
  }


  // Variables declaration - do not modify//GEN-BEGIN:variables
  private javax.swing.JLabel label;
  private javax.swing.JProgressBar progressBar;
  // End of variables declaration//GEN-END:variables


}
