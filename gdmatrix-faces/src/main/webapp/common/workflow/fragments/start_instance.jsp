<?xml version='1.0' encoding='windows-1252'?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
          xmlns:f="http://java.sun.com/jsf/core"
          xmlns:h="http://java.sun.com/jsf/html"
          xmlns:t="http://myfaces.apache.org/tomahawk"
          xmlns:sf="http://www.santfeliu.org/jsf">

<f:loadBundle basename="org.santfeliu.workflow.web.resources.WorkflowBundle" 
  var="workflowBundle" />

  <t:saveState value="#{startInstanceBean}" />

  <h:panelGrid columns="1" width="100%" cellspacing="0" cellpadding="0"
    styleClass="workflowInstance" headerClass="header" footerClass="footer">

    <h:panelGrid columns="1" width="100%" style="height:100px">
      <sf:customForm url="#{startInstanceBean.url}"
       values="#{startInstanceBean.values}"        
       newValues="#{startInstanceBean.values}"
       translator="#{applicationBean.translator}" />

      <h:messages rendered="#{userSessionBean.facesMessagesQueued}" 
        showSummary="true"
        globalOnly="true"
        layout="table"
        warnClass="warnMessage"
        errorClass="errorMessage" 
        fatalClass="fatalMessage" />
    </h:panelGrid>

    <f:facet name="footer">
      <h:panelGrid columns="2" width="100%" columnClasses="col1, col2">
        <h:panelGroup/>
        <h:panelGroup>
          <sf:longCommandLink id="forward"
            styleClass="workflowCommandLink"
            action="#{startInstanceBean.startInstance}">
            <h:outputText value="#{workflowBundle.next}" />
            <h:graphicImage value="/common/workflow/images/forward.gif" alt="" 
              style="vertical-align:middle" />
          </sf:longCommandLink>
        </h:panelGroup>
      </h:panelGrid>
    </f:facet>
  </h:panelGrid>

</jsp:root>

