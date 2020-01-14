<?xml version='1.0' encoding='windows-1252'?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
          xmlns:f="http://java.sun.com/jsf/core"
          xmlns:h="http://java.sun.com/jsf/html"
          xmlns:t="http://myfaces.apache.org/tomahawk"
          xmlns:sf="http://www.santfeliu.org/jsf">

  <f:loadBundle basename="org.santfeliu.web.obj.resources.ObjectBundle"
                var="objectBundle" />

  <f:loadBundle basename="org.santfeliu.feed.web.resources.FeedBundle"
                var="feedBundle" />

  <t:buffer into="#{table}">
    <t:dataTable id="data" value="#{folderFeedsBean.rows}" var="row"
                 rowStyleClass="#{folderFeedsBean.editingFeed == null ? null :
                 (folderFeedsBean.editingFeed.feedId == row.feedId ? 'selectedRow' : null)}"
                 rowClasses="row1,row2" headerClass="header" footerClass="footer"
                 styleClass="resultList" style="width:100%"
                 rendered="#{!folderFeedsBean.new}"
                 rows="#{folderFeedsBean.pageSize}"
                 first="#{folderFeedsBean.firstRowIndex}">
      <t:column style="width:10%">
        <f:facet name="header">
          <h:outputText value="#{feedBundle.feed}:" />
        </f:facet>
        <h:outputText value="#{row.feedId}" />
      </t:column>
      <t:column style="width:10%">
        <f:facet name="header">
          <h:outputText value="#{feedBundle.type}:" />
        </f:facet>
        <h:outputText value="#{row.feedType}" />
      </t:column>
      <t:column style="width:60%">
        <f:facet name="header">
          <h:outputText value="#{feedBundle.name}:" />
        </f:facet>
        <h:outputText value="#{row.feedName}" />
      </t:column>
      <t:column style="width:20%;text-align:right;">
        <h:panelGroup>
          <h:commandButton value="#{objectBundle.show}"
                           image="#{userSessionBean.icons.show}"
                           alt="#{objectBundle.show}" title="#{objectBundle.show}"
                           action="#{folderFeedsBean.showFeed}"
                           styleClass="showButton"  />
          <h:commandButton value="#{objectBundle.edit}"
                           image="#{userSessionBean.icons.detail}"
                           alt="#{objectBundle.edit}" title="#{objectBundle.edit}"
                           action="#{folderFeedsBean.editFeedFolder}"
                           styleClass="addButton"  />
          <h:commandButton value="#{objectBundle.delete}"
                           image="#{userSessionBean.icons.delete}"
                           alt="#{objectBundle.delete}" title="#{objectBundle.delete}"
                           action="#{folderFeedsBean.removeFeedFolder}"
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

  <t:div styleClass="resultBar" rendered="#{folderFeedsBean.rowCount > 0}">
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
    <h:commandButton action="#{folderFeedsBean.createFeedFolder}"
                     disabled="#{folderFeedsBean.editingFeed != null}"
                     styleClass="addButton" value="#{objectBundle.add}"
                     image="#{userSessionBean.icons.add}"
                     alt="#{objectBundle.add}" title="#{objectBundle.add}" />
  </t:div>

  <t:div styleClass="editingPanel" rendered="#{folderFeedsBean.editingFeed != null}">

    <t:div>
      <h:outputText value="#{feedBundle.feed}:" styleClass="textBox"
                    style="width:18%" />
      <h:panelGroup>
        <t:selectOneMenu value="#{folderFeedsBean.editingFeed.feedId}"
                         style="width:350px" styleClass="selectBox">
          <f:selectItems value="#{folderFeedsBean.feedItems}" />
        </t:selectOneMenu>
        <h:commandButton value="#{objectBundle.search}"
                         image="#{userSessionBean.icons.search}"
                         alt="#{objectBundle.search}" title="#{objectBundle.search}"
                         action="#{folderFeedsBean.searchFeed}"
                         styleClass="searchButton" />
      </h:panelGroup>
    </t:div>

    <t:div styleClass="actionsRow">
      <h:commandButton action="#{folderFeedsBean.storeFeedFolder}"
                       styleClass="addButton" value="#{objectBundle.store}" />
      <h:commandButton action="#{folderFeedsBean.cancelFeedFolder}"
                       styleClass="cancelButton" value="#{objectBundle.cancel}" />
    </t:div>
    
  </t:div>

</jsp:root>
