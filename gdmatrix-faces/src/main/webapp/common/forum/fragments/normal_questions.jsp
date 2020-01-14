<?xml version='1.0' encoding='windows-1252'?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
          xmlns:f="http://java.sun.com/jsf/core"
          xmlns:h="http://java.sun.com/jsf/html"
          xmlns:t="http://myfaces.apache.org/tomahawk"
          xmlns:sf="http://www.santfeliu.org/jsf">

  <f:loadBundle basename="org.santfeliu.forum.web.resources.ForumBundle"
                var="forumBundle" />
  <f:loadBundle basename="org.santfeliu.web.obj.resources.ObjectBundle"
                var="objectBundle" />

  <t:saveState value="#{forumCatalogueBean}" />

  <t:div styleClass="messages">
    <h:messages rendered="#{userSessionBean.facesMessagesQueued}" 
      showSummary="true" infoClass="infoMessage"
      warnClass="warnMessage" errorClass="errorMessage"
      fatalClass="fatalMessage" />
  </t:div>

  <t:div styleClass="objectSearch">

  <t:div rendered="#{userSessionBean.selectedMenuItem.properties.questionsHeaderDocId!=null}"
               styleClass="headerDocument">
    <sf:browser url="/documents/#{userSessionBean.selectedMenuItem.properties.questionsHeaderDocId}"
      port="#{applicationBean.defaultPort}"
      translator="#{userSessionBean.translator}"
      translationGroup="#{userSessionBean.translationGroup}"
      rendered="#{userSessionBean.selectedMenuItem.properties.questionsHeaderDocId!=null}"/>
  </t:div>

  <t:div styleClass="forumName" style="float:left">
    <h:outputText value="#{forumCatalogueBean.currentForumView.forum.name}" />
  </t:div>
  <t:div styleClass="topButtons">
    <h:commandButton value="#{forumCatalogueBean.setupButtonLabel}"
      styleClass="searchButton" action="#{forumCatalogueBean.setupCurrentForum}"
      rendered="#{forumCatalogueBean.editorUser}"/>
    <h:commandButton value="#{forumCatalogueBean.otherForumsLabel}"
      styleClass="searchButton" action="#{forumCatalogueBean.show}"
      rendered="#{not forumCatalogueBean.singleForum}"/>
  </t:div>

  <t:div>
    <h:commandLink action="#{forumCatalogueBean.showForumHits}"
      styleClass="Link"
      rendered="#{forumCatalogueBean.editorUser}">
      <h:outputText value="#{forumBundle.userConnected}: #{forumCatalogueBean.forumHits}" />
    </h:commandLink>
    <h:outputText value="#{forumBundle.userConnected}: #{forumCatalogueBean.forumHits}"
      rendered="#{not forumCatalogueBean.editorUser}"/>
  </t:div>    

  <t:div styleClass="#{forumCatalogueBean.readOnly ? 'closedStatusMessage' : 'openStatusMessage'}">
    <sf:outputText value="#{forumCatalogueBean.statusLabel}"
      translator="#{userSessionBean.translator}"
      translationGroup="#{userSessionBean.translationGroup}"/>
  </t:div>

  <h:panelGrid columns="1" width="100%" styleClass="filterPanel" style="margin-top:3px"
    columnClasses="column1"
    headerClass="header" footerClass="footer">
    <t:div>
    <h:outputText value="Mostra "/>
      <t:selectOneMenu styleClass="selectBox"
        value="#{forumCatalogueBean.questionFilter.showAnswered}"
        valueChangeListener="#{forumCatalogueBean.processQuestionFilterValueChange}">
        <f:selectItem itemValue="" itemLabel="#{forumBundle.showAnsweredAll}" />
        <f:selectItems value="#{forumCatalogueBean.showAnsweredItems}" />
        <f:converter converterId="EnumConverter" />
        <f:attribute name="enum" value="org.matrix.forum.ShowAnswered" />
      </t:selectOneMenu>
    </t:div>    
    <f:facet name="footer">
      <h:commandButton value="#{forumBundle.refresh}"
        styleClass="searchButton" action="#{forumCatalogueBean.searchQuestions}"/>
    </f:facet>

  </h:panelGrid>

  <t:buffer into="#{table}">
    <t:dataTable rows="#{forumCatalogueBean.questionsData.pageSize}" id="data"
      first="#{forumCatalogueBean.questionsData.firstRowIndex}"
      value="#{forumCatalogueBean.questionsData.rows}" var="row"
      rendered="#{forumCatalogueBean.questionsData.rowCount > 0}"
      styleClass="resultList" summary="results"
      rowClasses="row1,row2" headerClass="header"
      footerClass="footer">
      <t:column styleClass="normalQuestionsColumn" style="width:82%">
        <t:div styleClass="questionInfo">
          <t:div styleClass="dateInfo">
            <h:outputText value="#{forumBundle.author}: " />
            <h:outputText value="#{row.question.creationUserId}" styleClass="user"/>
            <h:graphicImage value="/common/forum/images/user.png" alt="user"
              rendered="#{row.question.text != null and forumCatalogueBean.editorUser and forumCatalogueBean.userConnected}"
              styleClass="userImage"/>
            <h:outputText value=" #{forumBundle.date}:  " />
            <h:outputText value="#{forumCatalogueBean.questionDateTime}" styleClass="dateTime">
              <f:convertDateTime pattern="dd/MM/yyyy HH:mm:ss" />
            </h:outputText>
          </t:div>

          <t:div styleClass="counters">
            <h:outputText value="Resp." />
            <h:outputText value="#{forumCatalogueBean.answerCount} " styleClass="counter"/>
            <h:outputText value="Lect." />
            <h:outputText value="#{row.question.readCount} " styleClass="counter" />
          </t:div>
        </t:div>
        <t:div styleClass="questionBody">
          <h:outputText value=" #{row.question.title}"
             styleClass="title"/>
        </t:div>

      </t:column>
      <t:column styleClass="normalQuestionsColumn"  style="width:18%">
        <t:div styleClass="buttonsBar">
          <h:commandButton value="#{objectBundle.show}"
              alt="#{objectBundle.show}"
              title="#{objectBundle.show}"
              styleClass="showButton" immediate="true"
              action="#{forumCatalogueBean.showQuestion}"/>
          <h:commandButton value="#{objectBundle.delete}"
              rendered="#{forumCatalogueBean.editorUser}"
              alt="#{objectBundle.delete}"
              title="#{objectBundle.delete}"
              styleClass="editButton" immediate="true"
              action="#{forumCatalogueBean.removeQuestion}"
              onclick="return confirm('#{objectBundle.confirm_remove}')"/>
        </t:div>
      </t:column>

      <f:facet name="footer">
        <t:dataScroller
          fastStep="100"
          paginator="true"
          paginatorMaxPages="20"
          immediate="true"
          styleClass="scrollBar"
          paginatorColumnClass="page"
          paginatorActiveColumnClass="activePage"
          nextStyleClass="nextButton"
          previousStyleClass="previousButton"
          firstStyleClass="firstButton"
          lastStyleClass="lastButton"
          fastfStyleClass="fastForwardButton"
          fastrStyleClass="fastRewindButton"
          renderFacetsIfSinglePage="false">
          <f:facet name="first">
            <h:graphicImage value="/themes/#{userSessionBean.theme}/images/first.png" alt="#{objectBundle.first}" title="#{objectBundle.first}"/>
          </f:facet>
          <f:facet name="last">
            <h:graphicImage value="/themes/#{userSessionBean.theme}/images/last.png" alt="#{objectBundle.last}" title="#{objectBundle.last}"/>
          </f:facet>
          <f:facet name="previous">
            <h:graphicImage value="/themes/#{userSessionBean.theme}/images/previous.png" alt="#{objectBundle.previous}" title="#{objectBundle.previous}"/>
          </f:facet>
          <f:facet name="next">
            <h:graphicImage value="/themes/#{userSessionBean.theme}/images/next.png" alt="#{objectBundle.next}" title="#{objectBundle.next}"/>
          </f:facet>
          <f:facet name="fastrewind">
            <h:graphicImage value="/themes/#{userSessionBean.theme}/images/fastrewind.png" alt="#{objectBundle.fastRewind}" title="#{objectBundle.fastRewind}"/>
          </f:facet>
          <f:facet name="fastforward">
            <h:graphicImage value="/themes/#{userSessionBean.theme}/images/fastforward.png" alt="#{objectBundle.fastForward}" title="#{objectBundle.fastForward}"/>
          </f:facet>
        </t:dataScroller>
      </f:facet>
    </t:dataTable>
   </t:buffer>

    <t:div styleClass="resultBar"
              rendered="#{forumCatalogueBean.questionsData.rows != null}">
      <t:dataScroller for="data"
        firstRowIndexVar="firstRow"
        lastRowIndexVar="lastRow"
        rowsCountVar="rowCount"
        rendered="#{forumCatalogueBean.questionsData.rowCount > 0}">
        <h:outputFormat value="#{forumBundle.questionsResultRange}"
          style="margin-top:10px;display:block">
          <f:param value="#{firstRow}" />
          <f:param value="#{lastRow}" />
          <f:param value="#{rowCount}" />
        </h:outputFormat>
      </t:dataScroller>
    </t:div>

    <h:outputText value="#{table}" escape="false" />

    <t:div style="margin-top:10px" styleClass="fieldName"
           rendered="#{!forumCatalogueBean.readOnly or forumCatalogueBean.editorUser}">
      <h:outputText value=" #{forumCatalogueBean.questionLabel}" />
    </t:div>

    <t:div rendered="#{!forumCatalogueBean.readOnly or forumCatalogueBean.editorUser}"
           styleClass="editingPanel">
      <t:div>
        <h:outputText value=" #{forumBundle.title}" styleClass="fieldName"/>
        <h:inputText value="#{forumCatalogueBean.currentQuestion.title}"
          styleClass="inputBox" style="width:99%"
          maxlength="1000"/>
      </t:div>
      <t:div>
        <h:outputText value="#{forumBundle.text}"
                      styleClass="fieldName"/>
        <t:inputTextarea value="#{forumCatalogueBean.currentQuestion.text}"
          styleClass="inputBox" style="width:99%" rows="4"
          onkeypress="checkMaxLength(this, 4000)" />
      </t:div>
      <t:div styleClass="actionsBar">
        <h:commandButton value="#{objectBundle.send}"
          alt="#{objectBundle.send}" title="#{objectBundle.send}"
          styleClass="createButton"
          action="#{forumCatalogueBean.createQuestion}" />
      </t:div>
      <t:inputHidden value="#{forumCatalogueBean.questionHash}" />      
    </t:div>

 </t:div>

</jsp:root>
