<?xml version='1.0' encoding='windows-1252'?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
          xmlns:f="http://java.sun.com/jsf/core"
          xmlns:h="http://java.sun.com/jsf/html"
          xmlns:t="http://myfaces.apache.org/tomahawk"
          xmlns:sf="http://www.santfeliu.org/jsf">

  <h:outputText value="#{eventDetailBean.emailSharingScripts}" escape="false" />  
  
  <f:loadBundle basename="org.santfeliu.agenda.web.resources.AgendaBundle" var="agendaBundle"/>
  <f:loadBundle basename="org.santfeliu.web.obj.resources.ObjectBundle" var="objectBundle" />

  <sf:printableGroup name="printAgenda">
    <t:div styleClass="eventDetail" >

      <h:messages rendered="#{userSessionBean.facesMessagesQueued}" 
                showSummary="true"
                infoClass="infoMessage"
                warnClass="warnMessage"
                errorClass="errorMessage"
                fatalClass="fatalMessage" />

      <t:div styleClass="actionButtons" style="width:100%;text-align:right">
        <h:commandButton value="#{objectBundle.edit}"
          action="#{eventDetailBean.editEvent}"
          image="#{userSessionBean.icons.edit}"
          rendered="#{eventSearchBean.editorUser and userSessionBean.menuModel.browserType == 'desktop'}"
          alt="#{objectBundle.edit}" title="#{objectBundle.edit}"
          styleClass="editButton"/>
        <h:commandButton onclick="javascript:printGroup('printAgenda');"
          styleClass="editButton"
          image="#{userSessionBean.icons.print}"
          alt="#{objectBundle.print}" title="#{objectBundle.print}"
          rendered="#{userSessionBean.selectedMenuItem.properties.printEnabled=='true' and userSessionBean.menuModel.browserType == 'desktop'}">
        </h:commandButton>
        <h:commandButton action="#{eventDetailBean.close}"
        rendered="#{userSessionBean.menuModel.browserType == 'desktop'}"
        value="#{objectBundle.close}" immediate="true" styleClass="closeButton"
        image="#{userSessionBean.icons.close}"
        alt="#{objectBundle.close}" title="#{objectBundle.close}" />
      </t:div>

      <h:panelGroup styleClass="eventBlock mainBlock">

        <t:div styleClass="blockHeader ">
          <h:outputText value="#{agendaBundle.event}" />
        </t:div>

        <t:div styleClass="eventImage" rendered="#{eventDetailBean.detailImageDocId != null}">
          <h:graphicImage url="/documents/#{eventDetailBean.detailImageDocId}"
            height="#{eventDetailBean.detailImageHeight}"
            width="#{eventDetailBean.detailImageWidth}"/>
        </t:div>

        <t:div styleClass="eventProperty title">
          <h:outputText value="#{agendaBundle.event_title}: "
                        styleClass="name" style="width:15%"/>
          <sf:outputText value="#{eventDetailBean.event.summary}"
            styleClass="value"
            translator="#{userSessionBean.translator}"
            translationGroup="event:#{eventDetailBean.event.eventId}"/>
        </t:div>

        <t:div styleClass="eventProperty date">
          <h:outputText value="#{agendaBundle.event_when}: "
                        styleClass="name" style="width:15%"/>
          <h:outputLink
            value="#{eventDetailBean.dateTimeParameters}">
            <h:outputText value="#{eventDetailBean.when}"
                          styleClass="value" />
          </h:outputLink>
        </t:div>

        <t:div styleClass="eventProperty place">
          <h:outputText value="#{agendaBundle.event_where}: "
                        styleClass="name" style="width:15%"/>
          <h:outputLink rendered="#{eventDetailBean.places[0].room}"
                        value="#{eventDetailBean.roomParameters}">

            <sf:outputText value="#{eventDetailBean.places[0].description}"
              styleClass="value"
              translator="#{userSessionBean.translator}"
              translationGroup="event:#{eventDetailBean.event.eventId}"/>
          </h:outputLink>
          <sf:outputText rendered="#{!eventDetailBean.places[0].room}"
            value="#{eventDetailBean.places[0].description}"
            styleClass="value"
            translator="#{userSessionBean.translator}"
            translationGroup="event:#{eventDetailBean.event.eventId}"/>
        </t:div>

        <t:div styleClass="eventProperty type">
          <h:outputText value="#{agendaBundle.event_type}: "
                        styleClass="name" style="width:15%" />
          <h:outputLink
            value="#{eventDetailBean.typeIdParameters}">
            <sf:outputText value="#{eventDetailBean.eventType}"
              styleClass="value" translator="#{userSessionBean.translator}"
              translationGroup="event:#{eventDetailBean.event.eventId}"/>
          </h:outputLink>
        </t:div>

        <t:div styleClass="eventProperty " rendered="#{not eventDetailBean.typeUndefined and
          eventDetailBean.selector != null and eventDetailBean.renderFormSelectItems}">
          <h:outputText value="#{agendaBundle.event_form}:"
            styleClass="name" style="width:12%" />
          <sf:commandMenu value="#{eventDetailBean.selector}"
            styleClass="selectBox">
            <f:selectItems value="#{eventDetailBean.formSelectItems}" />
          </sf:commandMenu>
          <h:commandButton value="#{objectBundle.update}"
            image="#{userSessionBean.icons.update}" immediate="true"
            alt="#{objectBundle.update}" title="#{objectBundle.update}"
            styleClass="showButton"
            action="#{eventDetailBean.updateForm}" />
        </t:div>

        <t:div rendered="#{not eventDetailBean.typeUndefined and
          eventDetailBean.selector != null}"
          styleClass="eventProperty dynamicForm">
          <sf:dynamicForm
            form="#{eventDetailBean.form}"
            rendererTypes="DisabledHtmlFormRenderer"
            value="#{eventDetailBean.data}"/>
        </t:div>

      </h:panelGroup>

      <h:panelGroup styleClass="eventBlock descriptionBlock" style="display:block"
             rendered="#{eventDetailBean.event.description != null or eventDetailBean.event.detail != null}">

        <t:div styleClass="blockHeader">
          <h:outputText value="#{agendaBundle.event_description}" />
        </t:div>

        <t:div styleClass="eventProperty description" 
          rendered="#{eventDetailBean.event.description != null and eventDetailBean.event.detail == null}">
          <sf:outputText value="#{eventDetailBean.event.description}"
            translator="#{userSessionBean.translator}"
            translationGroup="event:#{eventDetailBean.event.eventId}"/>
        </t:div>

        <t:div styleClass="eventProperty detail" rendered="#{eventDetailBean.event.detail != null}">
          <sf:outputText value="#{eventDetailBean.event.detail}"
            styleClass="text" escape="false"
            translator="#{userSessionBean.translator}"
            translationGroup="event:#{eventDetailBean.event.eventId}"/>
        </t:div>

      </h:panelGroup>

      <h:panelGroup styleClass="eventBlock placesBlock" style="display:block" rendered="#{!empty eventDetailBean.places}">

        <t:div styleClass="blockHeader">
          <h:outputText value="#{agendaBundle.eventPlace}"/>
        </t:div>

        <t:dataList var="place" value="#{eventDetailBean.places}"
                    styleClass="placeList" rowClasses="row1,row2" >

          <t:div styleClass="eventProperty place" rendered="#{!place.address}" style="margin-top:20px">
            <h:outputText value="#{place.room ? agendaBundle.event_roomId : agendaBundle.event_place}: "
                          styleClass="name" style="width:15%" />
            <h:outputLink rendered="#{place.room}"
              value="go.faces?xmid=#{userSessionBean.selectedMid}&amp;roomid=#{place.roomView.roomId}&amp;oc=false">
              <sf:outputText value="#{place.description}" translator="#{userSessionBean.translator}"
                translationGroup="event:#{eventDetailBean.event.eventId}"/>
            </h:outputLink>
            <h:outputText rendered="#{!place.room}"
              value="#{place.description}"/>
          </t:div>

          <t:div styleClass="eventProperty address" rendered="#{place.address or place.room}">
            <h:outputText value="#{agendaBundle.room_address}: "
                          styleClass="name" style="width:15%" />
            <h:outputText value="#{place.addressView.description}"/>
            <h:outputLink value="#{eventDetailBean.mapURL}"
                          target="_blank"
                          styleClass="showButton" style="margin-left:5px">
              <h:graphicImage value="/common/agenda/images/directions.png" style="vertical-align:middle" alt="#{agendaBundle.event_showMap}"/>
            </h:outputLink>
          </t:div>

          <t:div styleClass="eventProperty city" rendered="#{place.address or place.room}">
            <h:outputText value="#{agendaBundle.room_city}: "
                          styleClass="name" style="width:15%" />
            <h:outputText value="#{place.addressView.city}" />
          </t:div>

          <t:div styleClass="eventProperty province" rendered="#{place.address or place.room}">
            <h:outputText value="#{agendaBundle.room_province}: "
                          styleClass="name" style="width:15%" />
            <h:outputText value="#{place.addressView.province}" />
          </t:div>

        </t:dataList>

      </h:panelGroup>

      <h:panelGroup styleClass="eventBlock attendantsBlock" rendered="#{eventDetailBean.renderAttendants and !empty eventDetailBean.attendants}">

        <t:div styleClass="blockHeader">
          <h:outputText value="#{agendaBundle.attendants}" />
        </t:div>

        <t:dataList var="attendant" value="#{eventDetailBean.attendants}"
                     styleClass="attendantList">
          <t:div styleClass="eventProperty attendant">
            <h:outputText value="#{attendant.personView.fullName}"
                          style="display:inline-block;width:35%"
                          styleClass="value"/>
            <h:outputText value="#{agendaBundle.attendants_type}: "
                          styleClass="name" style="width:8%"
                          rendered="#{attendant.attendantTypeId != null}"/>
            <h:outputText value="#{attendant.attendantTypeId}" />
          </t:div>
        </t:dataList>

      </h:panelGroup>

      <h:panelGroup styleClass="eventBlock documentsBlock" rendered="#{!empty eventDetailBean.extendedInfoDocs}">

        <t:div styleClass="blockHeader">
          <h:outputText value="#{agendaBundle.eventDocuments}" />
        </t:div>

        <t:dataList var="doc" value="#{eventDetailBean.extendedInfoDocs}"
                     styleClass="documentList" layout="unorderedList">
          <t:div styleClass="eventProperty document">
            <h:graphicImage url="#{eventDetailBean.mimeTypePath}"/>
            <h:outputLink value="#{eventDetailBean.documentUrl}" target="_blank">
            <h:outputText value="#{doc.title}" style="margin-left:5px; vertical-align:top"/>
            </h:outputLink>
          </t:div>
        </t:dataList>

      </h:panelGroup>

      <t:div rendered="#{eventDetailBean.sharingEnabled}" styleClass="shareLayer">
        <h:panelGroup>
          <sf:outputText value="#{userSessionBean.selectedMenuItem.properties['details.shareText']}"
            styleClass="shareText"
            translator="#{userSessionBean.translator}"
            translationGroup="#{userSessionBean.translationGroup}"
            rendered="#{userSessionBean.selectedMenuItem.properties['details.shareText'] != null}"/>
          <t:dataList value="#{eventDetailBean.shareLinkList}" styleClass="shareTable" var="item">
            <sf:outputLink rendered="#{item.shareURL != 'EMAIL'}" 
                          value="#{item.shareURL}" 
                          styleClass="shareLink" 
                          target="_blank"
                          title="#{item.description}"
                          translator="#{userSessionBean.translator}"
                          translationGroup="#{userSessionBean.translationGroup}">
              <sf:graphicImage url="#{item.iconURL}" styleClass="shareImage" 
                              alt="#{item.description}"                                
                              translator="#{userSessionBean.translator}"
                              translationGroup="#{userSessionBean.translationGroup}" />
            </sf:outputLink>
            <sf:outputLink rendered="#{item.shareURL == 'EMAIL' and userSessionBean.menuModel.browserType == 'desktop'}" 
                          title="#{item.description}"
                          translator="#{userSessionBean.translator}"
                          translationGroup="#{userSessionBean.translationGroup}"
                          onclick="switchSendEmailDiv(event);return false;" value="#" styleClass="shareLink">
              <sf:graphicImage url="#{item.iconURL}"  
                             alt="#{item.description}"                              
                             translator="#{userSessionBean.translator}"
                             translationGroup="#{userSessionBean.translationGroup}" />                            
            </sf:outputLink>            
          </t:dataList>
        </h:panelGroup>
      </t:div>

    </t:div>
  </sf:printableGroup>

  <t:div styleClass="sendEmailDiv" forceId="true" id="sendEmailDiv">
    <t:div styleClass="titleDiv">
      <h:outputText value="#{webBundle.sendEmailTitle}"/>
      <h:outputLink onclick="switchSendEmailDiv(event);return false;" value="#" 
              styleClass="closeButton"
              title="#{webBundle.sendEmailCancel}">
        <h:graphicImage url="/images/sn/send_email_close.png" 
                        alt="#{webBundle.sendEmailCancel}"/>
      </h:outputLink>
    </t:div>    
    <t:div styleClass="labelDiv">
      <h:outputText value="* #{webBundle.sendEmailRequiredFields}"/>
    </t:div>
    <t:div styleClass="labelDiv">
      <h:outputLabel value="#{webBundle.sendEmailName}:" for="sendEmailName" />
    </t:div>
    <t:div styleClass="inputDiv">
      <t:inputText forceId="true" id="sendEmailName" value="#{eventDetailBean.emailName}"/>
    </t:div>
    <t:div styleClass="labelDiv">
      <h:outputLabel value="#{webBundle.sendEmailFrom}&lt;abbr title='#{webBundle.requiredField}'&gt;*&lt;/abbr&gt;:" for="sendEmailFrom" />      
    </t:div>
    <t:div styleClass="inputDiv">
      <t:inputText forceId="true" id="sendEmailFrom" value="#{eventDetailBean.emailFrom}"/>
    </t:div>
    <t:div styleClass="labelDiv">
      <h:outputLabel value="#{webBundle.sendEmailTo}&lt;abbr title='#{webBundle.requiredField}'&gt;*&lt;/abbr&gt;:" for="sendEmailTo" />      
    </t:div>
    <t:div styleClass="inputDiv">
      <t:inputText forceId="true" id="sendEmailTo" value="#{eventDetailBean.emailTo}"/>
    </t:div>
    <t:div styleClass="labelDiv">
      <h:outputLabel value="#{webBundle.sendEmailSubject}:" for="sendEmailSubject" />
    </t:div>
    <t:div styleClass="inputDiv">
      <t:inputText forceId="true" id="sendEmailSubject" value="#{eventDetailBean.emailSubject}"/>
    </t:div>
    <t:div styleClass="labelDiv">
      <h:outputLabel value="#{webBundle.sendEmailText}&lt;abbr title='#{webBundle.requiredField}'&gt;*&lt;/abbr&gt;:" for="sendEmailText" />      
    </t:div>
    <t:div styleClass="inputDiv">
      <t:inputTextarea forceId="true" id="sendEmailText" value="#{eventDetailBean.emailText}"/>
    </t:div>    
    <t:div styleClass="buttonDiv">      
      <t:div styleClass="errorMessageDiv">
        <t:outputText value="#{webBundle.sendEmailInvalidForm}" forceId="true" id="sendEmailError" style="display:inline;visibility:hidden;" />
      </t:div>
      <h:outputLink onclick="sendEmail();return false;" value="#" styleClass="sendLink"> 
        <t:outputText value="#{webBundle.sendEmailButton}" />      
      </h:outputLink>      
    </t:div>      
  </t:div>

  <t:commandButton style="visibility:hidden" forceId="true" id="sendEmailButton" action="#{eventDetailBean.sendEmail}" styleClass="hiddenButton" /> 

</jsp:root>