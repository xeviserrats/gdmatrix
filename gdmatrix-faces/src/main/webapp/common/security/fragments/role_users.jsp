<?xml version='1.0' encoding='windows-1252'?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
          xmlns:f="http://java.sun.com/jsf/core"
          xmlns:h="http://java.sun.com/jsf/html"
          xmlns:t="http://myfaces.apache.org/tomahawk"
          xmlns:sf="http://www.santfeliu.org/jsf">

  <f:loadBundle basename="org.santfeliu.web.obj.resources.ObjectBundle"
                var="objectBundle" />

  <f:loadBundle basename="org.santfeliu.security.web.resources.SecurityBundle"
                var="securityBundle" />

  <t:buffer into="#{table}">
    <t:dataTable id="data" value="#{roleUsersBean.rows}" var="row"
                 rowStyleClass="#{roleUsersBean.editingUser == null ? null :
                   (roleUsersBean.editingUser.userId == row.user.userId ? 'selectedRow' : null)}"
                 rowClasses="row1,row2" headerClass="header" footerClass="footer"
                 styleClass="resultList" style="width:100%"
                 bodyStyle="#{empty roleUsersBean.rows ? 'display:none' : ''}"
                 rendered="#{!roleUsersBean.new}"
                 rows="#{roleUsersBean.pageSize}"
                 first="#{roleUsersBean.firstRowIndex}">
      <t:column style="width:20%">
        <f:facet name="header">
          <h:outputText value="#{securityBundle.user_user}:" />
        </f:facet>
        <h:outputText value="#{row.user.userId}"
                      styleClass="#{roleUsersBean.userInRoleStyleClass}" />
      </t:column>
      <t:column style="width:50%">
        <f:facet name="header">
          <h:outputText value="#{securityBundle.user_displayName}:" />
        </f:facet>
        <h:outputText value="#{row.user.displayName}"
                      styleClass="#{roleUsersBean.userInRoleStyleClass}" />
      </t:column>
      <t:column style="width:30%;text-align:right;">
        <h:panelGroup>
          <h:commandButton value="#{objectBundle.show}"
                           image="#{userSessionBean.icons.show}"
                           alt="#{objectBundle.show}" title="#{objectBundle.show}"
                           action="#{roleUsersBean.showUserInRole}"
                           styleClass="showButton"  />
          <h:commandButton value="#{objectBundle.edit}"
                           image="#{userSessionBean.icons.detail}"
                           alt="#{objectBundle.edit}" title="#{objectBundle.edit}"
                           action="#{roleUsersBean.editUserInRole}"
                           styleClass="addButton"  />
          <h:commandButton value="#{objectBundle.delete}"
                           image="#{userSessionBean.icons.delete}"
                           alt="#{objectBundle.delete}" title="#{objectBundle.delete}"
                           action="#{roleUsersBean.removeUserInRole}"
                           styleClass="removeButton"
                           onclick="return confirm('#{objectBundle.confirm_remove}');" />
        </h:panelGroup>
      </t:column>

      <f:facet name="footer">
        <t:dataScroller
          fastStep="100"
          paginator="true"
          paginatorMaxPages="9"
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
            <t:div title="#{objectBundle.first}"></t:div>
          </f:facet>
          <f:facet name="last">
            <t:div title="#{objectBundle.last}"></t:div>
          </f:facet>
          <f:facet name="previous">
            <t:div title="#{objectBundle.previous}"></t:div>
          </f:facet>
          <f:facet name="next">
            <t:div title="#{objectBundle.next}"></t:div>
          </f:facet>
          <f:facet name="fastrewind">
            <t:div title="#{objectBundle.fastRewind}"></t:div>
          </f:facet>
          <f:facet name="fastforward">
            <t:div title="#{objectBundle.fastForward}"></t:div>
          </f:facet>
        </t:dataScroller>
      </f:facet>
    </t:dataTable>

  </t:buffer>

  <t:div styleClass="resultBar" rendered="#{roleUsersBean.rowCount > 0}">
    <t:dataScroller for="data"
                    firstRowIndexVar="firstRow"
                    lastRowIndexVar="lastRow"
                    rowsCountVar="rowCount">
      <h:outputFormat value="#{objectBundle.resultRange}">
        <f:param value="#{firstRow}" />
        <f:param value="#{lastRow}" />
        <f:param value="#{rowCount}" />
      </h:outputFormat>
    </t:dataScroller>
  </t:div>

  <h:outputText value="#{table}" escape="false"/>

  <t:div style="width:100%;text-align:right">
    <h:commandButton action="#{roleUsersBean.createUserInRole}"
                     disabled="#{roleUsersBean.editingUser != null}"
                     styleClass="addButton" value="#{objectBundle.add}"
                     image="#{userSessionBean.icons.add}"
                     alt="#{objectBundle.add}" title="#{objectBundle.add}"      />
  </t:div>

  <t:div styleClass="editingPanel" rendered="#{roleUsersBean.editingUser != null}">

    <t:div>
      <h:outputText value="#{securityBundle.user_user}:" styleClass="textBox"
                    style="width:18%" />
      <h:panelGroup>
        <t:selectOneMenu value="#{roleUsersBean.editingUser.userId}"
                         style="width:350px" styleClass="selectBox">
          <f:selectItems value="#{roleUsersBean.userItems}" />
        </t:selectOneMenu>
        <h:commandButton value="#{objectBundle.search}"
                         image="#{userSessionBean.icons.search}"
                         alt="#{objectBundle.search}" title="#{objectBundle.search}"
                         action="#{roleUsersBean.searchUser}"
                         styleClass="searchButton" />
      </h:panelGroup>
    </t:div>

    <t:div>
      <h:outputText value="#{securityBundle.userRoles_comments}:"
        styleClass="textBox" style="width:18%;vertical-align:top" />
      <h:inputTextarea value="#{roleUsersBean.editingUser.comments}"
        styleClass="inputBox" style="width:79%" rows="3"
        onkeypress="checkMaxLength(this, 1000)" />
    </t:div>

    <t:div>
      <h:outputText value="#{securityBundle.userRoles_startDate}:"
        styleClass="textBox" style="width:18%" />
      <sf:calendar value="#{roleUsersBean.editingUser.startDate}"
        style="width:80px" styleClass="calendarBox" buttonStyleClass="calendarButton" />
    </t:div>

    <t:div>
      <h:outputText value="#{securityBundle.userRoles_endDate}:"
        styleClass="textBox" style="width:18%" />
      <sf:calendar value="#{roleUsersBean.editingUser.endDate}"
        style="width:80px" styleClass="calendarBox" buttonStyleClass="calendarButton" />
    </t:div>

    <t:div styleClass="actionsRow">
      <h:commandButton action="#{roleUsersBean.storeUserInRole}"
                       styleClass="addButton" value="#{objectBundle.store}" />
      <h:commandButton action="#{roleUsersBean.cancelUserInRole}"
                       styleClass="cancelButton" value="#{objectBundle.cancel}" />
    </t:div>
    
  </t:div>

</jsp:root>
