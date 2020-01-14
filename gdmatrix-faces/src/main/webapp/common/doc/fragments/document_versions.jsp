<?xml version='1.0' encoding='windows-1252'?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
          xmlns:f="http://java.sun.com/jsf/core"
          xmlns:h="http://java.sun.com/jsf/html"
          xmlns:t="http://myfaces.apache.org/tomahawk"
          xmlns:sf="http://www.santfeliu.org/jsf">

  <f:loadBundle basename="org.santfeliu.doc.web.resources.DocumentBundle"
                var="documentBundle" />

  <t:buffer into="#{table}">
    <t:dataTable id="data" value="#{documentVersionsBean.rows}" var="row"
                 rowClasses="row1,row2" headerClass="header" footerClass="footer"
                 styleClass="resultList" style="width:100%"
                 rendered="#{!documentVersionsBean.new}"
                 rows="#{documentVersionsBean.pageSize}">
      <t:column style="width:10%">
        <f:facet name="header">
          <h:outputText value="#{documentBundle.version}:"  />
        </f:facet>
        <h:outputText value="#{row.version}"
                      style="#{documentVersionsBean.currentVersion ? 'font-weight:bold;' : ''}"
                      styleClass="#{row.state == 'DELETED' ? 'deletedDocument' : null}"/>
      </t:column>
      <t:column style="width:34%">
        <f:facet name="header">
          <h:outputText value="#{documentBundle.title}:" />
        </f:facet>
        <h:outputText value="#{row.title}"
                      style="#{documentVersionsBean.currentVersion ? 'font-weight:bold;' : ''}" 
                      styleClass="#{row.state == 'DELETED' ? 'deletedDocument' : null}"/>
      </t:column>
      <t:column style="width:18%">
        <f:facet name="header">
          <h:outputText value="#{documentBundle.document_captureDate}:" />
        </f:facet>
        <h:outputText value="#{documentVersionsBean.rowCaptureDateTime}"
                      style="#{documentVersionsBean.currentVersion ? 'font-weight:bold;' : ''}"
                      styleClass="#{row.state == 'DELETED' ? 'deletedDocument' : null}">
          <f:convertDateTime pattern="dd/MM/yyyy" />
        </h:outputText>
      </t:column>
      <t:column style="width:18%">
        <f:facet name="header">
          <h:outputText value="#{documentBundle.document_changeDate}:" />
        </f:facet>
        <h:outputText value="#{documentVersionsBean.rowChangeDateTime}"
                      style="#{documentVersionsBean.currentVersion ? 'font-weight:bold;' : ''}"
                      styleClass="#{row.state == 'DELETED' ? 'deletedDocument' : null}">
          <f:convertDateTime pattern="dd/MM/yyyy" />
        </h:outputText>
      </t:column>
      <t:column style="width:20%;text-align:right;">
        <h:panelGroup>
          <h:commandButton value="#{objectBundle.show}"
                           image="#{userSessionBean.icons.show}"
                           alt="#{objectBundle.show}" title="#{objectBundle.show}"
                           action="#{documentVersionsBean.showDocument}"
                           styleClass="showButton"  />
          <h:commandButton value="#{objectBundle.delete}"
                           image="#{userSessionBean.icons.delete}"
                           alt="#{objectBundle.delete}" title="#{objectBundle.delete}"
                           action="#{documentVersionsBean.removeDocument}"
                           styleClass="removeButton"
                           disabled="#{!document2Bean.editable}"
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

  <t:div styleClass="resultBar" rendered="#{documentVersionsBean.rowCount > 0}">
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

  <t:div styleClass="actionsRow" style="text-align:right;"
            rendered="#{!documentVersionsBean.new}">
    <h:commandButton value="#{documentBundle.purge}"
                     action="#{documentVersionsBean.purgeDocument}"
                     styleClass="storeButton"
                     disabled="#{!document2Bean.editable}"
                     onclick="return confirm('#{objectBundle.confirm_remove}');" />
  </t:div>

</jsp:root>
