<?xml version='1.0' encoding='windows-1252'?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
          xmlns:f="http://java.sun.com/jsf/core"
          xmlns:h="http://java.sun.com/jsf/html"
          xmlns:sf="http://www.santfeliu.org/jsf"
          xmlns:t="http://myfaces.apache.org/tomahawk">

  <h:panelGrid columns="2" width="100%" columnClasses="hcol1, hcol2" style="background:yellow">
    <h:graphicImage
      url="#{userSessionBean.selectedMenuItem.properties.bannerURI}"
      alt="#{userSessionBean.selectedMenuItem.properties.bannerAlt}" />

    <h:panelGrid columns="1" width="100%">
      <sf:languageSelector locales="#{userSessionBean.supportedLocales}"
        style="margin-right:4px;vertical-align:middle"
        rendered="#{userSessionBean.languageSelectionEnabled}" />

      <h:panelGroup rendered="#{userSessionBean.anonymousUser}">
      <sf:commandMenu value="#{userSessionBean.theme}"
        rendered="#{userSessionBean.themeSelectionEnabled}"
        style="margin-right:4px;vertical-align:middle">
        <f:selectItems value="#{userSessionBean.themes}" />
      </sf:commandMenu>
      <h:outputText value="#{webBundle.outputUsername}"
        style="margin-right:4px" styleClass="loginText" />
      <h:inputText binding="#{loginBean.usernameInputText}"
                   tabindex="1" size="10" immediate="true"
                   onkeypress="login(event)"
                   styleClass="loginBox" />
      <h:outputText value="#{webBundle.outputPassword}"
                    style="margin-left:4px; margin-right:4px"
                    styleClass="loginText" />
      <h:inputSecret binding="#{loginBean.passwordInputSecret}"
                     tabindex="2" size="10" immediate="true"
                     onkeypress="login(event)"
                     styleClass="loginBox" />
      <sf:secureCommandLink id="loginbutton" style="margin-left:4px"
        action="#{loginBean.login}" function="login" immediate="true"
        port="#{applicationBean.serverSecurePort}" scheme="https">
        <h:graphicImage url="/templates/wiki/images/button.gif" alt="login"
          style="border-style:none;vertical-align:middle" />
      </sf:secureCommandLink>
    </h:panelGroup>

    <h:panelGroup rendered="#{not userSessionBean.anonymousUser}">
      <h:outputText value="#{webBundle.outputUsername}"
        styleClass="loginText" />
      <h:outputText value="#{userSessionBean.displayName} "
        styleClass="displayNameText" style="margin-left:4px" />

      <h:commandLink action="#{loginBean.logout}"
         rendered="#{not userSessionBean.anonymousUser}"
         styleClass="loginCommand" immediate="true">
        <h:outputText value="[#{webBundle.buttonSignout}]" />
      </h:commandLink>
    </h:panelGroup>

      <f:facet name="footer">
       <h:outputText value="#{loginBean.loginMessage}"
          rendered="#{loginBean.loginMessage != null}"
          styleClass="errorMessage" />
      </f:facet>
    </h:panelGrid>
  </h:panelGrid>

  <sf:splitter orientation="horizontal" stretch="none"
    style="border:20px solid blue;width:1000px;height:200px;display:inline-block;"
    firstStyle="background:yellow;float:left;overflow:auto;border-right:40px solid black;height:100%"
    lastStyle="background:orange;float:left;overflow:auto;height:100%">
    <f:facet name="first">
      <sf:treeMenu var="item"
                   baseMid="#{userSessionBean.selectedMenuItem.path[1]}"
                   expandedMenuItems="#{userSessionBean.attributes.wikiExpandedNodes}"
                   styleClass="wikiTree"
                   expandImageUrl="/images/expand.gif"
                   collapseImageUrl="/images/collapse.gif">
        <f:facet name="data">
          <h:outputLink value="#{item.actionURL}"
            onclick="#{item.onclick}"
            target="#{item.target}" styleClass="wikiTopic"
            rendered="#{item.rendered}">
            <sf:outputText value="#{item.label}"
              styleClass="#{userSessionBean.menuModel.selectedMid == item.mid ? 'selected' : 'unselected'}"
              translator="#{userSessionBean.translator}"
              translationGroup="#{userSessionBean.translationGroup}" />
          </h:outputLink>
        </f:facet>
      </sf:treeMenu>
    </f:facet>
    <f:facet name="last">
      <h:panelGroup style="display:block">
        <jsp:include page="${requestScope['_body']}"/>
      </h:panelGroup>
    </f:facet>
  </sf:splitter>
  <f:verbatim>
    <div>
    Container:<input id="cwidth" name="cwidth" type="text" /><br/>
    Position:<input id="position" name="position" type="text" /><br/>
    X-Position:<input id="xposition" name="xposition" type="text" /><br/>
    </div>
  </f:verbatim>

</jsp:root>
