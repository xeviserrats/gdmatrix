<?xml version='1.0' encoding='windows-1252'?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
          xmlns:f="http://java.sun.com/jsf/core"
          xmlns:h="http://java.sun.com/jsf/html"
          xmlns:t="http://myfaces.apache.org/tomahawk"
          xmlns:sf="http://www.santfeliu.org/jsf">
  
  
  <t:div styleClass="actionsBar top" 
     rendered="#{eventSearchBean.renderActionsBar and listEventViewBean.rowCount > 5}">
     <h:commandButton value="#{objectBundle.search}"
        styleClass="searchButton"
        action="#{eventSearchBean.pickUpEvent}"
        image="#{userSessionBean.icons.search}"
        alt="#{objectBundle.search}" title="#{objectBundle.search}"
        rendered="#{eventSearchBean.renderPickUpButton}"/>
    <h:commandButton value="#{objectBundle.current}"
       image="#{userSessionBean.icons.current}"
       alt="#{objectBundle.current}" title="#{objectBundle.current}"
       action="#{eventBean.show}" immediate="true"
       styleClass="currentButton"
       rendered="#{eventSearchBean.editorUser and userSessionBean.menuModel.browserType == 'desktop'}"/>
     <h:commandButton value="#{objectBundle.create}"
       image="#{userSessionBean.icons.new}"
       alt="#{objectBundle.create}" title="#{objectBundle.create}"
       action="#{eventBean.create}" immediate="true"
       styleClass="createButton"
       rendered="#{eventSearchBean.editorUser and userSessionBean.menuModel.browserType == 'desktop'}"/>
  </t:div>
  
  <t:div styleClass="resultBar" rendered="#{listEventViewBean.rows != null}">
    <t:dataScroller for="data"
      firstRowIndexVar="firstRow"
      lastRowIndexVar="lastRow"
      rowsCountVar="rowCount"
      rendered="#{listEventViewBean.rowCount > 0}">
      <h:outputFormat value="#{objectBundle.resultRange}"
        style="margin-top:10px;display:block">
        <f:param value="#{firstRow}" />
        <f:param value="#{lastRow}" />
        <f:param value="#{rowCount}" />
      </h:outputFormat>
    </t:dataScroller>
    <h:outputText value="#{objectBundle.no_results_found}"
      rendered="#{listEventViewBean.rowCount == 0}" />
  </t:div>

  <h:panelGroup styleClass="eventList">
    <t:dataList rows="#{listEventViewBean.pageSize}"
      id="data"
      rowIndexVar="rowIndex"
      first="#{listEventViewBean.firstRowIndex}"
      value="#{listEventViewBean.rows}" var="row"
      rendered="#{listEventViewBean.rowCount > 0}">

      <h:panelGroup>
        <t:div rendered="#{listEventViewBean.dayHeaderRendered}" styleClass="dayHeader">
          <h:outputText value="#{listEventViewBean.startDateTime}">
            <f:convertDateTime pattern="EEEE, dd MMMM yyyy':'"/>
          </h:outputText>
        </t:div>

        <h:panelGroup styleClass="eventRow#{row.eventId == eventBean.objectId ? ' selected' : ''}">
          <h:panelGroup styleClass="hourBlock">
            <h:outputText value="#{listEventViewBean.startDateTime}">
              <f:convertDateTime pattern="HH:mm"/>
            </h:outputText>
            <h:outputText value="-" />
            <h:outputText value="#{listEventViewBean.endDateTime}">
              <f:convertDateTime pattern="HH:mm 'h'"/>
            </h:outputText>
          </h:panelGroup>

          <h:panelGroup styleClass="eventBlock #{listEventViewBean.eventStyleClass}">
            <h:panelGroup styleClass="eventDescription">
              <h:outputText value="#{row.eventTypeName}:" styleClass="eventType" />
              <h:outputText value="#{row.summary}" styleClass="eventSummary" />
            </h:panelGroup>

          <h:panelGroup styleClass="actionsGroup">
              <h:graphicImage value="/common/agenda/images/public.gif"
                rendered="#{eventSearchBean.renderPublicIcon and row.public}"
                style="vertical-align:middle" alt="#{agendaBundle.event_public}" 
                title="#{agendaBundle.event_public}"/>
              <h:graphicImage value="/common/agenda/images/only_attendants.png"
                rendered="#{eventSearchBean.renderOnlyAttendantsIcon and row.onlyAttendants}"
                style="vertical-align:middle" alt="#{agendaBundle.event_onlyAttendants}" 
                title="#{agendaBundle.event_onlyAttendants}"/>
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
                action="#{listEventViewBean.showEvent}"
                rendered="#{row.summary != '???' and eventSearchBean.showEventAllowed}"/>
            </h:panelGroup>
          </h:panelGroup>
        </h:panelGroup>
      </h:panelGroup>
    </t:dataList>

    <t:dataScroller for="data"
      fastStep="100"
      paginator="true"
      paginatorMaxPages="9"
      immediate="true"
      rendered="#{listEventViewBean.rows != null}"
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
  </h:panelGroup>

</jsp:root>
