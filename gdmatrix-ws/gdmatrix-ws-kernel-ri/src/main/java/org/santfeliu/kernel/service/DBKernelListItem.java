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

import org.matrix.kernel.KernelListItem;

/**
 *
 * @author unknown
 */
public class DBKernelListItem extends DBEntityBase
{
  private String listId;
  private String itemId;
  private String auxItemId;
  private String label;
  private String description;
  private String tcqual;
  private int tcvnum;

  public DBKernelListItem()
  {
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

  public void setAuxItemId(String auxItemId)
  {
    this.auxItemId = auxItemId;
  }

  public String getAuxItemId()
  {
    return auxItemId;
  }

  public void setLabel(String label)
  {
    this.label = label;
  }

  public String getLabel()
  {
    return label;
  }

  public void setDescription(String description)
  {
    this.description = description;
  }

  public String getDescription()
  {
    return description;
  }

  public void setTcqual(String tcqual)
  {
    this.tcqual = tcqual;
  }

  public String getTcqual()
  {
    return tcqual;
  }

  public void setTcvnum(int tcvnum)
  {
    this.tcvnum = tcvnum;
  }

  public int getTcvnum()
  {
    return tcvnum;
  }
  
  public void copyFrom(KernelListItem listItem)
  {
    itemId = listItem.getItemId();
    label = listItem.getLabel();
    description = listItem.getDescription();
  }
  
  public void copyTo(KernelListItem listItem)
  {
    listItem.setItemId(itemId);
    listItem.setLabel(label);
    listItem.setDescription(description);
  }
}
