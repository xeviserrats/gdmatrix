<?xml version='1.0' encoding='windows-1252'?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
          xmlns:f="http://java.sun.com/jsf/core"
          xmlns:h="http://java.sun.com/jsf/html"
          xmlns:sf="http://www.santfeliu.org/jsf"
          xmlns:t="http://myfaces.apache.org/tomahawk">
  
  <h:panelGrid id="mainLayout" columns="2" 
               styleClass="main" 
               rowClasses="row"
               cellspacing="0"
               cellpadding="0"
               columnClasses="treeCol,contCol" 
               headerClass="header"
               footerClass="footer" 
               width="100%">

    <f:facet name="header">
      <h:panelGrid columns="2" width="100%" columnClasses="hcol1, hcol2">
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
    </f:facet>

    <t:div id="wikiTreeLayer" styleClass="wikiTreeLayer">
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
    </t:div>

    <h:panelGrid columns="1" width="100%" cellpadding="0" cellspacing="0"
      styleClass="contPanel" rowClasses="path, content">
      <sf:navigationPath id="navPath"
                         var="item"
                         value="main"
                         baseMid="#{userSessionBean.selectedMenuItem.path[1]}"
                         styleClass="navPath">
        <f:facet name="separator">
          <h:outputText value=" / " />
        </f:facet>
        <f:facet name="menuitem">
          <sf:outputText value="#{item.label}"
            translator="#{userSessionBean.translator}"
            translationGroup="#{userSessionBean.translationGroup}" />
        </f:facet>
      </sf:navigationPath>

      <t:div id="bodyLayer" styleClass="bodyLayer">
        <h:panelGrid columns="1" width="98%">
          <jsp:include page="${requestScope['_body']}"/>
        </h:panelGrid>
      </t:div>
      
    </h:panelGrid>

  </h:panelGrid>
  <f:verbatim>
    <script type="text/javascript">
      function findPos(obj) 
      {
        var curleft = curtop = 0;
        if (obj.offsetParent) 
        {
          curleft = obj.offsetLeft
          curtop = obj.offsetTop
          while (obj = obj.offsetParent) 
          {
            curleft += obj.offsetLeft
            curtop += obj.offsetTop
          }
        }
        return [curleft,curtop];
      } 
            
      function resizeLayers()
      {
        var wikiTreeLayer = document.getElementById('mainform:wikiTreeLayer');    
        var bodyLayer = document.getElementById('mainform:bodyLayer');
        var windowWidth;
        var windowHeight;
        
        if( typeof( window.innerWidth ) == 'number' )
        {
          windowWidth = window.innerWidth;
          windowHeight = window.innerHeight;
        }
        else
        {
          windowWidth = document.documentElement.clientWidth;
          windowHeight = document.documentElement.clientHeight;
        }
        
        var posTreeLayer = findPos(wikiTreeLayer);
        wikiTreeLayer.style.width = 
           windowWidth * 0.25 + 'px';
        wikiTreeLayer.style.height = 
           windowHeight - posTreeLayer[1] + 'px';
      
        var posBodyLayer = findPos(bodyLayer);
        bodyLayer.style.width = 
          windowWidth - posBodyLayer[0] + 'px';
        bodyLayer.style.height = 
          windowHeight - posBodyLayer[1] + 'px';
          
        window.onresize = resizeLayers;          
      }
      
      window.onload = resizeLayers;
    </script>
  </f:verbatim>
</jsp:root>
