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

import org.matrix.cases.CaseDocument;

import org.santfeliu.util.audit.Auditable;

/**
 *
 * @author unknown
 */
public class DBCaseDocument extends CaseDocument implements Auditable
{
  private DBCase caseObject;
  
  public DBCaseDocument()
  {
  }

  public DBCaseDocument(CaseDocument caseDocument)
  {
    copyFrom(caseDocument);
  }

  public void copyTo(CaseDocument caseDocument)
  {
    caseDocument.setCaseDocId(caseDocId);
    caseDocument.setCaseId(caseId);
    caseDocument.setDocId(docId);
    caseDocument.setCaseDocTypeId(caseDocTypeId);
    caseDocument.setComments(comments);
    caseDocument.setVolume(volume);
  }

  public void copyFrom(CaseDocument caseDocument)
  {
    caseDocId = caseDocument.getCaseDocId();
    caseId = caseDocument.getCaseId();
    docId = caseDocument.getDocId();
    caseDocTypeId = caseDocument.getCaseDocTypeId();
    comments = caseDocument.getComments();
    volume = caseDocument.getVolume();
  }

  public void setCaseObject(DBCase caseObject)
  {
    this.caseObject = caseObject;
  }

  public DBCase getCaseObject()
  {
    return caseObject;
  }
}
