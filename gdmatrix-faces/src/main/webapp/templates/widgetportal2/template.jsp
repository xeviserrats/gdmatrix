<?xml version='1.0' encoding='windows-1252'?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
          xmlns:f="http://java.sun.com/jsf/core"
          xmlns:h="http://java.sun.com/jsf/html"
          xmlns:t="http://myfaces.apache.org/tomahawk"
          xmlns:sf="http://www.santfeliu.org/jsf"
          xmlns:c="http://java.sun.com/jsp/jstl/core">

  <!-- TOP BAR -->

  <h:outputText value="&lt;header id='wp2_header' aria-label='#{webBundle.mainHeader}'&gt;" escape="false"/>  

  <t:div styleClass="topBar #{userSessionBean.selectedMenuItem.properties.layout}">

    <t:div styleClass="centralArea">
      <t:div styleClass="item logo" rendered="#{userSessionBean.layout == 'fullscreen'}">
        <sf:outputLink value="#{userSessionBean.selectedMenuItem.properties.headerLinkURL == null ?
          '#' : userSessionBean.selectedMenuItem.properties.headerLinkURL}"
          title="#{userSessionBean.selectedMenuItem.properties.headerLogoTitle}"
          translator="#{userSessionBean.translator}"
          translationGroup="#{userSessionBean.translationGroup}">
          <sf:graphicImage url="#{userSessionBean.selectedMenuItem.properties.headerLogoURL}"            
            alt="#{userSessionBean.selectedMenuItem.properties.headerLogoTitle}"
            translator="#{userSessionBean.translator}"
            translationGroup="#{userSessionBean.translationGroup}" />
        </sf:outputLink>
      </t:div>

      <t:div id="templateSkipTop" forceId="true" styleClass="item skipDiv">
        <h:outputLink value="#sf_main_content" 
                      title="#{webBundle.skipToContent}"
                      rendered="#{userSessionBean.selectedMenuItem.properties.skipToContentIconURL != null}">
          <t:graphicImage url="#{userSessionBean.selectedMenuItem.properties.skipToContentIconURL}"
                          alt="#{webBundle.skipToContent}" />          
        </h:outputLink>
      </t:div>

      <t:div styleClass="item clock">
        <sf:clock />
      </t:div>

      <sf:heading level="2" styleClass="element-invisible">
        <sf:outputText value="#{webBundle.language}" />
      </sf:heading>
      <t:div styleClass="item language">
        <f:verbatim>
          <noscript>
          <h3 class="element-invisible">catala</h3>
          <a href='/go.faces?language=ca'>ca </a>
          <h3 class="element-invisible">castellano</h3>
          <a href='/go.faces?language=es'>es </a>
          <h3 class="element-invisible">english</h3>
          <a href='/go.faces?language=en'>en </a>            
          </noscript>
        </f:verbatim>
        <t:div id="languageSelectorDescription" forceId="true" style="visibility:hidden;">
          <sf:outputLink id="languageSelectorLink" styleClass="selectedLanguage" 
            onclick="return tooglePanelVisibility('languageSelector','#{webBundle.languageSelectorShowMessage}','#{webBundle.languageSelectorHideMessage}');" 
                         ariaLabel="#{userSessionBean.viewLanguage == 'es' ? 'castellano' : userSessionBean.currentLocaleDescription}, #{webBundle.languageSelectorShowMessage}"
                         translator="#{userSessionBean.translator}"
                         translationGroup="#{userSessionBean.translationGroup}">           
            <h:outputText value="#{userSessionBean.viewLanguage == 'es' ? 'castellano' : userSessionBean.currentLocaleDescription}" />
          </sf:outputLink> 
        </t:div>
        <t:div id="languageSelector" forceId="true" style="display:none">
          <t:dataList var="locale" value="#{userSessionBean.unselectedLocales}" layout="unorderedList">
            <t:div styleClass="languageItem">
              <h:commandLink action="#{userSessionBean.changeLanguage}" lang="#{locale.language}">
                <h:outputText value="#{locale.language == 'es' ? 'castellano' : userSessionBean.localeRowDescription}" />
              </h:commandLink>
            </t:div>
          </t:dataList>
        </t:div>
      </t:div>

      <sf:heading level="2" styleClass="element-invisible">
        <sf:outputText value="#{userSessionBean.selectedMenuItem.properties.identificationMessage}"
                       translator="#{userSessionBean.translator}"
                       translationGroup="#{userSessionBean.translationGroup}" />
      </sf:heading>
      <t:div styleClass="item login"
             rendered="#{userSessionBean.selectedMenuItem.properties.loginEnabled == null ||
                         userSessionBean.selectedMenuItem.properties.loginEnabled == 'true'}">

        <!-- new login/logout buttons -->

        <sf:outputLink id="loginPanelLink" value="#{loginBean.loginURL}" 
          onclick="return tooglePanelVisibility('loginPanel', '#{webBundle.identificationPanelShowMessage}','#{webBundle.identificationPanelHideMessage}');"
                       ariaLabel="#{userSessionBean.selectedMenuItem.properties.identificationMessage}, #{webBundle.identificationPanelShowMessage}"                       
                       translator="#{userSessionBean.translator}"
                       translationGroup="#{userSessionBean.translationGroup}">
          <sf:outputText value="#{userSessionBean.selectedMenuItem.properties.identificationMessage}"
                         translator="#{userSessionBean.translator}" rendered="#{userSessionBean.anonymousUser}"
                         translationGroup="#{userSessionBean.translationGroup}" />
          <h:outputText value="#{userSessionBean.displayName}" rendered="#{not userSessionBean.anonymousUser}" />
        </sf:outputLink>                       

        <t:div id="loginPanel" forceId="true" style="display:none">
          <t:div id="errorMessage" forceId="true">
            <h:outputText value="#{loginBean.loginMessage}" />
          </t:div>

          <t:div styleClass="loginBox password" 
                 rendered="#{userSessionBean.anonymousUser or userSessionBean.loginMethod == 'PASSWORD'}">
            <t:div styleClass="headerLine">
              <sf:outputText value="#{userSessionBean.selectedMenuItem.properties.login_password}" 
                             translator="#{userSessionBean.translator}" 
                             translationGroup="login" />
            </t:div>
            <t:div styleClass="subHeaderLine" rendered="#{userSessionBean.anonymousUser}">
              <sf:outputText value="#{userSessionBean.selectedMenuItem.properties.login_password_info}" 
                             translator="#{userSessionBean.translator}" 
                             translationGroup="login" />
            </t:div>
            <t:div rendered="#{userSessionBean.anonymousUser}">
              <t:div styleClass="inputLine">
                <h:outputLabel for="userBox"
                               value="#{webBundle.outputUsername}:" styleClass="loginText" />
                <h:inputText binding="#{loginBean.usernameInputText}"
                             size="10" immediate="true"
                             onkeypress="login(event)"
                             id="userBox" />
              </t:div>
              <t:div styleClass="inputLine">
                <h:outputLabel for="passwordBox"
                               value="#{webBundle.outputPassword}:" styleClass="loginText" />
                <h:inputSecret binding="#{loginBean.passwordInputSecret}"
                               size="10" immediate="true"
                               onkeypress="login(event)"
                               id="passwordBox" />
              </t:div>
              <t:div>
                <sf:secureCommandLink id="loginbutton" 
                                      styleClass="loginButton"
                                      action="#{loginBean.login}" function="login" immediate="true"
                                      port="#{applicationBean.serverSecurePort}" scheme="https"
                                      role="button" ariaLabel="#{webBundle.buttonSigninUserPass}">
                  <h:outputText value="#{webBundle.buttonSignin}" />
                </sf:secureCommandLink>
              </t:div>
              <t:div rendered="#{userSessionBean.selectedMenuItem.properties.login_password_register_url != null}">
                <sf:outputLink value="#{userSessionBean.selectedMenuItem.properties.login_password_register_url}" 
                               styleClass="loginButton" role="button"
                               ariaLabel="#{userSessionBean.selectedMenuItem.properties.login_password_register_text_aria}"
                               translator="#{userSessionBean.translator}"
                               translationGroup="login">
                  <sf:outputText value="#{userSessionBean.selectedMenuItem.properties.login_password_register_text}" 
                                 translator="#{userSessionBean.translator}"
                                 translationGroup="login" />
                </sf:outputLink>
              </t:div>
              <t:div rendered="#{userSessionBean.selectedMenuItem.properties.login_password_restore_url != null}">
                <h:outputLink value="#{userSessionBean.selectedMenuItem.properties.login_password_restore_url}" 
                              styleClass="loginButton">
                  <sf:outputText value="#{userSessionBean.selectedMenuItem.properties.login_password_restore_text}" 
                                 translator="#{userSessionBean.translator}"
                                 translationGroup="login" />
                </h:outputLink>
              </t:div>
            </t:div>
            <t:div rendered="#{not userSessionBean.anonymousUser}">
              <t:div rendered="#{userSessionBean.selectedMenuItem.properties.login_password_change_url != null}">
                <h:outputLink value="#{userSessionBean.selectedMenuItem.properties.login_password_change_url}" 
                              styleClass="loginButton">
                  <sf:outputText value="#{userSessionBean.selectedMenuItem.properties.login_password_change_text}" 
                                 translator="#{userSessionBean.translator}"
                                 translationGroup="login" />
                </h:outputLink>
              </t:div>          
            </t:div>
          </t:div>

          <t:div styleClass="loginBox certificate" 
                 rendered="#{userSessionBean.anonymousUser or userSessionBean.loginMethod == 'CERTIFICATE'}">
            <t:div styleClass="headerLine">
              <sf:outputText value="#{userSessionBean.selectedMenuItem.properties.login_certificate}" 
                             translator="#{userSessionBean.translator}"
                             translationGroup="login" />
            </t:div>
            <t:div styleClass="subHeaderLine" rendered="#{userSessionBean.anonymousUser}">
              <sf:outputText value="#{userSessionBean.selectedMenuItem.properties.login_certificate_info}" 
                             translator="#{userSessionBean.translator}" 
                             translationGroup="login" />
            </t:div>                
            <t:div rendered="#{userSessionBean.anonymousUser}">
              <t:div>
                <sf:secureCommandLink
                  action="#{loginBean.loginCertificate}" immediate="true"
                  scheme="https" port="#{applicationBean.clientSecurePort}" styleClass="loginButton">
                  <h:outputText value="#{webBundle.certificateAuthentication}"  />
                </sf:secureCommandLink>
              </t:div>
              <t:div rendered="#{userSessionBean.selectedMenuItem.properties.login_certificate_get_url != null}">
                <h:outputLink value="#{userSessionBean.selectedMenuItem.properties.login_certificate_get_url}" 
                              styleClass="loginButton">
                  <sf:outputText value="#{userSessionBean.selectedMenuItem.properties.login_certificate_get_text}" 
                                 translator="#{userSessionBean.translator}"
                                 translationGroup="login" />
                </h:outputLink>
              </t:div>
            </t:div>
          </t:div>

          <t:div styleClass="loginBox valid" 
                 rendered="#{(userSessionBean.intranetUser or userSessionBean.selectedMenuItem.properties.login_valid_enabled == 'true') and 
                             userSessionBean.anonymousUser or userSessionBean.loginMethod == 'VALID'}">
            <t:div styleClass="headerLine">
              <sf:outputText value="#{userSessionBean.selectedMenuItem.properties.login_valid}" 
                             translator="#{userSessionBean.translator}"
                             translationGroup="login" />
            </t:div>
            <t:div styleClass="subHeaderLine" rendered="#{userSessionBean.anonymousUser}">
              <sf:outputText value="#{userSessionBean.selectedMenuItem.properties.login_valid_info}" 
                             translator="#{userSessionBean.translator}" 
                             translationGroup="login" />
            </t:div>                
            <t:div rendered="#{userSessionBean.anonymousUser}">
              <t:div>
                <sf:outputLink value="#{validBean.loginURL}" styleClass="loginButton"
                               ariaLabel="#{webBundle.buttonSigninValid}">
                  <h:outputText value="#{webBundle.buttonSignin}" />
                </sf:outputLink>
              </t:div>
              <t:div rendered="#{userSessionBean.selectedMenuItem.properties.login_valid_register_url != null}">
                <sf:outputLink value="#{userSessionBean.selectedMenuItem.properties.login_valid_register_url}" 
                               styleClass="loginButton" target="valid"
                               ariaLabel="#{userSessionBean.selectedMenuItem.properties.login_valid_register_text_aria}"
                               translator="#{userSessionBean.translator}"
                               translationGroup="login">
                  <sf:outputText value="#{userSessionBean.selectedMenuItem.properties.login_valid_register_text}" 
                                 translator="#{userSessionBean.translator}"
                                 translationGroup="login" />
                </sf:outputLink>
              </t:div>
            </t:div>
          </t:div>

          <t:div styleClass="loginBox mobileid" 
                 rendered="#{(userSessionBean.intranetUser or userSessionBean.selectedMenuItem.properties.login_mobileid_enabled == 'true') and 
                             userSessionBean.anonymousUser or userSessionBean.loginMethod == 'MOBILEID'}">
            <t:div styleClass="headerLine">
              <sf:outputText value="#{userSessionBean.selectedMenuItem.properties.login_mobileid}" 
                             translator="#{userSessionBean.translator}"
                             translationGroup="login" />
            </t:div>
            <t:div styleClass="subHeaderLine" rendered="#{userSessionBean.anonymousUser}">
              <sf:outputText value="#{userSessionBean.selectedMenuItem.properties.login_mobileid_info}" 
                             translator="#{userSessionBean.translator}" 
                             translationGroup="login" />
            </t:div>                
            <t:div rendered="#{userSessionBean.anonymousUser}">
              <t:div>
                <sf:outputLink value="#{mobileIdBean.loginURL}" styleClass="loginButton"
                               ariaLabel="#{webBundle.buttonSigninMobileId}">
                  <h:outputText value="#{webBundle.buttonSignin}" />
                </sf:outputLink>
              </t:div>
              <t:div rendered="#{userSessionBean.selectedMenuItem.properties.login_mobileid_register_url != null}">
                <sf:outputLink value="#{userSessionBean.selectedMenuItem.properties.login_mobileid_register_url}" 
                               styleClass="loginButton" target="mobileid"
                               ariaLabel="#{userSessionBean.selectedMenuItem.properties.login_mobileid_register_text_aria}"
                               translator="#{userSessionBean.translator}"
                               translationGroup="login">
                  <sf:outputText value="#{userSessionBean.selectedMenuItem.properties.login_mobileid_register_text}" 
                                 translator="#{userSessionBean.translator}"
                                 translationGroup="login" />
                </sf:outputLink>
              </t:div>
            </t:div>
          </t:div>

          <!-- logout button -->
          <t:div styleClass="loginBox logout" rendered="#{not userSessionBean.anonymousUser}">
            <t:div>
              <h:commandLink action="#{loginBean.logout}"                 
                             immediate="true" styleClass="loginButton">
                <h:outputText value="#{webBundle.buttonSignout}" />
              </h:commandLink>
            </t:div>
          </t:div>
        </t:div>          
      </t:div>
    </t:div>

  </t:div>

  <t:div id="topPanel" rendered="#{userSessionBean.layout != 'fullscreen'}">

    <!-- HEADER BAR -->

    <t:div styleClass="headerBar">
      <t:div styleClass="leftArea">
        <sf:outputLink value="#{userSessionBean.selectedMenuItem.properties.homeURL}"
                       title="#{userSessionBean.selectedMenuItem.properties.homeTitle}"                           
                       translator="#{userSessionBean.translator}"
                       translationGroup="#{userSessionBean.translationGroup}">
          <sf:graphicImage url="#{userSessionBean.selectedMenuItem.properties.logoURL != null ? 
                                  userSessionBean.selectedMenuItem.properties.logoURL : '/templates/widgetportal2/images/escut.png'}" 
                           alt="#{userSessionBean.selectedMenuItem.properties.homeTitle}"                           
                           translator="#{userSessionBean.translator}"
                           translationGroup="#{userSessionBean.translationGroup}" />
        </sf:outputLink>
      </t:div>
      <t:div styleClass="rightArea">

        <sf:heading level="2" styleClass="element-invisible">
          <h:outputText value="#{webBundle.globalSearch}" />          
        </sf:heading>
        <t:div styleClass="searchArea">
          <t:outputLabel for="checkedTextField" 
                         value="#{webBundle.globalSearch}" 
                         styleClass="element-invisible" />              
          <t:inputText id="checkedTextField"
                       title="#{webBundle.globalSearch}"
                       onkeypress="inputTextKeyCheck(event, 'mainform:templateSearchButton');"
                       value="#{webSearchBean.outerWords}" />
          <sf:commandButton id="templateSearchButton" styleClass="templateSearchButton"
                            value="#{userSessionBean.selectedMenuItem.properties.searchButtonText}"
                            title="#{userSessionBean.selectedMenuItem.properties.searchButtonDescription != null ? 
                                     userSessionBean.selectedMenuItem.properties.searchButtonDescription : 'Cercador global'}"
                            action="#{webSearchBean.outerSearch}"
                            translator="#{userSessionBean.translator}"
                            translationGroup="#{userSessionBean.translationGroup}" />
        </t:div>

        <sf:heading level="2" styleClass="element-invisible">
          <h:outputText value="#{webBundle.topMenu}" />
        </sf:heading>        
        <sf:treeMenu styleClass="topMenu" var="item"
                     baseMid="#{userSessionBean.selectedMenuItem.properties.headerMenuMid}"
          headingsRender="true" headingsBaseLevel="2">
          <f:facet name="data">
            <sf:outputLink value="#{item.actionURL}"
                           onclick="#{item.onclick}" target="#{item.target}"
                           rendered="#{item.rendered}" 
                           ariaLabel="#{item.directProperties.ariaLabel}"
                           ariaHidden="#{item.directProperties.ariaHidden == 'true'}"              
                           translator="#{userSessionBean.translator}"
                           translationGroup="#{userSessionBean.translationGroup}">
              <h:graphicImage url="/documents/#{item.properties.iconDocId}"
                              alt=""
                              rendered="#{item.properties.iconDocId != null}"/>
              <sf:outputText styleClass="button_label" value="#{item.label}"
                             translator="#{userSessionBean.translator}"
                             translationGroup="#{userSessionBean.translationGroup}" />
            </sf:outputLink>              
          </f:facet>
        </sf:treeMenu>

        <sf:heading level="2" styleClass="element-invisible">
          <h:outputText value="#{webBundle.mainMenu}" />
        </sf:heading>                

        <sf:treeMenu styleClass="mainMenu" var="item"
                     baseMid="#{userSessionBean.selectedMenuItem.cursorPath[1].mid}"
                     menuStyleClass="#{item.properties.menuStyleClass}"
                     expandDepth="3" headingsRender="false" headingsBaseLevel="2"
                     enableDropdownButton="#{item.properties.enableMenuDropdownButton}">
          <f:facet name="data">
            <sf:outputLink value="#{item.actionURL}"
                           onclick="#{item.onclick}" target="#{item.target}"
                           rendered="#{item.rendered}" 
                           ariaLabel="#{item.directProperties.ariaLabel}"
                           ariaHidden="#{item.directProperties.ariaHidden == 'true'}"
                           translator="#{userSessionBean.translator}"
                           translationGroup="#{userSessionBean.translationGroup}">
              <sf:outputText value="#{item.label}"
                             translator="#{userSessionBean.translator}"
                             translationGroup="#{userSessionBean.translationGroup}" />
            </sf:outputLink>
          </f:facet>
        </sf:treeMenu>

      </t:div>
    </t:div>

    <t:div styleClass="separator" />

  </t:div>

  <h:outputText value="&lt;/header&gt;" escape="false"/>

  <t:div styleClass="body #{userSessionBean.layout}">
    <c:if test="${userSessionBean.layout != null}">
      <jsp:include page="${userSessionBean.layout}.jsp" />
    </c:if>
  </t:div>

  <t:div id="bottomPanel"
         rendered="#{userSessionBean.selectedMenuItem.properties.layout != 'fullscreen'}">

    <h:outputText value="&lt;footer id='wp2_footer' aria-label='#{webBundle.mainFooter}'&gt;" escape="false"/>

    <t:div styleClass="separator" />

    <!-- FOOTER BAR -->
    <sf:heading level="1" styleClass="element-invisible">
      <h:outputText value="Sitemap" />
    </sf:heading> 
    <t:div styleClass="footerBar">
      <t:div styleClass="leftArea">
        <sf:treeMenu styleClass="sideMenu" var="item"
                     baseMid="#{userSessionBean.selectedMenuItem.properties.footerLeftMenuMid}"
                     expandDepth="1" headingsRender="false" headingsBaseLevel="3">
          <f:facet name="data">
            <sf:outputLink value="#{item.actionURL}"
                           onclick="#{item.onclick}" target="#{item.target}"
                           rendered="#{item.rendered and item.properties.onFooterMenu}"
                           ariaLabel="#{item.directProperties.ariaLabel}"
                           ariaHidden="#{item.directProperties.ariaHidden == 'true'}"
                           translator="#{userSessionBean.translator}"
                           translationGroup="#{userSessionBean.translationGroup}">
              <sf:outputText value="#{item.label}"
                             translator="#{userSessionBean.translator}"
                             translationGroup="#{userSessionBean.translationGroup}" />
            </sf:outputLink>
          </f:facet>
        </sf:treeMenu>
      </t:div>

      <t:div styleClass="centralArea">
        <sf:heading level="2" styleClass="element-invisible">
          <h:outputText value="#{webBundle.snMenu}" />
        </sf:heading>                        
        <sf:treeMenu styleClass="snMenu" var="item"
                     baseMid="#{userSessionBean.selectedMenuItem.properties.snMenuMid}"
                     expandDepth="1" headingsRender="false" headingsBaseLevel="3">
          <f:facet name="data">
            <sf:outputLink value="#{item.actionURL}"
                           onclick="#{item.onclick}"
                           target="#{item.target == null ? 'blank' : item.target}"
                           rendered="#{item.rendered and item.properties.onSnMenu}"
                           translator="#{userSessionBean.translator}"
                           translationGroup="#{userSessionBean.translationGroup}"
                           title="#{item.directProperties.title}"
                           ariaHidden="#{item.directProperties.ariaHidden == 'true'}">
              <sf:graphicImage alt="#{item.directProperties.title}"
                               url="#{item.properties.imageURL}" 
                               translator="#{userSessionBean.translator}"
                               translationGroup="#{userSessionBean.translationGroup}" />
            </sf:outputLink>
          </f:facet>
        </sf:treeMenu>
        <sf:treeMenu styleClass="contactsMenu" var="item"
                     baseMid="#{userSessionBean.selectedMenuItem.properties.contactsMenuMid}"
                     expandDepth="1" headingsRender="false" headingsBaseLevel="3">
          <f:facet name="data">
            <sf:outputText value="#{item.label}"
                           translator="#{userSessionBean.translator}"
                           translationGroup="#{userSessionBean.translationGroup}"
                           rendered="#{item.rendered}" />
          </f:facet>
        </sf:treeMenu>
        <sf:treeMenu styleClass="centralMenu" var="item"
                     baseMid="#{userSessionBean.selectedMenuItem.properties.footerCentralMenuMid}"
                     expandDepth="1" headingsRender="false" headingsBaseLevel="3">
          <f:facet name="data">
            <sf:outputLink value="#{item.actionURL}"
                           onclick="#{item.onclick}" target="#{item.target}"
                           rendered="#{item.rendered}" 
                           ariaLabel="#{item.directProperties.ariaLabel}"
                           ariaHidden="#{item.directProperties.ariaHidden == 'true'}"              
                           translator="#{userSessionBean.translator}"
                           translationGroup="#{userSessionBean.translationGroup}">
              <sf:outputText value="#{item.label}"
                             translator="#{userSessionBean.translator}"
                             translationGroup="#{userSessionBean.translationGroup}" />
            </sf:outputLink>              
          </f:facet>
        </sf:treeMenu>
        <sf:outputLink rendered="#{userSessionBean.selectedMenuItem.properties.mobileBrowserLabel != null}"
                       value="/go.faces?xmid=#{userSessionBean.selectedMenuItem.mid}&amp;btype=mobile"
                       styleClass="mobileBrowserLink"
                       ariaHidden="true">
          <sf:outputText value="#{userSessionBean.selectedMenuItem.properties.mobileBrowserLabel}"
                         translator="#{userSessionBean.translator}"
                         translationGroup="#{userSessionBean.translationGroup}" />
        </sf:outputLink>        
      </t:div>

      <t:div styleClass="rightArea">
        <sf:treeMenu styleClass="sideMenu" var="item"
                     baseMid="#{userSessionBean.selectedMenuItem.properties.footerRightMenuMid}"
                     expandDepth="1" headingsRender="false" headingsBaseLevel="3">
          <f:facet name="data">
            <sf:outputLink value="#{item.actionURL}"
                           onclick="#{item.onclick}" target="#{item.target}"
                           rendered="#{item.rendered and item.properties.onFooterMenu}"
                           ariaLabel="#{item.directProperties.ariaLabel}"
                           ariaHidden="#{item.directProperties.ariaHidden == 'true'}"              
                           translator="#{userSessionBean.translator}"
                           translationGroup="#{userSessionBean.translationGroup}">
              <sf:outputText value="#{item.label}"
                             translator="#{userSessionBean.translator}"
                             translationGroup="#{userSessionBean.translationGroup}" />
            </sf:outputLink>              
          </f:facet>
        </sf:treeMenu>
      </t:div>
    </t:div>

    <t:div id="testFontSizeDiv" forceId="true" 
           style="visibility: hidden; position: absolute">
      <h:outputText value="A B C" />
    </t:div>

    <h:outputText value="&lt;/footer&gt;" escape="false"/>
  </t:div>

  <h:outputText value="&lt;nav id='wp2_nav_skipBottom' aria-label='#{webBundle.skipToTop}'&gt;" escape="false"/>  
  <t:div id="templateSkipBottom" forceId="true" styleClass="skipDiv hide">
    <h:outputLink value="#topframe_header"
                  title="#{webBundle.skipToTop}"
                  rendered="#{userSessionBean.selectedMenuItem.properties.skipToTopIconURL != null}">
      <t:graphicImage url="#{userSessionBean.selectedMenuItem.properties.skipToTopIconURL}"
                      alt="#{webBundle.skipToTop}" />          
    </h:outputLink>
  </t:div>
  <h:outputText value="&lt;/nav&gt;" escape="false"/>  

  <f:verbatim>
    <script type="text/javascript">
      makeLanguageSelectorVisible();
      function showLogingPanelOnError()
      {
        var elem = document.getElementById("errorMessage");
        if (elem)
        {
          if (elem.innerHTML != '')
            tooglePanelVisibility('loginPanel');
        }
      }

      function tooglePanelVisibility(panelName, visibleAriaLabel, hiddenAriaLabel)
      {
        var panel = document.getElementById(panelName);
        var visible = panel.style.display != 'none';
        panel.style.display = visible ? "none" : "block";
        var panelLink = document.getElementById(panelName + "Link");
        var ariaLabel = panelLink.getAttribute("aria-label");
        ariaLabel = ariaLabel != null ? ariaLabel.substr(0, ariaLabel.indexOf(",") + 1) : ariaLabel;
        panelLink.setAttribute('aria-label', ariaLabel + " " + (visible ? visibleAriaLabel : hiddenAriaLabel));
        return false;
      }

      function renderDropDownButtons()
      {
        var menuItems = document.querySelectorAll('.mainMenu li.has-children');
        Array.prototype.forEach.call(menuItems, function (el, i)
        {
/*          
          var activatingA = el.querySelector('a');
          var btn = '<button><span><span class="visuallyhidden">show submenu for "' + activatingA.text + '"</span></span></button>';
          activatingA.insertAdjacentHTML('afterend', btn);
*/
          var ddbutton = el.querySelector('button');  
          if (ddbutton != null)
          {
            ddbutton.addEventListener("click", function (event)
            {
              var doOpen = false;
              if (this.parentNode.className == "has-children" || this.parentNode.className == " has-children") {
                doOpen = true;
              }

              var others = this.parentNode.parentNode.querySelectorAll('li.has-children.open');
              Array.prototype.forEach.call(others, function (otr) {
                otr.className = "has-children";
                otr.querySelector('a').setAttribute('aria-expanded', "false");
                otr.querySelector('button').setAttribute('aria-expanded', "false");
              });

              if (doOpen)
              {
                this.parentNode.className = "has-children open";
                this.parentNode.querySelector('a').setAttribute('aria-expanded', "true");
                this.parentNode.querySelector('button').setAttribute('aria-expanded', "true");
              } else
              {
                this.parentNode.className = "has-children";
                this.parentNode.querySelector('a').setAttribute('aria-expanded', "false");
                this.parentNode.querySelector('button').setAttribute('aria-expanded', "false");
              }

              event.preventDefault();
            });
          }
        });
      }

      renderDropDownButtons();

      showLogingPanelOnError();

      var userAgent = navigator.userAgent.toLowerCase();
      if (userAgent.indexOf("webfont:off") == -1)
      {
        if (userAgent.indexOf("webfont:on") != -1 ||
                userAgent.indexOf("windows") == -1)
        {
          document.body.className = "webfont";
        }
      }

      document.addEventListener('click', function (e)
      {
        if (document.activeElement.nodeName == 'A')
        {
          document.activeElement.blur();
        }
      }
      );

      //Per controlar que no es solapi el contenidor dinamic amb el men� 
      //inferior en augmentar a Firefox la mida de la font
      window.setInterval(function ()
      {
        if (navigator.userAgent.indexOf("Firefox") != -1)
        {
          var testDiv = document.getElementById('testFontSizeDiv');
          if (testDiv)
          {
            var stored = parseInt(testDiv.getAttribute("c_height"));
            if (isNaN(stored))
            {
              testDiv.setAttribute("c_height", testDiv.offsetHeight);
            } else if (stored != testDiv.offsetHeight)
            {
              testDiv.setAttribute("c_height", testDiv.offsetHeight);
              if (typeof portal_custom_container !== 'undefined')
              {
                portal_custom_container._updateColumnsHeight();
              }
            }
          }
        }
      }, 4000);

      window.addEventListener('scroll', checkSkipBottomLink);
      window.addEventListener('load', checkSkipBottomLink);

    </script>
  </f:verbatim>

</jsp:root>
