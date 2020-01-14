<?xml version='1.0' encoding='windows-1252'?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
          xmlns:f="http://java.sun.com/jsf/core"
          xmlns:h="http://java.sun.com/jsf/html"
          xmlns:t="http://myfaces.apache.org/tomahawk"
          xmlns:sf="http://www.santfeliu.org/jsf">

  <f:loadBundle basename="org.santfeliu.web.obj.resources.ObjectBundle" 
    var="objectBundle" />  

  <h:panelGrid columns="1" width="100%" cellspacing="0" cellpadding="0"
    styleClass="sendMailPage" headerClass="header" footerClass="footer">

    <h:panelGrid columns="1" width="100%" style="height:100px">
      <sf:customForm url="#{sendMailBean.url}"
       values="#{sendMailBean.values}" 
       newValues="#{sendMailBean.values}" />

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
            styleClass="buttonLink"
            action="#{sendMailBean.sendMail}" rendered="#{!sendMailBean.mailSent}">
            <h:outputText value="#{objectBundle.next_page}" />
          </sf:longCommandLink>
        </h:panelGroup>
      </h:panelGrid>
    </f:facet>
  
    <t:saveState value="#{sendMailBean}" />
  </h:panelGrid>

</jsp:root>
