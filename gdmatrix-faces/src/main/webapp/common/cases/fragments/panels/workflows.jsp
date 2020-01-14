<?xml version='1.0' encoding='windows-1252'?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
          xmlns:f="http://java.sun.com/jsf/core"
          xmlns:h="http://java.sun.com/jsf/html"
          xmlns:t="http://myfaces.apache.org/tomahawk"
          xmlns:sf="http://www.santfeliu.org/jsf"
          xmlns:c="http://java.sun.com/jsp/jstl/core" >

    <f:loadBundle basename="org.santfeliu.web.obj.resources.ObjectBundle" var="objectBundle"/>  
    <f:loadBundle basename="org.santfeliu.workflow.web.resources.WorkflowBundle" var="workflowBundle"/>

    <t:div styleClass="workflowsPanel">

      <t:div styleClass="onlyMobile" rendered="#{userSessionBean.menuModel.browserType == 'mobile' and (not panel.mobileEnabled)}">
        <h:outputText value="#{webBundle.onlyDesktopBrowsers}" />
      </t:div>
      
      <t:dataTable value="#{panel.caseDocuments}" var="row" 
                   summary="#{panel.tableSummary}"
                   footerClass="footer" headerClass="header"
                   bodyStyle="#{empty panel.caseDocuments ? 'display:none' : ''}"
                   rowStyleClass="#{panel.rowStyleClass}"
                   styleClass="resultList" style="width:100%"
                   rowClasses="row1,row2" >

       <t:columns value="#{panel.resultsManager.columnNames}" var="column"
                   style="#{panel.resultsManager.columnStyle}"
                   styleClass="#{panel.resultsManager.columnStyleClass}">
        <f:facet name="header">
          <t:commandSortHeader columnName="#{panel.resultsManager.localizedColumnName}" arrow="true" immediate="false"
                               action="#{panel.sort}" >
            <h:outputText value="#{panel.resultsManager.localizedColumnName}" />
          </t:commandSortHeader>
        </f:facet>


        <h:panelGroup rendered="#{panel.resultsManager.customColumn and
                                  panel.resultsManager.columnName == 'title'}">
            <sf:outputText value="#{panel.workflowTitle}" 
                           translator="#{userSessionBean.translator}"
                           translationGroup="#{userSessionBean.translationGroup}" />
        </h:panelGroup>

        <h:panelGroup rendered="#{panel.resultsManager.columnName != 'jsp:title'
          and !panel.resultsManager.customColumn}">
          <!-- render as link -->
          <h:outputLink target="_blank" value="#{panel.resultsManager.columnValue}"
                        rendered="#{panel.resultsManager.linkColumn}">
            <h:outputText value="#{panel.resultsManager.columnValue}"/>
          </h:outputLink>

          <!-- render as image -->
          <h:graphicImage value="#{panel.resultsManager.columnValue}"
            rendered="#{panel.resultsManager.imageColumn and panel.resultsManager.columnValue != null}"/>

          <!-- render as text -->
          <h:outputText value="#{panel.resultsManager.columnValue}"
                        rendered="#{not panel.resultsManager.imageColumn and not panel.resultsManager.linkColumn}"/>
        </h:panelGroup>

       </t:columns>
         
       <t:column>
        <h:graphicImage url="/templates/#{userSessionBean.template}/images/picto/certificate.png"
          styleClass="icon" style="vertical-align:middle"
          title="#{workflowBundle.authenticationRequired}"
          alt="#{workflowBundle.authenticationRequired}"
          rendered="#{panel.requestedAuthenticationLevel gt 0}" />
        <h:graphicImage url="/templates/#{userSessionBean.template}/images/picto/signature.png"
          styleClass="icon" style="vertical-align:middle"
          title="#{workflowBundle.signatureRequired}"
          alt="#{workflowBundle.signatureRequired}"
          rendered="#{panel.requestedSignatureLevel gt 0}" />
       </t:column>

      <t:column style="text-align:right">

        <h:panelGroup rendered="#{panel.renderStartInstance}">

          <!-- direct process (logged or not) -->
          <h:panelGroup rendered="#{panel.externalURL == null and 
                                   not (panel.userAuthenticationLevel lt panel.requestedAuthenticationLevel or
                                   panel.userSignatureLevel lt panel.requestedSignatureLevel) and
                                  (userSessionBean.menuModel.browserType == 'desktop' or 
                                  (userSessionBean.menuModel.browserType == 'mobile' and panel.mobileEnabled))}">
            <sf:secureCommandLink
              action="#{panel.startInstance}"
              scheme="https" port="#{applicationBean.serverSecurePort}"
              styleClass="buttonLink" style="vertical-align:middle"
              title="#{workflowBundle.catalogueProcess} #{panel.workflowTitle}"
              ariaLabel="#{workflowBundle.catalogueProcess} #{panel.workflowTitle}"
              translator="#{userSessionBean.translator}"
              translationGroup="#{userSessionBean.translationGroup}" >
              <h:outputText value="#{workflowBundle.catalogueProcess}" />
            </sf:secureCommandLink>
            <sf:secureCommandLink
              rendered="#{panel.simulateEnabled and panel.editorUser}"
              action="#{panel.startSimulation}"
              scheme="https" port="#{applicationBean.serverSecurePort}"
              styleClass="buttonLink" style="vertical-align:middle"
              title="#{workflowBundle.catalogueSimulate} #{panel.workflowTitle}"
              ariaLabel="#{workflowBundle.catalogueSimulate} #{panel.workflowTitle}"
              translator="#{userSessionBean.translator}"
              translationGroup="#{userSessionBean.translationGroup}">
              <h:outputText value="#{workflowBundle.catalogueSimulate}" />
            </sf:secureCommandLink>
          </h:panelGroup>

          <!-- process login first -->
          <sf:outputLink value="#{panel.processURL}"
            rendered="#{panel.externalURL == null and 
                       (panel.userAuthenticationLevel lt panel.requestedAuthenticationLevel or
                        panel.userSignatureLevel lt panel.requestedSignatureLevel) and
                       (userSessionBean.menuModel.browserType == 'desktop' or 
                       (userSessionBean.menuModel.browserType == 'mobile' and panel.mobileEnabled))}"
            styleClass="buttonLink" style="vertical-align:middle"
            title="#{workflowBundle.catalogueProcess} #{panel.workflowTitle}"
            ariaLabel="#{workflowBundle.catalogueProcess} #{panel.workflowTitle}"
            translator="#{userSessionBean.translator}"
            translationGroup="#{userSessionBean.translationGroup}">
           <h:outputText value="#{workflowBundle.catalogueProcess}" />
          </sf:outputLink>
        
          <!-- process external procedures -->
          <sf:outputLink value="#{panel.externalURL}"
            rendered="#{panel.externalURL != null}"
            target="_blank" styleClass="buttonLink"
            title="#{workflowBundle.catalogueExternal} #{panel.workflowTitle}"
            ariaLabel="#{workflowBundle.catalogueExternal} #{panel.workflowTitle}"
            translator="#{userSessionBean.translator}"
            translationGroup="#{userSessionBean.translationGroup}">
            <h:outputText value="#{workflowBundle.catalogueExternal}" />
          </sf:outputLink>
        </h:panelGroup>
      </t:column>

      <t:column>
        <t:commandButton value="#{objectBundle.show}"
                         image="#{userSessionBean.icons.show}"
                         alt="#{objectBundle.show}" title="#{objectBundle.show}"
                         styleClass="button" immediate="true"
                         action="#{panel.showDocument}"
                         rendered="#{panel.renderShowDocument and userSessionBean.menuModel.browserType == 'desktop'}"/>
      </t:column>
      </t:dataTable>      
    </t:div>

</jsp:root>