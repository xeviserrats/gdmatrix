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
package org.santfeliu.cases.service;

import org.matrix.security.AccessControl;
import org.santfeliu.jpa.JPAUtils;

/**
 *
 * @author blanquepa
 */
public class DBAccessControl extends AccessControl
{
  private String caseId;

  public DBAccessControl()
  {
  }

  public String getCaseId()
  {
    return caseId;
  }

  public void setCaseId(String caseId)
  {
    this.caseId = caseId;
  }

  public DBAccessControl(AccessControl accessControl)
  {
    copyFrom(accessControl);
  }

  public DBAccessControlPK getPrimaryKey()
  {
    DBAccessControlPK pk = new DBAccessControlPK();
    pk.setCaseId(caseId);
    pk.setRoleId(roleId);
    pk.setAction(action);
    return pk;
  }

  public void copyTo(AccessControl accessControl)
  {
    JPAUtils.copy(this, accessControl);
  }

  public void copyFrom(AccessControl accessControl)
  {
    JPAUtils.copy(accessControl, this);
  }
}
