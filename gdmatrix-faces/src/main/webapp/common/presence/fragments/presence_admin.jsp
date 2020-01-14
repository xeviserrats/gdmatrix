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

  <sf:saveScroll resetIfError="true" />
  
  <jsp:include page="/common/presence/fragments/header.jsp"/>

  <t:div styleClass="presence_admin">
    <t:panelTabbedPane immediateTabChange="false" serverSideTabSwitch="true" styleClass="tabbed_panel">

      <!-- PresenceEntryType -->

      <t:panelTab label="#{presenceBundle.entryTypes}">
        <t:dataTable id="entryTypes" value="#{presenceAdminBean.entryTypes}" var="entryType"
          rowStyleClass="#{entryType == presenceAdminBean.editingEntryType ? 'selected': null}" 
          styleClass="presence_table" bodyStyleClass="#{empty presenceAdminBean.entryTypes ? 'empty' : null}">
          <t:column sortable="true" style="width:5%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.id}" />
            </f:facet>
            <h:outputText value="#{entryType.entryTypeId}" />
          </t:column>
          <t:column sortable="true" style="width:30%">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.label}" />
            </f:facet>
            <h:outputText value="#{entryType.label}" 
              styleClass="#{entryType.enabled ? null : ' disabled'}"
              rendered="#{presenceAdminBean.editingEntryType != entryType}" />
            <h:inputText value="#{entryType.label}" rendered="#{presenceAdminBean.editingEntryType == entryType}" 
              styleClass="input_text short" style="width:200px" />
            <t:div rendered="#{presenceAdminBean.editingEntryType == entryType}" styleClass="popup_button info">
              <t:div styleClass="popup">
              <h:inputTextarea rows="5" value="#{entryType.description}" 
                rendered="#{presenceAdminBean.editingEntryType == entryType}" 
                styleClass="input_text"/>
              </t:div>
            </t:div>
          </t:column>
          <t:column sortable="true" style="width:5%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.code}" />
            </f:facet>
            <h:outputText value="#{entryType.code}" rendered="#{presenceAdminBean.editingEntryType != entryType}" 
              styleClass="code" />
            <h:inputText value="#{entryType.code}" rendered="#{presenceAdminBean.editingEntryType == entryType}" 
              styleClass="input_text code" maxlength="3" />
          </t:column>
          <t:column sortable="true" style="width:6%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.enabled}" />
            </f:facet>
            <h:selectBooleanCheckbox value="#{entryType.enabled}"
              title="#{presenceBundle.enabled}"
              disabled="#{presenceAdminBean.editingEntryType != entryType}" />
          </t:column>
          <t:column sortable="true" style="width:6%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.realWork}" />
            </f:facet>
            <h:selectBooleanCheckbox value="#{entryType.realWork}" 
              title="#{presenceBundle.realWork}"
              disabled="#{presenceAdminBean.editingEntryType != entryType}" />
          </t:column>
          <t:column sortable="true" style="width:6%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.absenceShort}" />
            </f:facet>
            <h:selectBooleanCheckbox value="#{entryType.absence}" 
              title="#{presenceBundle.absence}"
              disabled="#{presenceAdminBean.editingEntryType != entryType}" />
          </t:column>
          <t:column sortable="true" style="width:6%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.consolidableShort}" />
            </f:facet>
            <h:selectBooleanCheckbox value="#{entryType.consolidable}" 
              title="#{presenceBundle.consolidable}"
              disabled="#{presenceAdminBean.editingEntryType != entryType}" />
          </t:column>
          <t:column sortable="true" style="width:6%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.maxWorkedTime}" />
            </f:facet>
            <h:outputText value="#{entryType.maxWorkedTime}" 
              rendered="#{presenceAdminBean.editingEntryType != entryType}">
              <f:converter converterId="IntervalConverter" />
            </h:outputText>
            <h:inputText value="#{entryType.maxWorkedTime}" 
              rendered="#{presenceAdminBean.editingEntryType == entryType}" 
              styleClass="input_text">
              <f:converter converterId="IntervalConverter" />
            </h:inputText>
          </t:column>
          <t:column sortable="true" style="width:4%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="F." />
            </f:facet>
            <t:div styleClass="popup_button filter #{presenceAdminBean.editingEntryType == entryType or entryType.filter != null ? 'set' : 'none'}">
              <t:div styleClass="popup" style="width:200px;height:80px">
                <h:inputTextarea rows="3" value="#{entryType.filter}" 
                  readonly="#{presenceAdminBean.editingEntryType != entryType}" 
                  styleClass="input_text"/>
              </t:div>
            </t:div>
          </t:column>
          <t:column sortable="true" style="width:10%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.color}" />
            </f:facet>
            <h:panelGroup rendered="#{presenceAdminBean.editingEntryType != entryType and entryType.color != null}">
              <t:div style="background-color:##{entryType.color};" styleClass="color_sample" />
              <h:outputText value="#{entryType.color}" styleClass="color_code" />
            </h:panelGroup>
            <h:inputText value="#{entryType.color}" rendered="#{presenceAdminBean.editingEntryType == entryType}" 
              styleClass="input_text code color {hash:false, required:false}" />
          </t:column>
          <t:column sortable="true" style="width:6%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.position}" />
            </f:facet>
            <h:outputText value="#{entryType.position}" rendered="#{presenceAdminBean.editingEntryType != entryType}" />
            <h:inputText value="#{entryType.position}" rendered="#{presenceAdminBean.editingEntryType == entryType}" 
              styleClass="input_text" />
          </t:column>
          <t:column style="width:10%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.actions}" />
            </f:facet>
            <t:div styleClass="toolbar">
              <h:commandButton action="#{presenceAdminBean.editEntryType}" image="/common/presence/images/edit.png"
                rendered="#{presenceAdminBean.editingEntryType == null}" styleClass="button" 
                alt="#{objectBundle.edit}" title="#{objectBundle.edit}" />
              <h:commandButton action="#{presenceAdminBean.removeEntryType}" image="/common/presence/images/remove.png" 
                rendered="#{presenceAdminBean.editingEntryType == null}" styleClass="button" 
                alt="#{objectBundle.delete}" title="#{objectBundle.delete}" 
                onclick="return confirm('#{presenceBundle.confirmRemoveEntryType}')"/>
              <h:commandButton action="#{presenceAdminBean.storeEntryType}" image="/common/presence/images/accept.png" 
                rendered="#{presenceAdminBean.editingEntryType == entryType}" styleClass="button"
                alt="#{objectBundle.accept}" title="#{objectBundle.accept}" />
              <h:commandButton action="#{presenceAdminBean.cancelEntryType}" image="/common/presence/images/cancel.png" 
                rendered="#{presenceAdminBean.editingEntryType == entryType}" styleClass="button"
                alt="#{objectBundle.cancel}" immediate="true" title="#{objectBundle.cancel}" />
            </t:div>
          </t:column>
        </t:dataTable>
        <h:commandLink action="#{presenceAdminBean.newEntryType}" 
          rendered="#{presenceAdminBean.editingEntryType == null}" styleClass="button img_left">
          <t:outputText value="#{presenceBundle.addNew}" styleClass="new" />
        </h:commandLink>
      </t:panelTab>

      <!-- AbsenceType -->

      <t:panelTab label="#{presenceBundle.absenceTypes}">
        <t:dataTable id="absenceTypes" value="#{presenceAdminBean.absenceTypes}" var="absenceType" rowIndexVar="index"
          rowStyleClass="#{absenceType == presenceAdminBean.editingAbsenceType ? 'selected': null}" 
          styleClass="presence_table" bodyStyleClass="#{empty presenceAdminBean.absenceTypes ? 'empty' : null}">
          <t:column sortable="true" style="width:5%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.id}" />
            </f:facet>
            <h:outputText value="#{absenceType.absenceTypeId}" />
          </t:column>
          <t:column sortable="true" style="width:31%">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.label}" />
            </f:facet>
            <h:outputText value="#{absenceType.label}" 
              styleClass="#{absenceType.enabled ? null : ' disabled'}"
              rendered="#{presenceAdminBean.editingAbsenceType != absenceType}" />
            <h:inputText value="#{absenceType.label}" rendered="#{presenceAdminBean.editingAbsenceType == absenceType}" 
              styleClass="input_text short" />
            <t:div rendered="#{presenceAdminBean.editingAbsenceType == absenceType}" styleClass="popup_button info">
              <t:div styleClass="popup">
              <h:inputTextarea rows="5" value="#{absenceType.description}" 
                rendered="#{presenceAdminBean.editingAbsenceType == absenceType}" 
                styleClass="input_text"/>
              </t:div>
            </t:div>
          </t:column>
          <t:column sortable="true" style="width:5%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.enabled}" />
            </f:facet>
            <h:selectBooleanCheckbox value="#{absenceType.enabled}" disabled="#{presenceAdminBean.editingAbsenceType != absenceType}" 
              title="#{presenceBundle.enabled}" />
          </t:column>
          <t:column sortable="true" style="width:5%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.authorization}" />
            </f:facet>
            <h:selectBooleanCheckbox value="#{absenceType.authorizable}" disabled="#{presenceAdminBean.editingAbsenceType != absenceType}" 
               title="#{presenceBundle.authorizable}" />
          </t:column>
          <t:column sortable="true" style="width:5%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.justify}" />
            </f:facet>
            <h:selectBooleanCheckbox value="#{absenceType.justificable}" disabled="#{presenceAdminBean.editingAbsenceType != absenceType}" 
               title="#{presenceBundle.justificable}" />
          </t:column>
          <t:column sortable="true" style="width:5%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.holiday}" />
            </f:facet>
            <h:selectBooleanCheckbox value="#{absenceType.holiday}" disabled="#{presenceAdminBean.editingAbsenceType != absenceType}" 
               title="#{presenceBundle.holidays}"/>
          </t:column>
          <t:column sortable="true" style="width:5%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.countVis}" />
            </f:facet>
            <h:selectBooleanCheckbox value="#{absenceType.counterVisible}" disabled="#{presenceAdminBean.editingAbsenceType != absenceType}" 
              title="#{presenceBundle.counterVisible}" />
          </t:column>
          <t:column sortable="true" style="width:6%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.consolidation}" />
            </f:facet>
            <t:outputText value="#{presenceAdminBean.absenceEntryTypeCode}" styleClass="code value"
              title="#{presenceAdminBean.absenceEntryTypeLabel}" 
              style="background-color:#{presenceAdminBean.absenceEntryTypeColor}"
              rendered="#{presenceAdminBean.editingAbsenceType != absenceType}"/>
            <t:div styleClass="select_popup" rendered="#{presenceAdminBean.editingAbsenceType == absenceType}">
              <h:outputLink value="#" onclick="return false;" onfocus="showOptions(this);" 
                styleClass="code value edit">
                <t:outputText value="#{presenceAdminBean.absenceEntryTypeCode}" />
              </h:outputLink>
              <t:div styleClass="popup">
                <t:selectOneListbox size="6" value="#{absenceType.entryTypeId}" 
                  onchange="selectOption(this)" ondblclick="hideOptions(this)" 
                  onblur="hideOptions(this)" onkeypress="captureKeyPress(this, event)">
                  <f:selectItem itemLabel=" " itemValue="" />
                  <f:selectItems value="#{presenceConfigBean.presenceEntryTypeSelectItems}" />
                </t:selectOneListbox>
              </t:div>
            </t:div>
          </t:column>
          <t:column sortable="true" style="width:6%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.defaultTime}" />
            </f:facet>
            <h:outputText value="#{absenceType.defaultTime lt 0 ? '-' : absenceType.defaultTime}" rendered="#{presenceAdminBean.editingAbsenceType != absenceType}" />
            <h:inputText value="#{absenceType.defaultTime}" rendered="#{presenceAdminBean.editingAbsenceType == absenceType}" 
              styleClass="input_text" />
          </t:column>
          <t:column sortable="true" style="width:6%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.count}" />
            </f:facet>
            <h:outputText value="#{presenceAdminBean.absenceCountingLabel}" styleClass="small"
              rendered="#{presenceAdminBean.editingAbsenceType != absenceType}" />
            <t:selectOneMenu value="#{absenceType.counting}"
              rendered="#{presenceAdminBean.editingAbsenceType == absenceType}" 
              styleClass="select_box small">
              <f:selectItems value="#{presenceAdminBean.absenceCountingSelectItems}" />
              <f:converter converterId="EnumConverter" />
              <f:attribute name="enum" value="org.matrix.presence.AbsenceCounting" />
            </t:selectOneMenu>
          </t:column>
          <t:column sortable="true" style="width:5%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.carry}" />
            </f:facet>
            <h:selectBooleanCheckbox value="#{absenceType.carry}" disabled="#{presenceAdminBean.editingAbsenceType != absenceType}" 
              title="#{presenceBundle.carry}" />
          </t:column>
          <t:column sortable="true" style="width:6%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.position}" />
            </f:facet>
            <h:outputText value="#{absenceType.position}" rendered="#{presenceAdminBean.editingAbsenceType != absenceType}" />
            <h:inputText value="#{absenceType.position}" rendered="#{presenceAdminBean.editingAbsenceType == absenceType}" 
              styleClass="input_text" />
          </t:column>
          <t:column style="width:10%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.actions}" />
            </f:facet>
            <t:div styleClass="toolbar">
              <h:commandButton action="#{presenceAdminBean.editAbsenceType}" image="/common/presence/images/edit.png"
                rendered="#{presenceAdminBean.editingAbsenceType == null}" styleClass="button" 
                alt="#{objectBundle.edit}" title="#{objectBundle.edit}" />
              <h:commandButton action="#{presenceAdminBean.removeAbsenceType}" image="/common/presence/images/remove.png" 
                rendered="#{presenceAdminBean.editingAbsenceType == null}" styleClass="button" 
                onclick="return confirm('#{presenceBundle.confirmRemoveAbsenceType}')"
                alt="#{objectBundle.delete}" title="#{objectBundle.delete}" />
              <h:commandButton action="#{presenceAdminBean.storeAbsenceType}" image="/common/presence/images/accept.png" 
                rendered="#{presenceAdminBean.editingAbsenceType == absenceType}" styleClass="button" 
                alt="#{objectBundle.accept}" title="#{objectBundle.accept}" />
              <h:commandButton action="#{presenceAdminBean.cancelAbsenceType}" image="/common/presence/images/cancel.png" 
                rendered="#{presenceAdminBean.editingAbsenceType == absenceType}" styleClass="button" 
                alt="#{objectBundle.cancel}" immediate="true" title="#{objectBundle.cancel}" />
            </t:div>
          </t:column>
        </t:dataTable>
        <h:commandLink action="#{presenceAdminBean.newAbsenceType}" 
          rendered="#{presenceAdminBean.editingAbsenceType == null}" styleClass="button img_left">
          <t:outputText value="#{presenceBundle.addNew}" styleClass="new" />
        </h:commandLink>
      </t:panelTab>

      <!-- DayType -->

      <t:panelTab label="#{presenceBundle.dayTypes}">
        <t:dataTable id="dayTypes" value="#{presenceAdminBean.dayTypes}" var="dayType"
          rowStyleClass="#{dayType == presenceAdminBean.editingDayType ? 'selected': null}" 
          styleClass="presence_table" bodyStyleClass="#{empty presenceAdminBean.dayTypes ? 'empty' : null}">
          <t:column sortable="true" style="width:5%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.id}" />
            </f:facet>
            <h:outputText value="#{dayType.dayTypeId}" />
          </t:column>
          <t:column sortable="true" style="width:24%">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.label}" />
            </f:facet>
            <h:outputText value="#{dayType.label}" rendered="#{presenceAdminBean.editingDayType != dayType}" />
            <h:inputText value="#{dayType.label}" rendered="#{presenceAdminBean.editingDayType == dayType}" 
              styleClass="input_text" />
          </t:column>
          <t:column sortable="true" style="width:5%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.code}" />
            </f:facet>
            <h:outputText value="#{dayType.code}" rendered="#{presenceAdminBean.editingDayType != dayType}" 
              styleClass="code" />
            <h:inputText value="#{dayType.code}" rendered="#{presenceAdminBean.editingDayType == dayType}" 
              styleClass="input_text code" maxlength="3" />
          </t:column>
          <t:column sortable="true" style="width:6%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.in1}" />
            </f:facet>
            <h:outputText value="#{dayType.inTime1}" rendered="#{presenceAdminBean.editingDayType != dayType}">
              <f:converter converterId="TimeConverter" />
            </h:outputText>
            <h:inputText value="#{dayType.inTime1}" rendered="#{presenceAdminBean.editingDayType == dayType}" 
              styleClass="input_text" required="true">
              <f:converter converterId="TimeConverter" />
            </h:inputText>
          </t:column>
          <t:column sortable="true" style="width:6%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.out1}" />
            </f:facet>
            <h:outputText value="#{dayType.outTime1}" rendered="#{presenceAdminBean.editingDayType != dayType}">
              <f:converter converterId="TimeConverter" />
            </h:outputText>
            <h:inputText value="#{dayType.outTime1}" rendered="#{presenceAdminBean.editingDayType == dayType}" 
              styleClass="input_text" required="true">
              <f:converter converterId="TimeConverter" />
            </h:inputText>
          </t:column>
          <t:column sortable="true" style="width:6%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.flex}1" />
            </f:facet>
            <h:outputText value="#{dayType.flexibility1}" rendered="#{presenceAdminBean.editingDayType != dayType}"
              title="#{presenceBundle.flexibility}1">
              <f:converter converterId="IntervalConverter" />
            </h:outputText>
            <h:inputText value="#{dayType.flexibility1}" rendered="#{presenceAdminBean.editingDayType == dayType}" 
              styleClass="input_text">
              <f:converter converterId="IntervalConverter" />
            </h:inputText>
          </t:column>
          <t:column sortable="true" style="width:6%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.in2}" />
            </f:facet>
            <h:outputText value="#{dayType.inTime2}" rendered="#{presenceAdminBean.editingDayType != dayType}">
              <f:converter converterId="TimeConverter" />
            </h:outputText>
            <h:inputText value="#{dayType.inTime2}" rendered="#{presenceAdminBean.editingDayType == dayType}" 
              styleClass="input_text">
              <f:converter converterId="TimeConverter" />
            </h:inputText>
          </t:column>
          <t:column sortable="true" style="width:6%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.out2}" />
            </f:facet>
            <h:outputText value="#{dayType.outTime2}" rendered="#{presenceAdminBean.editingDayType != dayType}">
              <f:converter converterId="TimeConverter" />
            </h:outputText>
            <h:inputText value="#{dayType.outTime2}" rendered="#{presenceAdminBean.editingDayType == dayType}" 
              styleClass="input_text">
              <f:converter converterId="TimeConverter" />
            </h:inputText>
          </t:column>
          <t:column sortable="true" style="width:6%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.flex}2" />
            </f:facet>
            <h:outputText value="#{dayType.flexibility2}" rendered="#{presenceAdminBean.editingDayType != dayType}"
              title="#{presenceBundle.flexibility}2">
              <f:converter converterId="IntervalConverter" />
            </h:outputText>
            <h:inputText value="#{dayType.flexibility2}" rendered="#{presenceAdminBean.editingDayType == dayType}" 
              styleClass="input_text">
              <f:converter converterId="IntervalConverter" />
            </h:inputText>
          </t:column>
          <t:column sortable="true" style="width:5%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.holid}" />
            </f:facet>
            <h:selectBooleanCheckbox value="#{dayType.holidaysEnabled}" disabled="#{presenceAdminBean.editingDayType != dayType}" 
              title="#{presenceBundle.festivities}" />
          </t:column>
          <t:column sortable="true" style="width:5%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.reduct}" />
            </f:facet>
            <h:selectBooleanCheckbox value="#{dayType.reductionsEnabled}" disabled="#{presenceAdminBean.editingDayType != dayType}" 
              title="#{presenceBundle.reductions}" />
          </t:column>
          <t:column sortable="true" style="width:10%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.color}" />
            </f:facet>
            <h:panelGroup rendered="#{presenceAdminBean.editingDayType != dayType and dayType.color != null}">
              <t:div style="background-color:##{dayType.color};" styleClass="color_sample" />
              <h:outputText value="#{dayType.color}" styleClass="color_code" />
            </h:panelGroup>
            <h:inputText value="#{dayType.color}" rendered="#{presenceAdminBean.editingDayType == dayType}" 
              styleClass="input_text code color {hash:false, required:false}" />
          </t:column>
          <t:column style="width:10%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.actions}" />
            </f:facet>
            <t:div styleClass="toolbar">
              <h:commandButton action="#{presenceAdminBean.editDayType}" image="/common/presence/images/edit.png"
                rendered="#{presenceAdminBean.editingDayType == null}" styleClass="button" 
                alt="#{objectBundle.edit}" title="#{objectBundle.edit}" />
              <h:commandButton action="#{presenceAdminBean.removeDayType}" image="/common/presence/images/remove.png" 
                rendered="#{presenceAdminBean.editingDayType == null}" styleClass="button" 
                onclick="return confirm('#{presenceBundle.confirmRemoveDayType}')"
                alt="#{objectBundle.delete}" title="#{objectBundle.delete}" />
              <h:commandButton action="#{presenceAdminBean.storeDayType}" image="/common/presence/images/accept.png" 
                rendered="#{presenceAdminBean.editingDayType == dayType}" styleClass="button" 
                alt="#{objectBundle.accept}" title="#{objectBundle.accept}" />
              <h:commandButton action="#{presenceAdminBean.cancelDayType}" image="/common/presence/images/cancel.png" 
                rendered="#{presenceAdminBean.editingDayType == dayType}" styleClass="button" 
                alt="#{objectBundle.cancel}" immediate="true" title="#{objectBundle.cancel}" />
            </t:div>
          </t:column>
        </t:dataTable>
        <h:commandLink action="#{presenceAdminBean.newDayType}" 
          rendered="#{presenceAdminBean.editingDayType == null}" styleClass="button img_left">
          <t:outputText value="#{presenceBundle.addNew}" styleClass="new" />
        </h:commandLink>
      </t:panelTab>

      <!-- WeekType -->

      <t:panelTab label="#{presenceBundle.weekTypes}">
        <t:dataTable id="weekTypes" value="#{presenceAdminBean.weekTypes}" var="weekType" rowIndexVar="index"
          rowStyleClass="#{weekType == presenceAdminBean.editingWeekType ? 'selected': null}" 
          styleClass="presence_table" bodyStyleClass="#{empty presenceAdminBean.weekTypes ? 'empty' : null}">
          <t:column sortable="true" style="width:5%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.id}" />
            </f:facet>
            <h:outputText value="#{weekType.weekTypeId}" />
          </t:column>
          <t:column sortable="true" style="width:33%">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.label}" />
            </f:facet>
            <h:outputText value="#{weekType.label}" rendered="#{presenceAdminBean.editingWeekType != weekType}" />
            <h:inputText value="#{weekType.label}" rendered="#{presenceAdminBean.editingWeekType == weekType}" 
              styleClass="input_text" />
          </t:column>
          <t:column sortable="true" style="width:6%" styleClass=" center">
            <f:facet name="header">
              <h:outputText value="#{presenceConfigBean.daysOfWeek[0]}" />
            </f:facet>
            <t:outputText value="#{presenceAdminBean.dayTypeCodeList[0]}" 
              title="#{presenceAdminBean.dayTypeLabelList[0]}" styleClass="code value" 
              style="background-color:#{presenceAdminBean.dayTypeColorList[0]}" 
              rendered="#{presenceAdminBean.editingWeekType != weekType}" />
            <t:div styleClass="select_popup" rendered="#{presenceAdminBean.editingWeekType == weekType}">
              <h:outputLink value="#" onclick="return false;" 
                onfocus="showOptions(this)" styleClass="code value edit">
                <t:outputText value="#{presenceAdminBean.dayTypeCodeList[0]}" />
              </h:outputLink>
              <t:div styleClass="popup">
                <t:selectOneListbox size="10" value="#{weekType.mondayTypeId}" 
                  onchange="selectOption(this)" ondblclick="hideOptions(this)" 
                  onblur="hideOptions(this)" onkeypress="captureKeyPress(this, event)">
                  <f:selectItem itemLabel=" " itemValue="" />
                  <f:selectItems value="#{presenceConfigBean.dayTypeSelectItems}" />
                </t:selectOneListbox>
              </t:div>
            </t:div>
          </t:column>
          <t:column sortable="true" style="width:6%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceConfigBean.daysOfWeek[1]}" />
            </f:facet>
            <t:outputText value="#{presenceAdminBean.dayTypeCodeList[1]}" 
              title="#{presenceAdminBean.dayTypeLabelList[1]}" styleClass="code value" 
              style="background-color:#{presenceAdminBean.dayTypeColorList[1]}" 
              rendered="#{presenceAdminBean.editingWeekType != weekType}" />
            <t:div styleClass="select_popup" rendered="#{presenceAdminBean.editingWeekType == weekType}">
              <h:outputLink value="#" onclick="return false;" 
                onfocus="showOptions(this)" styleClass="code value edit">
                <t:outputText value="#{presenceAdminBean.dayTypeCodeList[1]}" />
              </h:outputLink>
              <t:div styleClass="popup">
                <t:selectOneListbox size="10" value="#{weekType.tuesdayTypeId}" 
                  onchange="selectOption(this)" ondblclick="hideOptions(this)" 
                  onblur="hideOptions(this)" onkeypress="captureKeyPress(this, event)">
                  <f:selectItem itemLabel=" " itemValue="" />
                  <f:selectItems value="#{presenceConfigBean.dayTypeSelectItems}" />
                </t:selectOneListbox>
              </t:div>
            </t:div>
          </t:column>
          <t:column sortable="true" style="width:6%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceConfigBean.daysOfWeek[2]}" />
            </f:facet>
            <t:outputText value="#{presenceAdminBean.dayTypeCodeList[2]}" 
              title="#{presenceAdminBean.dayTypeLabelList[2]}" styleClass="code value" 
              style="background-color:#{presenceAdminBean.dayTypeColorList[2]}" 
              rendered="#{presenceAdminBean.editingWeekType != weekType}" />
            <t:div styleClass="select_popup" rendered="#{presenceAdminBean.editingWeekType == weekType}">
              <h:outputLink value="#" onclick="return false;"
                onfocus="showOptions(this)" styleClass="code value edit">
                <t:outputText value="#{presenceAdminBean.dayTypeCodeList[2]}" />
              </h:outputLink>
              <t:div styleClass="popup">
                <t:selectOneListbox size="10" value="#{weekType.wednesdayTypeId}" 
                  onchange="selectOption(this)" ondblclick="hideOptions(this)" 
                  onblur="hideOptions(this)" onkeypress="captureKeyPress(this, event)">
                  <f:selectItem itemLabel=" " itemValue="" />
                  <f:selectItems value="#{presenceConfigBean.dayTypeSelectItems}" />
                </t:selectOneListbox>
              </t:div>
            </t:div>
          </t:column>
          <t:column sortable="true" style="width:6%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceConfigBean.daysOfWeek[3]}" />
            </f:facet>
            <t:outputText value="#{presenceAdminBean.dayTypeCodeList[3]}" 
              title="#{presenceAdminBean.dayTypeLabelList[3]}" styleClass="code value" 
              style="background-color:#{presenceAdminBean.dayTypeColorList[3]}" 
              rendered="#{presenceAdminBean.editingWeekType != weekType}" />
            <t:div styleClass="select_popup" rendered="#{presenceAdminBean.editingWeekType == weekType}">
              <h:outputLink value="#" onclick="return false;"
                onfocus="showOptions(this)" styleClass="code value edit">
                <t:outputText value="#{presenceAdminBean.dayTypeCodeList[3]}" />
              </h:outputLink>
              <t:div styleClass="popup">
                <t:selectOneListbox size="10" value="#{weekType.thursdayTypeId}" 
                  onchange="selectOption(this)" ondblclick="hideOptions(this)" 
                  onblur="hideOptions(this)" onkeypress="captureKeyPress(this, event)">
                  <f:selectItem itemLabel=" " itemValue="" />
                  <f:selectItems value="#{presenceConfigBean.dayTypeSelectItems}" />
                </t:selectOneListbox>
              </t:div>
            </t:div>
          </t:column>
          <t:column sortable="true" style="width:6%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceConfigBean.daysOfWeek[4]}" />
            </f:facet>
            <t:outputText value="#{presenceAdminBean.dayTypeCodeList[4]}" 
              title="#{presenceAdminBean.dayTypeLabelList[4]}" styleClass="code value" 
              style="background-color:#{presenceAdminBean.dayTypeColorList[4]}" 
              rendered="#{presenceAdminBean.editingWeekType != weekType}" />
            <t:div styleClass="select_popup" rendered="#{presenceAdminBean.editingWeekType == weekType}">
              <h:outputLink value="#" onclick="return false;"
                onfocus="showOptions(this)" styleClass="code value edit">
                <t:outputText value="#{presenceAdminBean.dayTypeCodeList[4]}" />
              </h:outputLink>
              <t:div styleClass="popup">
                <t:selectOneListbox size="10" value="#{weekType.fridayTypeId}" 
                  onchange="selectOption(this)" ondblclick="hideOptions(this)" 
                  onblur="hideOptions(this)" onkeypress="captureKeyPress(this, event)">
                  <f:selectItem itemLabel=" " itemValue="" />
                  <f:selectItems value="#{presenceConfigBean.dayTypeSelectItems}" />
                </t:selectOneListbox>
              </t:div>
            </t:div>
          </t:column>
          <t:column sortable="true" style="width:6%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceConfigBean.daysOfWeek[5]}" />
            </f:facet>
            <t:outputText value="#{presenceAdminBean.dayTypeCodeList[5]}" 
              title="#{presenceAdminBean.dayTypeLabelList[5]}" styleClass="code value" 
              style="background-color:#{presenceAdminBean.dayTypeColorList[5]}" 
              rendered="#{presenceAdminBean.editingWeekType != weekType}" />
            <t:div styleClass="select_popup" rendered="#{presenceAdminBean.editingWeekType == weekType}">
              <h:outputLink value="#" onclick="return false;"
                onfocus="showOptions(this)" styleClass="code value edit">
                <t:outputText value="#{presenceAdminBean.dayTypeCodeList[5]}" />
              </h:outputLink>
              <t:div styleClass="popup">
                <t:selectOneListbox size="10" value="#{weekType.saturdayTypeId}" 
                  onchange="selectOption(this)" ondblclick="hideOptions(this)" 
                  onblur="hideOptions(this)" onkeypress="captureKeyPress(this, event)">
                  <f:selectItem itemLabel=" " itemValue="" />
                  <f:selectItems value="#{presenceConfigBean.dayTypeSelectItems}" />
                </t:selectOneListbox>
              </t:div>
            </t:div>
          </t:column>
          <t:column sortable="true" style="width:6%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceConfigBean.daysOfWeek[6]}" />
            </f:facet>
            <t:outputText value="#{presenceAdminBean.dayTypeCodeList[6]}" 
              title="#{presenceAdminBean.dayTypeLabelList[6]}" styleClass="code value" 
              style="background-color:#{presenceAdminBean.dayTypeColorList[6]}" 
              rendered="#{presenceAdminBean.editingWeekType != weekType}" />
            <t:div styleClass="select_popup" rendered="#{presenceAdminBean.editingWeekType == weekType}">
              <h:outputLink value="#" onclick="return false;"
                onfocus="showOptions(this)" styleClass="code value edit">
                <t:outputText value="#{presenceAdminBean.dayTypeCodeList[6]}" />
              </h:outputLink>
              <t:div styleClass="popup">
                <t:selectOneListbox size="10" value="#{weekType.sundayTypeId}" 
                  onchange="selectOption(this)" ondblclick="hideOptions(this)" 
                  onblur="hideOptions(this)" onkeypress="captureKeyPress(this, event)">
                  <f:selectItem itemLabel=" " itemValue="" />
                  <f:selectItems value="#{presenceConfigBean.dayTypeSelectItems}" />
                </t:selectOneListbox>
              </t:div>
            </t:div>
          </t:column>
          <t:column style="width:10%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.hours}" />
            </f:facet>
            <t:outputText value="#{presenceAdminBean.weekTime}">
              <f:converter converterId="IntervalConverter" />
            </t:outputText>
          </t:column>
          <t:column style="width:10%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.actions}" />
            </f:facet>
            <t:div styleClass="toolbar">
              <h:commandButton action="#{presenceAdminBean.editWeekType}" image="/common/presence/images/edit.png"
                rendered="#{presenceAdminBean.editingWeekType == null}" styleClass="button" 
                alt="#{objectBundle.edit}" title="#{objectBundle.edit}" />
              <h:commandButton action="#{presenceAdminBean.removeWeekType}" image="/common/presence/images/remove.png" 
                rendered="#{presenceAdminBean.editingWeekType == null}" styleClass="button" 
                onclick="return confirm('#{presenceBundle.confirmRemoveWeekType}')"
                alt="#{objectBundle.delete}" title="#{objectBundle.delete}" />
              <h:commandButton action="#{presenceAdminBean.storeWeekType}" image="/common/presence/images/accept.png" 
                rendered="#{presenceAdminBean.editingWeekType == weekType}" styleClass="button" 
                alt="#{objectBundle.accept}" title="#{objectBundle.accept}" />
              <h:commandButton action="#{presenceAdminBean.cancelWeekType}" image="/common/presence/images/cancel.png" 
                rendered="#{presenceAdminBean.editingWeekType == weekType}" styleClass="button" 
                alt="#{objectBundle.cancel}" immediate="true" title="#{objectBundle.cancel}" />
            </t:div>
          </t:column>
        </t:dataTable>
        <h:commandLink action="#{presenceAdminBean.newWeekType}" 
          rendered="#{presenceAdminBean.editingWeekType == null}" styleClass="button img_left">
          <t:outputText value="#{presenceBundle.addNew}" styleClass="new" />
        </h:commandLink>
      </t:panelTab>

      <!-- Holidays/Festivities -->
      
      <t:panelTab label="#{presenceBundle.festivities}">
        <t:div styleClass="toolbar">
          <h:commandLink action="#{presenceAdminBean.previousHolidayYear}" styleClass="button img_left"
            title="#{presenceBundle.previousYearInfo}">
            <t:outputText value="#{presenceBundle.previous}" styleClass="left" />
          </h:commandLink>    
          <h:commandLink action="#{presenceAdminBean.currentHolidayYear}" value="#{presenceAdminBean.holidayYear}" 
                         styleClass="button" title="#{presenceBundle.currentYearInfo}" />
          <h:commandLink action="#{presenceAdminBean.nextHolidayYear}" styleClass="button img_right"
            title="#{presenceBundle.nextYearInfo}">
            <t:outputText value="#{presenceBundle.next}" styleClass="right" />
          </h:commandLink>
        </t:div>
        <t:dataTable id="holidays" value="#{presenceAdminBean.holidays}" var="holiday"
          rowStyleClass="#{holiday == presenceAdminBean.editingHoliday ? 'selected': null}" 
          styleClass="presence_table" bodyStyleClass="#{empty presenceAdminBean.holidays ? 'empty' : null}">
          <t:column sortable="true" style="width:5%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.id}" />
            </f:facet>
            <h:outputText value="#{holiday.holidayId}" />
          </t:column>
          <t:column sortable="true" style="width:15%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.startDate}" />
            </f:facet>
            <h:outputText value="#{holiday.startDate}" rendered="#{presenceAdminBean.editingHoliday != holiday}">
              <f:converter converterId="DateTimeConverter" />
              <f:attribute name="userFormat" value="dd/MM/yyyy" />
              <f:attribute name="internalFormat" value="yyyyMMdd" />
            </h:outputText>
            <sf:calendar value="#{holiday.startDate}" rendered="#{presenceAdminBean.editingHoliday == holiday}" 
              styleClass="input_date" />
          </t:column>
          <t:column sortable="true" style="width:15%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.endDate}" />
            </f:facet>
            <h:outputText value="#{holiday.endDate}" rendered="#{presenceAdminBean.editingHoliday != holiday}">
              <f:converter converterId="DateTimeConverter" />
              <f:attribute name="userFormat" value="dd/MM/yyyy" />
              <f:attribute name="internalFormat" value="yyyyMMdd" />
            </h:outputText>
            <sf:calendar value="#{holiday.endDate}" rendered="#{presenceAdminBean.editingHoliday == holiday}" 
              styleClass="input_date" />
          </t:column>
          <t:column sortable="true" style="width:34%">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.description}" />
            </f:facet>
            <h:outputText value="#{holiday.description}" rendered="#{presenceAdminBean.editingHoliday != holiday}" />
            <h:inputText value="#{holiday.description}" rendered="#{presenceAdminBean.editingHoliday == holiday}" 
              styleClass="input_text" />
          </t:column>
          <t:column sortable="true" style="width:8%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.optional}" />
            </f:facet>
            <h:selectBooleanCheckbox value="#{holiday.optional}" disabled="#{presenceAdminBean.editingHoliday != holiday}" />
          </t:column>
          <t:column sortable="true" 
            style="width:10%" 
            styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.color}" />
            </f:facet>
            <h:panelGroup rendered="#{presenceAdminBean.editingHoliday != holiday and holiday.color != null}">
              <t:div style="background-color:##{holiday.color};" styleClass="color_sample" />
              <h:outputText value="#{holiday.color}" styleClass="color_code" />
            </h:panelGroup>
            <h:inputText value="#{holiday.color}" rendered="#{presenceAdminBean.editingHoliday == holiday}" 
              styleClass="input_text code color {hash:false, required:false}" />
          </t:column>
          <t:column style="width:13%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.actions}" />
            </f:facet>
            <t:div styleClass="toolbar">
              <h:commandButton action="#{presenceAdminBean.editHoliday}" image="/common/presence/images/edit.png"
                rendered="#{presenceAdminBean.editingHoliday == null}" styleClass="button" 
                alt="#{objectBundle.edit}" title="#{objectBundle.edit}" />
              <h:commandButton action="#{presenceAdminBean.removeHoliday}" image="/common/presence/images/remove.png" 
                rendered="#{presenceAdminBean.editingHoliday == null}" styleClass="button" 
                onclick="return confirm('#{presenceBundle.confirmRemoveHoliday}')"
                alt="#{objectBundle.delete}" title="#{objectBundle.delete}" />
              <h:commandButton action="#{presenceAdminBean.copyHoliday}" image="/common/presence/images/copy_next_year.png" 
                rendered="#{presenceAdminBean.editingHoliday == null}" styleClass="button" 
                alt="#{presenceBundle.copyNextYear}" title="#{presenceBundle.copyNextYear}" />
              <h:commandButton action="#{presenceAdminBean.storeHoliday}" image="/common/presence/images/accept.png" 
                rendered="#{presenceAdminBean.editingHoliday == holiday}" styleClass="button" 
                alt="#{objectBundle.accept}" title="#{objectBundle.accept}" />
              <h:commandButton action="#{presenceAdminBean.cancelHoliday}" image="/common/presence/images/cancel.png" 
                rendered="#{presenceAdminBean.editingHoliday == holiday}" styleClass="button" 
                alt="#{objectBundle.cancel}" immediate="true" title="#{objectBundle.cancel}" />
            </t:div>
          </t:column>
        </t:dataTable>
        <h:commandLink action="#{presenceAdminBean.newHoliday}" 
          rendered="#{presenceAdminBean.editingHoliday == null}" styleClass="button img_left">
          <t:outputText value="#{presenceBundle.addNew}" styleClass="new" />
        </h:commandLink>
      </t:panelTab>

      <!-- WorkReduction -->
      
      <t:panelTab label="#{presenceBundle.reductions}">
        <t:div styleClass="toolbar">
          <h:commandLink action="#{presenceAdminBean.previousWorkReductionYear}" styleClass="button img_left"
            title="#{presenceBundle.previousYearInfo}">
            <t:outputText value="#{presenceBundle.previous}" styleClass="left" />
          </h:commandLink>    
          <h:commandLink action="#{presenceAdminBean.currentWorkReductionYear}" value="#{presenceAdminBean.workReductionYear}" 
                         styleClass="button" title="#{presenceBundle.currentYearInfo}" />
          <h:commandLink action="#{presenceAdminBean.nextWorkReductionYear}" styleClass="button img_right"
            title="#{presenceBundle.nextYearInfo}">
            <t:outputText value="#{presenceBundle.next}" styleClass="right" />
          </h:commandLink>
        </t:div>
        <t:dataTable id="holidays" value="#{presenceAdminBean.workReductions}" var="workReduction"
          rowStyleClass="#{workReduction == presenceAdminBean.editingWorkReduction ? 'selected': null}" 
          styleClass="presence_table" bodyStyleClass="#{empty presenceAdminBean.workReductions ? 'empty' : null}">
          <t:column sortable="true" style="width:5%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.id}" />
            </f:facet>
            <h:outputText value="#{workReduction.reductionId}" />
          </t:column>
          <t:column sortable="true" style="width:15%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.startDate}" />
            </f:facet>
            <h:outputText value="#{workReduction.startDate}" rendered="#{presenceAdminBean.editingWorkReduction != workReduction}">
              <f:converter converterId="DateTimeConverter" />
              <f:attribute name="userFormat" value="dd/MM/yyyy" />
              <f:attribute name="internalFormat" value="yyyyMMdd" />
            </h:outputText>
            <sf:calendar value="#{workReduction.startDate}" rendered="#{presenceAdminBean.editingWorkReduction == workReduction}" 
              styleClass="input_date" />
          </t:column>
          <t:column sortable="true" style="width:15%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.endDate}" />
            </f:facet>
            <h:outputText value="#{workReduction.endDate}" rendered="#{presenceAdminBean.editingWorkReduction != workReduction}">
              <f:converter converterId="DateTimeConverter" />
              <f:attribute name="userFormat" value="dd/MM/yyyy" />
              <f:attribute name="internalFormat" value="yyyyMMdd" />
            </h:outputText>
            <sf:calendar value="#{workReduction.endDate}" rendered="#{presenceAdminBean.editingWorkReduction == workReduction}" 
              styleClass="input_date" />
          </t:column>
          <t:column sortable="true" style="width:45%">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.description}" />
            </f:facet>
            <h:outputText value="#{workReduction.description}" rendered="#{presenceAdminBean.editingWorkReduction != workReduction}" />
            <h:inputText value="#{workReduction.description}" rendered="#{presenceAdminBean.editingWorkReduction == workReduction}" 
              styleClass="input_text" />
          </t:column>
          <t:column sortable="true" style="width:10%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.factor} (%)" />
            </f:facet>
            <h:outputText value="#{workReduction.factor}" rendered="#{presenceAdminBean.editingWorkReduction != workReduction}" />
            <h:inputText value="#{workReduction.factor}" rendered="#{presenceAdminBean.editingWorkReduction == workReduction}" 
              styleClass="input_text" />
          </t:column>
          <t:column style="width:10%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.actions}" />
            </f:facet>
            <t:div styleClass="toolbar">
              <h:commandButton action="#{presenceAdminBean.editWorkReduction}" image="/common/presence/images/edit.png"
                rendered="#{presenceAdminBean.editingWorkReduction == null}" styleClass="button" 
                alt="#{objectBundle.edit}" title="#{objectBundle.edit}" />
              <h:commandButton action="#{presenceAdminBean.removeWorkReduction}" image="/common/presence/images/remove.png" 
                rendered="#{presenceAdminBean.editingWorkReduction == null}" styleClass="button" 
                onclick="return confirm('#{presenceBundle.confirmRemoveWorkReduction}')"
                alt="#{objectBundle.delete}" title="#{objectBundle.delete}" />
              <h:commandButton action="#{presenceAdminBean.storeWorkReduction}" image="/common/presence/images/accept.png" 
                rendered="#{presenceAdminBean.editingWorkReduction == workReduction}" styleClass="button" 
                alt="#{objectBundle.accept}" title="#{objectBundle.accept}" />
              <h:commandButton action="#{presenceAdminBean.cancelWorkReduction}" image="/common/presence/images/cancel.png" 
                rendered="#{presenceAdminBean.editingWorkReduction == workReduction}" styleClass="button" 
                alt="#{objectBundle.cancel}" immediate="true" title="#{objectBundle.cancel}" />
            </t:div>
          </t:column>
        </t:dataTable>
        <h:commandLink action="#{presenceAdminBean.newWorkReduction}" 
          rendered="#{presenceAdminBean.editingWorkReduction == null}" styleClass="button img_left">
          <t:outputText value="#{presenceBundle.addNew}" styleClass="new" />
        </h:commandLink>
      </t:panelTab>

      <t:panelTab label="#{presenceBundle.workers}">
        <t:div styleClass="filter">
          <h:panelGroup rendered="#{presenceAdminBean.workerFilter.validatorPersonId == null}">
            <h:outputLabel value="#{presenceBundle.worker}:" for="workerFullName" />
            <h:inputText id="workerFullName" value="#{presenceAdminBean.workerFilter.fullName}" 
              styleClass="input_text" />
            <h:outputLabel value="#{presenceBundle.team}:" for="workerTeam" />
            <h:inputText id="workerTeam" value="#{presenceAdminBean.workerFilter.team}" 
              styleClass="input_text" />
            <t:commandLink action="#{presenceAdminBean.findWorkers}" styleClass="button img_left" 
                           onclick="showOverlay();">
              <t:outputText value="#{objectBundle.search}" styleClass="search" />
            </t:commandLink>
          </h:panelGroup>
          <h:panelGroup rendered="#{presenceAdminBean.workerFilter.validatorPersonId != null}">
            <h:outputText value="#{presenceAdminBean.filterValidatorFullName} #{presenceBundle.andWorkers}: " />
            <h:commandButton action="#{presenceAdminBean.clearWorkers}" value="#{objectBundle.cancel}" styleClass="button" />
          </h:panelGroup>
        </t:div>
        <t:dataTable id="workers" value="#{presenceAdminBean.workers}" var="worker"
          rowStyleClass="#{worker == presenceAdminBean.editingWorker ? 'selected' : null}" 
          styleClass="presence_table" bodyStyleClass="#{empty presenceAdminBean.workers ? 'empty' : null}">
          <t:column sortable="true" style="width:8%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.id}" />
            </f:facet>
            <h:outputText value="#{worker.personId}" rendered="#{presenceAdminBean.editingWorker != worker or worker.personId != null}" />
            <h:inputText value="#{worker.personId}" rendered="#{presenceAdminBean.editingWorker == worker and worker.personId == null}" 
              styleClass="input_text" />
          </t:column>
          <t:column sortable="true" sortPropertyName="fullName" style="width:30%;">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.worker}" />
            </f:facet>
            <h:commandLink action="#{presenceAdminBean.findWorkerDescendants}" 
               value="#{worker.fullName}" rendered="#{presenceAdminBean.editingWorker != worker}" />
            <h:inputText value="#{worker.fullName}" rendered="#{presenceAdminBean.editingWorker == worker}" 
              styleClass="input_text" />
          </t:column>
          <t:column sortable="true" sortPropertyName="team" style="width:10%;" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.team}" />
            </f:facet>
            <h:outputText value="#{worker.team}" rendered="#{presenceAdminBean.editingWorker != worker}" />
            <h:inputText value="#{presenceAdminBean.editingWorker.team}" rendered="#{presenceAdminBean.editingWorker == worker}" 
              styleClass="input_text" />
          </t:column>
          <t:column sortable="true" style="width:30%">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.validator}" />
            </f:facet>
            <h:commandLink action="#{presenceAdminBean.findValidatorDescendants}"  
              value="#{presenceAdminBean.validatorFullName}" rendered="#{presenceAdminBean.editingWorker != worker}" />
            <t:selectOneMenu value="#{worker.validatorPersonId}" rendered="#{presenceAdminBean.editingWorker == worker}" 
              styleClass="select_box">
              <f:selectItem itemLabel=" " itemValue="" />
              <f:selectItems value="#{presenceAdminBean.workerSelectItems}" />
            </t:selectOneMenu>
          </t:column>
          <t:column sortable="true" style="width:9%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.compensationTime}" />
            </f:facet>
            <h:outputText value="#{worker.compensationTime}" rendered="#{presenceAdminBean.editingWorker != worker}">
              <f:converter converterId="IntervalConverter" />
            </h:outputText>
            <h:inputText value="#{worker.compensationTime}" rendered="#{presenceAdminBean.editingWorker == worker}" 
              styleClass="input_text">
              <f:converter converterId="IntervalConverter" />
            </h:inputText>
          </t:column>
          <t:column style="width:18%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.actions}" />
            </f:facet>
            <t:div styleClass="toolbar">
              <h:commandButton action="#{presenceAdminBean.showWorkerWeek}" image="/common/presence/images/show.png"
                rendered="#{presenceAdminBean.editingWorker == null}" styleClass="button" 
                alt="#{objectBundle.show}" title="#{objectBundle.show}" />
              <h:commandButton action="#{presenceAdminBean.editWorker}" image="/common/presence/images/edit.png"
                rendered="#{presenceAdminBean.editingWorker == null}" styleClass="button" 
                alt="#{objectBundle.edit}" title="#{objectBundle.edit}" />
              <h:commandButton action="#{presenceAdminBean.removeWorker}" image="/common/presence/images/remove.png" 
                rendered="#{presenceAdminBean.editingWorker == null}" styleClass="button" 
                onclick="return confirm('#{presenceBundle.confirmRemoveWorker}')"
                alt="#{objectBundle.delete}" title="#{objectBundle.delete}" />
              <h:commandButton action="#{presenceAdminBean.storeWorker}" image="/common/presence/images/accept.png" 
                rendered="#{presenceAdminBean.editingWorker == worker}" styleClass="button" 
                alt="#{objectBundle.accept}" title="#{objectBundle.accept}" />
              <h:commandButton action="#{presenceAdminBean.cancelWorker}" image="/common/presence/images/cancel.png" 
                rendered="#{presenceAdminBean.editingWorker == worker}" styleClass="button" 
                alt="#{objectBundle.cancel}" immediate="true" title="#{objectBundle.cancel}" />
            </t:div>
          </t:column>
        </t:dataTable>
        <t:div styleClass="toolbar" rendered="#{presenceAdminBean.editingWorker == null}">
          <h:commandLink action="#{presenceAdminBean.newWorker}" 
             styleClass="button img_left">
            <t:outputText value="#{presenceBundle.addNew}" styleClass="new" />
          </h:commandLink>
          <h:panelGroup rendered="#{presenceAdminBean.workerCount gt 100}">
            <t:commandLink action="#{presenceAdminBean.previousWorkerPage}" onclick="showOverlay();" styleClass="button img_left">
              <t:outputText value="#{presenceBundle.previous}" styleClass="left" />
            </t:commandLink>
            <t:outputText value="#{presenceAdminBean.workerFirst}..#{presenceAdminBean.workerLast} / #{presenceAdminBean.workerCount}" styleClass="button" />
            <t:commandLink action="#{presenceAdminBean.nextWorkerPage}" onclick="showOverlay();" styleClass="button img_right">
              <t:outputText value="#{presenceBundle.next}" styleClass="right" />
            </t:commandLink>  
          </h:panelGroup>
        </t:div>
        <t:div styleClass="find_persons"
          rendered="#{presenceAdminBean.editingWorker != null and presenceAdminBean.editingWorker.personId == null}">
          <h:panelGroup>
            <t:outputLabel value="#{presenceBundle.personName}:" for="new_worker_fullname" />
            <t:inputText id="new_worker_fullname" value="#{presenceAdminBean.personFilter.fullName}" 
              styleClass="input_text" />
            <t:div styleClass="toolbar">
              <t:commandLink action="#{presenceAdminBean.findPersons}" styleClass="button img_left">
                <t:outputText value="#{objectBundle.search}" styleClass="search" />
              </t:commandLink>
              <t:commandLink action="#{presenceAdminBean.cancelFindPersons}" 
                immediate="true" styleClass="button img_left">
                <t:outputText value="#{objectBundle.cancel}" styleClass="cancel" />
              </t:commandLink>
            </t:div>
          </h:panelGroup>
          <t:dataList value="#{presenceAdminBean.personList}" var="person" layout="unorderedList" styleClass="person_list">
            <h:commandLink action="#{presenceAdminBean.selectPerson}" 
              value="#{person.personId}: #{person.fullName} #{person.nif}" />
          </t:dataList>
        </t:div>
      </t:panelTab>

      <t:panelTab label="#{presenceBundle.parameters}">
        <t:dataTable id="parameters" value="#{presenceAdminBean.parameters}" var="parameter"
          rowStyleClass="#{parameter == presenceAdminBean.editingParameter ? 'selected': null}" 
          styleClass="presence_table" bodyStyleClass="#{empty presenceAdminBean.parameters ? 'empty' : null}">
          <t:column sortable="true" style="width:30%">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.id}" />
            </f:facet>
            <h:outputText value="#{parameter.parameterId}" styleClass="code"   
               rendered="#{presenceAdminBean.editingParameter != parameter}"/>
            <h:inputText value="#{parameter.parameterId}"
              rendered="#{presenceAdminBean.editingParameter == parameter}" 
              styleClass="input_text code" />
          </t:column>
          <t:column sortable="true" style="width:60%">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.value}" />
            </f:facet>
            <h:outputText value="#{parameter.value}" styleClass="code"
              rendered="#{presenceAdminBean.editingParameter != parameter}" />
            <h:inputText value="#{parameter.value}" rendered="#{presenceAdminBean.editingParameter == parameter}" 
              styleClass="input_text code" />
          </t:column>
          <t:column style="width:10%" styleClass="center">
            <f:facet name="header">
              <h:outputText value="#{presenceBundle.actions}" />
            </f:facet>
            <t:div styleClass="toolbar">
              <h:commandButton action="#{presenceAdminBean.editParameter}" image="/common/presence/images/edit.png"
                rendered="#{presenceAdminBean.editingParameter == null}" styleClass="button" 
                alt="#{objectBundle.edit}" title="#{objectBundle.edit}" />
              <h:commandButton action="#{presenceAdminBean.removeParameter}" image="/common/presence/images/remove.png" 
                rendered="#{presenceAdminBean.editingParameter == null}" styleClass="button" 
                onclick="return confirm('#{presenceBundle.confirmRemoveParameter}')"
                alt="#{objectBundle.delete}" title="#{objectBundle.delete}" />
              <h:commandButton action="#{presenceAdminBean.storeParameter}" image="/common/presence/images/accept.png" 
                rendered="#{presenceAdminBean.editingParameter == parameter}" styleClass="button" 
                alt="#{objectBundle.accept}" title="#{objectBundle.accept}" />
              <h:commandButton action="#{presenceAdminBean.cancelParameter}" image="/common/presence/images/cancel.png" 
                rendered="#{presenceAdminBean.editingParameter == parameter}" styleClass="button" 
                alt="#{objectBundle.cancel}" immediate="true" title="#{objectBundle.cancel}" />
            </t:div>
          </t:column>
        </t:dataTable>
        <h:commandLink action="#{presenceAdminBean.newParameter}" 
          rendered="#{presenceAdminBean.editingParameter == null}" styleClass="button img_left">
          <t:outputText value="#{presenceBundle.addNew}" styleClass="new" />
        </h:commandLink>
      </t:panelTab>
    </t:panelTabbedPane>
  </t:div>

  <h:outputText value="#{presenceAdminBean.scripts}" escape="false" />
  <f:verbatim>
    <script type="text/javascript">      
      function showOptions(valueElem)
      {
        var baseElem = valueElem.parentNode;
        var popupElems = baseElem.getElementsByClassName("popup");
        if (popupElems)
        {
          var popupElem = popupElems[0];
          popupElem.style.display = "inline-block";
          var selectElems = popupElem.getElementsByTagName("select");
          if (selectElems)
          {
            var selectElem = selectElems[0];
            selectElem.focus();
          }
        }
      }

      function selectOption(selectElem)
      {
        var baseElem = selectElem.parentNode.parentNode;
        var valueElems = baseElem.getElementsByClassName("value");
        if (valueElems)
        {
          var valueElem = valueElems[0];
          var value = selectElem.options[selectElem.selectedIndex].label;
          var index = value.indexOf(" ");
          if (index !== -1)
          {
            value = value.substring(0, index);
          }
          valueElem.innerHTML = value;
          valueElem.title = "";
        }
      }

      function hideOptions(selectElem)
      {
        var popupElem = selectElem.parentNode;
        popupElem.style.display = "none";
      }

      function captureKeyPress(selectElem, event)
      {
        if (event.keyCode == 13) 
        {
          if (event.preventDefault) event.preventDefault();
          else if (event.stopPropagation) event.stopPropagation();
          hideOptions(selectElem);
        }
      }
    </script>
  </f:verbatim>
      
</jsp:root>

