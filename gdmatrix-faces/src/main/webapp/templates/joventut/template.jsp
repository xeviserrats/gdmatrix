<?xml version='1.0' encoding='windows-1252'?>
 <jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
           xmlns:f="http://java.sun.com/jsf/core"
           xmlns:h="http://java.sun.com/jsf/html"
           xmlns:sf="http://www.santfeliu.org/jsf">

    <h:panelGrid columns="2" id="mainLayout" styleClass="main"
                 columnClasses="mainFirstColumn,mainSecondColumn"
                 rowClasses="mainRow1,mainRow2"
                 cellspacing="0" cellpadding="0">
      <f:facet name="header">
        <h:panelGrid columns="1" cellspacing="0" cellpadding="0" width="100%">
           <h:graphicImage style="border-style:none;margin:0px;padding:0px" width="100%"
                          url="#{userSessionBean.selectedMenuItem.properties.pantone}"/>      
        </h:panelGrid>
      </f:facet>

      <h:outputText value="" />
                       
      <h:panelGrid id="topMenu" columns="1" styleClass="hContainer">
        <h:panelGrid columns="1"
                     style="background-color: #{userSessionBean.selectedMenuItem.properties.darkColor}"
                     styleClass="navPath">
          <sf:navigationPath id="navPath" var="item" value="main"
                             baseMid="#{userSessionBean.selectedMenuItem.path[1]}">
            <f:facet name="separator">
              <h:outputText value="#{webBundle.facetSeparator}" />
            </f:facet>
            <f:facet name="menuitem">
              <sf:outputText value="#{item.label}"
                translator="#{userSessionBean.translator}"
                translationGroup="#{userSessionBean.translationGroup}" />
            </f:facet>
          </sf:navigationPath>
        </h:panelGrid>
        <sf:navigationMenu id="hmenu" var="item" value="main"
                           orientation="horizontal"
                           rendered="#{userSessionBean.selectedMenuItem.properties['menu.hmenu.render'] != 'false' 
                            and (userSessionBean.selectedMenuItem.depth > 3 
                            || (userSessionBean.selectedMenuItem.childCount > 0 
                            and userSessionBean.selectedMenuItem.depth == 3))}"
                           styleClass="hmenu"
                           selectedStyleClass="hmenu_selected"
                           unselectedStyleClass="hmenu_unselected">
          <sf:outputText value="#{item.label}"
                        rendered="#{item.rendered}"
                        translator="#{userSessionBean.translator}"
                        translationGroup="#{userSessionBean.translationGroup}" />
          <h:outputText styleClass="hmenu_separator"
                        style="color: #{userSessionBean.selectedMenuItem.properties.darkColor}"
                        value="|"
                        rendered="#{item.rendered}"/>
        </sf:navigationMenu>
        <f:facet name="footer">
          <h:panelGrid columns="1"
                       rendered="#{userSessionBean.selectedMenuItem.properties['menu.hmenu.render'] != 'false' 
                        and (userSessionBean.selectedMenuItem.depth > 3 
                        || (userSessionBean.selectedMenuItem.childCount > 0 
                        and userSessionBean.selectedMenuItem.depth == 3))}"
                       style="width:100%; background-color: #{userSessionBean.selectedMenuItem.properties.darkColor}"
                       styleClass="navPath">
            <h:outputText value=""/>
          </h:panelGrid>
        </f:facet>
      </h:panelGrid>
      <h:panelGrid columns="1" style="width:100%">
        <sf:navigationMenu id="vmenu" value="main" var="item"
                           baseMid="#{userSessionBean.selectedMenuItem.path[1]}"
                           orientation="vertical" styleClass="vmenu"
                           selectedStyleClass="#{item.properties.cjclass}_sel"
                           unselectedStyleClass="#{item.properties.cjclass}_unsel">
          <sf:outputText rendered="#{item.rendered}"
                        value="#{item.label}"
                        style="#{'margin-left:'}#{item.properties.indent}"
                        translator="#{userSessionBean.translator}"
                        translationGroup="#{userSessionBean.translationGroup}" />
        </sf:navigationMenu>
        
        <h:panelGrid columns="1" cellpadding="3"
                     rendered="#{userSessionBean.anonymousUser}"
                     styleClass="loginContainer">
          <h:outputText style="font-weight: bold" styleClass="userBar"
            value="#{webBundle.outputMessageNotConnected}" />
          <h:outputText value="#{webBundle.outputUsername}:" />
          <h:inputText binding="#{loginBean.usernameInputText}"
                       styleClass="loginBox" immediate="true"
                       tabindex="1" size="10" />
          <h:outputText value="#{webBundle.outputPassword}:" />
          <h:inputSecret binding="#{loginBean.passwordInputSecret}"
                         styleClass="loginBox" size="10" 
                         onkeypress="login(event)" immediate="true"
                         tabindex="2"/>
          <sf:secureCommandLink action="#{loginBean.login}" 
            styleClass="loginButton" function="login" immediate="true"
            port="#{applicationBean.serverSecurePort}" scheme="https">
            <h:outputText value="#{webBundle.buttonSignin}" />
          </sf:secureCommandLink>

          <h:outputText value="#{loginBean.loginMessage}"
                        rendered="#{loginBean.loginMessage != null}"
                        styleClass="errorMessage" />

          <h:panelGroup style="line-height:8pt">
          <h:outputText rendered="#{userSessionBean.anonymousUser}"
            style="font-weight: bold" styleClass="userBar" 
            value="#{webBundle.outputMessageInfo}" />
            <h:commandLink action="register" styleClass="buttonLink"
                           style="font-size: 7pt">
              <h:outputText value="#{webBundle.outputCreateAccount}" />
            </h:commandLink>              
          </h:panelGroup>
        </h:panelGrid>
        
        <h:panelGrid rendered="#{!userSessionBean.anonymousUser}"
                     columns="1" styleClass="loginContainer" cellpadding="3">

          <h:outputText value="#{webBundle.outputUsername}:"
                        style="text-align: left " />
          <h:outputText value="#{userSessionBean.displayName}"
                        style="text-align: right; font-weight: bold; color: red"/>

          <h:commandLink action="#{loginBean.logout}" 
            styleClass="loginButton" immediate="true">
            <h:outputText value="#{webBundle.buttonSignout}" />
          </h:commandLink>

          <h:commandLink action="password" styleClass="buttonLink">
            <h:outputText value="#{webBundle.outputChangePassword}" />
          </h:commandLink>
        </h:panelGrid>
        
        <h:panelGrid columns="1" styleClass="languageContainer">
        
          <h:outputText value="#{webBundle.language}:" />
          <sf:languageSelector locales="#{userSessionBean.supportedLocales}" />        
        </h:panelGrid>              
      </h:panelGrid>
      <h:panelGrid id="pageBody" columns="2"
                   columnClasses="bodyColumn,linksColumn">
        <h:panelGroup>
          <jsp:include page="${requestScope['_body']}" />                         
        </h:panelGroup>
        <h:panelGrid columns="1">
          <h:panelGroup>
            <h:outputText value="#{webBundle.outputLinks}"
                          styleClass="headLinks" />
          </h:panelGroup>
          <sf:navigationMenu id="linkmenu" value="main" var="item"
                             baseMid="#{userSessionBean.selectedMenuItem.properties.linkmid}"
                             orientation="vertical"
                             selectedStyleClass="lkmenu_selected"
                             unselectedStyleClass="lkmenu_unselected"
                             rendered="#{userSessionBean.selectedMenuItem.properties.linkmid!=null}">
            <h:panelGroup rendered="#{item.rendered}">
              <h:graphicImage url="/templates/joventut/images/punt.gif"
                            alt="" style="vertical-align:middle; margin-right:4px" />
              <sf:outputText value="#{item.label}"
                translator="#{userSessionBean.translator}"
                translationGroup="#{userSessionBean.translationGroup}" />
            </h:panelGroup>
          </sf:navigationMenu>
        </h:panelGrid>
      </h:panelGrid>
      <f:facet name="footer"/>
    </h:panelGrid>
</jsp:root>