<?xml version='1.0' encoding='windows-1252'?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
          xmlns:f="http://java.sun.com/jsf/core"
          xmlns:h="http://java.sun.com/jsf/html"
          xmlns:t="http://myfaces.apache.org/tomahawk"
          xmlns:sf="http://www.santfeliu.org/jsf">

  <t:div styleClass="reportPanel">

    <t:div styleClass="formPanel">

      <t:div styleClass="reportTitle"
        rendered="#{userSessionBean.selectedMenuItem.properties.reportTitle != null}">
        <sf:outputText value="#{userSessionBean.selectedMenuItem.properties.reportTitle}"
         translator="#{userSessionBean.translator}"
         translationGroup="#{userSessionBean.translationGroup}" />
      </t:div>

      <t:div styleClass="reportSelector"
        rendered="#{dynamicReportBean.reportSelectorRendered}">
        <sf:outputText styleClass="reportLabel"
         value="#{userSessionBean.selectedMenuItem.properties.reportLabel}"
         rendered="#{userSessionBean.selectedMenuItem.properties.reportLabel != null}"
         translator="#{userSessionBean.translator}"
         translationGroup="#{userSessionBean.translationGroup}" />
        <t:selectOneMenu onchange="document.forms[0].submit(); return false;"
          value="#{dynamicReportBean.reportId}">
          <f:selectItems value="#{dynamicReportBean.reportSelectItems}" />
        </t:selectOneMenu>
      </t:div>

      <t:div rendered="#{dynamicReportBean.formSelector != null}">
        <sf:dynamicForm form="#{dynamicReportBean.form}"
         rendererTypes="HtmlFormRenderer,GenericFormRenderer"
         value="#{dynamicReportBean.parameters}" />
        <sf:commandButton id="default_button" value="#{dynamicReportBean.executeButtonLabel}"
         translator="#{userSessionBean.translator}"
         translationGroup="#{userSessionBean.translationGroup}" />
      </t:div>

      <t:messages />
    </t:div>

    <t:div id="previewPanel" forceId="true" styleClass="previewPanel">
      <sf:browser url="#{dynamicReportBean.pdfUrl}"
        port="#{applicationBean.defaultPort}"
        iframe="true" width="99%" height="99%"
        rendered="#{dynamicReportBean.pdfRendered}" />
    </t:div>
    
  </t:div>

  <f:verbatim>
    <script type="text/javascript">
      var previewPanel = document.getElementById("previewPanel");
      if (previewPanel)
      {
        var iframeElem = previewPanel.firstElementChild;
        if (iframeElem)
        {
          updateBackground = function(event)
          {
            iframeElem.style.backgroundImage = "none";
          };
          if (iframeElem.addEventListener)
          {
            iframeElem.addEventListener('load', updateBackground, false);
          }
          else
          {
            iframeElem.attachEvent('onload', updateBackground);
          }
        }
      }
    </script>
  </f:verbatim>

</jsp:root>
