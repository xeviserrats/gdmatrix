<?xml version='1.0' encoding='windows-1252'?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
          xmlns:f="http://java.sun.com/jsf/core"
          xmlns:h="http://java.sun.com/jsf/html"
          xmlns:t="http://myfaces.apache.org/tomahawk"
          xmlns:sf="http://www.santfeliu.org/jsf">

  <f:loadBundle basename="org.santfeliu.agenda.web.resources.AgendaBundle"
    var="agendaBundle" />

  <t:div rendered="#{!eventBean.new}">
    <h:outputText value="#{objectBundle.object_id}:" styleClass="textBox"
      style="width:18%" />
    <h:outputText value="#{eventMainBean.event.eventId}" styleClass="outputBox"
      style="width:16%" />
  </t:div>

  <t:div>
    <h:outputText value="#{agendaBundle.event_type}:"
      style="width:18%" styleClass="textBox"/>
    <sf:commandMenu value="#{eventMainBean.currentTypeId}"
      styleClass="selectBox" disabled="#{not eventBean.editable}" >
      <f:selectItem itemLabel=" " itemValue="" />
      <f:selectItems value="#{eventMainBean.allTypeItems}" />
    </sf:commandMenu>
    <h:commandButton action="#{eventMainBean.showType}"
      value="#{objectBundle.show}"
      image="#{userSessionBean.icons.show}"
      alt="#{objectBundle.show}" title="#{objectBundle.show}"
      styleClass="showButton"      
      rendered="#{eventMainBean.renderShowTypeButton}" />
  </t:div>

  <t:div>
    <h:outputText value="#{agendaBundle.event_summary}:" styleClass="textBox"
      style="width:18%" />
    <h:inputText value="#{eventMainBean.event.summary}" styleClass="inputBox"
      style="width:78%" valueChangeListener="#{eventMainBean.valueChanged}"
      maxlength="#{eventMainBean.propertySize.summary}"
      readonly="#{not eventBean.editable}"
      />
  </t:div>

  <t:div>
    <h:outputText value="#{agendaBundle.event_startDate}:"
      style="width:18%"
      styleClass="textBox"/>

    <sf:calendar value="#{eventMainBean.event.startDateTime}"
      styleClass="calendarBox"
      externalFormat="dd/MM/yyyy|HH:mm:ss"
      internalFormat="yyyyMMddHHmmss"
      buttonStyleClass="calendarButton"
      style="width:14%;"
      disabled="#{not eventBean.editable}"/>

    <h:commandButton value="#{agendaBundle.event_allDay}" styleClass="addButton"
      action="#{eventMainBean.allDay}" disabled="#{not eventBean.editable}" />
  </t:div>
  
  <t:div>
    <h:outputText value="#{agendaBundle.event_endDate}:"
      styleClass="textBox"
      style="width:18%"/>

    <sf:calendar value="#{eventMainBean.event.endDateTime}"
      styleClass="calendarBox"
      externalFormat="dd/MM/yyyy|HH:mm:ss"
      internalFormat="yyyyMMddHHmmss"
      buttonStyleClass="calendarButton"
      style="width:14%;"
      disabled="#{not eventBean.editable}"/>
  </t:div>

  <t:div rendered="#{eventMainBean.creationDateTime != null}">
    <h:outputText value="#{agendaBundle.event_creationDateTime}:"
      styleClass="textBox" style="width:18%" />
      <h:outputText value="#{eventMainBean.creationDateTime}"
        styleClass="outputBox" style="width:22%">
        <f:convertDateTime pattern="dd/MM/yyyy HH:mm:ss" />
    </h:outputText>
    <h:outputText value="#{agendaBundle.event_createdBy}:"
      styleClass="textBox" style="width:5%"
      rendered="#{eventMainBean.event.creationUserId != null}"/>
    <h:outputText value="#{eventMainBean.event.creationUserId}"
      styleClass="outputBox" style="width:22%" />
  </t:div>

  <t:div rendered="#{eventMainBean.changeDateTime != null}">
    <h:outputText value="#{agendaBundle.event_changeDateTime}:"
      styleClass="textBox" style="width:18%" />
    <h:outputText value="#{eventMainBean.changeDateTime}"
    styleClass="outputBox" style="width:22%">
        <f:convertDateTime pattern="dd/MM/yyyy HH:mm:ss" />
    </h:outputText>
    <h:outputText value="#{agendaBundle.event_changedBy}:"
      styleClass="textBox" style="width:5%"
      rendered="#{eventMainBean.event.changeUserId != null}"/>
    <h:outputText value="#{eventMainBean.event.changeUserId}"
      styleClass="outputBox" style="width:22%" />
  </t:div>

  <t:div>
    <h:outputText value="#{agendaBundle.event_description}:" styleClass="textBox"
      style="width:18%; vertical-align:top"/>

    <h:inputTextarea value="#{eventMainBean.event.description}"
      style="width:79%" rows="4"
      styleClass="inputBox"
      valueChangeListener="#{eventMainBean.valueChanged}"
      onkeypress="checkMaxLength(this, #{eventMainBean.propertySize.description})"
      readonly="#{not eventBean.editable}"/>

  </t:div>

  <t:div>
    <t:collapsiblePanel title="#{agendaBundle.event_detail}:"
                        titleStyleClass="textBox" titleStyle="color: black"
                         var="collapsed">
      <f:facet name="header">
        <t:div>
          <t:headerLink immediate="true">
            <h:graphicImage value="/images/expand.gif" rendered="#{collapsed}"/>
            <h:graphicImage value="/images/collapse.gif" rendered="#{!collapsed}"/>
          </t:headerLink>
          <h:outputText value=" #{agendaBundle.event_detail}:" />
        </t:div>
      </f:facet>
      <sf:editor id="fckeditor_text" toolbarSet="Reduced" readonly="#{not eventBean.editable}"
                 height="300" width="99%"
                 value="#{eventMainBean.event.detail}"
                 disabled="#{not eventBean.editable}"
                 />
    </t:collapsiblePanel>
  </t:div>

  <t:div>
    <h:outputText value="#{agendaBundle.event_hiddenComments}:" styleClass="textBox"
      style="width:18%; vertical-align:top"/>

    <h:inputTextarea value="#{eventMainBean.event.comments}"
      style="width:79%" rows="4"
      styleClass="inputBox"
      valueChangeListener="#{eventMainBean.valueChanged}"
      onkeypress="checkMaxLength(this, #{eventMainBean.propertySize.comments})"
      readonly="#{not eventBean.editable}"/>
  </t:div>

  <t:div>
    <t:selectBooleanCheckbox value="#{eventMainBean.onlyAttendants}"
      style="vertical-align:middle;"
      disabled="#{not eventBean.editable}"/>
    <h:outputText value="#{agendaBundle.event_onlyAttendants}" styleClass="textBox"
      style="width:30%; vertical-align:middle"/>
  </t:div>

  <t:div rendered="#{eventMainBean.new}">
    <t:selectBooleanCheckbox value="#{eventMainBean.autoAttendant}"
      style="vertical-align:middle;" rendered="#{eventMainBean.new}"
      disabled="#{not eventBean.editable}"/>
    <h:outputText value="#{agendaBundle.event_autoAttendant}" styleClass="textBox"
      style="width:25%; vertical-align:middle" rendered="#{eventMainBean.new}"/>
  </t:div>  
  
  <t:div rendered="#{eventMainBean.propertyEditorVisible || eventMainBean.renderFormSelector}">
    <h:outputText value="#{agendaBundle.event_form}:"
      styleClass="textBox" style="width:18%" />
    <sf:commandMenu value="#{eventMainBean.selector}"
      styleClass="selectBox">
      <f:selectItems value="#{eventMainBean.formSelectItems}" />
    </sf:commandMenu>
    <h:commandButton value="#{objectBundle.update}"
      image="#{userSessionBean.icons.update}" immediate="true"
      alt="#{objectBundle.update}" title="#{objectBundle.update}"
      styleClass="showButton"
      rendered="#{not eventMainBean.propertyEditorVisible}"
      action="#{eventMainBean.updateForm}" />
  </t:div>

  <t:div rendered="#{eventMainBean.renderForm}">
    <sf:dynamicForm
      form="#{eventMainBean.form}"
      rendererTypes="#{eventBean.editable ? 'HtmlFormRenderer,GenericFormRenderer' : 'DisabledHtmlFormRenderer'}"
      value="#{eventMainBean.data}"
      rendered="#{not eventMainBean.propertyEditorVisible}" />
    <h:inputTextarea value="#{eventMainBean.propertyEditorString}"
      rendered="#{eventMainBean.propertyEditorVisible}"
      validator="#{eventMainBean.validatePropertyEditorString}"
      style="width:98%;height:100px; font-family:Courier New"
      styleClass="inputBox" />
  </t:div>

</jsp:root>
