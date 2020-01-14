<?xml version='1.0' encoding='windows-1252'?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
          xmlns:f="http://java.sun.com/jsf/core"
          xmlns:h="http://java.sun.com/jsf/html"
          xmlns:t="http://myfaces.apache.org/tomahawk"
          xmlns:sf="http://www.santfeliu.org/jsf">

  <t:div styleClass="resultBar" rendered="#{tableEventViewBean.rows != null}">
    <t:dataScroller for="data"
      firstRowIndexVar="firstRow"
      lastRowIndexVar="lastRow"
      rowsCountVar="rowCount"
      rendered="#{tableEventViewBean.rowCount > 0}">
      <h:outputFormat value="#{objectBundle.resultRange}"
        style="margin-top:10px;display:block">
        <f:param value="#{firstRow}" />
        <f:param value="#{lastRow}" />
        <f:param value="#{rowCount}" />
      </h:outputFormat>
    </t:dataScroller>
    <h:outputText value="#{objectBundle.no_results_found}"
      rendered="#{tableEventViewBean.rowCount == 0}" />
  </t:div>

  <t:dataTable rows="#{tableEventViewBean.pageSize}"
    id="data"
    first="#{tableEventViewBean.firstRowIndex}"
    value="#{tableEventViewBean.rows}" var="row"
    rendered="#{tableEventViewBean.rowCount > 0}"
    rowStyleClass="#{row.eventId == eventBean.objectId ? 'selectedRow' : null}"
    styleClass="resultList"
    rowClasses="row1,row2" headerClass="header" footerClass="footer">
    <t:column style="width:15%" groupBy="true" >
      <f:facet name="header">
        <h:outputText value="" />
      </f:facet>
      <h:outputText
        value="#{tableEventViewBean.startDate}" style="font-size:12px"
        styleClass="#{row.eventId == eventBean.objectId ? 'selected' : ''}">
        <f:convertDateTime pattern="EEEE, dd/MM/yyyy"/>
      </h:outputText>
    </t:column>

    <t:column style="width:65%">
      <f:facet name="header">
        <h:outputText value="#{agendaBundle.event_summary}" />
      </f:facet>
      <t:div>
        <h:outputText value="#{tableEventViewBean.startDateTime}" style="font-size:12px"
          styleClass="#{row.eventId == eventBean.objectId ? 'selected' : ''}">
          <f:convertDateTime pattern="HH:mm:ss"/>
        </h:outputText>
        <h:outputLabel value=" - " />
        <h:outputText value="#{tableEventViewBean.endDateTime}" style="font-size:12px"
          styleClass="#{row.eventId == eventBean.objectId ? 'selected' : ''}">
          <f:convertDateTime pattern="HH:mm:ss"/>
        </h:outputText>
      </t:div>
      <h:outputText value="#{row.summary}" style="font-weight:bold"
        styleClass="#{row.eventId == eventBean.objectId ? 'selected' : ''}"/>
    </t:column>
    <t:column style="width:20%" styleClass="actionsColumn">
      <h:panelGroup>
        <h:commandButton value="#{objectBundle.select}"
          image="#{userSessionBean.icons.back}"
          alt="#{objectBundle.select}" title="#{objectBundle.select}"
          rendered="#{controllerBean.selectableNode}"
          styleClass="selectButton" immediate="true"
          action="#{eventSearchBean.selectEvent}" />
        <h:commandButton value="#{objectBundle.show}"
          image="#{userSessionBean.icons.show}"
          alt="#{objectBundle.show}" title="#{objectBundle.show}"
          styleClass="showButton" immediate="true"
          action="#{tableEventViewBean.showEvent}"
          rendered="#{row.summary != '???' and eventSearchBean.showEventAllowed}"/>
      </h:panelGroup>
    </t:column>

    <f:facet name="footer">
      <t:dataScroller for="data"
        fastStep="100"
        paginator="true"
        paginatorMaxPages="9"
        immediate="true"
        rendered="#{tableEventViewBean.rows != null}"
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

</jsp:root>
