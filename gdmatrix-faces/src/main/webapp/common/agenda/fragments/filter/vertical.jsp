<?xml version='1.0' encoding='windows-1252'?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
          xmlns:f="http://java.sun.com/jsf/core"
          xmlns:h="http://java.sun.com/jsf/html"
          xmlns:t="http://myfaces.apache.org/tomahawk"
          xmlns:sf="http://www.santfeliu.org/jsf">

    <h:panelGrid styleClass="filterPanel" columns="1"
                 columnClasses="calendarColumn,propsColumn"
                 headerClass="header"
                 footerClass="footer"
                 style="display:inline-block"
                 >
    <f:facet name="header">
      <h:outputText />
    </f:facet>
    
    <!-- Calendar -->
    <t:div styleClass="calendarColumn" style="width:100%"
           rendered="#{eventSearchBean.renderCalendarPanel}">
      <t:inputCalendar 
        value="#{eventSearchBean.selectedDate}"
        valueChangeListener="#{eventSearchBean.searchSelectedDay}"
        styleClass="calendarBox"
        currentDayCellClass="calendarCurrentDay"
        weekRowClass="weekRow"
        dayCellClass="calendarDayCell" 
        monthYearRowClass="monthYearRow"  />

      <t:div style="width:100%;font-size:9px;margin:2px;"
             rendered="#{eventSearchBean.viewName != 'schedule'}">
        <h:outputText value="#{agendaBundle.eventSearch_showEvents}: "/>
        <t:fieldset legend="#{agendaBundle.eventSearch_showEvents}">        
          <t:selectOneRadio 
            value="#{eventSearchBean.onlyCurrentDate}" layout="pageDirection"
                            style="vertical-align:middle">
            <f:selectItem itemLabel="#{agendaBundle.eventSearch_onlyCurrentDate}" itemValue="true" />
            <f:selectItem itemLabel="#{agendaBundle.eventSearch_fromCurrentDate}" itemValue="false"/>
          </t:selectOneRadio>
        </t:fieldset>
      </t:div>

   </t:div>

    <t:div styleClass="propsColumn" rendered="#{eventSearchBean.renderFilterPanel}">
      <!-- EventId -->
      <t:div styleClass="filterRow" rendered="#{eventSearchBean.renderEventIdFilter}">
        <h:outputText value="#{agendaBundle.event_id}:" styleClass="textBox" style="width:15%"/>
        <t:div>
          <h:inputText value="#{eventSearchBean.eventId}"
            styleClass="inputBox"  />
        </t:div>
      </t:div>

      <!-- EventTypeId -->
      <t:div styleClass="filterRow" rendered="#{eventSearchBean.renderTypeFilter
         or (!eventSearchBean.renderTypeFilter and eventSearchBean.typeFilterActive)}">
        <h:outputLabel for="eventType" value="#{agendaBundle.event_type}:" styleClass="textBox" style="width:15%"
                       rendered="#{eventSearchBean.renderTypeFilter}" />
        <h:outputLabel for="eventType_alt" value="#{agendaBundle.event_type}:" styleClass="textBox" style="width:15%"
                       rendered="#{!eventSearchBean.renderTypeFilter and eventSearchBean.typeFilterActive}" />
        <t:div>
          <h:panelGroup>
            <sf:commandMenu title="#{agendaBundle.event_type}" id="eventType" value="#{eventSearchBean.propertiesFilter.currentTypeId}"
              styleClass="selectBox"
              action="#{eventSearchBean.createPropDefSelectItems}"
              rendered="#{eventSearchBean.renderTypeFilter}">
              <f:selectItems value="#{eventSearchBean.typeSelectItems}" />
            </sf:commandMenu>
            <t:selectOneMenu title="#{agendaBundle.event_type}" id="eventType_alt" value="#{eventSearchBean.propertiesFilter.currentTypeId}"
              styleClass="selectBox"
              rendered="#{!eventSearchBean.renderTypeFilter and eventSearchBean.typeFilterActive}">
              <f:selectItems value="#{eventSearchBean.typeSelectItems}" />
            </t:selectOneMenu>
          </h:panelGroup>
        </t:div>
      </t:div>

      <!-- Content -->
      <t:div styleClass="filterRow" rendered="#{eventSearchBean.renderContentFilter}">
        <h:outputText value="#{agendaBundle.event_content}:" styleClass="textBox" style="width:15%" />
        <t:div>
          <h:inputText value="#{eventSearchBean.eventFilter.content}"
                       styleClass="inputBox" style="width:65%"/>
        </t:div>
      </t:div>

      <!-- Dates -->
      <t:div styleClass="filterRow" rendered="#{eventSearchBean.renderDateFilter and !eventSearchBean.renderCalendarPanel}">
        <h:outputText value="#{agendaBundle.eventSearch_date}:" styleClass="textBox" style="width:15%" />
        <h:panelGroup>
          <t:selectOneMenu title="#{agendaBundle.eventSearch_date}" value="#{eventSearchBean.eventFilter.dateComparator}"
            styleClass="selectBox" style="vertical-align:middle">
            <f:selectItem itemLabel=" " itemValue="" />
            <f:selectItem itemLabel="#{agendaBundle.event_startDate}" itemValue="S" />
            <f:selectItem itemLabel="#{agendaBundle.event_endDate}" itemValue="E" />
            <f:selectItem itemLabel="#{agendaBundle.eventSearch_activeDate}" itemValue="R" />
          </t:selectOneMenu>
          <h:outputText value=" #{agendaBundle.eventSearch_from} " />
          <sf:calendar value="#{eventSearchBean.startDateFilter}"
            styleClass="calendarBox"
            buttonStyleClass="calendarButton"
            style="width:15%;margin-left:2px"
            internalFormat="yyyyMMddHHmmss"
            externalFormat="dd/MM/yyyy"  />
          <h:outputText value=" #{agendaBundle.eventSearch_to} " />
          <sf:calendar
            value="#{eventSearchBean.endDateFilter}"
            styleClass="calendarBox"
            buttonStyleClass="calendarButton"
            style="width:15%;margin-left:2px"
            internalFormat="yyyyMMddHHmmss"
            externalFormat="dd/MM/yyyy" />
        </h:panelGroup>
      </t:div>

      <!-- ThemeId -->
      <t:div styleClass="filterRow" rendered="#{eventSearchBean.renderThemeFilter}">
        <h:outputText value="#{agendaBundle.event_themeId}:" styleClass="textBox" style="width:15%" />
        <t:div>
          <h:panelGroup>
            <t:selectOneMenu title="#{agendaBundle.event_themeId}" value="#{eventSearchBean.themeId}"
              styleClass="selectBox">
              <f:selectItems value="#{eventSearchBean.themeSelectItems}" />
            </t:selectOneMenu>
          </h:panelGroup>
        </t:div>
      </t:div>

      <!-- PersonId -->
      <t:div styleClass="filterRow" rendered="#{eventSearchBean.renderPersonFilter}">
        <h:outputText value="#{agendaBundle.event_personId}:" styleClass="textBox" style="width:15%" />
        <t:div>
          <h:panelGroup>
            <t:selectOneMenu title="#{agendaBundle.event_personId}" value="#{eventSearchBean.eventFilter.personId}"
              styleClass="selectBox" style="width:85%">
              <f:selectItems value="#{eventSearchBean.personSelectItems}" />
            </t:selectOneMenu>
            <h:commandButton value="#{objectBundle.search}"
              image="#{userSessionBean.icons.search}"
              alt="#{objectBundle.search}" title="#{objectBundle.search}"
              styleClass="searchButton"
              action="#{eventSearchBean.searchPerson}"/>
          </h:panelGroup>
        </t:div>
      </t:div>

      <!-- Room -->
      <t:div styleClass="filterRow" rendered="#{eventSearchBean.renderRoomFilter or
        (not eventSearchBean.renderRoomFilter and eventSearchBean.roomFilterActive)}">
        <h:outputText value="#{agendaBundle.event_roomId}:" styleClass="textBox" style="width:15%" />
        <t:div>
          <h:panelGroup>
            <t:selectOneMenu title="#{agendaBundle.event_roomId}" value="#{eventSearchBean.roomId}"
              styleClass="selectBox"
              style="#{eventSearchBean.renderSearchRoom and eventSearchBean.renderRoomFilter ? 'width:85%' : ''}">
              <f:selectItems value="#{eventSearchBean.roomSelectItems}" />
            </t:selectOneMenu>
            <h:commandButton value="#{objectBundle.search}"
              image="#{userSessionBean.icons.search}"
              alt="#{objectBundle.search}" title="#{objectBundle.search}"
              styleClass="searchButton"
              action="#{eventSearchBean.searchRoom}"
              rendered="#{eventSearchBean.renderSearchRoom and eventSearchBean.renderRoomFilter}" />
          </h:panelGroup>
        </t:div>
      </t:div>

    </t:div>
    <f:facet name="footer">
      <h:commandButton id="default_button" value="#{objectBundle.search}"
        styleClass="searchButton"
        action="#{eventSearchBean.search}"
        rendered="#{eventSearchBean.renderFilterPanel and 
          (eventSearchBean.renderRoomFilter or (!eventSearchBean.renderRoomFilter and eventSearchBean.roomFilterActive)
          or eventSearchBean.renderContentFilter
          or eventSearchBean.renderTypeFilter or (!eventSearchBean.renderTypeFilter and eventSearchBean.typeFilterActive)
          or eventSearchBean.renderDateFilter
          or eventSearchBean.renderEventIdFilter or eventSearchBean.renderInputPropertiesFilter
          or eventSearchBean.renderPersonFilter or eventSearchBean.renderSelectPropertiesFilter
          or eventSearchBean.renderThemeFilter)}"
        onclick="showOverlay()"/>
    </f:facet>
  </h:panelGrid>
</jsp:root>