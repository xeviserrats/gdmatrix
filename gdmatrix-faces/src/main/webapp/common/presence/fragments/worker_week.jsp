<?xml version='1.0' encoding='windows-1252'?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
          xmlns:f="http://java.sun.com/jsf/core"
          xmlns:h="http://java.sun.com/jsf/html"
          xmlns:t="http://myfaces.apache.org/tomahawk"
          xmlns:sf="http://www.santfeliu.org/jsf">

  <f:loadBundle basename="org.santfeliu.presence.web.resources.PresenceBundle"
    var="presenceBundle" />
  <f:loadBundle basename="org.santfeliu.web.obj.resources.ObjectBundle"
    var="objectBundle" />

  <t:inputHidden immediate="true" value="#{presenceMainBean.sessionTrack}" />
  
  <jsp:include page="/common/presence/fragments/header.jsp"/>
  
  <t:div styleClass="worker_week">
    <t:div styleClass="toolbars">
      <t:panelGroup styleClass="toolbar time">
        <t:commandLink action="#{workerWeekBean.previousMonth}" styleClass="button img_left"
          title="#{presenceBundle.previousMonthInfo}">
          <t:outputText value="#{presenceBundle.month}" styleClass="left" />
        </t:commandLink>
        <t:commandLink action="#{workerWeekBean.previousWeek}" styleClass="button img_left"
          title="#{presenceBundle.previousWeekInfo}">
          <t:outputText value="#{presenceBundle.week}" styleClass="left" />
        </t:commandLink>
        <t:commandLink action="#{workerWeekBean.goToday}" value="#{presenceBundle.today}" styleClass="button"
          title="#{presenceBundle.todayInfo}"/>
        <t:commandLink action="#{workerWeekBean.nextWeek}" styleClass="button img_right"
          title="#{presenceBundle.nextWeekInfo}">
          <t:outputText value="#{presenceBundle.week}" styleClass="right" />
        </t:commandLink>
        <t:commandLink action="#{workerWeekBean.nextMonth}" styleClass="button img_right"
          title="#{presenceBundle.nextMonthInfo}">
          <t:outputText value="#{presenceBundle.month}" styleClass="right" />
        </t:commandLink>
      </t:panelGroup>
      <t:panelGroup styleClass="toolbar zoom">
        <t:commandLink action="#{workerWeekBean.zoom1}"
          title="#{presenceBundle.zoom1Info}"
          styleClass="button img_left#{workerWeekBean.zoomLevel == 1 ? ' selected' : ''}">
          <t:outputText value="1" styleClass="zoom" />
        </t:commandLink>
        <t:commandLink action="#{workerWeekBean.zoom2}"
          title="#{presenceBundle.zoom2Info}"
          styleClass="button img_left#{workerWeekBean.zoomLevel == 2 ? ' selected' : ''}">
          <t:outputText value="2" styleClass="zoom" />
        </t:commandLink>
        <t:commandLink action="#{workerWeekBean.zoom3}"
          title="#{presenceBundle.zoom3Info}"
          styleClass="button img_left#{workerWeekBean.zoomLevel == 3 ? ' selected' : ''}">
          <t:outputText value="3" styleClass="zoom" />
        </t:commandLink>
        <t:commandLink action="#{workerWeekBean.zoom0}"
          title="#{presenceBundle.reviewEntriesInfo}"
          styleClass="button img_left#{workerWeekBean.zoomLevel == 0 ? ' selected' : ''}">
          <t:outputText value=" " styleClass="review_entries" />
        </t:commandLink>
      </t:panelGroup>
      <t:panelGroup styleClass="toolbar visibility">
        <t:commandLink action="#{workerWeekBean.toogleScheduleVisibility}" styleClass="button img_left"
          title="#{presenceBundle.toogleSchedule}">
          <t:outputText value="#{presenceBundle.schedule}" styleClass="#{workerWeekBean.scheduleVisible ? 'visible' : 'hidden'}" />
        </t:commandLink>
        <t:commandLink action="#{workerWeekBean.toogleEntriesVisibility}" styleClass="button img_left"
          title="#{presenceBundle.toogleEntries}">
          <t:outputText value="#{presenceBundle.presenceEntries}" styleClass="#{workerWeekBean.entriesVisible ? 'visible' : 'hidden'}" />
        </t:commandLink>
        <t:commandLink action="#{workerWeekBean.toogleAbsencesVisibility}" styleClass="button img_left"
          title="#{presenceBundle.toogleAbsences}">
          <t:outputText value="#{presenceBundle.absences}" styleClass="#{workerWeekBean.absencesVisible ? 'visible' : 'hidden'}" />
        </t:commandLink>
      </t:panelGroup>
      <h:outputText value="#{workerWeekBean.workerStatistics.workedTimeDifference}"
        styleClass="differential #{workerWeekBean.workerStatistics.workedTimeDifference lt 0 ? 'ko' : 'ok'}"
        title="#{workerWeekBean.currentWeek ? presenceBundle.instantWorkedTimeDifferenceWeek : presenceBundle.workedTimeDifferenceWeek}">
        <f:converter converterId="IntervalConverter" />
        <f:attribute name="positiveSignum" value="true" />
      </h:outputText>
      <h:outputText value="#{workerWeekBean.workerStatistics.scheduleFaults}"
        styleClass="faults #{workerWeekBean.workerStatistics.scheduleFaults gt 0 ? 'ko' : 'ok'}"
        title="#{presenceBundle.scheduleFaults}: #{presenceBundle.scheduleFaultsInfo}">
      </h:outputText>
    </t:div>

    <t:div styleClass="page_body">
      <t:div styleClass="week_panel">
        <t:div styleClass="week_description">
          <h:outputText value="Setmana #{workerWeekBean.weekNumber}:" styleClass="week_number" />
          <h:outputText value="#{workerWeekBean.monthAndYear}" styleClass="month_year" />
        </t:div>

        <t:div styleClass="week_header">
          <t:dataList value="#{workerWeekBean.weekDates}" var="weekDate" rowIndexVar="index">
            <t:commandLink action="#{workerWeekBean.changeInsertDate}"
              styleClass="column col#{index} #{workerWeekBean.today ? 'today' : ''}"
              style="width:#{workerWeekBean.pixelsPerDay}px;left:#{workerWeekBean.weekDateLeft}px;#{workerWeekBean.holidayColor}">
              <h:outputText value="#{workerWeekBean.weekDateFormatted}" styleClass="date #{not workerWeekBean.clockVisible and workerWeekBean.insertDate == weekDate ? ' current' : ''}" />
              <h:outputText value="#{workerWeekBean.holidayDescription}" styleClass="holiday_description" />
            </t:commandLink>
          </t:dataList>
        </t:div>
        <t:div styleClass="week_scroller" forceId="true" id="scroll_div">
          <t:div styleClass="week_hours" rendered="#{workerWeekBean.zoomLevel gt 0}">
            <h:outputText styleClass="hour" value="00:00" style="top:0" />
            <h:outputText styleClass="hour" value="01:00" style="top:#{workerWeekBean.pixelsPerHour}px"/>
            <h:outputText styleClass="hour" value="02:00" style="top:#{2 * workerWeekBean.pixelsPerHour}px"/>
            <h:outputText styleClass="hour" value="03:00" style="top:#{3 * workerWeekBean.pixelsPerHour}px"/>
            <h:outputText styleClass="hour" value="04:00" style="top:#{4 * workerWeekBean.pixelsPerHour}px"/>
            <h:outputText styleClass="hour" value="05:00" style="top:#{5 * workerWeekBean.pixelsPerHour}px"/>
            <h:outputText styleClass="hour" value="06:00" style="top:#{6 * workerWeekBean.pixelsPerHour}px"/>
            <h:outputText styleClass="hour" value="07:00" style="top:#{7 * workerWeekBean.pixelsPerHour}px"/>
            <h:outputText styleClass="hour" value="08:00" style="top:#{8 * workerWeekBean.pixelsPerHour}px"/>
            <h:outputText styleClass="hour" value="09:00" style="top:#{9 * workerWeekBean.pixelsPerHour}px"/>
            <h:outputText styleClass="hour" value="10:00" style="top:#{10 * workerWeekBean.pixelsPerHour}px"/>
            <h:outputText styleClass="hour" value="11:00" style="top:#{11 * workerWeekBean.pixelsPerHour}px"/>
            <h:outputText styleClass="hour" value="12:00" style="top:#{12 * workerWeekBean.pixelsPerHour}px"/>
            <h:outputText styleClass="hour" value="13:00" style="top:#{13 * workerWeekBean.pixelsPerHour}px"/>
            <h:outputText styleClass="hour" value="14:00" style="top:#{14 * workerWeekBean.pixelsPerHour}px"/>
            <h:outputText styleClass="hour" value="15:00" style="top:#{15 * workerWeekBean.pixelsPerHour}px"/>
            <h:outputText styleClass="hour" value="16:00" style="top:#{16 * workerWeekBean.pixelsPerHour}px"/>
            <h:outputText styleClass="hour" value="17:00" style="top:#{17 * workerWeekBean.pixelsPerHour}px"/>
            <h:outputText styleClass="hour" value="18:00" style="top:#{18 * workerWeekBean.pixelsPerHour}px"/>
            <h:outputText styleClass="hour" value="19:00" style="top:#{19 * workerWeekBean.pixelsPerHour}px"/>
            <h:outputText styleClass="hour" value="20:00" style="top:#{20 * workerWeekBean.pixelsPerHour}px"/>
            <h:outputText styleClass="hour" value="21:00" style="top:#{21 * workerWeekBean.pixelsPerHour}px"/>
            <h:outputText styleClass="hour" value="22:00" style="top:#{22 * workerWeekBean.pixelsPerHour}px"/>
            <h:outputText styleClass="hour" value="23:00" style="top:#{23 * workerWeekBean.pixelsPerHour}px"/>
          </t:div>
          <t:div styleClass="week_columns" style="height:#{24 * workerWeekBean.pixelsPerHour}px"
            rendered="#{workerWeekBean.zoomLevel gt 0}">
            <!-- week columns and holidays  -->
            <t:dataList value="#{workerWeekBean.weekDates}" var="weekDate" rowIndexVar="index">
              <t:div styleClass="column col#{index}"
                title="#{workerWeekBean.holidayDescription}"
                style="width:#{workerWeekBean.pixelsPerDay}px;left:#{workerWeekBean.weekDateLeft}px;">
              </t:div>
            </t:dataList>
            <!-- schedule entries -->
            <t:dataList value="#{workerWeekBean.workerStatistics.scheduleEntry}" var="entry"
              rendered="#{workerWeekBean.scheduleVisible}">
              <t:div styleClass="work_interval"
                onmouseover="enterTooltip(this)"
                onmouseout="exitTooltip(this)"
                onmousemove="moveTooltip(this, event)"
                style="width:#{workerWeekBean.pixelsPerDay - 1}px;left:#{workerWeekBean.scheduleEntryLeft + 1}px;top:#{workerWeekBean.scheduleEntryTop}px;height:#{workerWeekBean.scheduleEntryHeight}px">
                <t:div styleClass="tooltip">
                  <t:outputText value="#{workerWeekBean.dayTypeLabel}" styleClass="line label" />
                  <t:panelGroup styleClass="line">
                    <t:outputText value="#{presenceBundle.flexibility}: "/>
                    <t:outputText value="#{entry.flexibility}">
                      <f:converter converterId="IntervalConverter" />
                    </t:outputText>
                  </t:panelGroup>
                  <t:panelGroup styleClass="line">
                    <t:outputText value="#{presenceBundle.initialDayDuration}: "/>
                    <t:outputText value="#{entry.initialDayDuration}">
                      <f:converter converterId="IntervalConverter" />
                    </t:outputText>
                  </t:panelGroup>
                  <t:outputText value="#{presenceBundle.reductions}:"
                    rendered="#{not empty entry.reductionId}" styleClass="line" />
                  <t:dataList value="#{entry.reductionId}" var="reductionId" layout="unorderedList">
                    <t:panelGroup styleClass="reduction">
                      <t:outputText value="#{workerWeekBean.reductionLabel}: -" />
                      <t:outputText value="#{workerWeekBean.reductionTime}">
                        <f:converter converterId="IntervalConverter" />
                      </t:outputText>
                    </t:panelGroup>
                  </t:dataList>
                  <t:panelGroup styleClass="line" rendered="#{not empty entry.reductionId}">
                    <t:outputText value="#{presenceBundle.dayDuration}: "/>
                    <t:outputText value="#{entry.dayDuration}">
                      <f:converter converterId="IntervalConverter" />
                    </t:outputText>
                  </t:panelGroup>
                  <t:panelGroup styleClass="line">
                    <t:outputText value="#{presenceBundle.thisInterval}: "/>
                    <t:outputText value="#{entry.startDateTime}">
                      <f:converter converterId="DateTimeConverter" />
                      <f:attribute name="userFormat" value="H:mm'h'" />
                    </t:outputText>
                    <t:outputText value=" - " />
                    <t:outputText value="#{entry.endDateTime}">
                      <f:converter converterId="DateTimeConverter" />
                      <f:attribute name="userFormat" value="H:mm'h'" />
                    </t:outputText>
                  </t:panelGroup>
                </t:div>
              </t:div>
            </t:dataList>
            <!-- absences -->
            <t:dataList value="#{workerWeekBean.absences}" var="absence"
              rendered="#{workerWeekBean.absencesVisible}">
              <t:commandLink styleClass="absence#{absence.absenceId == workerWeekBean.editingAbsence.absenceId ? ' selected' : ''}"
                 action="#{workerWeekBean.editAbsence}"
                 style="width:#{workerWeekBean.pixelsPerDay - 3}px;left:#{workerWeekBean.absenceLeft + 1}px;top:#{workerWeekBean.absenceTop}px;height:#{workerWeekBean.absenceHeight - 2}px">
                <h:outputText value="#{presenceBundle.absenceShort} #{absence.absenceId}" styleClass="link#{absence.absenceId == workerWeekBean.editingAbsence.absenceId ? ' selected' : ''}"
                  title="#{absence.reason}" />
              </t:commandLink>
            </t:dataList>
            <!-- presence entries -->
            <t:dataList value="#{workerWeekBean.workerStatistics.presenceEntry}" var="entry"
              rendered="#{workerWeekBean.entriesVisible}">
              <t:commandLink styleClass="presence_entry"
                 style="#{workerWeekBean.presenceEntryStyle};width:#{workerWeekBean.pixelsPerDay - 15}px;left:#{workerWeekBean.presenceEntryLeft + 7}px;top:#{workerWeekBean.presenceEntryTop}px;"
                 action="#{workerWeekBean.editEntry}" title="#{workerWeekBean.entryTitle}">
                <t:outputText
                  value="#{workerWeekBean.presenceEntryHeight gt 14 or entry.endDateTime == null ? workerWeekBean.presenceEntryTime : ' ' }"
                  rendered="#{entry.creationDateTime != null}"
                  style="height:#{workerWeekBean.presenceEntryHeight lt 14 and entry.endDateTime != null ? workerWeekBean.presenceEntryHeight : 14}px"
                  styleClass="presence_entry_time #{workerWeekBean.presenceEntryTimeStyleClass}#{entry.entryId == workerWeekBean.editingEntry.entryId ? ' selected' : ''}" />
              </t:commandLink>
            </t:dataList>
            <!-- schedule faults -->
            <t:dataList value="#{workerWeekBean.workerStatistics.scheduleFault}" var="fault"
              rendered="#{workerWeekBean.entriesVisible}">
              <t:div styleClass="schedule_fault"                 
                 style="width:#{workerWeekBean.pixelsPerDay - 48}px;left:#{workerWeekBean.scheduleFaultLeft + 24}px;top:#{workerWeekBean.scheduleFaultTop}px">
                <t:div styleClass="time">
                  <t:outputText value="#{presenceBundle.scheduleFaultTime}: " />
                  <t:outputText value="#{fault.faultDuration}">
                    <f:converter converterId="IntervalConverter" />
                  </t:outputText>
                </t:div>
              </t:div>
            </t:dataList>
            <!-- now line -->
            <t:div styleClass="now_line" rendered="#{workerWeekBean.currentWeek and workerWeekBean.clockVisible}"
              style="width:#{workerWeekBean.pixelsPerDay}px;left:#{workerWeekBean.nowLeft}px;top:#{workerWeekBean.nowTop}px;">
            </t:div>
          </t:div>
          <t:div styleClass="week_columns" style="height:500px"
            rendered="#{workerWeekBean.zoomLevel == 0}">
            <t:dataList value="#{workerWeekBean.weekDates}" var="weekDate" rowIndexVar="index">
              <t:div styleClass="column col#{index}"
                title="#{workerWeekBean.holidayDescription}"
                style="width:#{workerWeekBean.pixelsPerDay}px;left:#{workerWeekBean.weekDateLeft}px;">
                <t:dataList value="#{workerWeekBean.datePresenceEntries}" var="entry"
                  rendered="#{workerWeekBean.entriesVisible}">
                  <t:commandLink action="#{workerWeekBean.editEntry}"
                    styleClass="presence_entry list"
                    style="#{workerWeekBean.presenceEntryStyle};height:46px" rendered="#{entry.creationDateTime != null}"
                    title="#{workerWeekBean.entryTitle}">
                    <t:outputText
                      value="#{workerWeekBean.presenceEntryTime}"
                      styleClass="presence_entry_time #{workerWeekBean.presenceEntryTimeStyleClass}#{entry.entryId == workerWeekBean.editingEntry.entryId ? ' selected' : ''}" />
                    <t:outputText
                      value="#{workerWeekBean.presenceEntryType}"
                      styleClass="presence_entry_type" />
                    <t:outputText value="#{entry.duration}" 
                      styleClass="presence_entry_duration#{entry.duration lt 60 ? ' error': ''}"
                      rendered="#{entry.endDateTime != null}">
                      <f:converter converterId="IntervalConverter" />
                    </t:outputText>
                  </t:commandLink>
                </t:dataList>
                <t:div styleClass="day_worked_time">
                  <t:outputText value="#{presenceBundle.dayWorkedTime}:" style="text-align:center;display:block" />
                  <t:outputText value="#{workerWeekBean.dayWorkedTime}">
                    <f:converter converterId="IntervalConverter" />
                  </t:outputText>
                </t:div>
              </t:div>
            </t:dataList>
          </t:div>
        </t:div>
      </t:div>

      <t:div styleClass="actions_panel">
        <t:div styleClass="tabs">
          <t:commandButton action="#{workerWeekBean.entryMode}" value="#{presenceBundle.presenceEntry}"
            styleClass="tab_button #{workerWeekBean.mode == 'entry' ? 'selected' : 'unselected'}" />
          <t:commandButton action="#{workerWeekBean.absenceMode}" value="#{presenceBundle.absence}"
            styleClass="tab_button #{workerWeekBean.mode == 'absence' ? 'selected' : 'unselected'}" />
          <t:commandButton action="#{workerWeekBean.statsMode}" value="#{presenceBundle.stats}"
            styleClass="tab_button #{workerWeekBean.mode == 'stats' ? 'selected' : 'unselected'}" />
        </t:div>
        <t:div styleClass="panel_tab entry_tab" rendered="#{workerWeekBean.mode == 'entry'}">
          <t:div styleClass="toolbar">
            <h:commandButton action="#{workerWeekBean.goToday}" image="/common/presence/images/new.png"
              styleClass="button" rendered="#{not workerWeekBean.clockVisible}" disabled="#{not presenceMainBean.editionEnabled}"
              alt="#{presenceBundle.newEntryNow}" title="#{presenceBundle.newEntryNow}" />
            <h:commandButton action="#{workerWeekBean.editEntryTime}" image="/common/presence/images/new_edit.png"
              styleClass="button" rendered="#{workerWeekBean.clockVisible or workerWeekBean.editingEntry.entryId != null}"
              alt="#{presenceBundle.newEditedEntry}" title="#{presenceBundle.newEditedEntry}" disabled="#{not presenceMainBean.editionEnabled}" />
            <h:commandButton action="#{workerWeekBean.storeEntry}" image="/common/presence/images/save.png"
              styleClass="button" rendered="#{workerWeekBean.editingEntry.entryId != null}" disabled="#{not presenceMainBean.editionEnabled}"
              alt="#{presenceBundle.saveAbsence}" title="#{presenceBundle.saveEntry}" onclick="if (confirm('#{presenceBundle.confirmEditEntry}')) {showOverlay(); return true;} else return false;" />
            <h:commandButton action="#{workerWeekBean.removeEntry}" image="/common/presence/images/remove.png"
              rendered="#{workerWeekBean.editingEntry.entryId != null}" styleClass="button"
              alt="#{presenceBundle.deleteEntry}" title="#{presenceBundle.deleteEntry}" disabled="#{not presenceMainBean.editionEnabled}"
              onclick="if (confirm('#{presenceBundle.confirmRemoveEntry}')) {showOverlay(); return true;} else return false;"/>
            <h:commandButton action="#{workerWeekBean.goToday}" image="/common/presence/images/cancel.png"
              styleClass="button" rendered="#{not workerWeekBean.clockVisible}" disabled="#{not presenceMainBean.editionEnabled}"
              alt="#{presenceBundle.cancelEdition}" title="#{presenceBundle.cancelEdition}" />
          </t:div>
          <t:panelGroup styleClass="row">
            <h:outputText value="#{workerWeekBean.editingEntry.entryId == null ?
              presenceBundle.addEntry : presenceBundle.editEntry}:" styleClass="label" />
            <t:outputText value="#{workerWeekBean.insertDateFormatted}" styleClass="insert_date"
              onclick="alert('#{presenceBundle.changeEntryDateInfo}')" />
          </t:panelGroup>
          <t:panelGroup rendered="#{workerWeekBean.clockVisible}" styleClass="row">
            <h:outputText value="#{presenceBundle.andTime}:" styleClass="label" />
            <t:commandLink action="#{workerWeekBean.editEntryTime}" styleClass="clock_link" 
              disabled="#{not presenceMainBean.editionEnabled}">
              <sf:clock styleClass="clock" format="time" />
            </t:commandLink>
          </t:panelGroup>
          <t:panelGroup rendered="#{not workerWeekBean.clockVisible}" styleClass="row">
            <t:outputLabel for="insert_time" value="#{presenceBundle.andTime}:" styleClass="label" />
            <t:inputText id="insert_time" forceId="true" readonly="#{not presenceMainBean.editionEnabled}"
              value="#{workerWeekBean.insertTime}"
              styleClass="editing_entry_time #{workerWeekBean.editingEntryStyleClass}">
              <f:converter converterId="TimeConverter" />
            </t:inputText>
          </t:panelGroup>
          <t:panelGroup rendered="#{not workerWeekBean.clockVisible}" styleClass="row">
            <t:outputLabel for="entry_reason" value="#{presenceBundle.entryReason}:" styleClass="label" />
            <t:inputTextarea id="entry_reason" readonly="#{not presenceMainBean.editionEnabled}"
              value="#{workerWeekBean.editingEntry.reason}" styleClass="reason"
              onkeyup="checkMaxLength(this, 200)" />
          </t:panelGroup>
          <t:panelGroup rendered="#{workerWeekBean.editingEntry.entryId != null}">
            <t:panelGroup styleClass="row entry_type" rendered="#{workerWeekBean.editingEntryTypeEnabled}">
              <h:outputLabel for="sel_entry_type"
                value="#{presenceBundle.presenceEntryType}:" styleClass="label" />
              <t:selectOneMenu id="sel_entry_type" value="#{workerWeekBean.editingEntry.entryTypeId}" 
                disabled="#{not presenceMainBean.editionEnabled}">
                <f:selectItems value="#{workerWeekBean.presenceEntryTypeSelectItems}" />
              </t:selectOneMenu>
            </t:panelGroup>
            <t:panelGroup styleClass="row entry_type" rendered="#{not workerWeekBean.editingEntryTypeEnabled}">
              <h:outputLabel value="#{presenceBundle.presenceEntryType}:" styleClass="label" />
              <h:outputText value="#{workerWeekBean.editingEntryTypeLabel}" styleClass="entry_type_label" />
            </t:panelGroup>
            <t:panelGroup styleClass="row" rendered="#{workerWeekBean.editingEntry.compensationTime gt 0}">
              <h:outputText value="#{presenceBundle.compensationTime}:" styleClass="label" />
              <h:outputText value="#{workerWeekBean.editingEntry.compensationTime}">
                <f:converter converterId="IntervalConverter" />
              </h:outputText>
            </t:panelGroup>
            <t:panelGroup styleClass="row">
              <h:outputText value="#{presenceBundle.creationDateTime}:" styleClass="label" />
              <h:outputText value="#{workerWeekBean.editingEntry.creationDateTime}"
                styleClass="#{workerWeekBean.editingEntry.creationDateTime != workerWeekBean.editingEntry.startDateTime and workerWeekBean.editingEntry.manipulated and workerWeekBean.editingEntry.compensationTime == 0 ? 'manipulated' : null}">
                <f:converter converterId="DateTimeConverter" />
              </h:outputText>
            </t:panelGroup>
            <t:panelGroup styleClass="row" rendered="#{workerWeekBean.editingEntry.changeDateTime != workerWeekBean.editingEntry.creationDateTime}">
              <h:outputText value="#{presenceBundle.changeDateTime}:" styleClass="label" />
              <h:outputText value="#{workerWeekBean.editingEntry.changeDateTime}"
                styleClass="#{workerWeekBean.editingEntry.manipulated and workerWeekBean.editingEntry.creationDateTime != workerWeekBean.editingEntry.changeDateTime ? 'manipulated' : null}">
                <f:converter converterId="DateTimeConverter" />
              </h:outputText>
            </t:panelGroup>
            <t:panelGroup styleClass="row" rendered="#{workerWeekBean.editingEntry.changeDateTime != workerWeekBean.editingEntry.creationDateTime}">
              <h:outputText value="#{presenceBundle.changeUserId}:" styleClass="label" />
              <h:outputText value="#{workerWeekBean.editingEntry.changeUserId}" />
            </t:panelGroup>
            <t:panelGroup styleClass="row" rendered="#{workerWeekBean.editingEntry.endDateTime != null}">
              <h:outputText value="#{presenceBundle.duration}:" styleClass="label" />
              <h:outputText value="#{workerWeekBean.editingEntryDuration}">
                <f:converter converterId="IntervalConverter" />
              </h:outputText>
            </t:panelGroup>
             <t:panelGroup styleClass="row" rendered="#{workerWeekBean.editingEntry.endDateTime != null}">
              <h:outputText value="#{presenceBundle.workedTime}:" styleClass="label" />
              <h:outputText value="#{workerWeekBean.editingEntry.workedTime}">
                <f:converter converterId="IntervalConverter" />
              </h:outputText>
            </t:panelGroup>
            <t:panelGroup styleClass="row" rendered="#{workerWeekBean.editingEntry.ipAddress != null}">
              <h:outputText value="#{presenceBundle.terminal}:" styleClass="label" />
              <h:outputText value="#{workerWeekBean.editingEntry.ipAddress}"
                 styleClass="#{workerWeekBean.entryAddressValid ? null : 'manipulated'}" />
            </t:panelGroup>
            <t:panelGroup styleClass="row" rendered="#{workerWeekBean.editingEntry.absenceId != null}">
              <h:outputText value="#{presenceBundle.generatorAbsence}:" styleClass="label" />
              <h:outputText value="#{workerWeekBean.editingEntry.absenceId}" />
            </t:panelGroup>
            <t:panelGroup styleClass="row" rendered="#{workerWeekBean.editingEntry.previousEntryTypeId != null
                and presenceMainBean.presenceAdministrator}">
              <h:outputText value="#{presenceBundle.previousEntryTypeId}:" styleClass="label" />
              <h:outputText value="#{workerWeekBean.editingEntry.previousEntryTypeId}" />
            </t:panelGroup>
          </t:panelGroup>
          <t:div styleClass="button_stack" 
            rendered="#{workerWeekBean.editingEntry.entryId == null and presenceMainBean.editionEnabled}">
            <t:dataList value="#{workerWeekBean.presenceEntryTypes}" var="presenceEntryType">
              <h:panelGroup styleClass="button_group">
                <t:commandButton action="#{workerWeekBean.storeEntry}" styleClass="button key#{presenceEntryType.position == 0 ? '' : presenceEntryType.position}"
                   value="#{presenceEntryType.label}" accesskey="#{workerWeekBean.accessKey}"
                   title="#{presenceEntryType.description}" onclick="showOverlay()" />
                <h:outputText value="#{presenceEntryType.position}" styleClass="button_key"
                  rendered="#{presenceEntryType.position != 0}" title="#{presenceBundle.key} #{presenceEntryType.position}"/>
              </h:panelGroup>
            </t:dataList>
          </t:div>
          <h:panelGroup rendered="#{workerWeekBean.editingEntry.entryId == null}">
            <t:div styleClass="row times" rendered="#{workerWeekBean.workedTimeRendered}">
              <h:outputText value="#{presenceBundle.workedTimeOnDay}:" styleClass="label" />
              <t:outputText value="#{workerWeekBean.workedTime}">
                <f:converter converterId="IntervalConverter" />
              </t:outputText>
            </t:div>
            <t:div styleClass="row" rendered="#{workerWeekBean.lastEntryDurationRendered}">
              <h:outputText value="#{presenceBundle.lastEntryDuration}:" styleClass="label" />
              <t:outputText value="#{workerWeekBean.lastEntryDuration}">
                <f:converter converterId="IntervalConverter" />
              </t:outputText>
            </t:div>
          </h:panelGroup>
        </t:div>
        <t:div styleClass="panel_tab absence_tab" rendered="#{workerWeekBean.mode == 'absence'}">
          <t:div styleClass="toolbar">
            <h:commandButton action="#{workerWeekBean.newAbsence}" image="/common/presence/images/new.png"
              styleClass="button" rendered="#{workerWeekBean.editingAbsence.absenceId != null}" disabled="#{not presenceMainBean.editionEnabled}"
              alt="#{presenceBundle.newAbsence}" title="#{presenceBundle.newAbsence}" />
            <h:commandButton action="#{workerWeekBean.storeAbsence}" image="/common/presence/images/save.png"
              styleClass="button" rendered="#{workerWeekBean.saveAbsenceEnabled}" onclick="showOverlay()"
              alt="#{presenceBundle.saveAbsence}" title="#{presenceBundle.saveAbsence}" disabled="#{not presenceMainBean.editionEnabled}" />
            <h:commandButton action="#{workerWeekBean.removeAbsence}" image="/common/presence/images/remove.png"
              rendered="#{workerWeekBean.deleteAbsenceEnabled}" styleClass="button"
              alt="#{presenceBundle.deleteAbsence}" title="#{presenceBundle.deleteAbsence}"
              onclick="return confirm('#{presenceBundle.confirmRemoveAbsence}')" disabled="#{not presenceMainBean.editionEnabled}" />
            <h:commandButton action="#{workerWeekBean.processAbsence}" image="/common/presence/images/process.png"
              rendered="#{workerWeekBean.editingAbsence.absenceId != null}" styleClass="button"
              disabled="#{not presenceMainBean.editionEnabled}"
              alt="#{presenceBundle.processAbsence}" title="#{presenceBundle.processAbsence}" />
            <h:commandButton action="#{workerWeekBean.newAbsence}" image="/common/presence/images/cancel.png"
              styleClass="button" rendered="#{workerWeekBean.editingAbsence.absenceId != null and workerWeekBean.saveAbsenceEnabled}" disabled="#{not presenceMainBean.editionEnabled}"
              alt="#{presenceBundle.cancelEdition}" title="#{presenceBundle.cancelEdition}" />
          </t:div>
          <t:panelGroup styleClass="row">
            <h:outputText value="#{presenceBundle.absenceId}: #{workerWeekBean.editingAbsence.absenceId}"
              styleClass="label" rendered="#{workerWeekBean.editingAbsence.absenceId != null}" />
            <h:outputText value="#{presenceBundle.newAbsence}"
              styleClass="label" rendered="#{workerWeekBean.editingAbsence.absenceId == null}" />
          </t:panelGroup>
          <t:panelGroup styleClass="row">
            <h:outputLabel for="absenceType" value="#{presenceBundle.type}:" styleClass="label" />
            <t:selectOneMenu id="absenceType" value="#{workerWeekBean.editingAbsence.absenceTypeId}"
              styleClass="absence_type" onchange="showOverlay(); submit()"
              disabled="#{not workerWeekBean.saveAbsenceEnabled or not presenceMainBean.editionEnabled}">
              <f:selectItem itemLabel=" " itemValue="" />
              <f:selectItems value="#{workerWeekBean.absenceTypeSelectItems}" />
            </t:selectOneMenu>
          </t:panelGroup>
          <t:panelGroup styleClass="row" rendered="#{workerWeekBean.absenceDescription != null and workerWeekBean.editingAbsence.absenceId == null}">
            <t:outputText value="#{presenceBundle.authorizable}" rendered="#{workerWeekBean.absenceAutorizable}" 
              styleClass="property authorizable" />
            <t:outputText value="#{presenceBundle.justificable}" rendered="#{workerWeekBean.absenceJustificable}" 
              styleClass="property justificable" />
            <t:outputText value="#{workerWeekBean.absenceDescription}" styleClass="description" />
          </t:panelGroup>
          <t:panelGroup styleClass="row date">
            <h:outputLabel for="startDateTime" value="#{presenceBundle.startDate}:" styleClass="label" />
            <sf:calendar id="startDateTime" value="#{workerWeekBean.absenceStartDate}"
              styleClass="input_date"
              externalFormat="dd/MM/yyyy"
              internalFormat="yyyyMMdd"
              buttonStyleClass="calendar_button"
              disabled="#{not workerWeekBean.saveAbsenceEnabled or not presenceMainBean.editionEnabled}"
              style="width:38%" />
            <t:panelGroup rendered="#{not workerWeekBean.absenceIntegerCounting}">
              <t:inputText id="absenceStartTime" value="#{workerWeekBean.absenceStartTime}"
                disabled="#{not workerWeekBean.saveAbsenceEnabled or not presenceMainBean.editionEnabled}"
                styleClass="input_time">
                <f:converter converterId="TimeConverter" />
              </t:inputText>
              <t:outputLabel for="absenceStartTime" value="HH:mm" styleClass="time_label" />
            </t:panelGroup>
          </t:panelGroup>
          <t:panelGroup styleClass="row date">
            <h:outputLabel for="endDateTime" value="#{presenceBundle.endDate}:" styleClass="label" />
            <sf:calendar id="endDateTime" value="#{workerWeekBean.absenceEndDate}"
              styleClass="input_date"
              externalFormat="dd/MM/yyyy"
              internalFormat="yyyyMMdd"
              buttonStyleClass="calendar_button"
              disabled="#{not workerWeekBean.saveAbsenceEnabled or not presenceMainBean.editionEnabled}"
              style="width:38%" />
            <t:panelGroup rendered="#{not workerWeekBean.absenceIntegerCounting}">
              <t:inputText id="absenceEndTime" value="#{workerWeekBean.absenceEndTime}"
                disabled="#{not workerWeekBean.saveAbsenceEnabled or not presenceMainBean.editionEnabled}"
                styleClass="input_time">
                <f:converter converterId="TimeConverter" />
              </t:inputText>
              <t:outputLabel for="absenceEndTime" value="HH:mm" styleClass="time_label" />
            </t:panelGroup>
          </t:panelGroup>
          <t:panelGroup styleClass="row">
            <h:outputLabel for="absenceReason" value="#{presenceBundle.absenceReason}:" styleClass="label" />
            <t:inputTextarea id="absenceReason" value="#{workerWeekBean.editingAbsence.reason}"
              styleClass="reason" disabled="#{not workerWeekBean.saveAbsenceEnabled or not presenceMainBean.editionEnabled}"
              onkeyup="checkMaxLength(this, 200)" />
          </t:panelGroup>
          <t:panelGroup styleClass="row" rendered="#{workerWeekBean.editingAbsence.absenceId != null}">
            <h:outputLabel for="absenceState" value="#{presenceBundle.status}:" styleClass="label" />
            <t:selectOneMenu id="absenceState" value="#{workerWeekBean.editingAbsence.status}"
              styleClass="absence_state" disabled="#{not presenceMainBean.presenceAdministrator}">
              <f:selectItems value="#{presenceConfigBean.absenceStatusSelectItems}" />
            </t:selectOneMenu>
          </t:panelGroup>
          <t:panelGroup styleClass="row">
            <h:outputText value="#{workerWeekBean.editingAbsence.statusDetail}" styleClass="status_detail"
               rendered="#{workerWeekBean.editingAbsence.statusDetail != null}" />
          </t:panelGroup>
          <t:panelGroup rendered="#{workerWeekBean.editingAbsence.absenceId != null}">
            <t:panelGroup styleClass="row">
              <h:outputText value="#{presenceBundle.requestedDays}: " styleClass="label" />
              <h:outputText value="#{workerWeekBean.editingAbsence.requestedDays}">
                <f:convertNumber type="number" groupingUsed="true" pattern="#0.##"/>
              </h:outputText>
            </t:panelGroup>
            <t:panelGroup styleClass="row" rendered="#{workerWeekBean.editingAbsence.status == 'C'}">
              <h:outputText value="#{presenceBundle.consolidatedDays}: " styleClass="label" />
              <h:outputText value="#{workerWeekBean.editingAbsence.consolidatedDays}">
                <f:convertNumber type="number" groupingUsed="true" pattern="#0.##"/>
              </h:outputText>
            </t:panelGroup>
            <t:panelGroup styleClass="row">
              <h:outputText value="#{presenceBundle.requestedTime}: " styleClass="label" />
              <h:outputText value="#{workerWeekBean.editingAbsence.requestedTime}">
                <f:converter converterId="IntervalConverter" />
              </h:outputText>
            </t:panelGroup>
            <t:panelGroup styleClass="row" rendered="#{workerWeekBean.editingAbsence.status == 'C'}">
              <h:outputText value="#{presenceBundle.consolidatedTime}: " styleClass="label" />
              <h:outputText value="#{workerWeekBean.editingAbsence.consolidatedTime}">
                <f:converter converterId="IntervalConverter" />
              </h:outputText>
            </t:panelGroup>
            <t:panelGroup styleClass="row"
              rendered="#{workerWeekBean.editingAbsence.absenceId != null and 
                workerWeekBean.editingAbsence.status == 'P' and presenceMainBean.editionEnabled}">
              <t:outputText value="#{presenceBundle.processMessage}" styleClass="process_message" />
              <t:commandLink action="#{workerWeekBean.processAbsence}" styleClass="button img_left first">
                <t:outputText value="#{presenceBundle.processAbsence}" styleClass="process" />
              </t:commandLink>
            </t:panelGroup>
            <t:panelGroup styleClass="row" rendered="#{workerWeekBean.editingAbsence.instanceId != null}">
              <h:outputLink value="#{workerWeekBean.absenceDocumentUrl}" target="_blank" styleClass="document"
                rendered="#{workerWeekBean.editingAbsence.absenceDocId != null}">
                <h:outputText value="#{presenceBundle.request}" />
              </h:outputLink>
              <h:outputLink value="#{workerWeekBean.justificantDocumentUrl}" target="_blank" styleClass="document"
                rendered="#{workerWeekBean.editingAbsence.justificantDocId != null}">
                <h:outputText value="#{presenceBundle.justificant}" />
              </h:outputLink>
            </t:panelGroup>
          </t:panelGroup>
        </t:div>
        <t:div styleClass="panel_tab stats_tab" rendered="#{workerWeekBean.mode == 'stats'}">
          <t:div styleClass="row ok" title="#{presenceBundle.daysToWorkInfo}">
            <h:outputText value="#{presenceBundle.daysToWork}:" styleClass="label" />
            <h:outputText value="#{workerWeekBean.workerStatistics.daysToWork}" />
          </t:div>
          <t:div styleClass="row ok" title="#{presenceBundle.timeToWorkInfo}">
            <h:outputText value="#{presenceBundle.timeToWork}:" styleClass="label" />
            <h:outputText value="#{workerWeekBean.workerStatistics.timeToWork}">
              <f:converter converterId="IntervalConverter" />
            </h:outputText>
          </t:div>
          <t:div styleClass="row ok" title="#{presenceBundle.instantTimeToWorkInfo}" 
            rendered="#{workerWeekBean.currentWeek}">
            <h:outputText value="#{presenceBundle.instantTimeToWork}:" styleClass="label" />
            <h:outputText value="#{workerWeekBean.workerStatistics.instantTimeToWork}">
              <f:converter converterId="IntervalConverter" />
            </h:outputText>
          </t:div>
          <t:div styleClass="row ok" title="#{presenceBundle.workedDaysInfo}">
            <h:outputText value="#{presenceBundle.workedDays}:" styleClass="label" />
            <h:outputText value="#{workerWeekBean.workerStatistics.workedDays}" />
          </t:div>
          <t:div styleClass="row#{workerWeekBean.workerStatistics.notWorkedDays gt 0 ? ' warning' : ' ok'}"
                 title="#{presenceBundle.notWorkedDaysInfo}">
            <h:outputText value="#{presenceBundle.notWorkedDays}:" styleClass="label" />
            <h:outputText value="#{workerWeekBean.workerStatistics.notWorkedDays}" />
          </t:div>
          <t:div styleClass="row ok" title="#{presenceBundle.workedTimeInfo}">
            <h:outputText value="#{presenceBundle.workedTime}:" styleClass="label" />
            <h:outputText value="#{workerWeekBean.workerStatistics.workedTime}">
              <f:converter converterId="IntervalConverter" />
            </h:outputText>
          </t:div>
          <t:div styleClass="row ok" title="#{presenceBundle.realWorkedTimeInfo}">
            <h:outputText value="#{presenceBundle.realWorkedTime}:" styleClass="label" />
            <h:outputText value="#{workerWeekBean.workerStatistics.realWorkedTime}">
              <f:converter converterId="IntervalConverter" />
            </h:outputText>
          </t:div>
          <t:div styleClass="row#{workerWeekBean.workerStatistics.scheduleFaultTime gt 0 ? ' warning' : ' ok'}"
             title="#{presenceBundle.scheduleFaultTimeInfo}">
            <h:outputText value="#{presenceBundle.scheduleFaultTime}:" styleClass="label" />
            <h:outputText value="#{workerWeekBean.workerStatistics.scheduleFaultTime}">
              <f:converter converterId="IntervalConverter" />
            </h:outputText>
          </t:div>
          <t:div styleClass="row ok" title="#{presenceBundle.entryCountInfo}">
            <h:outputText value="#{presenceBundle.entryCount}:" styleClass="label" />
            <h:outputText value="#{workerWeekBean.workerStatistics.entryCount}" />
          </t:div>
          <t:div styleClass="row#{workerWeekBean.workerStatistics.manipulatedEntryCount gt 0 ? ' warning' : ' ok'}"
             title="#{presenceBundle.manipulatedEntryCountInfo}">
            <h:outputText value="#{presenceBundle.manipulatedEntryCount}:" styleClass="label" />
            <h:outputText value="#{workerWeekBean.workerStatistics.manipulatedEntryCount}" />
          </t:div>
          <t:div styleClass="row#{workerWeekBean.workerStatistics.suspiciousEntryCount gt 0 ? ' warning' : ' ok'}"
             title="#{presenceBundle.suspiciousEntryCountInfo}">
            <h:outputText value="#{presenceBundle.suspiciousEntryCount}:" styleClass="label" />
            <h:outputText value="#{workerWeekBean.workerStatistics.suspiciousEntryCount}" />
          </t:div>
          <t:div styleClass="row ok" title="#{presenceBundle.compensatedEntryCountInfo}"
            rendered="#{workerWeekBean.workerStatistics.compensatedEntryCount gt 0}">
            <h:outputText value="#{presenceBundle.compensatedEntryCount}:" styleClass="label" />
            <h:outputText value="#{workerWeekBean.workerStatistics.compensatedEntryCount}" />
          </t:div>
          <t:div styleClass="row ok" title="#{presenceBundle.compensationTimeInfo}" 
            rendered="#{workerWeekBean.workerStatistics.compensationTime gt 0}">
            <h:outputText value="#{presenceBundle.compensationTime}:" styleClass="label" />
            <h:outputText value="#{workerWeekBean.workerStatistics.compensationTime}">
              <f:converter converterId="IntervalConverter" />
            </h:outputText>
          </t:div>
          <t:div styleClass="row#{workerWeekBean.workerStatistics.workedTimeDifference lt 0 ? ' warning' : ' ok'}"
            title="#{presenceBundle.workedTimeDifferenceInfo}">
            <h:outputText value="#{presenceBundle.workedTimeDifference}:" styleClass="label" />
            <h:outputText value="#{workerWeekBean.workerStatistics.workedTimeDifference}">
              <f:converter converterId="IntervalConverter" />
              <f:attribute name="positiveSignum" value="true" />
            </h:outputText>
          </t:div>
          <t:div styleClass="row ok"
            title="#{presenceBundle.absenceDegreeInfo}">
            <h:outputText value="#{presenceBundle.absenceDegree}:" styleClass="label" />
            <h:outputText value="#{workerWeekBean.workerStatistics.absenceDegree}">
              <f:convertNumber type="number" groupingUsed="true" minFractionDigits="2" pattern="#0.00'%'"/>
            </h:outputText>
          </t:div>
          <t:div styleClass="row#{workerWeekBean.workerStatistics.complianceDegree lt 100 ? ' warning' : ' ok'}"
            title="#{presenceBundle.complianceDegreeInfo}">
            <h:outputText value="#{presenceBundle.complianceDegree}:" styleClass="label" />
            <h:outputText value="#{workerWeekBean.workerStatistics.complianceDegree}">
             <f:convertNumber type="number" groupingUsed="true" minFractionDigits="2" pattern="#0.00'%'"/>
            </h:outputText>
          </t:div>
          <t:div styleClass="row#{workerWeekBean.workerStatistics.punctualityDegree lt 100 ? ' warning' : ' ok'}"
            title="#{presenceBundle.punctualityDegreeInfo}">
            <h:outputText value="#{presenceBundle.punctualityDegree}:" styleClass="label" />
            <h:outputText value="#{workerWeekBean.workerStatistics.punctualityDegree}">
              <f:convertNumber type="number" groupingUsed="true" minFractionDigits="2" pattern="#0.00'%'"/>
            </h:outputText>
          </t:div>
          <t:div styleClass="row#{workerWeekBean.workerStatistics.veracityDegree lt 90 ? ' warning' : ' ok'}"
            title="#{presenceBundle.veracityDegreeInfo}">
            <h:outputText value="#{presenceBundle.veracityDegree}:" styleClass="label" />
            <h:outputText value="#{workerWeekBean.workerStatistics.veracityDegree}">
              <f:convertNumber type="number" groupingUsed="true" minFractionDigits="2" pattern="#0.00'%'"/>
            </h:outputText>
          </t:div>
          <t:div styleClass="row ok"
            title="#{presenceBundle.presenceDegreeInfo}">
            <h:outputText value="#{presenceBundle.presenceDegree}:" styleClass="label" />
            <h:outputText value="#{workerWeekBean.workerStatistics.presenceDegree}">
             <f:convertNumber type="number" groupingUsed="true" minFractionDigits="2" pattern="#0.00'%'"/>
            </h:outputText>
          </t:div>
        </t:div>
      </t:div>
    </t:div>

    <t:div styleClass="absence_counters_bars" rendered="#{not empty workerWeekBean.absenceCounters}">
      <t:panelGroup styleClass="counter">
        <h:outputText value="#{presenceBundle.availableTime} (#{workerWeekBean.absencesYear}):" />
      </t:panelGroup>
      <t:dataList value="#{workerWeekBean.absenceCounters}" var="counter">
        <t:panelGroup styleClass="counter">
          <h:outputText value="#{counter.absenceType.label}" styleClass="counterType" />
          <t:div styleClass="progressBar">
            <t:div style="width:#{100 * counter.absenceCounter.remainingTime / counter.absenceCounter.totalTime}%"></t:div>
          </t:div>
          <t:div styleClass="days">
            <h:outputText value="#{counter.absenceCounter.remainingTime}">
              <f:convertNumber type="number" groupingUsed="true" pattern="#0.##"/>
            </h:outputText>
            <h:outputText value=" / " />
            <h:outputText value="#{counter.absenceCounter.totalTime}">
              <f:convertNumber type="number" groupingUsed="true" pattern="#0.##"/>
            </h:outputText>
            <h:outputText value=" #{workerWeekBean.counterCounting}" />
          </t:div>
        </t:panelGroup>
      </t:dataList>
    </t:div>
  </t:div>

  <t:inputHidden value="#{workerWeekBean.scroll}" forceId="true" id="scroll_input" />

  <f:verbatim>
    <script type="text/javascript">  
      function setFocus()
      {
        if (document.getElementById("insert_time") != null)
        {
          var insertTime = document.getElementById("insert_time");
          insertTime.autocomplete = "off";
          insertTime.focus();
        }
      }
      setFocus();

      var scrollDiv = document.getElementById("scroll_div");
      var scrollInput = document.getElementById("scroll_input");

      scrollDiv.addEventListener("scroll", function(event)
      {
        scrollInput.value = scrollDiv.scrollTop;
      }, true);

      scrollDiv.scrollTop = parseFloat(scrollInput.value);

      // endDate copy
      var endElem = document.getElementById("mainform:endDateTime:date");
      if (endElem)
      {
        endElem.addEventListener("focus", function()
        {
          if (endElem.value == null || endElem.value.length == 0)
          {
            var startElem =
              document.getElementById("mainform:startDateTime:date");
            endElem.value = startElem.value;
          }
        }, false);
      }
      // automatic refresh in 5 minutes
      setTimeout(function(){document.forms[0].submit();}, 5 * 60 * 1000);

      var keyListener = function(event)
      {
        if (document.activeElement === document.body)
        {
          var key = event.key;
          if (key === '.')
          {
            var elem = document.getElementById("exit_presence");
            if (elem)
            {
              document.removeEventListener("keyup", keyListener);
              elem.click();
            }
          }
          else
          {
            var elements = document.getElementsByClassName("button key" + key);
            if (elements.length > 0)
            {
              var elem = elements[0];
              document.removeEventListener("keyup", keyListener);
              elem.click();
            }
          }
        }
      };
      document.addEventListener("keyup", keyListener, false);

      function enterTooltip(elem)
      {
        var elems = elem.getElementsByClassName("tooltip");
        var tooltip = elems[0];
        tooltip.style.display = "inline-block";
      }

      function exitTooltip(elem)
      {
        var elems = elem.getElementsByClassName("tooltip");
        var tooltip = elems[0];
        tooltip.style.display = "none";
      }

      function moveTooltip(elem, event)
      {
        var elems = elem.getElementsByClassName("tooltip");
        var tooltip = elems[0];
        tooltip.style.left = (event.clientX + 16) + "px";
        tooltip.style.top = (event.clientY + 16) + "px";
      }

      function showMessages()
      {
        var opacity = 1.0;
        var messageList = document.getElementById("message_list");
        if (messageList)
        {
          messageList.className = "messages popup";
          var updateOpacity = function()
          {
            opacity -= 0.01;
            messageList.style.opacity = opacity;
            if (opacity &lt;= 0)
            {
              messageList.className = "messages";
              messageList.style.opacity = 1.0;
            }
            else
            {
              setTimeout(updateOpacity, 10);
            }
          };
          setTimeout(updateOpacity, 2000);
        }
      }
      showMessages();

    </script>
  </f:verbatim>

</jsp:root>

