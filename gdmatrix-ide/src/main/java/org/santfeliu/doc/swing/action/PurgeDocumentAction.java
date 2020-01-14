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
package org.santfeliu.doc.swing.action;

import java.awt.Cursor;
import java.awt.event.ActionEvent;
import javax.swing.AbstractAction;
import javax.swing.Action;
import org.matrix.doc.DocumentConstants;
import org.santfeliu.doc.swing.DocumentBasePanel;
import org.santfeliu.doc.swing.DocumentListPanel;

/**
 *
 * @author unknown
 */
public class PurgeDocumentAction extends AbstractAction
{
  private DocumentBasePanel documentPanel;
  
  public PurgeDocumentAction(DocumentBasePanel documentPanel)
  {
    this.documentPanel = documentPanel;
    this.putValue(Action.NAME, documentPanel.getLocalizedText("purge"));
  }

  public void actionPerformed(ActionEvent e)
  {
    try
    {
      documentPanel.setCursor(Cursor.getPredefinedCursor(Cursor.WAIT_CURSOR));        
      
      //DocumentManagerClient client = documentPanel.getDocumentManagerClient();

      String docId = documentPanel.getDocId();
      //String language = documentPanel.getDocLanguage();
/*
      XMLGregorianCalendar time = 
        DatatypeFactory.newInstance().newXMLGregorianCalendar(
          (GregorianCalendar)Calendar.getInstance());

      client.purgeDocument(docId, language, time);
*/
      
      if (documentPanel instanceof DocumentListPanel)
        ((DocumentListPanel)documentPanel).search();
      else
        documentPanel.loadDocument(docId, DocumentConstants.LAST_VERSION);
 
      documentPanel.getClient().removeDocument(docId, -3); //Old versions

    }
    catch (Exception ex)
    {
      ex.printStackTrace();
      documentPanel.showError(ex);
    }
    finally
    {
      documentPanel.setCursor(Cursor.getPredefinedCursor(Cursor.DEFAULT_CURSOR));
    }
  }
  
  public boolean isEnabled()
  {
    return documentPanel.existsDocument();
  }


}
