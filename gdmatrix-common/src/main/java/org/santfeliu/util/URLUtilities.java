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
package org.santfeliu.util;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;

import java.net.URL;
import java.net.URLConnection;


/**
 *
 * @author unknown
 */
public class URLUtilities
{
  public URLUtilities()
  {
  }
  
  public static void downloadFile(String urlString, String path)
    throws Exception
  {
    URL url = new URL(urlString);
    URLConnection conn = url.openConnection();
    // read from url
    ByteArrayOutputStream os = new ByteArrayOutputStream();
    InputStream is = conn.getInputStream();
    try
    {
      byte[] buffer = new byte[1024];
      int count = is.read(buffer);
      while (count != -1)
      {
        os.write(buffer, 0, count);
        count = is.read(buffer);
      }
    }
    finally
    {
      is.close();
    }
    // write to file
    File file = new File(path);
    FileOutputStream fos = new FileOutputStream(file);
    try
    {
      fos.write(os.toByteArray());
    }
    finally
    {
      fos.close();
    }
  }
  
  public static void main(String[] args)
  {
    try
    {
      downloadFile("http://localhost/documents/48398", "c:/aaaa.gif");
    }
    catch (Exception ex)
    {
      ex.printStackTrace();
    }
  }
}
