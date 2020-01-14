<?xml version='1.0' encoding='windows-1252'?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
          xmlns:f="http://java.sun.com/jsf/core"
          xmlns:h="http://java.sun.com/jsf/html"
          xmlns:t="http://myfaces.apache.org/tomahawk"
          xmlns:sf="http://www.santfeliu.org/jsf">

  <f:loadBundle basename="org.santfeliu.doc.web.resources.DocumentBundle"
                var="documentBundle"/>

  <h:panelGrid id="header" columns="1" style="width:100%"
               rendered="#{documentSearchBean.headerBrowserUrl!=null and documentSearchBean.headerRender}"
               styleClass="headerDocument">
    <sf:browser url="#{documentSearchBean.headerBrowserUrl}"
      port="#{applicationBean.defaultPort}"
      translator="#{userSessionBean.translator}"
      translationGroup="#{userSessionBean.translationGroup}" />
  </h:panelGrid>

  <t:div styleClass="confirmPickup"
    rendered="#{documentSearchBean.selectedDocument != null and
      documentSearchBean.renderPickUpButton}" >
    <t:div styleClass="header">
      <h:outputText value="#{documentBundle.confirmAddSelectedDocument}" />
    </t:div>
    <t:div styleClass="body">
      <h:outputText value="#{documentSearchBean.selectedDocument.title}" />
    </t:div>
    <t:div styleClass="footer">
      <h:commandButton value="#{documentBundle.confirmYes}"
        action="#{documentSearchBean.addSelectedDocument}" immediate="true" />
      <h:commandButton value="#{documentBundle.confirmNo}"
        action="#{documentSearchBean.discardSelectedDocument}" immediate="true" />
    </t:div>
  </t:div>

  <t:div styleClass="filterPanel" rendered="#{documentSearchBean.renderFilterPanel}">
    

    <t:div styleClass="column1" rendered="#{documentSearchBean.renderDocId}">
      <h:outputLabel for="docId" value="#{objectBundle.object_id}:" />
    </t:div>
    <t:div styleClass="column2" rendered="#{documentSearchBean.renderDocId}">
      <h:inputText id="docId" value="#{documentSearchBean.docId}"
                   rendered="#{documentSearchBean.renderDocId}"
                   styleClass="inputBox" style="width:10%" />
      <h:outputLabel for="version" value="#{documentBundle.outputVersion}"
                    rendered="#{documentSearchBean.renderVersion}"
                    style="padding-left:5pt" />
      <h:inputText id="version" value="#{documentSearchBean.version}"
                   rendered="#{documentSearchBean.renderVersion}"
                   styleClass="inputBox" style="width:5%"/>
      <h:outputLabel for="contentId" value="#{documentBundle.outputContentId}"
                    rendered="#{documentSearchBean.renderContentId}"
                    style="padding-left:5pt"/>
      <h:inputText id="contentId" value="#{documentSearchBean.filter.contentId}"
                   rendered="#{documentSearchBean.renderContentId}"
                   styleClass="inputBox" style="width:48%"/>
    </t:div>


    <t:div styleClass="column1" rendered="#{documentSearchBean.renderTitle}">
      <h:outputLabel for="title" value="#{documentBundle.outputTitle}"
                    rendered="#{documentSearchBean.renderTitle}"/>
    </t:div>
    <t:div styleClass="column2" rendered="#{documentSearchBean.renderTitle}">
      <t:inputText id="title" forceId="true"
                   value="#{documentSearchBean.titleFilter}"
                   rendered="#{documentSearchBean.renderTitle}"
                   styleClass="inputBox" style="width:95%"/>
    </t:div>


    <t:div styleClass="column1" rendered="#{documentSearchBean.renderType}">
      <h:outputLabel for="typeId" value="#{documentBundle.outputType}"
         rendered="#{documentSearchBean.renderType}"/>
    </t:div>      
    <t:div styleClass="column2" rendered="#{documentSearchBean.renderType}">
      <sf:commandMenu id="typeId" value="#{documentSearchBean.currentTypeId}"
                    styleClass="selectBox"
                    action="#{documentSearchBean.reset}">
        <f:selectItems value="#{documentSearchBean.typeSelectItems}" />
      </sf:commandMenu>
      <h:commandButton value="#{objectBundle.search}" styleClass="searchButton"
        action="#{documentSearchBean.searchType}"
        image="#{userSessionBean.icons.search}"
        alt="#{objectBundle.search}" title="#{objectBundle.search}"/>
    </t:div>


    <t:div styleClass="column1" rendered="#{documentSearchBean.renderState}">
      <h:outputLabel value="#{documentBundle.outputState}"
                    rendered="#{documentSearchBean.renderState}"/>
    </t:div>
    <t:div styleClass="column2" rendered="#{documentSearchBean.renderState}">
      <h:selectBooleanCheckbox id="draftCB" style="vertical-align:middle;"
                               value="#{documentSearchBean.includeDraftCBValue}"
                               rendered="#{documentSearchBean.renderDraftState}"/>
      <h:outputText id="draftCBText" value="#{documentBundle.stateDraft}"
                    styleClass="textBox" style="vertical-align:middle;"
                    rendered="#{documentSearchBean.renderDraftState}"/>
      <h:selectBooleanCheckbox id="completeCB" style="vertical-align:middle;"
                               value="#{documentSearchBean.includeCompleteCBValue}"
                               rendered="#{documentSearchBean.renderCompleteState}"/>
      <h:outputText id="completeCBText" value="#{documentBundle.stateComplete}"
                    styleClass="textBox" style="vertical-align:middle;"
                    rendered="#{documentSearchBean.renderCompleteState}"/>
      <h:selectBooleanCheckbox id="recordCB" style="vertical-align:middle;"
                               value="#{documentSearchBean.includeRecordCBValue}"
                               rendered="#{documentSearchBean.renderRecordState}"/>
      <h:outputText id="recordCBText" value="#{documentBundle.stateRecord}"
                    styleClass="textBox" style="vertical-align:middle;"
                    rendered="#{documentSearchBean.renderRecordState}"/>
      <h:selectBooleanCheckbox id="deletedCB" style="vertical-align:middle;"
                               value="#{documentSearchBean.includeDeletedCBValue}"
                               rendered="#{documentSearchBean.renderDeletedState}"/>
      <h:outputText id="deletedCBText" value="#{documentBundle.stateDeleted}"
                    styleClass="textBox deletedDocument" style="vertical-align:middle"
                    rendered="#{documentSearchBean.renderDeletedState}"/>
    </t:div>

    <t:div styleClass="column1" rendered="#{documentSearchBean.renderClass}">
      <h:outputLabel for="classId" value="#{documentBundle.document_classId}:"
        rendered="#{documentSearchBean.renderClass}"/>
    </t:div>
    <t:div styleClass="column2" rendered="#{documentSearchBean.renderClass}">
      <t:inputText id="classId" forceId="true"
        value="#{documentSearchBean.classId}" styleClass="inputBox" />
     <h:commandButton value="#{objectBundle.search}" styleClass="searchButton"
        action="#{documentSearchBean.searchClass}"
        image="#{userSessionBean.icons.search}"
        alt="#{objectBundle.search}" title="#{objectBundle.search}"/>
    </t:div>


    <t:div styleClass="column1" rendered="#{documentSearchBean.renderDate}">
      <h:outputLabel for="dateComparator" value="#{documentBundle.documentSearch_date}:"
                    rendered="#{documentSearchBean.renderDate}"/>
    </t:div>  
    <t:div styleClass="column2" rendered="#{documentSearchBean.renderDate}">
      <t:selectOneMenu id="dateComparator" value="#{documentSearchBean.filter.dateComparator}"
                       styleClass="selectBox" style="vertical-align:middle">
        <f:selectItem itemLabel="#{documentBundle.documentSearch_changeDateTime}" itemValue="1" />
        <f:selectItem itemLabel="#{documentBundle.documentSearch_captureDateTime}" itemValue="2" />
        <f:selectItem itemLabel="#{documentBundle.documentSearch_creationDate}" itemValue="3" />
      </t:selectOneMenu>
      <h:outputLabel for="startDate" value="#{documentBundle.outputStartDate}"
                    rendered="#{documentSearchBean.renderDate}"/>
      <sf:calendar id="startDate" value="#{documentSearchBean.filter.startDate}"
                   styleClass="calendarBox" style="width:15%"
                   buttonStyleClass="calendarButton" />
      <h:outputLabel for="endDate" value="#{documentBundle.outputEndDate}"
                    style="padding-left:5pt"/>
      <sf:calendar id="endDate" value="#{documentSearchBean.filter.endDate}"
                   styleClass="calendarBox" style="width:15%"
                   buttonStyleClass="calendarButton" />
    </t:div>



    <t:div styleClass="column1" rendered="#{documentSearchBean.renderData}">
      <h:outputLabel for="contentSearch" value="#{documentBundle.outputContents}"
                   />
    </t:div>
    <t:div styleClass="column2" rendered="#{documentSearchBean.renderData}">
      <t:inputText id="contentSearch" forceId="true"
                   value="#{documentSearchBean.filter.contentSearchExpression}"
                   styleClass="inputBox" style="width:90%"/>
      <h:outputLink value="#{documentSearchBean.searchHelpDocumentUrl}"
        target="_blank"
        accesskey="h" style="margin-left:4px; vertical-align:bottom"
        rendered="#{documentSearchBean.searchHelpDocumentUrl != null}">
        <h:graphicImage value="/images/help.png"
          style="border:none" alt="help" />
      </h:outputLink>
    </t:div>



    <t:div styleClass="column1" rendered="#{documentSearchBean.renderLanguage}">
      <h:outputLabel for="idioma" value="#{documentBundle.outputLanguage}"
                     />
    </t:div>
    <t:div styleClass="column2" rendered="#{documentSearchBean.renderLanguage}">
      <t:selectOneMenu id="idioma"
                       value="#{documentSearchBean.filter.language}"                 
                       styleClass="selectBox">
        <f:selectItem itemValue="" itemLabel=" "/>
        <f:selectItems value="#{documentSearchBean.languageValues}" />
  <!--      
        <f:selectItem itemValue="%%" itemLabel="universal"/>
        <f:selectItem itemValue="ca" itemLabel="#{documentBundle.selectItemCA}"/>
        <f:selectItem itemValue="es" itemLabel="#{documentBundle.selectItemES}"/>
        <f:selectItem itemValue="en" itemLabel="#{documentBundle.selectItemEN}"/>
        <f:selectItem itemValue="fr" itemLabel="#{documentBundle.selectItemFR}"/>
        <f:selectItem itemValue="it" itemLabel="#{documentBundle.selectItemIT}"/>
        <f:selectItem itemValue="de" itemLabel="#{documentBundle.selectItemDE}"/>
  -->
      </t:selectOneMenu>
    </t:div>


    
    <t:div styleClass="column1" rendered="#{documentSearchBean.renderOutputSearchExpression}">
      <h:outputLabel for="metadataSearch" value="#{documentBundle.outputSearchExpression}"/>
    </t:div>
    <t:div styleClass="column2" rendered="#{documentSearchBean.renderOutputSearchExpression}">
      <h:inputText id="metadataSearch" value="#{documentSearchBean.filter.metadataSearchExpression}"
        styleClass="inputBox" style="width:90%"/>
    </t:div> 


    <t:div styleClass="column1" rendered="#{documentSearchBean.renderPropertyValueFilter}">
      <h:outputLabel for="propertyName1" value="#{documentBundle.documentSearch_property} / #{documentBundle.documentSearch_value} 1:"
                    rendered="#{documentSearchBean.renderPropertyValueFilter}"/>
    </t:div>
    <t:div styleClass="column2" rendered="#{documentSearchBean.renderPropertyValueFilter}">
      <h:inputText id="propertyName1" value="#{documentSearchBean.propertyName1}"
                   styleClass="inputBox" style="width:25%"/>
      <h:outputLabel for="propertyValue1" value=":" />
      <h:inputText id="propertyValue1" value="#{documentSearchBean.propertyValue1}"
                   styleClass="inputBox" style="width:63%"/>
    </t:div>



    <t:div styleClass="column1"  rendered="#{documentSearchBean.renderPropertyValueFilter}">
      <h:outputLabel for="propertyName2" value="#{documentBundle.documentSearch_property} / #{documentBundle.documentSearch_value} 2:"
                    rendered="#{documentSearchBean.renderPropertyValueFilter}"/>
    </t:div>
    <t:div styleClass="column2"  rendered="#{documentSearchBean.renderPropertyValueFilter}">
      <h:inputText id="propertyName2" value="#{documentSearchBean.propertyName2}"
                   styleClass="inputBox" style="width:25%"/>
      <h:outputLabel for="propertyValue2" value=":" />
      <h:inputText id="propertyValue2" value="#{documentSearchBean.propertyValue2}"
                   styleClass="inputBox" style="width:63%"/>
    </t:div>

    <t:div styleClass="footer">
        <t:div style="text-align:left" rendered="#{documentSearchBean.renderDynamicForm}">
          <t:collapsiblePanel var="collapsed"
                              rendered="#{documentSearchBean.renderCollapsiblePanel}">
            <f:facet name="header">
              <t:div styleClass="title" >
                <t:headerLink immediate="true">
                  <h:graphicImage value="/images/expand.gif" rendered="#{collapsed}"/>
                  <h:graphicImage value="/images/collapse.gif" rendered="#{!collapsed}"/>
                </t:headerLink>
                <h:outputText value=" #{objectBundle.more_properties}: " />
              </t:div>
            </f:facet>
            <sf:dynamicForm
              form="#{documentSearchBean.form}"
              rendererTypes="HtmlFormRenderer"
              value="#{documentSearchBean.data}" />
          </t:collapsiblePanel>
          <sf:dynamicForm rendered="#{not documentSearchBean.renderCollapsiblePanel}"
            form="#{documentSearchBean.form}"
            rendererTypes="HtmlFormRenderer"
            value="#{documentSearchBean.data}" />
        </t:div>
        <h:commandButton value="#{objectBundle.clear}"
                       styleClass="searchButton"
                       action="#{documentSearchBean.clearFilter}"
                       rendered="#{documentSearchBean.renderClearButton}" /> 
        <h:commandButton id="default_button" value="#{objectBundle.search}"
                         styleClass="searchButton"
                         action="#{documentSearchBean.newSearch}"
                         rendered="#{documentSearchBean.renderSearchButton}"
                         onclick="showOverlay()"/>
    </t:div>
 
  </t:div>

