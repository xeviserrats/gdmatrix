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
package org.santfeliu.matrix.client.ui.microsigner.action;

import java.awt.event.ActionEvent;

import javax.swing.AbstractAction;
import javax.swing.Action;
import javax.swing.JOptionPane;
import org.santfeliu.matrix.client.ui.microsigner.MainPanel;
import org.santfeliu.matrix.client.ui.microsigner.MicroSigner;


/**
 *
 * @author realor
 */
public class SaveConfigAction extends AbstractAction
{
  private final MainPanel mainPanel;
  
  public SaveConfigAction(MainPanel mainPanel)
  {
    super.putValue(Action.NAME, 
      MicroSigner.getLocalizedText("SaveConfig"));  
    this.mainPanel = mainPanel;
  }

  @Override
  public void actionPerformed(ActionEvent event)
  {
    try
    {
      mainPanel.getMicroSigner().saveConfiguration();
      JOptionPane.showMessageDialog(mainPanel,
        MicroSigner.getLocalizedText("ConfigurationSaved"), 
        MicroSigner.getLocalizedText("SaveConfig"), 
        JOptionPane.INFORMATION_MESSAGE);
    }
    catch (Exception ex)
    {
      JOptionPane.showMessageDialog(mainPanel, 
        ex.getMessage(), 
        MicroSigner.getLocalizedText("SaveConfig"), 
        JOptionPane.ERROR_MESSAGE);
    }
  }
}
