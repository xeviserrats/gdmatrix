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
package org.santfeliu.workflow.swing.editor;

import java.awt.Component;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.DefaultCellEditor;
import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.JTextArea;
import javax.swing.JTextField;
import javax.swing.ListSelectionModel;
import javax.swing.event.ChangeEvent;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableColumn;

import org.santfeliu.swing.text.RestrictedDocument;
import org.santfeliu.util.Properties;
import org.santfeliu.workflow.WorkflowNode;
import org.santfeliu.workflow.node.FormNode;
import org.santfeliu.workflow.swing.NodeEditor;
import org.santfeliu.workflow.swing.NodeEditorDialog;


/**
 *
 * @author unknown
 */
public class SelectMenuFormParametersEditor extends JPanel
  implements NodeEditor
{
  private FormNode formNode;
  private GridBagLayout gridBagLayout1 = new GridBagLayout();
  private JLabel varLabel = new JLabel();
  private JLabel messageLabel = new JLabel();
  private JTextField varTextField = new JTextField();
  private JTextArea messageTextArea = new JTextArea();
  private JScrollPane scrollPane = new JScrollPane();
  private JLabel optionsLabel = new JLabel();
  private JScrollPane scrollPane2 = new JScrollPane();
  private JTable optionsTable = new JTable();
  private DefaultTableModel tableModel = new DefaultTableModel();
  private JButton addButton = new JButton();
  private JButton insertButton = new JButton();
  private JButton deleteButton = new JButton();

  public SelectMenuFormParametersEditor()
  {
    try
    {
      jbInit();
    }
    catch (Exception e)
    {
      e.printStackTrace();
    }
  }

  public Component getEditingComponent(NodeEditorDialog dialog, 
    WorkflowNode node)
  {
    this.formNode = (FormNode)node;
    Properties parameters = formNode.getParameters();
    Object var = parameters.get("var");
    if (var != null && String.valueOf(var).trim().length() > 0)
    {
      varTextField.setText(var.toString());
    }
    Object message = parameters.get("message");
    if (message != null)
    {
      messageTextArea.setText(message.toString());
      messageTextArea.setCaretPosition(0);
    }
    int i = 0;
    Object code = parameters.get("code" + i);
    while (code != null)
    {
      String scode = String.valueOf(code);
      String label = String.valueOf(parameters.get("label" + i));
      tableModel.addRow(new Object[]{label, scode});
      i++;
      code = parameters.get("code" + i);
    }
    return this;
  }

  public void checkValues() throws Exception
  {
  }

  public void stopEditing() throws Exception
  {
    checkValues();
    optionsTable.editingStopped(new ChangeEvent(this));
    Properties parameters = new Properties();
    parameters.setProperty("var", varTextField.getText());
    String message = messageTextArea.getText();
    if (message != null && message.trim().length() > 0)
    {
      parameters.setProperty("message", messageTextArea.getText());
    }
    for (int i = 0; i < tableModel.getRowCount(); i++)
    {
      String label = String.valueOf(tableModel.getValueAt(i, 0));
      String scode = String.valueOf(tableModel.getValueAt(i, 1));
      if (label.trim().length() > 0)
      {
        parameters.setProperty("code" + i, scode);
        parameters.setProperty("label" + i, label);
      }
    }
    formNode.setParameters(parameters);
  }

  public void cancelEditing()
  {
  }

  private void jbInit()
    throws Exception
  {
    this.setLayout(gridBagLayout1);
    varLabel.setText("Variable:");
    messageLabel.setText("Message:");
    varTextField.setPreferredSize(new Dimension(140, 24));
    varTextField.setMinimumSize(new Dimension(140, 24));
    messageTextArea.setFont(new Font("Dialog", 0, 14));
    messageTextArea.setLineWrap(true);
    messageTextArea.setWrapStyleWord(true);
    
    optionsLabel.setText("Options:");
    this.add(varLabel, 
             new GridBagConstraints(0, 0, 1, 1, 0.0, 0.0, GridBagConstraints.WEST, GridBagConstraints.HORIZONTAL, 
                                    new Insets(2, 4, 2, 4), 0, 0));
    this.add(messageLabel, 
             new GridBagConstraints(0, 1, 1, 1, 0.0, 0.0, GridBagConstraints.NORTHWEST, GridBagConstraints.HORIZONTAL, 
                                    new Insets(2, 4, 2, 4), 0, 0));
    this.add(varTextField, 
             new GridBagConstraints(1, 0, 1, 1, 0.0, 0.0, GridBagConstraints.WEST, GridBagConstraints.NONE, 
                                    new Insets(2, 4, 2, 4), 0, 0));
    this.add(scrollPane, 
             new GridBagConstraints(1, 1, 1, 1, 1.0, 0.2, GridBagConstraints.CENTER, GridBagConstraints.BOTH, 
                                    new Insets(2, 4, 2, 4), 0, 0));
    this.add(optionsLabel, 
             new GridBagConstraints(0, 2, 1, 1, 0.0, 0.0, GridBagConstraints.NORTHWEST, GridBagConstraints.HORIZONTAL, 
                                    new Insets(2, 2, 4, 2), 0, 0));
    scrollPane2.getViewport().add(optionsTable, null);
    this.add(scrollPane2, 
             new GridBagConstraints(1, 2, 1, 4, 0.0, 0.8, GridBagConstraints.CENTER, GridBagConstraints.BOTH, 
                                    new Insets(2, 4, 2, 4), 0, 0));
    this.add(addButton, 
             new GridBagConstraints(0, 3, 1, 1, 0.0, 0.0, GridBagConstraints.CENTER, GridBagConstraints.HORIZONTAL, 
                                    new Insets(2, 2, 2, 2), 0, 0));
    this.add(insertButton, 
             new GridBagConstraints(0, 4, 1, 1, 0.0, 0.0, GridBagConstraints.CENTER, GridBagConstraints.HORIZONTAL, 
                                    new Insets(2, 2, 2, 2), 0, 0));
    this.add(deleteButton, 
             new GridBagConstraints(0, 5, 1, 1, 0.0, 0.0, GridBagConstraints.NORTH, GridBagConstraints.HORIZONTAL, 
                                    new Insets(2, 2, 2, 2), 0, 0));
    scrollPane.getViewport().add(messageTextArea);
    this.varTextField.setDocument(new RestrictedDocument("[a-zA-Z_][a-zA-Z0-9_]*"));
    optionsTable.setAutoCreateColumnsFromModel(false);    
    tableModel.addColumn("Label");
    tableModel.addColumn("Value");
    optionsTable.setModel(tableModel);
    addButton.setText("Add");
    addButton.addActionListener(new ActionListener()
        {
          public void actionPerformed(ActionEvent e)
          {
            addButton_actionPerformed(e);
          }
        });
    insertButton.setText("Insert");
    insertButton.addActionListener(new ActionListener()
        {
          public void actionPerformed(ActionEvent e)
          {
            insertButton_actionPerformed(e);
          }
        });
    deleteButton.setText("Delete");
    deleteButton.addActionListener(new ActionListener()
        {
          public void actionPerformed(ActionEvent e)
          {
            deleteButton_actionPerformed(e);
          }
        });
    DefaultCellEditor editor = new DefaultCellEditor(new JTextField());
    editor.setClickCountToStart(2);

    optionsTable.addColumn(new TableColumn(0, 300, null, editor));
    optionsTable.addColumn(new TableColumn(1, 100, null, editor));
    optionsTable.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
    optionsTable.setRowHeight(20);
  }

  private void addButton_actionPerformed(ActionEvent e)
  {
    optionsTable.editingStopped(new ChangeEvent(this));
    tableModel.addRow(new Object[]{"", ""});
    int row = tableModel.getRowCount() - 1;
    optionsTable.setRowSelectionInterval(row, row);
    optionsTable.requestFocus();
    optionsTable.editCellAt(row, 0);
  }

  private void insertButton_actionPerformed(ActionEvent e)
  {
    optionsTable.editingStopped(new ChangeEvent(this));
    int row = optionsTable.getSelectedRow();
    if (row != -1)
    {
      tableModel.insertRow(row, new Object[]{"", ""});
      optionsTable.setRowSelectionInterval(row, row);
      optionsTable.requestFocus();
      optionsTable.editCellAt(row, 0);
    }
  }

  private void deleteButton_actionPerformed(ActionEvent e)
  {
    optionsTable.editingCanceled(new ChangeEvent(this));
    int row = optionsTable.getSelectedRow();
    if (row != -1)
    {
      tableModel.removeRow(row);
    }
  }
}
