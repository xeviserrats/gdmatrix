<?xml version='1.0' encoding='windows-1252'?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
          xmlns:f="http://java.sun.com/jsf/core"
          xmlns:h="http://java.sun.com/jsf/html"
          xmlns:t="http://myfaces.apache.org/tomahawk"
          xmlns:sf="http://www.santfeliu.org/jsf">

  <f:loadBundle basename="org.santfeliu.agenda.web.resources.AgendaBundle"
    var="agendaBundle" />
  <f:loadBundle basename="org.santfeliu.web.obj.resources.ObjectBundle"
    var="objectBundle" />

  <t:div>
    <t:panelTabbedPane width="100%" selectedIndex="#{eventCopyBean.selectedIndex}"
                       serverSideTabSwitch="true" >

      <t:div styleClass="containerTitle" style="margin-top:5px">
        <h:outputLabel value="#{agendaBundle.eventCopy_pattern}"/>
      </t:div>
      
      <!-- Dayly frequency -->
      <t:panelTab label="#{agendaBundle.eventCopy_dayly}">
        <t:panelGrid columns="1" styleClass="patternContainer">
          <t:selectOneRadio id="daylyFrequency" value="#{eventCopyBean.daylyFrequencyMode}"
                            layout="spread" converter="#{Integer}" style="vertical-align:top">
              <f:selectItem itemValue="0" itemLabel="#{agendaBundle.eventCopy_every}" />
              <f:selectItem itemValue="1" itemLabel="#{agendaBundle.eventCopy_allWorkingDays}" />
          </t:selectOneRadio>
          <h:panelGroup>
              <t:radio for="daylyFrequency" index="0" />
              <h:inputText id="daylyFrequencyValue" 
                value="#{eventCopyBean.daylyFrequencyValue}" converter="#{Integer}"
                style="margin:0px 2px 0px 2px;width: 20px;text-align:center"
                styleClass="inputBox">
                <f:validateLongRange minimum="0"/>
              </h:inputText>
              <h:outputText value="#{agendaBundle.eventCopy_days}" />
          </h:panelGroup>
          <t:radio for="daylyFrequency" index="1" />
        </t:panelGrid>
      </t:panelTab>

      <!-- Weekly frequency -->
      <t:panelTab label="#{agendaBundle.eventCopy_weekly}" >
        <h:panelGrid columns="1" styleClass="patternContainer">
          <h:panelGroup>
            <t:outputLabel value="#{agendaBundle.eventCopy_repeatsEvery}"/>
            <t:inputText value="#{eventCopyBean.weeklyFrequencyValue}"
                         style="margin:0px 2px 0px 2px;width: 20px;text-align:center">
              <f:validateLongRange minimum="0"/>
            </t:inputText>
            <t:outputLabel value="#{agendaBundle.eventCopy_weeks} "/>
            <t:outputLabel value="#{agendaBundle.eventCopy_theDays}: "/>
          </h:panelGroup>
          <t:selectManyCheckbox value="#{eventCopyBean.daysOfWeek}">
            <f:selectItem itemLabel="#{agendaBundle.eventCopy_monday}" itemValue="2" />
            <f:selectItem itemLabel="#{agendaBundle.eventCopy_tuesday}" itemValue="3" />
            <f:selectItem itemLabel="#{agendaBundle.eventCopy_wednesday}" itemValue="4" />
            <f:selectItem itemLabel="#{agendaBundle.eventCopy_thursday}" itemValue="5" />
            <f:selectItem itemLabel="#{agendaBundle.eventCopy_friday}" itemValue="6" />
            <f:selectItem itemLabel="#{agendaBundle.eventCopy_saturday}" itemValue="7" />
            <f:selectItem itemLabel="#{agendaBundle.eventCopy_sunday}" itemValue="1" />
          </t:selectManyCheckbox>
        </h:panelGrid>
      </t:panelTab>

      <!-- Monthly frequency -->
      <t:panelTab label="#{agendaBundle.eventCopy_monthly}" >
        <t:panelGrid columns="1" styleClass="patternContainer">
          <t:selectOneRadio id="monthlyFrequency" value="#{eventCopyBean.monthlyFrequencyMode}"
                            layout="spread" style="vertical-align:top">
              <f:selectItem itemValue="0" itemLabel="#{agendaBundle.eventCopy_theDay}" />
              <f:selectItem itemValue="1" itemLabel="#{agendaBundle.eventCopy_every}" />
          </t:selectOneRadio>
          <t:div>
            <t:radio for="monthlyFrequency" index="0" />
            <h:inputText value="#{eventCopyBean.dayOfMonth}" converter="#{Integer}"
                         style="margin:0px 2px 0px 2px;width: 20px;text-align:center">
              <f:validateLongRange minimum="0"/>
            </h:inputText>
            <h:outputText value="#{agendaBundle.eventCopy_ofEvery}" />
            <h:inputText value="#{eventCopyBean.monthlyFrequencyValue0}" converter="#{Integer}"
                         style="margin:0px 2px 0px 2px;width: 20px;text-align:center">
              <f:validateLongRange minimum="0"/>
            </h:inputText>
            <h:outputText value="#{agendaBundle.eventCopy_months}" />
          </t:div>
          <t:div>
            <t:radio for="monthlyFrequency" index="1" />
            <t:selectOneMenu value="#{eventCopyBean.weekPosition}">
              <f:selectItem itemLabel="#{agendaBundle.eventCopy_first}" itemValue="1" />
              <f:selectItem itemLabel="#{agendaBundle.eventCopy_second}" itemValue="2" />
              <f:selectItem itemLabel="#{agendaBundle.eventCopy_third}" itemValue="3" />
              <f:selectItem itemLabel="#{agendaBundle.eventCopy_fourth}" itemValue="4" />
              <f:selectItem itemLabel="#{agendaBundle.eventCopy_last}" itemValue="5" />
            </t:selectOneMenu>
            <t:selectOneMenu value="#{eventCopyBean.dayOfWeekType}">
              <f:selectItem itemLabel="#{agendaBundle.eventCopy_day}" itemValue="8" />
              <f:selectItem itemLabel="#{agendaBundle.eventCopy_workingDay}" itemValue="9" />
              <f:selectItem itemLabel="#{agendaBundle.eventCopy_weekendDay}" itemValue="10" />
              <f:selectItem itemLabel="#{agendaBundle.eventCopy_monday}" itemValue="2" />
              <f:selectItem itemLabel="#{agendaBundle.eventCopy_tuesday}" itemValue="3" />
              <f:selectItem itemLabel="#{agendaBundle.eventCopy_wednesday}" itemValue="4" />
              <f:selectItem itemLabel="#{agendaBundle.eventCopy_thursday}" itemValue="5" />
              <f:selectItem itemLabel="#{agendaBundle.eventCopy_friday}" itemValue="6" />
              <f:selectItem itemLabel="#{agendaBundle.eventCopy_saturday}" itemValue="7" />
              <f:selectItem itemLabel="#{agendaBundle.eventCopy_sunday}" itemValue="1" />
            </t:selectOneMenu>
            <h:outputText value="#{agendaBundle.eventCopy_ofEvery}" />
            <h:inputText value="#{eventCopyBean.monthlyFrequencyValue1}" converter="#{Integer}"
                         style="margin:0px 2px 0px 2px;width: 20px;text-align:center">
              <f:validateLongRange minimum="0"/>
            </h:inputText>
            <h:outputText value="#{agendaBundle.eventCopy_months}" />
          </t:div>
        </t:panelGrid>
      </t:panelTab>

      <!-- Yearly Frequency -->
      <t:panelTab label="#{agendaBundle.eventCopy_yearly}">
        <t:panelGrid columns="1" styleClass="patternContainer" >
          <t:selectOneRadio id="yearlyFrequency" value="#{eventCopyBean.yearlyFrequencyMode}"
                            layout="spread" style="vertical-align:top">
              <f:selectItem itemValue="0" itemLabel="#{agendaBundle.eventCopy_every}" />
              <f:selectItem itemValue="1" itemLabel="#{agendaBundle.eventCopy_every}" />
          </t:selectOneRadio>
          <t:div>
              <t:radio for="yearlyFrequency" index="0" />
              <h:inputText value="#{eventCopyBean.dayOfMonth}" 
                           style="margin:0px 2px 0px 2px;width: 20px;text-align:center">
                <f:validateLongRange minimum="0"/>
              </h:inputText>
              <h:outputText value="#{agendaBundle.eventCopy_of}" />
              <t:selectOneMenu value="#{eventCopyBean.month0}">
                <f:selectItems value="#{eventCopyBean.monthsSelectItems}" />
              </t:selectOneMenu>
          </t:div>
          <t:div>
            <t:radio for="yearlyFrequency" index="1"/>
            <t:selectOneMenu value="#{eventCopyBean.weekPosition}" >
              <f:selectItem itemLabel="#{agendaBundle.eventCopy_first}" itemValue="1" />
              <f:selectItem itemLabel="#{agendaBundle.eventCopy_second}" itemValue="2" />
              <f:selectItem itemLabel="#{agendaBundle.eventCopy_third}" itemValue="3" />
              <f:selectItem itemLabel="#{agendaBundle.eventCopy_fourth}" itemValue="4" />
              <f:selectItem itemLabel="#{agendaBundle.eventCopy_last}" itemValue="5" />
            </t:selectOneMenu>
            <t:selectOneMenu value="#{eventCopyBean.dayOfWeekType}">
              <f:selectItem itemLabel="#{agendaBundle.eventCopy_day}" itemValue="8" />
              <f:selectItem itemLabel="#{agendaBundle.eventCopy_workingDay}" itemValue="9" />
              <f:selectItem itemLabel="#{agendaBundle.eventCopy_weekendDay}" itemValue="10" />
              <f:selectItem itemLabel="#{agendaBundle.eventCopy_monday}" itemValue="2" />
              <f:selectItem itemLabel="#{agendaBundle.eventCopy_tuesday}" itemValue="3" />
              <f:selectItem itemLabel="#{agendaBundle.eventCopy_wednesday}" itemValue="4" />
              <f:selectItem itemLabel="#{agendaBundle.eventCopy_thursday}" itemValue="5" />
              <f:selectItem itemLabel="#{agendaBundle.eventCopy_friday}" itemValue="6" />
              <f:selectItem itemLabel="#{agendaBundle.eventCopy_saturday}" itemValue="7" />
              <f:selectItem itemLabel="#{agendaBundle.eventCopy_sunday}" itemValue="1" />
            </t:selectOneMenu>
            <h:outputText value="#{agendaBundle.eventCopy_ofEvery}" />
            <t:selectOneMenu value="#{eventCopyBean.month1}">
              <f:selectItems value="#{eventCopyBean.monthsSelectItems}" />
            </t:selectOneMenu>
          </t:div>
        </t:panelGrid>
      </t:panelTab>

      <t:div styleClass="containerTitle" style="margin-top:10px ">
        <h:outputLabel value="#{agendaBundle.eventCopy_range}" />
      </t:div>

      <t:div styleClass="rangeContainer">
        <t:div style="width:100%;display:inline-block" >
          <t:div style="width:30%;float:left">
            <h:outputLabel value="#{agendaBundle.eventCopy_start}:" />
            <t:div>
              <h:outputText value="#{agendaBundle.eventCopy_startsOn}" />
              <sf:calendar value="#{eventCopyBean.rangeStartDateTime}"
                styleClass="calendarBox"
                externalFormat="dd/MM/yyyy"
                internalFormat="yyyyMMddHHmmss"
                buttonStyleClass="calendarButton"
                style="width:70px"/>
            </t:div>
          </t:div>
          <t:div style="width:70%;float:left">
            <t:selectOneRadio id="endRangeMode" value="#{eventCopyBean.endRangeMode}"
                              layout="spread" converter="#{Integer}"
                              style="vertical-align:top">
                <f:selectItem itemValue="0" itemLabel="#{agendaBundle.eventCopy_endsOn}" />
                <f:selectItem itemValue="1" itemLabel="#{agendaBundle.eventCopy_endsAfter}" />
            </t:selectOneRadio>
            <h:outputLabel value="#{agendaBundle.eventCopy_end}:" />
            <t:div>
              <t:radio for="endRangeMode" index="0" />
              <sf:calendar value="#{eventCopyBean.rangeEndDateTime}"
                styleClass="calendarBox"
                externalFormat="dd/MM/yyyy"
                internalFormat="yyyyMMddHHmmss"
                buttonStyleClass="calendarButton"
                style="width:70px"/>
            </t:div>
            <t:div>
              <t:radio for="endRangeMode" index="1" />
              <h:inputText id="numberOfIterations"
                           value="#{eventCopyBean.numberOfIterations}" converter="#{Integer}"
                           style="margin:0px 2px 0px 2px;width: 20px;text-align:center">
                <f:validateLongRange minimum="0"/>
              </h:inputText>
              <h:outputLabel value="#{agendaBundle.eventCopy_iterations}" />
            </t:div>
          </t:div>
        </t:div>
      </t:div>

      <t:div styleClass="containerTitle" style="margin-top:10px ">
        <h:outputLabel value="#{agendaBundle.eventCopy_hourPattern}" />
      </t:div>

      <t:div styleClass="rangeContainer">
        <t:div style="width:100%;display:inline-block" >
          <t:div style="width:100%;float:left;padding:2px">
            <h:outputLabel value="#{agendaBundle.eventCopy_startHour} " />
            <h:inputText value="#{eventCopyBean.startHour}" styleClass="inputBox"
                         style="width:35px;text-align:right">
              <t:validateRegExpr pattern="([01]?[0-9]|2[0-3]):[0-5][0-9]" />
            </h:inputText>
            <h:outputLabel value=" #{agendaBundle.eventCopy_endHour} " />
            <h:inputText value="#{eventCopyBean.endHour}"  styleClass="inputBox"
                         style="width:35px;text-align:right">
              <t:validateRegExpr pattern="([01]?[0-9]|2[0-3]):[0-5][0-9]" />
            </h:inputText>
            <h:outputLabel value="#{agendaBundle.eventCopy_hoursOfProgrammedDays}." />
          </t:div>
          <t:div style="width:100%;float:left;padding:2px">
            <h:outputLabel value="#{agendaBundle.eventCopy_duration}: " />
            <h:inputText value="#{eventCopyBean.duration}"  styleClass="inputBox"
              style="width:30px;text-align:right">
              <f:validateLongRange minimum="1" />
            </h:inputText>
            <t:selectOneMenu value="#{eventCopyBean.durationSelector}"
              style="vertical-align:middle">
              <f:selectItem itemValue="m" itemLabel="minuts" />
              <f:selectItem itemValue="h" itemLabel="hores" />
              <f:selectItem itemValue="d" itemLabel="dies" />
            </t:selectOneMenu>
          </t:div>
          <t:div style="width:100%;float:left;padding:2px">
            <h:outputLabel value="#{agendaBundle.eventCopy_gap}: " />
            <h:inputText value="#{eventCopyBean.gap}" styleClass="inputBox"
                style="width:30px;text-align:right">
              <f:validateLongRange minimum="0"/>
            </h:inputText>
            <t:selectOneMenu value="#{eventCopyBean.gapSelector}"
                style="vertical-align:middle">
                <f:selectItem itemValue="m" itemLabel="minuts" />
                <f:selectItem itemValue="h" itemLabel="hores" />
                <f:selectItem itemValue="d" itemLabel="dies" />
            </t:selectOneMenu>
          </t:div>
        </t:div>
      </t:div>

      <t:div style="width:100%;margin-top:5px">
        <t:selectBooleanCheckbox value="#{eventCopyBean.checkAttendantsAvailability}"
          style="vertical-align:middle;"
          disabled="#{not eventBean.editable}"/>
        <h:outputText value="#{agendaBundle.eventCopy_checkAttendantsAvailability}" styleClass="textBox"
          style="vertical-align:middle"/>
      </t:div>

      <t:tabChangeListener type="org.santfeliu.agenda.web.EventCopyTabChangeListener" />

      <t:div style="width:100%;text-align:right;margin:10px 0px 10px 0px">
        <h:commandButton action="#{eventCopyBean.show}" value="#{agendaBundle.eventCopy_preview}"
                         styleClass="showButton"/>
        <h:commandButton action="#{eventCopyBean.reset}"
          value="#{agendaBundle.eventCopy_reset}" 
          styleClass="cancelButton"/>
      </t:div>

    </t:panelTabbedPane>

  </t:div>

  <t:buffer into="#{table}">
    <t:dataTable id="table" value="#{eventCopyBean.rows}" var="row"
      rendered="#{eventCopyBean.rowCount > 0}"
      styleClass="resultList"
      rowClasses="row1,row2" headerClass="header" footerClass="footer"
      rows="#{eventCopyBean.pageSize}" first="#{eventCopyBean.firstRowIndex}">
      <t:column style="width:17%">
        <f:facet name="header">
          <h:outputText value="#{agendaBundle.event_startDate}" />
        </f:facet>
        <h:outputText value="#{row.startDateTime}"
                      rendered="#{eventCopyBean.editingRow != row}">
            <f:convertDateTime pattern="EE dd/MM/yyyy HH:mm" />
        </h:outputText>
        <sf:calendar value="#{eventCopyBean.editingRow.event.startDateTime}"
          styleClass="calendarBox"
          externalFormat="dd/MM/yyyy|HH:mm:ss"
          internalFormat="yyyyMMddHHmmss"
          buttonStyleClass="calendarButton"
          rendered="#{eventCopyBean.editingRow == row}"
          style="width:55%"/>
      </t:column>
      <t:column style="width:17%">
        <f:facet name="header">
          <h:outputText value="#{agendaBundle.event_endDate}" />
        </f:facet>
        <h:outputText value="#{row.endDateTime}"
                      rendered="#{eventCopyBean.editingRow != row}">
            <f:convertDateTime pattern="EE dd/MM/yyyy HH:mm" />
        </h:outputText>
        <sf:calendar value="#{eventCopyBean.editingRow.event.endDateTime}"
          styleClass="calendarBox"
          externalFormat="dd/MM/yyyy|HH:mm:ss"
          internalFormat="yyyyMMddHHmmss"
          buttonStyleClass="calendarButton"
          rendered="#{eventCopyBean.editingRow == row}"
          style="width:55%"/>
      </t:column>
      <t:column style="width:45%">
        <f:facet name="header">
          <h:outputText value="#{agendaBundle.event_title}" />
        </f:facet>
        <h:outputText value="#{row.event.summary}"
                      rendered="#{eventCopyBean.editingRow != row}"/>
        <h:inputText value="#{row.event.summary}"
                     rendered="#{eventCopyBean.editingRow == row}"
                     style="width:100%"/>
      </t:column>
      <t:column style="width:10%;text-align:center" rendered="#{eventCopyBean.checkAttendantsAvailability}">
        <f:facet name="header">
          <h:outputText value="#{agendaBundle.eventCopy_attendantsAvailable}" />
        </f:facet>
        <t:popup closePopupOnExitingElement="false"
                 closePopupOnExitingPopup="true"
                 displayAtDistanceX="-50"
                 displayAtDistanceY="-5"
                 styleClass="actionsPopup"
                 rendered="#{not row.attendantAvailable}">
          <h:graphicImage value="/common/agenda/images/warn.png"
                          rendered="#{not row.attendantAvailable}"/>
          <f:facet name="popup">
            <h:panelGroup>
              <t:dataTable value="#{row.overlappingAttendants}" var="oa">
                <h:column>
                  <h:panelGrid style="width:200px">
                    <h:outputText value="#{oa}" />
                  </h:panelGrid>
                </h:column>
              </t:dataTable>
            </h:panelGroup>
          </f:facet>
        </t:popup>
      </t:column>
      <t:column style="width:10%;text-align:center">
        <f:facet name="header">
          <h:outputText value="#{agendaBundle.eventCopy_roomAvailable}" />
        </f:facet>
        <h:graphicImage value="/common/agenda/images/accept.png"
                        rendered="#{row.roomAvailable}"/>

        <t:popup closePopupOnExitingElement="false"
                 closePopupOnExitingPopup="true"
                 displayAtDistanceX="-50"
                 displayAtDistanceY="-5" 
                 styleClass="actionsPopup"
                 rendered="#{not row.roomAvailable}">
          <h:graphicImage value="/common/agenda/images/cross.png"
                          rendered="#{not row.roomAvailable}"/>
          <f:facet name="popup">
            <h:panelGroup>
              <t:dataTable value="#{row.overlappingEvents}" var="oe">
                <h:column>
                  <h:panelGrid style="width:200px">
                    <h:outputText value="#{oe.summary}" style="font-weight:bold" />
                    <h:outputText value="#{row.overlappingEventStartDateTime}">
                      <f:convertDateTime pattern="EE dd/MM/yyyy HH:mm:ss" />
                    </h:outputText>
                    <h:outputText value="#{row.overlappingEventEndDateTime}">
                      <f:convertDateTime pattern="EE dd/MM/yyyy HH:mm:ss" />
                    </h:outputText>
                  </h:panelGrid>
                </h:column>
              </t:dataTable>
            </h:panelGroup>
          </f:facet>
        </t:popup>

      </t:column>
      <t:column style="width:10%;text-align:right">
       <h:commandButton value="#{objectBundle.edit}"
         image="#{userSessionBean.icons.edit}"
         alt="#{objectBundle.edit}" title="#{objectBundle.edit}"
         action="#{eventCopyBean.editEvent}" immediate="true"
         rendered="#{eventCopyBean.editingRow != row}"
         styleClass="editButton"/>
       <h:commandButton value="#{objectBundle.store}"
         image="#{userSessionBean.icons.store}"
         alt="#{objectBundle.store}" title="#{objectBundle.store}"
         action="#{eventCopyBean.storeEvent}"
         rendered="#{eventCopyBean.editingRow == row}"
         styleClass="storeButton"/>
       <h:commandButton value="#{objectBundle.cancel}"
         image="#{userSessionBean.icons.cancel}"
         alt="#{objectBundle.cancel}" title="#{objectBundle.cancel}"
         action="#{eventCopyBean.cancelEvent}"
         rendered="#{eventCopyBean.editingRow == row}"
         styleClass="cancelButton"/>
       <h:commandButton value="#{objectBundle.delete}"
         image="#{userSessionBean.icons.delete}"
         alt="#{objectBundle.delete}" title="#{objectBundle.delete}"
         action="#{eventCopyBean.removeEvent}" immediate="true"
         styleClass="createButton"
         rendered="#{eventCopyBean.editingRow != row}"/>
      </t:column>

      <f:facet name="footer">
        <t:dataScroller for="table"
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

  <t:div rendered="#{eventCopyBean.rows != null}">
    <t:dataScroller for="table"
      firstRowIndexVar="firstRow"
      lastRowIndexVar="lastRow"
      rowsCountVar="rowCount"
      rendered="#{eventCopyBean.rowCount > 0}">
      <h:outputFormat value="#{objectBundle.resultRange}"
        style="margin-top:10px;display:block">
        <f:param value="#{firstRow}" />
        <f:param value="#{lastRow}" />
        <f:param value="#{rowCount}" />
      </h:outputFormat>
    </t:dataScroller>
    <h:outputText value="#{objectBundle.no_results_found}"
      rendered="#{eventCopyBean.rowCount == 0}"
      style="margin-top:10px"/>
  </t:div>

  <h:outputText value="#{table}" escape="false"/>

</jsp:root>
