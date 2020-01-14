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
package org.santfeliu.workflow;

import com.l2fprod.common.beans.BaseBeanInfo;

import com.l2fprod.common.beans.ExtendedPropertyDescriptor;

import java.beans.BeanDescriptor;

/**
 *
 * @author unknown
 */
public class WorkflowNodeBeanInfo extends BaseBeanInfo
{
  public final String GENERAL_CATEGORY = "general";
  public final String SPECIFIC_CATEGORY = "specific";

  public WorkflowNodeBeanInfo()
  {
    this(WorkflowNode.class);
  }
  
  public WorkflowNodeBeanInfo(Class beanClass)
  {
    super(beanClass);
    ExtendedPropertyDescriptor pd;
    pd = addProperty("id");
    pd.setCategory(GENERAL_CATEGORY);
    pd.setShortDescription("Node identifier");
    
    pd = addProperty("description");
    pd.setCategory(GENERAL_CATEGORY);
    pd.setShortDescription("Node description");

    pd = addProperty("type");
    pd.setCategory(GENERAL_CATEGORY);
    pd.setShortDescription("Node type");

    pd = addProperty("immediate");
    pd.setCategory(GENERAL_CATEGORY);
    pd.setShortDescription("Immediate execution");

    pd = addProperty("hidden");
    pd.setCategory(GENERAL_CATEGORY);
    pd.setShortDescription("Don't update STATE variable with node description");

    pd = addProperty("roles");
    pd.setCategory(GENERAL_CATEGORY);
    pd.setShortDescription("Execution roles");
  }

  public BeanDescriptor getBeanDescriptor()
  {
    return null;
  }
}
