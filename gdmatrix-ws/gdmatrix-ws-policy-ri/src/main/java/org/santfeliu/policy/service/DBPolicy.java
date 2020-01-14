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
package org.santfeliu.policy.service;

import org.santfeliu.jpa.JPAUtils;
import org.matrix.policy.Policy;

/**
 *
 * @author unknown
 */
public class DBPolicy extends Policy
{
  private String automaticExecutionValue;

  public String getAutomaticExecutionValue()
  {
    return automaticExecutionValue;
  }

  public void setAutomaticExecutionValue(String automaticExecutionValue)
  {
    this.automaticExecutionValue = automaticExecutionValue;
    automaticExecution = "T".equals(automaticExecutionValue);
  }

  public void copyTo(Policy policy)
  {
    JPAUtils.copy(this, policy);
    policy.setAutomaticExecution("T".equals(automaticExecutionValue));
  }

  public void copyFrom(Policy policy)
  {
    policyId = policy.getPolicyId();
    title = policy.getTitle();
    description = policy.getDescription();
    policyTypeId = policy.getPolicyTypeId();
    activationDateExpression = policy.getActivationDateExpression();
    activationCondition = policy.getActivationCondition();
    mandate = policy.getMandate();
    evaluationCode = policy.getEvaluationCode();    
    setAutomaticExecutionValue(policy.isAutomaticExecution() ? "T" : "F");
  }
}
