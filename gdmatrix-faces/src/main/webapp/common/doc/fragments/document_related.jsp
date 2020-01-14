<?xml version='1.0' encoding='windows-1252'?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
          xmlns:f="http://java.sun.com/jsf/core"
          xmlns:h="http://java.sun.com/jsf/html"
          xmlns:t="http://myfaces.apache.org/tomahawk"
          xmlns:sf="http://www.santfeliu.org/jsf">

  <f:loadBundle basename="org.santfeliu.doc.web.resources.DocumentBundle"
                var="documentBundle" />

  <t:buffer into="#{table}">
    <t:dataTable id="data" value="#{documentRelatedBean.rows}" var="row"
                 rowStyleClass="#{documentRelatedBean.editingRow == row ? 'selectedRow' : null}"
                 rowClasses="row1,row2" headerClass="header" footerClass="footer"
                 styleClass="resultList" style="width:100%"
                 bodyStyle="#{empty documentRelatedBean.rows ? 'display:none' : ''}"
                 rendered="#{!documentRelatedBean.new}"
                 rows="#{documentRelatedBean.pageSize}">
      <t:column style="width:20%">
        <f:facet name="header">
          <h:outputText value="#{documentBundle.relation}:" />
        </f:facet>
        <h:outputText value="#{row.relationType}" />
      </t:column>
      <t:column style="width:20%">
        <f:facet name="header">
          <h:outputText value="#{documentBundle.name}:" />
        </f:facet>
        <h:outputText value="#{row.name}" />
      </t:column>
      <t:column style="width:30%">
        <f:facet name="header">
          <h:outputText value="#{documentBundle.title}:" />
        </f:facet>
        <h:outputText value="#{documentRelatedBean.relatedDocumentTitle}" />
      </t:column>
      <t:column style="width:30%;text-align:right;">
        <h:panelGroup>
          <h:commandButton value="#{objectBundle.show}"
                           image="#{userSessionBean.icons.show}"
                           alt="#{objectBundle.show}" title="#{objectBundle.show}"
                           action="#{documentRelatedBean.showRelatedDocument}"
                           rendered="#{row.docId != null}"
                           styleClass="showButton"
                           />
          <h:commandButton value="#{objectBundle.edit}"
                           image="#{userSessionBean.icons.detail}"
                           alt="#{objectBundle.edit}" title="#{objectBundle.edit}"
                           action="#{documentRelatedBean.editRelatedDocument}"
                           rendered="#{row.docId != null}"
                           styleClass="editButton" />
          <h:commandButton value="#{objectBundle.delete}"
                           image="#{userSessionBean.icons.delete}"
                           alt="#{objectBundle.delete}" title="#{objectBundle.delete}"
                           action="#{documentRelatedBean.removeRelatedDocument}"
                           rendered="#{row.docId != null}"
                           styleClass="removeButton"
                           onclick="return confirm('#{objectBundle.confirm_remove}');"
                           disabled="#{!document2Bean.editable}"
                           />
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

  <t:div styleClass="resultBar" rendered="#{documentRelatedBean.rowCount > 0}">
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
    <h:commandButton value="#{objectBundle.add}"
                     image="#{userSessionBean.icons.add}"
                     alt="#{objectBundle.add}" title="#{objectBundle.add}"
                     rendered="#{row.docId == null}"
                     action="#{documentRelatedBean.addRelatedDocument}"
                     styleClass="addButton"
                     disabled="#{!document2Bean.editable}"
                     />
  </t:div>

  <t:div styleClass="editingPanel"
            rendered="#{documentRelatedBean.editingRow != null}">
    <t:div>
      <h:outputText value="#{documentBundle.relation}:" styleClass="textBox" style="width:15%" />
      <t:selectOneMenu value="#{documentRelatedBean.editingRow.relationType}" styleClass="selectBox"
                       disabled="#{not document2Bean.editable}">
        <f:selectItems value="#{documentRelatedBean.relationTypeSelectItems}" />
        <f:converter converterId="EnumConverter" />
        <f:attribute name="enum" value="org.matrix.doc.RelationType" />
      </t:selectOneMenu>
    </t:div>

    <t:div>
      <h:outputText value="#{documentBundle.name}:" styleClass="textBox" style="width:15%" />
      <h:inputText value="#{documentRelatedBean.editingRow.name}"
                   styleClass="inputBox" style="width:440px"
                   readonly="#{not document2Bean.editable}"/>
    </t:div>

    <t:div>
      <h:outputText value="#{documentBundle.document}: " styleClass="textBox" style="width:15%" />
      <h:panelGroup>
        <t:selectOneMenu value="#{documentRelatedBean.editingRowId}"
                         style="width:350px" styleClass="selectBox"
                         disabled="#{not document2Bean.editable}">
          <f:selectItems value="#{documentRelatedBean.relatedDocumentSelectItems}" />
        </t:selectOneMenu>
      </h:panelGroup>
      <h:commandButton value="#{objectBundle.search}"
                       image="#{userSessionBean.icons.search}"
                       alt="#{objectBundle.search}" title="#{objectBundle.search}"
                       action="#{documentRelatedBean.searchDocument}"
                       styleClass="searchButton"
                       disabled="#{not document2Bean.editable}"/>
    </t:div>
    <t:div rendered="#{documentRelatedBean.renderDateFields}">
      <h:outputText value="#{documentBundle.document_captureDate}:" styleClass="textBox" style="width:15%" />
      <h:panelGroup>
        <h:outputText value="#{documentRelatedBean.editingRowCaptureDateTime}"
                      styleClass="outputBox" style="width:22%">
          <f:convertDateTime pattern="dd/MM/yyyy HH:mm:ss" />
        </h:outputText>
        <h:outputText value="#{documentBundle.by}:" styleClass="textBox" />
        <h:outputText value="#{documentRelatedBean.editingRow.captureUserId}"
                      styleClass="outputBox" style="width:20%" />
      </h:panelGroup>
    </t:div>
    <t:div rendered="#{documentRelatedBean.renderDateFields}">
      <h:outputText value="#{documentBundle.document_changeDate}:" styleClass="textBox" style="width:15%" />
      <h:panelGroup>
        <h:outputText value="#{documentRelatedBean.editingRowChangeDateTime}"
                      styleClass="outputBox" style="width:22%">
          <f:convertDateTime pattern="dd/MM/yyyy HH:mm:ss" />
        </h:outputText>
        <h:outputText value="#{documentBundle.by}:" styleClass="textBox" />
        <h:outputText value="#{documentRelatedBean.editingRow.changeUserId}"
                      styleClass="outputBox" style="width:20%" />
      </h:panelGroup>
    </t:div>


    <t:div styleClass="actionsRow">
      <h:commandButton value="#{objectBundle.store}"
                       action="#{documentRelatedBean.storeRelatedDocument}"
                       styleClass="storeButton"
                       disabled="#{not document2Bean.editable}"
                       onclick="showOverlay()"/>
      <h:commandButton value="#{objectBundle.cancel}"
                       action="#{documentRelatedBean.cancelRelatedDocument}"
                       styleClass="cancelButton" />
    </t:div>

  </t:div>

  <t:div>
    <h:selectBooleanCheckbox value="#{document2Bean.createNewVersion}"
                             style="vertical-align:middle;"
                             disabled="#{not document2Bean.editable}"/>
    <h:outputText value="#{documentBundle.document_createNewVersion}"
                  styleClass="textBox" style="vertical-align:middle;"/>
  </t:div>


</jsp:root>
