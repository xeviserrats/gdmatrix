<?xml version='1.0' encoding='windows-1252'?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
          xmlns:f="http://java.sun.com/jsf/core"
          xmlns:h="http://java.sun.com/jsf/html"
          xmlns:t="http://myfaces.apache.org/tomahawk"
          xmlns:sf="http://www.santfeliu.org/jsf">

  <f:loadBundle basename="org.santfeliu.doc.web.resources.DocumentBundle"
                var="documentBundle" />

  <t:buffer into="#{table}">
    <t:dataTable id="data" value="#{documentCasesBean.rows}" var="row"
                 rowClasses="row1,row2" headerClass="header" footerClass="footer"
                 styleClass="resultList" style="width:100%"
                 bodyStyle="#{empty documentCasesBean.rows ? 'display:none' : ''}"
                 rendered="#{!documentCasesBean.new}"
                 rows="#{documentCasesBean.pageSize}">
      <t:column style="width:30%">
        <f:facet name="header">
          <h:outputText value="#{documentBundle.documentCases_caseCode}:" />
        </f:facet>
        <h:outputText value="#{row.caseObject.caseId}" />
      </t:column>
      <t:column style="width:40%">
        <f:facet name="header">
          <h:outputText value="#{documentBundle.title}:" />
        </f:facet>
        <h:outputText value="#{row.caseObject.title}" />
      </t:column>
      <t:column style="width:30%;text-align:right;">
        <h:panelGroup>
          <h:commandButton value="#{objectBundle.show}"
                           action="#{documentCasesBean.showDocumentCase}"
                           styleClass="showButton"
                           image="#{userSessionBean.icons.show}"
                           alt="#{objectBundle.show}" title="#{objectBundle.show}"           />
          <h:commandButton value="#{objectBundle.remove}"
                           image="#{userSessionBean.icons.delete}"
                           alt="#{objectBundle.delete}" title="#{objectBundle.delete}"
                           action="#{documentCasesBean.removeDocumentCase}"
                           styleClass="removeButton"
                           onclick="return confirm('#{objectBundle.confirm_remove}');"
                           disabled="#{!document2Bean.editable}"/>
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

  <t:div styleClass="resultBar" rendered="#{documentCasesBean.rowCount > 0}">
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

  <t:div styleClass="editingPanel" rendered="#{!documentCasesBean.new}">

    <h:outputText value="#{documentBundle.documentCases_case}: " styleClass="textBox" style="width:15%" />
    <h:panelGroup>
      <t:selectOneMenu value="#{documentCasesBean.editingCaseId}"
                       style="width:350px" styleClass="selectBox">
        <f:selectItems value="#{documentCasesBean.documentCaseSelectItems}" />
      </t:selectOneMenu>
    </h:panelGroup>
    <h:commandButton value="#{objectBundle.add}"
                     image="#{userSessionBean.icons.add}"
                     alt="#{objectBundle.add}" title="#{objectBundle.add}"
                     action="#{documentCasesBean.storeDocumentCase}"
                     styleClass="addButton"
                     disabled="#{!document2Bean.editable}"
                     onclick="showOverlay()"/>
    <h:commandButton value="#{objectBundle.search}"
                     image="#{userSessionBean.icons.search}"
                     alt="#{objectBundle.search}" title="#{objectBundle.search}"
                     action="#{documentCasesBean.searchCase}"
                     styleClass="searchButton"
                     disabled="#{not document2Bean.editable}"/>
  </t:div>

</jsp:root>
