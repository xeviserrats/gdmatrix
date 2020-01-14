<?xml version='1.0' encoding='windows-1252'?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
          xmlns:f="http://java.sun.com/jsf/core"
          xmlns:h="http://java.sun.com/jsf/html"
          xmlns:t="http://myfaces.apache.org/tomahawk"
          xmlns:sf="http://www.santfeliu.org/jsf">
  <f:loadBundle basename="org.santfeliu.news.web.resources.NewsBundle"
                var="newsBundle"/>

  <t:div rendered="#{!newBean.new}">
    <h:outputText value="#{objectBundle.object_id}:" styleClass="textBox"
      style="width:16%" />
    <h:outputText value="#{newMainBean.newObject.newId}" styleClass="outputBox"
      style="width:10%" />
  </t:div>
  <t:div>
    <h:outputText id="headlineLabel" value="#{newsBundle.new_main_headline}"
                  styleClass="textBox" style="width:16%"/>
    <h:inputText id="headlineInput" value="#{newMainBean.newObject.headline}"
                 size="65"
                 onkeypress="checkMaxLength(this, #{newMainBean.propertySize.headline})"
                 styleClass="inputBox"/>
  </t:div>
  <t:div>
    <h:outputText id="startDayLabel" value="#{newsBundle.new_main_startDay}:"
                  styleClass="textBox" style="width:16%"/>
    <sf:calendar externalFormat="dd/MM/yyyy|HH:mm"
                 internalFormat="yyyyMMddHHmmss"
                 value="#{newMainBean.startDateTime}"
                 styleClass="calendarBox" style="width:15%"
                 buttonStyleClass="calendarButton" />
  </t:div>
  <t:div>
    <h:outputText id="endDayLabel" value="#{newsBundle.new_main_endDay}:"
                  styleClass="textBox" style="width:16%"/>
    <sf:calendar externalFormat="dd/MM/yyyy|HH:mm"
                 internalFormat="yyyyMMddHHmmss"
                 value="#{newMainBean.endDateTime}"
                 styleClass="calendarBox" style="width:15%"
                 buttonStyleClass="calendarButton" />
  </t:div>
  <t:div>
    <h:outputText id="sourceLabel" value="#{newsBundle.new_main_source}:"
                  styleClass="textBox" style="width:16%" />
    <t:selectOneMenu styleClass="selectBox" id="sourceSelect"
                     value="#{newMainBean.newObject.source}">
      <f:selectItems value="#{newMainBean.sourceItems}" id="sourceItems" /> 
    </t:selectOneMenu>
  </t:div>
  <t:div>
    <h:outputText id="keywordsLabel" value="#{newsBundle.new_main_keywords}:"
                  styleClass="textBox" style="width:16%"/>
    <h:inputText id="keywordsInput" value="#{newMainBean.newObject.keywords}"
                 size="70"
                 onkeypress="checkMaxLength(this, #{newMainBean.propertySize.keywords})"
                 styleClass="inputBox"/>
  </t:div>
  <t:div>
    <h:outputText id="userLabel" value="#{newsBundle.new_main_user}:"
                  styleClass="textBox" style="width:16%" />
    <h:outputText id="userText" value="#{newMainBean.newObject.userId}"
                  styleClass="textBox"/>
  </t:div>
  <t:div>
    <h:outputText id="readCountLabel" value="#{newsBundle.new_main_readings}:"
                  styleClass="textBox" style="width:16%" />
    <h:outputText id="readCountText" value="#{newMainBean.newObject.totalReadingCount}"
                  styleClass="textBox"/>
  </t:div>
  <t:div>
    <h:selectBooleanCheckbox id="draftCB"
                             value="#{newMainBean.newObject.draft}"/>
    <h:outputText id="draftCBText" value="#{newsBundle.new_main_draft}"
                  styleClass="textBox"/>
  </t:div>
  <t:div>    
    <h:panelGroup>
      <h:commandButton id="switchToSummaryButton"
        action="#{newMainBean.switchToSummary}"
        value="#{newMainBean.editSummaryButtonTitle}"        
        styleClass="storeButton"
        style="#{newMainBean.editingSummary ? 'font-weight:bold;text-decoration:underline' : ''}" />
      <h:commandButton id="switchToTextButton"
        action="#{newMainBean.switchToText}"
        value="#{newMainBean.editTextButtonTitle}"
        styleClass="storeButton"
        style="#{!newMainBean.editingSummary ? 'font-weight:bold;text-decoration:underline' : ''}" />
    </h:panelGroup>
  </t:div>
  <t:div>
    <sf:editor id="fckeditor_text" toolbarSet="Custom" readonly="false"
               height="400" width="100%"
               value="#{newMainBean.htmlInputText}"/>
  </t:div>
  <t:div>
    <h:panelGroup id="cbCleanTextPanel">
      <h:selectBooleanCheckbox id="cbCleanText"
                               value="#{newMainBean.cleanHtmlInputText}"/>
      <h:outputText id="cbCleanTextLabel"
                    value="#{newMainBean.cleanCheckBoxTitle}"
                    styleClass="textBox"/>
    </h:panelGroup>
  </t:div>

</jsp:root>
