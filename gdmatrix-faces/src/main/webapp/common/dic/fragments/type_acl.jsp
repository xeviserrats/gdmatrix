<?xml version='1.0' encoding='windows-1252'?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
          xmlns:f="http://java.sun.com/jsf/core"
          xmlns:h="http://java.sun.com/jsf/html"
          xmlns:t="http://myfaces.apache.org/tomahawk"
          xmlns:sf="http://www.santfeliu.org/jsf">

  <f:loadBundle basename="org.santfeliu.dic.web.resources.DictionaryBundle"
                var="dictionaryBundle" />

  <f:loadBundle basename="org.santfeliu.web.obj.resources.ObjectBundle"
                var="objectBundle" />

  <t:buffer into="#{table}">
    <t:dataTable id="data" value="#{typeACLBean.rows}" var="row"
                 rowClasses="row1,row2" headerClass="header" footerClass="footer"
                 rowStyleClass="#{(typeACLBean.editingAccessControlItem != null and
                                  row.accessControl.roleId == typeACLBean.editingAccessControlItem.accessControl.roleId and
                                  row.accessControl.action == typeACLBean.editingAccessControlItem.accessControl.action) ?
                                  'selectedRow' : null}"
                 bodyStyle="#{empty typeACLBean.rows ? 'display:none' : ''}"
                 styleClass="resultList" style="width:100%"
                 rows="#{typeACLBean.pageSize}">

      <t:column style="width:30%">
        <f:facet name="header">
          <h:outputText value="#{dictionaryBundle.typeACL_roleId}:" />
        </f:facet>
        <h:outputText value="#{row.accessControl.roleId}" style="font-family:Courier New"
                      styleClass="#{typeACLBean.accessControlStyleClass}" />
      </t:column>

      <t:column style="width:40%">
        <f:facet name="header">
          <h:outputText value="#{dictionaryBundle.typeACL_action}:" />
        </f:facet>
        <h:outputText value="#{typeACLBean.rowAction}"
                      style="font-family:Courier New"
                      styleClass="#{typeACLBean.accessControlStyleClass}" />
      </t:column>

      <t:column style="width:30%" styleClass="actionsColumn">
        <h:panelGroup>
          <h:commandButton action="#{typeACLBean.editAccessControl}"
                           rendered="#{row.accessControl.roleId != null}"
                           disabled="#{typeACLBean.editingAccessControlItem != null}"
                           styleClass="editButton" value="#{objectBundle.edit}"
                           image="#{userSessionBean.icons.detail}"
                           alt="#{objectBundle.edit}" title="#{objectBundle.edit}" />
          <h:commandButton value="#{objectBundle.remove}"
                           image="#{userSessionBean.icons.remove}"
                           alt="#{objectBundle.remove}" title="#{objectBundle.remove}"
                           action="#{typeACLBean.removeAccessControl}"
                           rendered="#{row.accessControl.roleId != null}"
                           disabled="#{typeACLBean.editingAccessControlItem != null}"
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

  <t:div styleClass="resultBar" rendered="#{typeACLBean.rowCount > 0}">
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

  <t:div style="text-align:right">
    <h:commandButton value="#{objectBundle.add}"        
                     image="#{userSessionBean.icons.add}"
                     alt="#{objectBundle.add}" title="#{objectBundle.add}"
                     action="#{typeACLBean.addAccessControl}"
                     disabled="#{typeACLBean.editingAccessControlItem != null}"
                     styleClass="addButton" />
  </t:div>

  <t:div rendered="#{typeACLBean.editingAccessControlItem != null}"
            styleClass="editingPanel">

    <t:div>
      <h:outputText value="#{dictionaryBundle.typeACL_roleId}:"
                    style="width:15%" styleClass="textBox" />
      <h:inputText value="#{typeACLBean.editingAccessControlItem.accessControl.roleId}"
                   style="width:40%;font-family:Courier New"
                   styleClass="inputBox" />
      <h:commandButton action="#{typeACLBean.searchRole}"
        styleClass="searchButton" value="#{objectBundle.search}"
        image="#{userSessionBean.icons.search}"
        alt="#{objectBundle.search}" title="#{objectBundle.search}" />
    </t:div>

    <t:div>
      <h:outputText value="#{dictionaryBundle.typeACL_action}:"
                    style="width:15%" styleClass="textBox" />
      <t:selectOneMenu value="#{typeACLBean.editingAccessControlItem.accessControl.action}"
                       style="width:30%;font-family:Courier New" styleClass="selectBox">
        <f:selectItems value="#{typeACLBean.actions}" />
      </t:selectOneMenu>
    </t:div>

    <t:div styleClass="actionsRow">
      <h:commandButton action="#{typeACLBean.storeAccessControl}"
                       styleClass="addButton" value="#{objectBundle.accept}" />
      <h:commandButton action="#{typeACLBean.cancelAccessControl}"
                       styleClass="cancelButton" immediate="true" value="#{objectBundle.cancel}" />
    </t:div>
  </t:div>

</jsp:root>
