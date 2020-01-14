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
package org.santfeliu.workflow.node;

import java.beans.BeanInfo;

import org.santfeliu.workflow.WorkflowNodeBeanInfo;

/**
 *
 * @author unknown
 */
public class SendMailNodeBeanInfo extends WorkflowNodeBeanInfo
{
  public SendMailNodeBeanInfo()
  {
    this(SendMailNode.class);
  }

  public SendMailNodeBeanInfo(Class beanClass)
  {
    super(beanClass);
    addProperty("host").setCategory(SPECIFIC_CATEGORY);    
    addProperty("sender").setCategory(SPECIFIC_CATEGORY);    
    addProperty("recipientsTO").setCategory(SPECIFIC_CATEGORY);    
    addProperty("recipientsCC").setCategory(SPECIFIC_CATEGORY);    
    addProperty("recipientsBCC").setCategory(SPECIFIC_CATEGORY);    
    addProperty("subject").setCategory(SPECIFIC_CATEGORY);    
    addProperty("message").setCategory(SPECIFIC_CATEGORY);
    addProperty("charset").setCategory(SPECIFIC_CATEGORY);
    addProperty("contentType").setCategory(SPECIFIC_CATEGORY);
    addProperty("username").setCategory(SPECIFIC_CATEGORY);
    addProperty("password").setCategory(SPECIFIC_CATEGORY);
  }
  
  @Override
  public java.awt.Image getIcon(int iconKind)
  {
    if (iconKind == BeanInfo.ICON_COLOR_16x16)
    {
      return loadImage(
        "/org/santfeliu/workflow/swing/resources/icon/send_mail.gif");
    }
    return null;
  }
} 
