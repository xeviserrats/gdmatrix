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
package org.santfeliu.sql.store;

import java.util.HashMap;
import java.util.Map;
import org.santfeliu.dbf.DBConnection;
import org.santfeliu.dbf.DBException;
import org.santfeliu.dbf.DBKey;


/**
 *
 * @author unknown
 */
public class DBConnectionStore implements ConnectionStore
{
  public static final String PKG = DBConnectionStore.class.getName() + ".";
  public static final String DATA_SOURCE = "dsn";
  public static final String CONNECTIONS_TABLE = "connTableName";
  public static final String DATA_SOURCE_PREFIX = "jdbc/";
  
  private String dataSourceName;
  private String connTableName;

  public void init(Map properties) throws Exception
  {
    dataSourceName = (String)properties.get(PKG + DATA_SOURCE); 
    connTableName = (String)properties.get(PKG + CONNECTIONS_TABLE);
  }
  
  public DBConnection getConnection(String alias, String username, 
                                    String password) throws Exception
  {
    if (alias.startsWith(DATA_SOURCE_PREFIX))
    {
      // alias is itself a DataSource name
      return repository.getConnection(alias);
    }
    else
    {
      // alias is a connection name stored in connTableName
      DBConnection storeConnection = repository.getConnection(dataSourceName);
      try
      {
        return getUserDBConnection(storeConnection, alias, username, password);
      }
      catch (Exception ex)
      {
        storeConnection.rollback();
        throw ex;
      }
      finally
      {
        storeConnection.close();
      }
    }
  }

  public void addConnection(String alias, String driver, String url) 
    throws Exception
  {
    DBConnection conn = repository.getConnection(dataSourceName);
    try
    {
      doAddConnection(conn, alias, driver, url);
    }
    catch (Exception ex)
    {
      conn.rollback();
      throw ex;
    }
    finally
    {
      conn.close();
    }
  }

  public void removeConnection(String alias) throws Exception
  {
    DBConnection conn = repository.getConnection(dataSourceName);
    try
    {
      doRemoveConnection(conn, alias);
    }
    catch (Exception ex)
    {
      conn.rollback();
      throw ex;
    }
    finally
    {
      conn.close();
    }  
  }
  
  private DBConnection getUserDBConnection(DBConnection conn, String alias, 
    String username, String password) throws Exception
  {
    DBConnection result = null;
    
    Map connection = conn.selectMap(connTableName, new DBKey(alias));
    if (connection != null)
    {
      String driver = (String)connection.get("driver");
      String url = (String)connection.get("url");
      result = repository.getConnection(driver, url, username, password);
    }    
    return result;
  }
  
  private void doAddConnection(DBConnection conn, String alias, String driver,
    String url)
    throws DBException
  {
    Map fields = new HashMap();
    fields.put("alias", alias);    
    fields.put("driver", driver);    
    fields.put("url", url);    
  
    conn.insert(connTableName, fields);
  }
  
  private void doRemoveConnection(DBConnection conn, String alias)
    throws DBException
  {
    conn.delete(connTableName, new DBKey(alias));
  }  
}
