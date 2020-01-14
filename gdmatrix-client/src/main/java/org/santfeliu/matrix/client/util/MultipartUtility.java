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
package org.santfeliu.matrix.client.util;


import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.List;

/**
 * This utility class provides an abstraction layer for sending multipart HTTP
 * POST requests to a web server.
 *
 * @author www.codejava.net
 * @author blanquepa
 *
 */
public class MultipartUtility
{
  private final String boundary;
  private static final String LINE_FEED = "\r\n";
  private HttpURLConnection httpConn;
  private String charset;
  private OutputStream outputStream;
  private PrintWriter writer;

  /**
   * This constructor initializes a new HTTP POST request with content type is
   * set to multipart/form-data
   *
   * @param requestURL
   * @param charset
   * @throws IOException
   */
  public MultipartUtility(String requestURL, String charset, String userAgent)
          throws IOException
  {
    this.charset = charset;

    // creates a unique boundary based on time stamp
    boundary = "===" + System.currentTimeMillis() + "===";

    URL url = new URL(requestURL);
    httpConn = (HttpURLConnection) url.openConnection();
    httpConn.setUseCaches(false);
    httpConn.setDoOutput(true); // indicates POST method
    httpConn.setDoInput(true);
    httpConn.setRequestProperty("Content-Type",
            "multipart/form-data; boundary=" + boundary);
    httpConn.setRequestProperty("User-Agent", userAgent);
    outputStream = httpConn.getOutputStream();
    writer = new PrintWriter(new OutputStreamWriter(outputStream, charset),
            true);
  }
 

  /**
   * Adds a form field to the request
   *
   * @param name field name
   * @param value field value
   */
  public void addFormField(String name, String value)
  {
    writer.append("--" + boundary).append(LINE_FEED);
    writer.append("Content-Disposition: form-data; name=\"" + name + "\"")
            .append(LINE_FEED);
    writer.append("Content-Type: text/plain; charset=" + charset).append(
            LINE_FEED);
    writer.append(LINE_FEED);
    writer.append(value).append(LINE_FEED);
    writer.flush();
  }

  /**
   * Adds a upload file section to the request
   *
   * @param fieldName name attribute in <input type="file" name="..." />
   * @param fileName
   * @throws IOException
   */
  public void addFilePart(String fieldName, String fileName)
          throws IOException
  {
    writer.append("--" + boundary).append(LINE_FEED);
    writer.append(
            "Content-Disposition: form-data; name=\"" + fieldName
            + "\"; filename=\"" + fileName + "\"")
            .append(LINE_FEED);
    writer.append(
            "Content-Type: "
            + URLConnection.guessContentTypeFromName(fileName))
            .append(LINE_FEED);
    writer.append("Content-Transfer-Encoding: binary").append(LINE_FEED);
    writer.append(LINE_FEED);
    writer.flush();
  }
  
  public void addFilePart(String fieldName, File uploadFile)
          throws IOException  
  {
    String fileName = uploadFile.getName();
    addFilePart(fieldName, fileName);
    sendFile(uploadFile);
  }
  
  public void sendFile(File uploadFile) throws IOException
  {
    FileInputStream inputStream = new FileInputStream(uploadFile);
    byte[] buffer = new byte[4096];
    int bytesRead = -1;
    while ((bytesRead = inputStream.read(buffer)) != -1)
    {
      outputStream.write(buffer, 0, bytesRead);
    }
    outputStream.flush();
    inputStream.close();  
    
    writer.append(LINE_FEED);
    writer.flush();    
  }

  /**
   * Adds a header field to the request.
   *
   * @param name - name of the header field
   * @param value - value of the header field
   */
  public void addHeaderField(String name, String value)
  {
    writer.append(name + ": " + value).append(LINE_FEED);
    writer.flush();
  }

  /**
   * Completes the request and receives response from the server.
   *
   * @return a list of Strings as response in case the server returned status
   * OK, otherwise an exception is thrown.
   * @throws IOException
   */
  public List<String> finish() throws IOException
  {
    List<String> response = new ArrayList<String>();

    writer.append(LINE_FEED).flush();
    writer.append("--" + boundary + "--").append(LINE_FEED);
    writer.close();

//    // checks server's status code first
//    int status = httpConn.getResponseCode();
//    if (status == HttpURLConnection.HTTP_OK)
//    {
//      BufferedReader reader = new BufferedReader(new InputStreamReader(
//              httpConn.getInputStream()));
//      String line = null;
//      while ((line = reader.readLine()) != null)
//      {
//        response.add(line);
//      }
//      reader.close();
//      httpConn.disconnect();
//    }
//    else
//    {
//      throw new IOException("Server returned non-OK status: " + status);
//    }

    return response;
  }

  public HttpURLConnection getHttpConn()
  {
    return httpConn;
  }

  public OutputStream getOutputStream()
  {
    return outputStream;
  }

}
