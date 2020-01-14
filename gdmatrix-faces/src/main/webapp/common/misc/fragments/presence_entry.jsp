<?xml version='1.0' encoding='windows-1252'?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
          xmlns:f="http://java.sun.com/jsf/core"
          xmlns:h="http://java.sun.com/jsf/html"
          xmlns:t="http://myfaces.apache.org/tomahawk"
          xmlns:sf="http://www.santfeliu.org/jsf">

  <f:loadBundle basename="org.santfeliu.web.obj.resources.ObjectBundle" 
    var="objectBundle" />  

  <f:loadBundle basename="org.santfeliu.misc.presence.web.resources.PresenceBundle"
    var="presenceBundle" />  

  <h:messages rendered="#{userSessionBean.facesMessagesQueued}" 
    showSummary="true"
    globalOnly="true"
    layout="table"
    warnClass="warnMessage"
    errorClass="errorMessage"
    fatalClass="fatalMessage" />

  <t:div styleClass="presenceEntryPanel">
    <t:div styleClass="header">
      <h:outputText value="#{presenceBundle.presenceInfo}"
        styleClass="entryInfo" />
      <h:outputText value="#{presenceBean.workerProfile.displayName}"
        styleClass="displayName" />
    </t:div>

    <t:panelGrid columns="2" styleClass="properties" columnClasses="col1,col2">

      <h:outputLabel value="#{presenceBundle.date}:" />
      <h:outputText value="#{presenceBean.editingEntry.date}">
        <f:convertDateTime pattern="EEEE, dd MMMM yyyy" />
      </h:outputText>

      <h:outputLabel value="#{presenceBundle.time}:" />
      <h:outputText value="#{presenceBean.editingEntry.date}">
        <f:convertDateTime pattern="HH:mm:ss" />
      </h:outputText>

      <h:outputLabel value="#{presenceBundle.type}:" />
      <t:selectOneMenu value="#{presenceBean.editingEntry.type}"
        styleClass="type">
        <f:selectItems value="#{presenceBean.editingEntryTypes}" />
      </t:selectOneMenu>

      <h:outputLabel value="#{presenceBundle.reason}:" />
      <h:inputTextarea value="#{presenceBean.editingEntry.reason}"
         onkeydown="checkMaxLength(this, 100)"
         styleClass="reason" rows="3"  />

      <h:outputLabel value="#{presenceBundle.creationDate}:"
        rendered="#{presenceBean.editingEntry.timeAltered}" />
      <h:outputText value="#{presenceBean.editingEntry.creationDate}"
        rendered="#{presenceBean.editingEntry.timeAltered}"
        styleClass="#{presenceBean.editingEntry.manipulated ? 'warning' : ''}">
        <f:convertDateTime pattern="EEEE, dd MMMM yyyy, HH:mm:ss" />
      </h:outputText>

      <h:outputLabel value="#{presenceBundle.ipAddress}:" />
      <h:panelGroup styleClass="#{presenceBean.editingEntryInternal ? '' : 'warning'}">
        <h:outputText value="#{presenceBean.editingEntry.ipAddress}" />
        <h:outputText value=" (#{presenceBean.editingEntryInternal ? presenceBundle.internal : presenceBundle.external})" />
      </h:panelGroup>

      <h:outputLabel value="#{presenceBundle.bonusTime}:"
        rendered="#{presenceBean.editingEntry.bonusTime &gt; 0}"/>
      <h:outputText value="#{presenceBean.editingEntryBonusTimeFormatted}"
        rendered="#{presenceBean.editingEntry.bonusTime &gt; 0}" />

    </t:panelGrid>

    <t:div styleClass="buttonsPanel">
      <t:commandButton action="#{presenceBean.back}"
        id="backEntry" forceId="true" onclick="showOverlay()"
        onfocus="javascript:focused(this);" onblur="javascript:unfocused(this);"
        value="#{presenceBundle.back}" styleClass="button" />
      <t:commandButton action="#{presenceBean.modifyEntry}"
        id="saveEntry" forceId="true" onclick="showOverlay()"
        onfocus="javascript:focused(this);" onblur="javascript:unfocused(this);"
        value="#{presenceBundle.modifyEntry}" styleClass="button" />
      <t:commandButton action="#{presenceBean.removeEntry}"
        id="removeEntry" forceId="true" onclick="showOverlay()"
        onfocus="javascript:focused(this);" onblur="javascript:unfocused(this);"
        value="#{presenceBundle.removeEntry}" styleClass="button" />
    </t:div>
  </t:div>

  <t:inputHidden immediate="true" value="#{presenceBean.sessionTrack}" />
  
  <f:verbatim>
    <script type="text/javascript">
      document.getElementById("backEntry").focus();

      function focused(elem)
      {
        elem.style.border = "1px solid black";
      }

      function unfocused(elem)
      {
        elem.style.border = "none";
      }
    </script>
  </f:verbatim>
</jsp:root>
