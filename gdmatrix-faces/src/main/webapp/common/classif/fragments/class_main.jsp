<?xml version='1.0' encoding='windows-1252'?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
          xmlns:f="http://java.sun.com/jsf/core"
          xmlns:h="http://java.sun.com/jsf/html"
          xmlns:t="http://myfaces.apache.org/tomahawk"
          xmlns:sf="http://www.santfeliu.org/jsf">

  <f:loadBundle basename="org.santfeliu.classif.web.resources.ClassificationBundle"
    var="classificationBundle" />

  <t:div>
    <h:outputText value="#{classificationBundle.class_classId}:" styleClass="textBox"
      style="width:18%" />
    <h:inputText value="#{classMainBean.classObject.classId}" styleClass="inputBox"
      style="font-family:Courier New;font-weight:bold;width:12%"
      readonly="#{!classBean.new}" maxlength="#{classMainBean.propertySize.classId}"/>
    <h:commandButton value="#{classificationBundle.classMain_cases}"
      action="#{classBean.searchCases}"
      styleClass="showButton" rendered="#{!classBean.new}" />
    <h:commandButton value="#{classificationBundle.classMain_documents}"
      action="#{classBean.searchDocuments}"
      styleClass="showButton" rendered="#{!classBean.new}" />
  </t:div>

  <t:div rendered="#{classMainBean.creationDateTime != null}">
    <h:outputText value="#{classificationBundle.classMain_creation}:" styleClass="textBox"
      style="width:18%" />
    <h:outputText value="#{classMainBean.creationDateTime}"
      styleClass="outputBox" style="width:22%" >
        <f:convertDateTime pattern="dd/MM/yyyy HH:mm:ss" />
    </h:outputText>
    <h:outputText value="#{classificationBundle.classMain_changeUserId}:"
      styleClass="textBox" style="width:5%"
      rendered="#{classMainBean.classObject.creationUserId != null}"/>
    <h:outputText value="#{classMainBean.classObject.creationUserId}"
      styleClass="outputBox" style="width:22%" />
  </t:div>

  <t:div rendered="#{classMainBean.changeDateTime != null}">
    <h:outputText value="#{classificationBundle.classMain_changeDateTime}:"
      styleClass="textBox" style="width:18%" />
    <h:outputText value="#{classMainBean.changeDateTime}"
      styleClass="outputBox" style="width:22%">
        <f:convertDateTime pattern="dd/MM/yyyy HH:mm:ss" />
    </h:outputText>
    <h:outputText value="#{classificationBundle.classMain_changeUserId}:"
      styleClass="textBox" style="width:5%"
      rendered="#{classMainBean.classObject.changeUserId != null}"/>
    <h:outputText value="#{classMainBean.classObject.changeUserId}"
      styleClass="outputBox" style="width:22%" />
  </t:div>

  <t:div style="border-top:dashed 1px gray; margin-top:8px; padding-top:8px;">
    <h:outputText value="#{classificationBundle.classMain_startDate}:"
      styleClass="textBox" style="width:18%" />
    <sf:calendar value="#{classMainBean.classObject.startDateTime}"
      style="width:80px" styleClass="calendarBox" buttonStyleClass="calendarButton"
      disabled="#{not classBean.editable}"
      internalFormat="yyyyMMddHHmmss" externalFormat="dd/MM/yyyy|HH:mm:ss" />
  </t:div>

  <t:div>
    <h:outputText value="#{classificationBundle.classMain_endDate}:"
      styleClass="textBox" style="width:18%" />
    <sf:calendar value="#{classMainBean.classObject.endDateTime}"
      style="width:80px" styleClass="calendarBox" buttonStyleClass="calendarButton"
      disabled="#{not classBean.editable}"
      internalFormat="yyyyMMddHHmmss" externalFormat="dd/MM/yyyy|HH:mm:ss" />
  </t:div>

  <t:div rendered="#{!classBean.new and !classMainBean.rootClass}">
    <t:div style="margin-left:110px;font-style:italic;color:gray">
      <h:outputText value="#{classificationBundle.classMain_pathAtDate} "/>
      <h:outputText value="#{classMainBean.pathDateTime}">
        <f:convertDateTime pattern="dd/MM/yyyy HH:mm:ss" />
      </h:outputText>
      <h:outputText value=":"/>
    </t:div>
    <t:dataList value="#{classMainBean.superClasses}" var="class">
      <h:panelGroup style="display:block;padding:2px">
        <h:outputText styleClass="textBox" style="width:18%" />
        <h:graphicImage value="/common/classif/images/next.gif" alt=""
          style="margin-left:#{classMainBean.indent}px"/>
        <h:commandLink action="#{classMainBean.showClassFromPath}"
          style="text-decoration:none;color:black;
            text-decoration:#{class.open ? 'none' : 'line-through'}">
          <h:outputText value="#{class.classId}"
            style="font-family:Courier new;font-weight:bold;
            background:#FFFFD0;padding:0px;border:orange 1px solid;" />
          <h:outputText value=" : #{class.title}" />
        </h:commandLink>
      </h:panelGroup>
    </t:dataList>
  </t:div>

  <t:div>
    <h:outputText value="#{classificationBundle.class_superClassId}:" styleClass="textBox"
      style="width:18%" />
    <h:inputText value="#{classMainBean.classObject.superClassId}" styleClass="inputBox"
      style="font-family:Courier New;width:12%" 
      disabled="#{not classBean.editable}"
      maxlength="#{classMainBean.propertySize.superClassId}"/>
  </t:div>

  <t:div>
    <h:outputText value="#{classificationBundle.classMain_type}:"
      style="width:18%" styleClass="textBox"/>
    <sf:commandMenu value="#{classMainBean.currentTypeId}"
      styleClass="selectBox" disabled="#{not classBean.editable}">
      <f:selectItem itemValue="" itemLabel=" " />
      <f:selectItems value="#{classMainBean.allTypeItems}" />
    </sf:commandMenu>
    <h:commandButton action="#{classMainBean.showType}"
      value="#{objectBundle.show}"
      image="#{userSessionBean.icons.show}"
      alt="#{objectBundle.show}" title="#{objectBundle.show}"
      styleClass="showButton"     
      rendered="#{classMainBean.renderShowTypeButton}" />
  </t:div>
  
  <t:div>
    <h:outputText value="#{classificationBundle.class_title}:" styleClass="textBox"
      style="width:18%" />
    <h:inputText value="#{classMainBean.classObject.title}" styleClass="inputBox"
      style="width:79%" disabled="#{not classBean.editable}"
      maxlength="#{classMainBean.propertySize.title}"/>
  </t:div>
  
  <t:div>
    <h:outputText value="#{classificationBundle.class_description}:" styleClass="textBox"
      style="width:18%;vertical-align:top" />
    <h:inputTextarea value="#{classMainBean.classObject.description}"
      styleClass="inputBox" style="width:79%" rows="4"
      readonly="#{not classBean.editable}"
      onkeypress="checkMaxLength(this, #{classMainBean.propertySize.description})"/>
  </t:div>

  <t:div>
    <h:outputText value="#{classificationBundle.classMain_acUserId}:" styleClass="textBox"
      style="width:18%" />
    <h:inputText value="#{classMainBean.classObject.accessControlUserId}" 
      styleClass="inputBox" style="20%" readonly="#{not classBean.editable}"
      maxlength="#{classMainBean.propertySize.accessControlUserId}"/>
    <h:outputText value="#{classificationBundle.classMain_offlineDownload}:" styleClass="textBox" />
    <h:selectBooleanCheckbox value="#{classMainBean.classObject.offlineDownload}" 
      style="vertical-align:middle" disabled="#{not classBean.editable}" />
  </t:div>

  <t:div rendered="#{not classMainBean.typeUndefined and
    classMainBean.selector != null}">
    <h:outputText value="Formulari:"
      styleClass="textBox" style="width:18%" />
    <sf:commandMenu value="#{classMainBean.selector}"
      styleClass="selectBox">
      <f:selectItems value="#{classMainBean.formSelectItems}" />
    </sf:commandMenu>
    <h:commandButton value="#{objectBundle.update}"
      image="#{userSessionBean.icons.update}" immediate="true"
      alt="#{objectBundle.update}" title="#{objectBundle.update}"
      styleClass="showButton"
      rendered="#{not classMainBean.propertyEditorVisible}"
      action="#{classMainBean.updateForm}" />
  </t:div>

  <t:div rendered="#{not classMainBean.typeUndefined and
    classMainBean.selector != null}">
    <sf:dynamicForm form="#{classMainBean.form}"
     value="#{classMainBean.data}" 
     rendererTypes="HtmlFormRenderer,GenericFormRenderer"
     rendered="#{not classMainBean.propertyEditorVisible}" />
    <h:inputTextarea value="#{classMainBean.propertyEditorString}"
      rendered="#{classMainBean.propertyEditorVisible}"
      validator="#{classMainBean.validatePropertyEditorString}"
      style="width:98%;height:100px; font-family:Courier New"
      styleClass="inputBox" />
  </t:div>

  <t:div>
    <h:outputText value="#{classificationBundle.classMain_changeReason}:"
      styleClass="textBox" style="width:18%;vertical-align:top" />
  </t:div>

  <t:div>
    <h:inputTextarea value="#{classMainBean.classObject.changeReason}"
      styleClass="inputBox" style="width:98%" rows="4"
      readonly="#{not classBean.editable}" />
  </t:div>
</jsp:root>