<t:div styleClass="actionsBar top" rendered="#{documentSearchBean.rowCount > 2}"> 
     <h:commandButton value="#{objectBundle.search}"
        styleClass="searchButton"
        action="#{documentSearchBean.pickUpDocument}"
        image="#{userSessionBean.icons.search}"
        alt="#{objectBundle.search}" title="#{objectBundle.search}"
        rendered="#{documentSearchBean.renderPickUpButton}"/>
     <h:commandButton value="#{objectBundle.current}"
       action="#{document2Bean.show}" immediate="true"
       styleClass="currentButton"
       image="#{userSessionBean.icons.current}"
       alt="#{objectBundle.current}" title="#{objectBundle.current}"
       rendered="#{documentSearchBean.editorUser}"/>
     <h:commandButton value="#{objectBundle.create}"
       action="#{document2Bean.create}" immediate="true"
       styleClass="createButton"
       image="#{userSessionBean.icons.new}"
       alt="#{objectBundle.create}" title="#{objectBundle.create}"
       rendered="#{documentSearchBean.editorUser}"/>
     <h:commandButton value="#{objectBundle.upload}"
       styleClass="createButton" onclick="javascript:htmlSendFile_send();return false"
       image="#{userSessionBean.icons.upload}"
       alt="#{objectBundle.upload}" title="#{objectBundle.upload}"
       rendered="#{documentSearchBean.editorUser and (not userSessionBean.matrixClientEnabled)}"/>
     <h:commandButton value="#{objectBundle.upload}"
       styleClass="createButton" onclick="javascript:sendDocument();return false"
       image="#{userSessionBean.icons.upload}"
       alt="#{objectBundle.upload}" title="#{objectBundle.upload}"
       rendered="#{documentSearchBean.editorUser and userSessionBean.matrixClientEnabled}"/>
  </t:div>

  <t:div styleClass="resultBar" rendered="#{documentSearchBean.rows != null}">
    <t:dataScroller for="data"
      firstRowIndexVar="firstRow"
      lastRowIndexVar="lastRow"
      rowsCountVar="rowCount"
      rendered="#{documentSearchBean.rowCount > 0}">
      <h:outputFormat value="#{objectBundle.resultRange}"
        style="margin-top:10px;display:block">
        <f:param value="#{firstRow}" />
        <f:param value="#{lastRow}" />
        <f:param value="#{rowCount}" />
      </h:outputFormat>
    </t:dataScroller>
    <h:outputText value="#{objectBundle.no_results_found}"
      rendered="#{documentSearchBean.rowCount == 0}" />
  </t:div>

  <t:dataTable rows="#{documentSearchBean.pageSize}" id="data"
    first="#{documentSearchBean.firstRowIndex}" var="row"
    value="#{documentSearchBean.rows}" 
    rendered="#{documentSearchBean.rowCount > 0}"
    rowStyleClass="#{documentSearchBean.currentDocument ? 'selectedRow' : null}"
    styleClass="resultList"
    rowClasses="row1,row2" headerClass="header" footerClass="footer">

    <t:columns value="#{documentSearchBean.columnNames}" var="column"
               style="#{documentSearchBean.columnStyle}"
               styleClass="#{documentSearchBean.columnStyleClass}">
      <f:facet name="header">
        <h:panelGroup>
          <h:outputText value="#{documentSearchBean.localizedColumnName}"
                        rendered="#{not (documentSearchBean.columnName == 'actions' and documentSearchBean.customColumn)}"/>                          
          <h:outputText value="#{documentBundle.actions}"
                        rendered="#{(documentSearchBean.columnName == 'actions' and documentSearchBean.customColumn)}"
                        styleClass="element-invisible" />                                    
        </h:panelGroup>
      </f:facet>

      <h:panelGroup rendered="#{!documentSearchBean.customColumn}">
        <!-- render as command link -->
        <h:commandLink immediate="true"
                       action="#{documentSearchBean.showDocument}"
                       rendered="#{documentSearchBean.submitColumn}">
          <h:outputText value="#{documentSearchBean.columnValue}"
                        styleClass="#{row.state == 'DELETED' ? 'deletedDocument' : null}"/>
        </h:commandLink>

        <!-- render link type -->
        <h:outputLink target="_blank" value="#{documentSearchBean.columnValue}"
                      rendered="#{documentSearchBean.linkColumn}">
          <h:outputText value="#{documentSearchBean.columnValue}"
                        styleClass="#{row.state == 'DELETED' ? 'deletedDocument' : null}"/>
        </h:outputLink>

        <!-- render image type -->
        <h:graphicImage value="#{documentSearchBean.columnValue}"
          rendered="#{documentSearchBean.imageColumn and documentSearchBean.columnValue != null}"/>

        <!-- render default type -->
        <h:outputText value="#{documentSearchBean.columnValue}"
                      rendered="#{not documentSearchBean.imageColumn and not documentSearchBean.linkColumn
                        and not documentSearchBean.submitColumn}}"
                      styleClass="#{row.state == 'DELETED' ? 'deletedDocument' : null}"/>
      </h:panelGroup>

      <!-- page source title -->
      <h:panelGroup rendered="#{documentSearchBean.columnName == 'title' and
        documentSearchBean.renderDescColumn}" styleClass="descColumn">
        <f:facet name="header">
          <h:outputText value="#{documentBundle.headerColDesc}"/>
        </f:facet>
        <h:graphicImage url="#{documentSearchBean.fileTypeImage}"
          height="16" width="16"
          style="border:0;vertical-align:middle;margin-right:2px"
          rendered="#{not documentSearchBean.renderUrlColumn}"/>

        <h:outputLink target="_blank" styleClass="documentLink"
           value="#{documentSearchBean.url}"
           rendered="#{documentSearchBean.url != null and row.content != null
            and row.content.contentId != null}">
          <h:outputText value="#{documentSearchBean.documentTitle}"
                        styleClass="#{row.state == 'DELETED' ? 'deletedDocument' : null}"/>
          <h:outputText value=" (#{documentSearchBean.extension})"
                        styleClass="#{row.state == 'DELETED' ? 'deletedDocument' : null}"
                        rendered="#{documentSearchBean.extensionRender 
                          and documentSearchBean.extension != null}" />          
        </h:outputLink>

        <h:outputText value="#{documentSearchBean.documentTitle}" rendered="#{row.content == null
          or row.content.contentId == null}"
          styleClass="#{row.state == 'DELETED' ? 'deletedDocument' : null}"/>

        <h:panelGroup>
          <h:graphicImage url="#{userSessionBean.icons.lock}" height="16" width="16"
                          style="vertical-align:middle;margin-left:5px" alt="#{documentBundle.lock}" title="#{row.lockUserId}"
                          rendered="#{row.lockUserId != null and userSessionBean.username != row.lockUserId}"/>
          <h:graphicImage url="#{userSessionBean.icons.unlock}" height="16" width="16"
                          style="vertical-align:middle;margin-left:5px" alt="#{documentBundle.lock}" title="#{row.lockUserId}"
                          rendered="#{row.lockUserId != null and userSessionBean.username == row.lockUserId}"/>
        </h:panelGroup>
      </h:panelGroup>
      
      <h:panelGroup rendered="#{documentSearchBean.columnName == 'url' and
                                documentSearchBean.renderUrlColumn}"
                styleClass="urlColumn">
        <f:facet name="header">
          <h:outputText value="#{documentBundle.headerColURL}"/>
        </f:facet>
        <h:outputLink target="_blank"
                      value="#{documentSearchBean.url}">
          <sf:graphicImage url="#{documentSearchBean.fileTypeImage}" height="16" width="16"
                          style="border:0" 
                          alt="#{documentBundle.documentSearch_url} #{documentSearchBean.documentTitle} (#{documentSearchBean.extension})" 
                          title="#{documentBundle.documentSearch_url} #{documentSearchBean.documentTitle} (#{documentSearchBean.extension})" />
        </h:outputLink>
      </h:panelGroup>
                          
      <h:panelGroup rendered="#{documentSearchBean.columnName == 'langText' and
                                documentSearchBean.renderLangColumn}"
                    styleClass="langColumn">
        <h:outputText value="#{documentSearchBean.language}" 
                      styleClass="#{row.state == 'DELETED' ? 'deletedDocument' : null}"/>
      </h:panelGroup>                          
      
      <h:panelGroup rendered="#{documentSearchBean.columnName == 'language' 
                                and documentSearchBean.renderLangColumn}"
                    styleClass="langColumn">
        <h:graphicImage url="#{documentSearchBean.languageFlag}" 
                style="border:0"/>
      </h:panelGroup>                          

      <!-- page source actions -->
      <h:panelGroup styleClass="actionsColumn"  style="text-align:right"
        rendered="#{documentSearchBean.columnName == 'actions' and documentSearchBean.editorUser}">
        <h:commandButton 
            image="#{userSessionBean.icons.back}"
            styleClass="showButton"
            onclick="javascript:window.opener.CKEDITOR.tools.callFunction(#{documentSearchBean.editorCallback}, '#{documentSearchBean.protectedUrl}');window.close();false" 
            rendered="#{documentSearchBean.CKEditorCall}"
            alt="#{documentBundle.select} #{documentSearchBean.documentTitle}"/>          
     
        <h:commandButton value="#{objectBundle.show}"
           onclick="javascript:window.open('#{documentSearchBean.markupUrl}');return false"
           rendered="#{row.docId != null and (documentSearchBean.markupUrl != null) and !documentSearchBean.CKEditorCall}"
           styleClass="editButton"
           image="/common/doc/images/markup.gif"
           alt="#{objectBundle.show}" title="#{objectBundle.show}" />

        <h:commandButton value="#{objectBundle.edit}"
           rendered="#{row.content != null and (documentSearchBean.editorUser) and (row.docId != null) and (row.lockUserId == null or userSessionBean.username == row.lockUserId) and (not userSessionBean.matrixClientEnabled)}"
           styleClass="editButton" onclick="javascript:htmlSendFile_edit('#{row.docId}','#{row.language}');return false"
           image="#{userSessionBean.icons.edit}"
           alt="#{objectBundle.edit}" title="#{objectBundle.edit}" />
         <h:commandButton value="#{objectBundle.edit}"
           rendered="#{row.content != null and (documentSearchBean.editorUser) and (row.docId != null) and (row.lockUserId == null or userSessionBean.username == row.lockUserId) and userSessionBean.matrixClientEnabled}"
           styleClass="editButton" 
           onclick="javascript:editDocument({docId:'#{row.docId}'});return false"
           image="#{userSessionBean.icons.edit}"
           alt="#{objectBundle.edit}" title="#{objectBundle.edit}" />
         
        <h:commandButton value="#{objectBundle.upload}"
           rendered="#{(documentSearchBean.editorUser) and (row.docId != null) and (row.lockUserId == null or userSessionBean.username == row.lockUserId) and (not userSessionBean.matrixClientEnabled)}"
           styleClass="editButton" onclick="javascript:htmlSendFile_update('#{row.docId}');return false"
           image="#{userSessionBean.icons.upload}"
           alt="#{objectBundle.upload}" title="#{objectBundle.upload}" />
        <h:commandButton value="#{objectBundle.upload}"
           rendered="#{(documentSearchBean.editorUser) and (row.docId != null) and (row.lockUserId == null or userSessionBean.username == row.lockUserId) and userSessionBean.matrixClientEnabled}"
           styleClass="editButton" 
           onclick="javascript:updateDocument({docId:'#{row.docId}'});return false"
           image="#{userSessionBean.icons.upload}"
           alt="#{objectBundle.upload}" title="#{objectBundle.upload}" />        
        
        <h:commandButton value="#{objectBundle.download}"
          onclick="javascript:window.open('#{documentSearchBean.downloadUrl}');return false"
          rendered="#{documentSearchBean.url != null and row.content != null
            and row.content.contentId != null and !documentSearchBean.CKEditorCall}"
          styleClass="editButton"
          image="#{userSessionBean.icons.download}"
          alt="#{objectBundle.download}" title="#{objectBundle.download}" />
        <h:commandButton value="#{objectBundle.select}"
          rendered="#{controllerBean.selectableNode and !documentSearchBean.CKEditorCall}"
          styleClass="selectButton" immediate="true"
          action="#{documentSearchBean.selectDocument}"
          image="#{userSessionBean.icons.back}"
          alt="#{objectBundle.select}" title="#{objectBundle.select}" />
        <h:commandButton value="#{objectBundle.show}"
          styleClass="showButton" immediate="true" rendered="#{!documentSearchBean.CKEditorCall}"
          action="#{documentSearchBean.showDocument}"
          image="#{userSessionBean.icons.show}"
          alt="#{objectBundle.show}" title="#{objectBundle.show}"    />
      </h:panelGroup>
    </t:columns>
      

  </t:dataTable>
      
  <t:dataScroller for="data"
    fastStep="100"
    paginator="true"
    paginatorMaxPages="9"
    immediate="true"
    rendered="#{documentSearchBean.rows != null}"
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
        <h:graphicImage value="/themes/#{userSessionBean.theme}/images/first.png" alt="#{objectBundle.first}" title="#{objectBundle.first}"/>
      </f:facet>
      <f:facet name="last">
        <h:graphicImage value="/themes/#{userSessionBean.theme}/images/last.png" alt="#{objectBundle.last}" title="#{objectBundle.last}"/>
      </f:facet>
      <f:facet name="previous">
        <h:graphicImage value="/themes/#{userSessionBean.theme}/images/previous.png" alt="#{objectBundle.previous}" title="#{objectBundle.previous}"/>
      </f:facet>
      <f:facet name="next">
        <h:graphicImage value="/themes/#{userSessionBean.theme}/images/next.png" alt="#{objectBundle.next}" title="#{objectBundle.next}"/>
      </f:facet>
      <f:facet name="fastrewind">
        <h:graphicImage value="/themes/#{userSessionBean.theme}/images/fastrewind.png" alt="#{objectBundle.fastRewind}" title="#{objectBundle.fastRewind}"/>
      </f:facet>
      <f:facet name="fastforward">
        <h:graphicImage value="/themes/#{userSessionBean.theme}/images/fastforward.png" alt="#{objectBundle.fastForward}" title="#{objectBundle.fastForward}"/>
      </f:facet>
  </t:dataScroller>      

  <t:div styleClass="actionsBar">
     <h:commandButton value="#{objectBundle.search}"
        styleClass="searchButton"
        action="#{documentSearchBean.pickUpDocument}"
        image="#{userSessionBean.icons.search}"
        alt="#{objectBundle.search}" title="#{objectBundle.search}"
        rendered="#{documentSearchBean.renderPickUpButton}"/>
     <h:commandButton value="#{objectBundle.current}"
       action="#{document2Bean.show}" immediate="true"
       styleClass="currentButton"
       image="#{userSessionBean.icons.current}"
       alt="#{objectBundle.current}" title="#{objectBundle.current}"
       rendered="#{documentSearchBean.editorUser}"/>
     <h:commandButton value="#{objectBundle.create}"
       action="#{document2Bean.create}" immediate="true"
       styleClass="createButton"
       image="#{userSessionBean.icons.new}"
       alt="#{objectBundle.create}" title="#{objectBundle.create}"
       rendered="#{documentSearchBean.editorUser}"/>
     <h:commandButton value="#{objectBundle.upload}"
       styleClass="createButton" onclick="javascript:htmlSendFile_send();return false"
       image="#{userSessionBean.icons.upload}"
       alt="#{objectBundle.upload}" title="#{objectBundle.upload}"
       rendered="#{documentSearchBean.editorUser and (not userSessionBean.matrixClientEnabled)}"/>
     <h:commandButton value="#{objectBundle.upload}"
       styleClass="createButton" onclick="javascript:sendDocument();return false"
       image="#{userSessionBean.icons.upload}"
       alt="#{objectBundle.upload}" title="#{objectBundle.upload}"
       rendered="#{documentSearchBean.editorUser and userSessionBean.matrixClientEnabled}"/>
  </t:div>

  <sf:sendfile height="0" width="0" rendered="#{documentSearchBean.editorUser 
                and not userSessionBean.matrixClientEnabled}"
               action="#{documentSearchBean.searchIfFilterNotEmpty}"
               fileProperties="#{documentSearchBean.documentProperties}"
               docTypes="#{documentConfigBean.docTypes}"
               port="#{applicationBean.serverSecurePort}"/>
  
  <sf:matrixclient command="org.santfeliu.matrix.client.cmd.doc.SendDocumentCommand"
    model="#{documentSearchBean.sendModel}"                   
    action="#{documentSearchBean.documentSent}"
    function="sendDocument"
    rendered="#{documentSearchBean.editorUser and userSessionBean.matrixClientEnabled}"
    helpUrl="#{matrixClientBean.helpUrl}"/>
  <sf:matrixclient command="org.santfeliu.matrix.client.cmd.doc.EditDocumentCommand"
    action="#{documentSearchBean.documentEdited}"
    model="#{documentSearchBean.editModel}"                   
    function="editDocument"
    rendered="#{documentSearchBean.editorUser and userSessionBean.matrixClientEnabled}"
    helpUrl="#{matrixClientBean.helpUrl}"/>
  <sf:matrixclient command="org.santfeliu.matrix.client.cmd.doc.UpdateDocumentCommand"
    model="#{documentSearchBean.updateModel}"                   
    action="#{documentSearchBean.documentUpdated}"
    function="updateDocument"
    rendered="#{documentSearchBean.editorUser and userSessionBean.matrixClientEnabled}"
    helpUrl="#{matrixClientBean.helpUrl}"/>
  
  <h:panelGrid id="footer" columns="1" style="width:100%"
               rendered="#{documentSearchBean.footerBrowserUrl!=null and documentSearchBean.footerRender}"
               styleClass="footerDocument">
    <sf:browser url="#{documentSearchBean.footerBrowserUrl}"
      port="#{applicationBean.defaultPort}"
      translator="#{userSessionBean.translator}"
      translationGroup="#{userSessionBean.translationGroup}" />
  </h:panelGrid>

</jsp:root>