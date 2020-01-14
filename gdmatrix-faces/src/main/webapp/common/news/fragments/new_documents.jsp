<?xml version='1.0' encoding='windows-1252'?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
          xmlns:f="http://java.sun.com/jsf/core"
          xmlns:h="http://java.sun.com/jsf/html"
          xmlns:t="http://myfaces.apache.org/tomahawk"
          xmlns:sf="http://www.santfeliu.org/jsf">
  <f:loadBundle basename="org.santfeliu.news.web.resources.NewsBundle"
                var="newsBundle"/>

  <t:buffer into="#{table}">
    <t:dataTable id="data" value="#{newDocumentsBean.rows}"
                 var="row" rowClasses="row1,row2" headerClass="header" footerClass="footer"
                 rowStyleClass="#{row.newDocumentId != null and newDocumentsBean.editingDocument != null and row.newDocumentId == newDocumentsBean.editingDocument.newDocumentId ? 'selectedRow' : null}"
                 bodyStyle="#{empty newDocumentsBean.rows ? 'display:none' : ''}"
                 styleClass="resultList"
                 style="width:100%"
                 rows="#{newDocumentsBean.pageSize}">

      <t:column style="width:7%">
        <f:facet name="header">
          <h:outputText id="docRowsTableCol1Header"
                        value="#{newsBundle.new_documents_id}"
                        styleClass="textBox"/>
        </f:facet>
        <h:outputText value="#{row.documentId}"
                      rendered="#{row.newDocumentId != null}" />
      </t:column>
      <!--
      <t:column style="width: 3%">
        <h:graphicImage url="#{newDocumentsBean.languageFlag}" width="16"
                        style="vertical-align:middle" alt="#{newDocumentsBean.language}"
                        title="#{newDocumentsBean.language}"
                        rendered="#{newDocumentsBean.languageFlag != null}"/>
        <h:graphicImage url="/common/doc/images/pixel.gif" height="16" width="16"
                        style="vertical-align:middle"
                        rendered="#{newDocumentsBean.languageFlag == null}"/>
      </t:column>
      -->
      <t:column style="width:40%">
        <f:facet name="header">
          <h:outputText id="docRowsTableCol2Header"
                        value="#{newsBundle.new_documents_documentName}"
                        styleClass="textBox"/>
        </f:facet>
        <h:outputLink value="#{newDocumentsBean.documentUrl}" target="_blank"
                      rendered="#{row.newDocumentId != null}" styleClass="documentLink">
          <h:outputText id="docRowTitle" value="#{row.title}"/>
        </h:outputLink>
      </t:column>

      <t:column style="width:25%">
        <f:facet name="header">
          <h:outputText value="#{newsBundle.new_documents_type}" />
        </f:facet>
        <h:outputText value="#{newDocumentsBean.rowTypeLabel}" />
      </t:column>

      <t:column style="width:25%" styleClass="actionsColumn">
        <h:panelGroup
          rendered="#{row.newDocumentId != null}" >
           <h:commandButton value="#{objectBundle.edit}"
                            image="#{userSessionBean.icons.edit}"
                            alt="#{objectBundle.edit}" title="#{objectBundle.edit}"
                            styleClass="editButton"
                            onclick="javascript:htmlSendFile_edit('#{row.documentId}');return false"
                            rendered="#{row.newDocumentId != null and not userSessionBean.matrixClientEnabled}"/>
           <h:commandButton value="#{objectBundle.edit}"
                            image="#{userSessionBean.icons.edit}"
                            alt="#{objectBundle.edit}" title="#{objectBundle.edit}"
                            styleClass="editButton"
                            onclick="javascript:editDocument({docId:'#{row.documentId}'});return false"
                            rendered="#{row.newDocumentId != null and userSessionBean.matrixClientEnabled}"/>           
          <h:commandButton value="#{objectBundle.upload}"
                           rendered="#{row.newDocumentId != null and not userSessionBean.matrixClientEnabled}"
                           styleClass="editButton" onclick="javascript:htmlSendFile_update('#{row.documentId}');return false"
                           image="#{userSessionBean.icons.upload}"
                           alt="#{objectBundle.replace}" title="#{objectBundle.replace}" />
          <h:commandButton value="#{objectBundle.upload}"
                           rendered="#{row.newDocumentId != null and userSessionBean.matrixClientEnabled}"
                           styleClass="editButton" onclick="javascript:updateDocument({docId:'#{row.documentId}'});return false"
                           image="#{userSessionBean.icons.upload}"
                           alt="#{objectBundle.replace}" title="#{objectBundle.replace}" />
          <h:commandButton value="#{objectBundle.show}"
                           image="#{userSessionBean.icons.show}"
                           alt="#{objectBundle.show}" title="#{objectBundle.show}"
                           styleClass="showButton"
                           action="#{newDocumentsBean.showDocument}" />
          <h:commandButton action="#{newDocumentsBean.editNewDocument}"
                           styleClass="editButton" value="#{objectBundle.edit}"
                           image="#{userSessionBean.icons.detail}"
                           alt="#{objectBundle.edit}" title="#{objectBundle.edit}" />
          <h:commandButton value="#{objectBundle.delete}"
                           image="#{userSessionBean.icons.delete}"
                           alt="#{objectBundle.delete}" title="#{objectBundle.delete}"
                           action="#{newDocumentsBean.removeNewDocument}"
                           styleClass="removeButton"
                           onclick="return confirm('#{objectBundle.confirm_remove}');" />
        </h:panelGroup>

      </t:column>

      <f:facet name="footer">
        <t:dataScroller
          fastStep="100"
          paginator="true"
          paginatorMaxPages="9"
          immediate="true"
          styleClass="scrollBar"
          paginatorColumnClass="page"
          paginatorActiveColumnClass="activePage"
          nextStyleClass="nextButton"
          previousStyleClass="previousButton"
          firstStyleClass="firstButton"
          lastStyleClass="lastButton"
          fastfStyleClass="fastForwardButton"
          fastrStyleClass="fastRewindButton"
          renderFacetsIfSinglePage="false">
          <f:facet name="first">
            <t:div title="#{objectBundle.first}"></t:div>
          </f:facet>
          <f:facet name="last">
            <t:div title="#{objectBundle.last}"></t:div>
          </f:facet>
          <f:facet name="previous">
            <t:div title="#{objectBundle.previous}"></t:div>
          </f:facet>
          <f:facet name="next">
            <t:div title="#{objectBundle.next}"></t:div>
          </f:facet>
          <f:facet name="fastrewind">
            <t:div title="#{objectBundle.fastRewind}"></t:div>
          </f:facet>
          <f:facet name="fastforward">
            <t:div title="#{objectBundle.fastForward}"></t:div>
          </f:facet>
        </t:dataScroller>
      </f:facet>
    </t:dataTable>

  </t:buffer>

  <t:div styleClass="resultBar" rendered="#{newDocumentsBean.rowCount > 0}">
    <t:dataScroller for="data"
                    firstRowIndexVar="firstRow"
                    lastRowIndexVar="lastRow"
                    rowsCountVar="rowCount">
      <h:outputFormat value="#{objectBundle.resultRange}">
        <f:param value="#{firstRow}" />
        <f:param value="#{lastRow}" />
        <f:param value="#{rowCount}" />
      </h:outputFormat>
    </t:dataScroller>
  </t:div>

  <h:outputText value="#{table}" escape="false"/>



  <t:div style="width:100%;text-align:right">
    <h:commandButton value="#{objectBundle.upload}"
                     styleClass="createButton" onclick="javascript:htmlSendFile_send();return false"
                     image="#{userSessionBean.icons.upload}"
                     alt="#{objectBundle.upload}" title="#{objectBundle.upload}"
                     rendered="#{newDocumentsBean.editingDocument == null and not userSessionBean.matrixClientEnabled}"/>
    <h:commandButton value="#{objectBundle.upload}"
                     styleClass="createButton" onclick="javascript:sendDocument();return false"
                     image="#{userSessionBean.icons.upload}"
                     alt="#{objectBundle.upload}" title="#{objectBundle.upload}"
                     rendered="#{newDocumentsBean.editingDocument == null and userSessionBean.matrixClientEnabled}"/>
    <h:commandButton action="#{newDocumentsBean.createNewDocument}"
                     rendered="#{row.newDocumentId == null}"
                     styleClass="addButton" value="#{objectBundle.add}"
                     image="#{userSessionBean.icons.add}"
                     alt="#{objectBundle.add}" title="#{objectBundle.add}"      />
  </t:div>

  <t:div styleClass="editingPanel"
            rendered="#{newDocumentsBean.editingDocument != null}">

    <t:div>
      <h:outputText value="#{newsBundle.new_documents_type}:"
                    style="width:20%" styleClass="textBox"/>
      <t:selectOneMenu value="#{newDocumentsBean.editingDocument.newDocTypeId}"
                       styleClass="selectBox" >
        <f:selectItems value="#{newDocumentsBean.allTypeItems}" />
      </t:selectOneMenu>
      <h:commandButton action="#{newDocumentsBean.showNewDocType}"
                       rendered="#{newDocumentsBean.renderShowNewDocTypeButton}"
                       value="#{objectBundle.show}"
                       image="#{userSessionBean.icons.show}"
                       alt="#{objectBundle.show}" title="#{objectBundle.show}"
                       styleClass="showButton" />
    </t:div>

    <t:div>
      <h:outputText value="#{newsBundle.new_documents_documentName}:" styleClass="textBox" style="width:20%" />
      <h:panelGroup>
        <t:selectOneMenu value="#{newDocumentsBean.editingDocument.documentId}"
                         style="width:300px" styleClass="selectBox">
          <f:selectItems value="#{newDocumentsBean.newDocumentSelectItems}" />
        </t:selectOneMenu>
        <h:commandButton value="#{objectBundle.search}"         image="#{userSessionBean.icons.search}"         alt="#{objectBundle.search}" title="#{objectBundle.search}"
                         action="#{newDocumentsBean.searchDocument}"
                         styleClass="searchButton" />
      </h:panelGroup>
    </t:div>

    <t:div styleClass="actionsRow">
      <h:commandButton value="#{objectBundle.store}"
                       action="#{newDocumentsBean.storeNewDocument}"
                       styleClass="storeButton" />
      <h:commandButton value="#{objectBundle.cancel}"
                       action="#{newDocumentsBean.cancelNewDocument}"
                       styleClass="cancelButton" />
    </t:div>

  </t:div>

  <sf:sendfile action="#{newDocumentsBean.refresh}"
               command="#{newDocumentsBean.command}"
               result="#{newDocumentsBean.uploadedDocId}"
               fileProperties="#{newDocumentsBean.documentProperties}"
               docTypes="#{documentConfigBean.docTypes}"
               port="#{applicationBean.serverSecurePort}"
               width="0" height="0"
               rendered="#{not userSessionBean.matrixClientEnabled}"/>
  <sf:matrixclient command="org.santfeliu.matrix.client.cmd.doc.SendDocumentCommand"
    model="#{newDocumentsBean.models.sendModel}"                   
    action="#{newDocumentsBean.documentSent}"
    function="sendDocument"
    rendered="#{userSessionBean.matrixClientEnabled}"
    helpUrl="#{matrixClientBean.helpUrl}"/>
  <sf:matrixclient command="org.santfeliu.matrix.client.cmd.doc.EditDocumentCommand"
    action="#{newDocumentsBean.documentEdited}"
    model="#{newDocumentsBean.models.editModel}"                   
    function="editDocument"
    rendered="#{userSessionBean.matrixClientEnabled}"
    helpUrl="#{matrixClientBean.helpUrl}"/>
  <sf:matrixclient command="org.santfeliu.matrix.client.cmd.doc.UpdateDocumentCommand"
    model="#{newDocumentsBean.models.updateModel}"                   
    action="#{newDocumentsBean.documentUpdated}"
    result="#{newDocumentsBean.commands.update.result}" 
    function="updateDocument"
    rendered="#{userSessionBean.matrixClientEnabled}"
    helpUrl="#{matrixClientBean.helpUrl}"/>
</jsp:root>
