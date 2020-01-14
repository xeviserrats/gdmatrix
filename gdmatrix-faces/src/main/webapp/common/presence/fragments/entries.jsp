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
  
  <t:div styleClass="entries">
    <t:panelGrid columns="7" columnClasses="c1,c2,c3,c4,c5,c6,c7" styleClass="entry_filter">
      <t:outputLabel value="#{presenceBundle.worker}" for="entry_filter_worker" />
      <t:outputLabel value="#{presenceBundle.type}" for="entry_filter_type" />
      <t:outputLabel value="#{presenceBundle.startDate}" for="entry_filter_start_date" />
      <t:outputLabel value="#{presenceBundle.endDate}" for="entry_filter_end_date" />
      <t:outputLabel value="#{presenceBundle.reason}" for="entry_filter_reason" />
      <t:outputLabel value="#{presenceBundle.manipulated}" for="entry_filter_manipulated" />
      <t:outputText value="" />
      
      <t:inputText id="entry_filter_worker" value="#{entriesBean.workerName}" />
      <t:selectOneMenu id="entry_filter_type" value="#{entriesBean.filter.entryTypeId}">
        <f:selectItem itemLabel=" " itemValue="" />
        <f:selectItems value="#{entriesBean.presenceEntryTypeSelectItems}" />
      </t:selectOneMenu>
      <sf:calendar id="entry_filter_start_date" value="#{entriesBean.startDate}" styleClass="date" />
      <sf:calendar id="entry_filter_end_date" value="#{entriesBean.endDate}" styleClass="date" />
      <t:inputText id="entry_filter_reason" value="#{entriesBean.filter.reason}" />
      <t:selectBooleanCheckbox id="entry_filter_manipulated" value="#{entriesBean.manipulated}" />
      
      <t:commandLink action="#{entriesBean.search}" styleClass="button img_left" onclick="showOverlay()">
        <t:outputText value="#{objectBundle.search}" styleClass="search" />
      </t:commandLink>      
    </t:panelGrid>
      
    <t:dataTable
      value="#{entriesBean.entries}" var="entry" preserveDataModel="false"
      sortColumn="#{entriesBean.sortColumn}" preserveSort="true"
      bodyStyleClass="#{empty entriesBean.entries ? 'empty' : null}"
      styleClass="presence_table">
      <t:column sortable="true" style="width:18%">
        <f:facet name="header">
          <h:outputText value="#{presenceBundle.worker}" />
        </f:facet>
        <h:outputText value="#{entry.workerName}" />
      </t:column>
      <t:column sortable="true" style="width:18%" styleClass="center">
        <f:facet name="header">
          <h:outputText value="#{presenceBundle.type}" />
        </f:facet>
        <h:outputText value="#{entry.entryTypeLabel}" 
          style="display:block;height:100%;background-color:##{entry.color == null ? 'FFFFFF' : entry.color}"/>     
      </t:column>
      <t:column sortable="true" styleClass="center" style="width:13%">
        <f:facet name="header">
          <h:outputText value="#{presenceBundle.startDate}" />
        </f:facet>
        <h:outputText value="#{entry.startDateTime}" style="#{entry.manipulated ? 'color:red' : null}">
          <f:converter converterId="DateTimeConverter" />
          <f:attribute name="userFormat" value="dd/MM/yyyy H:mm" />
          <f:attribute name="internalFormat" value="yyyyMMddHHmmss" />
        </h:outputText>
      </t:column>
      <t:column sortable="true" styleClass="center" style="width:13%">
        <f:facet name="header">
          <h:outputText value="#{presenceBundle.endDate}" />
        </f:facet>
        <h:outputText value="#{entry.endDateTime}">
          <f:converter converterId="DateTimeConverter" />
          <f:attribute name="userFormat" value="dd/MM/yyyy H:mm" />
          <f:attribute name="internalFormat" value="yyyyMMddHHmmss" />
        </h:outputText>
      </t:column>
      <t:column sortable="true" style="width:20%">
        <f:facet name="header">
          <h:outputText value="#{presenceBundle.reason}" />
        </f:facet>
        <h:outputText value="#{entry.reason}" />
      </t:column>
      <t:column sortable="true" styleClass="center" style="width:11%">
        <f:facet name="header">
          <h:outputText value="#{presenceBundle.duration}" />
        </f:facet>
        <h:outputText value="#{entry.duration}">
           <f:converter converterId="IntervalConverter" />          
        </h:outputText>
      </t:column>
      <t:column sortable="true" styleClass="center" style="width:7%">
        <t:div styleClass="toolbar">
          <h:commandButton action="#{entriesBean.showPresenceEntry}" image="/common/presence/images/show.png" 
            styleClass="button" title="#{objectBundle.show}" alt="#{objectBundle.show}" />
        </t:div>
      </t:column>    
    </t:dataTable>
    <t:div styleClass="footer">
      <t:outputText value="#{presenceBundle.entryCount}: #{entriesBean.presenceEntryCount}" />
      <h:panelGroup rendered="#{not empty entriesBean.entries}">
        <t:outputText value="#{presenceBundle.totalTime}: " styleClass="total" />
        <t:outputText value="#{entriesBean.totalTime}">
          <f:converter converterId="IntervalConverter" />
        </t:outputText>
        <t:outputText value="#{presenceBundle.totalWorkedTime}: " styleClass="total" />
        <t:outputText value="#{entriesBean.totalWorkedTime}">
          <f:converter converterId="IntervalConverter" />
        </t:outputText>
      </h:panelGroup>
    </t:div>
  </t:div>
  
</jsp:root>

