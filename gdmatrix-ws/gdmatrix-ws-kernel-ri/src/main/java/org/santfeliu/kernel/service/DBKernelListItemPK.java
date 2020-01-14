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
package org.santfeliu.kernel.service;

import java.io.Serializable;

/**
 *
 * @author unknown
 */
public class DBKernelListItemPK implements Serializable
{
  private String listId;
  private String itemId;

  public DBKernelListItemPK()
  {
  }

  public DBKernelListItemPK(String listId, String itemId)
  {
    this.listId = listId;
    this.itemId = itemId;
  }

  public void setListId(String listId)
  {
    this.listId = listId;
  }

  public String getListId()
  {
    return listId;
  }

  public void setItemId(String itemId)
  {
    this.itemId = itemId;
  }

  public String getItemId()
  {
    return itemId;
  }
  
  public boolean equals(Object o)
  {
    DBKernelListItemPK pk = (DBKernelListItemPK)o;
    return pk.getListId().equals(listId) && pk.getItemId().equals(itemId);
  }
  
  public int hashCode()
  {
    return (listId + KernelManager.PK_SEPARATOR + itemId).hashCode();
  }
}
