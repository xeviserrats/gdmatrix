<?xml version='1.0' encoding='windows-1252'?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
          xmlns:f="http://java.sun.com/jsf/core"
          xmlns:h="http://java.sun.com/jsf/html"
          xmlns:t="http://myfaces.apache.org/tomahawk"
          xmlns:sf="http://www.santfeliu.org/jsf">

<f:loadBundle basename="org.santfeliu.forum.web.resources.ForumBundle" var="forumBundle" />
<f:loadBundle basename="org.santfeliu.web.obj.resources.ObjectBundle" var="objectBundle" />

  <sf:saveScroll />  
  <t:saveState value="#{forumCatalogueBean}" />

    <h:messages rendered="#{userSessionBean.facesMessagesQueued}" 
      showSummary="true"
      warnClass="warnMessage"
      errorClass="errorMessage"
      fatalClass="fatalMessage" />

      <sf:commandTimer action="#{forumCatalogueBean.refreshCurrentQuestion}"
        time="#{forumCatalogueBean.refreshTime}"
        rendered="#{forumCatalogueBean.currentForumView.status == 'OPEN'}"
        enabled="document.forms[0]['mainform:answerText'] == null ? true :
          document.forms[0]['mainform:answerText'].value.length == 0" />   
      
  <t:div styleClass="objectForm">

    <t:div rendered="#{userSessionBean.selectedMenuItem.properties.answerHeaderDocId!=null}"
                 styleClass="headerDocument">
      <sf:browser url="/documents/#{userSessionBean.selectedMenuItem.properties.answerHeaderDocId}"
        port="#{applicationBean.defaultPort}"
        translator="#{userSessionBean.translator}"
        translationGroup="#{userSessionBean.translationGroup}"
        rendered="#{userSessionBean.selectedMenuItem.properties.answerHeaderDocId!=null}"/>
    </t:div>

    <t:div styleClass="normalAnswers">
      <t:div styleClass="sheet">

      <t:div styleClass="questionHeader" style="float:left">
        <h:outputText value="#{forumCatalogueBean.currentQuestion.title == null ? '[No title]' : forumCatalogueBean.currentQuestion.title}"
           style="width:99%"/>
      </t:div>
      <t:div styleClass="topButtons">
        <h:commandButton action="#{forumCatalogueBean.cancelQuestion}"
          value="#{objectBundle.close}" styleClass="cancelButton"
          immediate="true" />
      </t:div>

      <t:div styleClass="questionInfo">
        <h:outputText value="#{forumBundle.author}:  "/>
        <h:outputText value="#{forumCatalogueBean.currentQuestion.creationUserId} " styleClass="user"/>
        <h:outputText value=" #{forumBundle.date}:  "/>
        <h:outputText value="#{forumCatalogueBean.currentQuestionDateTime}">
          <f:convertDateTime pattern="EEEE, dd/MM/yyyy HH:mm:ss" />
        </h:outputText>
        <h:outputText value="" />
      </t:div>
      <t:div styleClass="questionBody">
        <h:outputText value="#{forumCatalogueBean.currentQuestion.text}"
           style="width:99%"/>
      </t:div>

      <t:dataTable 
        value="#{forumCatalogueBean.questionAnswers}" var="row"
        styleClass="resultList" summary="results"
        rowClasses="row1,row2" headerClass="header"
        footerClass="footer" 
        renderedIfEmpty="false">
        <f:facet name="header">
          <h:outputText value="#{forumBundle.answers}"/>
        </f:facet>
        <t:column width="83%">
          <t:div styleClass="answerInfo">
            <h:outputText value="#{forumBundle.author}: " />
            <h:outputText value="#{row.creationUserId} " style="font-weight:bold"/>
             <h:outputText value=" #{forumBundle.date}: " />
            <h:outputText value="#{forumCatalogueBean.answerDateTime}">
              <f:convertDateTime pattern="EEEE, dd/MM/yyyy HH:mm:ss" />
            </h:outputText>
          </t:div>
          <t:div styleClass="answerBody">
            <h:outputText value="#{row.text}" />
          </t:div>
        </t:column>
        <t:column width="17%" rendered="#{forumCatalogueBean.editorUser and not forumCatalogueBean.readOnly}"
                  styleClass="actionsColumn">
          <h:commandButton action="#{forumCatalogueBean.editAnswer}" value="#{objectBundle.edit}"
                           styleClass="editButton"/>
          <h:commandButton action="#{forumCatalogueBean.removeAnswer}" value="#{objectBundle.delete}"
                           styleClass="removeButton"
                           onclick="return confirm('#{objectBundle.confirm_remove}')"/>
        </t:column>
      </t:dataTable>

      <t:div style="text-align:right"
             rendered="#{not forumCatalogueBean.readOnly}">
        <h:commandButton 
          action="#{forumCatalogueBean.editAnswer}" value="#{forumBundle.submitAnswer}"
          styleClass="createButton" />
      </t:div>      

      <t:div rendered="#{forumCatalogueBean.currentAnswer != null}">
        <h:outputText value=" #{forumBundle.answer}" style="font-weight: bold" />
        <h:inputTextarea id="answerText" value="#{forumCatalogueBean.currentAnswer.text}"
          styleClass="inputBox" style="width:99%"
          onkeypress="checkMaxLength(this, 4000)"
          rows="10"/>
      </t:div>
    </t:div>
  </t:div>
    <t:div styleClass="footer">
      <h:commandButton action="#{forumCatalogueBean.storeNormalAnswer}"
        value="#{objectBundle.store}" styleClass="storeButton"
        rendered="#{forumCatalogueBean.currentAnswer != null}"/>
      <h:commandButton action="#{forumCatalogueBean.cancelAnswer}"
        value="#{objectBundle.cancel}" styleClass="cancelButton"
        rendered="#{forumCatalogueBean.currentAnswer != null}"/>
    </t:div>
</t:div>

</jsp:root>
