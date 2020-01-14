<?xml version='1.0' encoding='windows-1252'?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
          xmlns:f="http://java.sun.com/jsf/core"
          xmlns:h="http://java.sun.com/jsf/html"
          xmlns:t="http://myfaces.apache.org/tomahawk"
          xmlns:sf="http://www.santfeliu.org/jsf">

  <f:loadBundle basename="org.santfeliu.policy.web.resources.PolicyBundle"
                var="policyBundle" />
  <f:loadBundle basename="org.santfeliu.web.obj.resources.ObjectBundle"
                var="objectBundle" />

  <t:buffer into="#{table}">
    <t:div style="width:100%;font-weight:bold;display:block;padding:1px 0px 1px 1px;">
      <h:commandLink action="#{classPoliciesBean.changeRenderInheritedPolicies}" >
        <h:graphicImage url="/images/expand.gif"
          style="border:0;vertical-align:middle;margin:2px 2px 2px 2px"
          rendered="#{!classPoliciesBean.inheritedPoliciesRendered}"/>
        <h:graphicImage url="/images/collapse.gif"
          style="border:0;vertical-align:middle;margin:2px 2px 2px 2px"
          rendered="#{classPoliciesBean.inheritedPoliciesRendered}"/>
      </h:commandLink>
      <h:outputText value="#{policyBundle.classPolicies_inheritedPolicies}"
                    styleClass="textBox" style="font-weight:bold;"/>
    </t:div>

    <t:dataList value="#{classPoliciesBean.superClasses}" var="class">
      <t:div rendered="#{classPoliciesBean.inheritedPoliciesRendered}"
        style="width:100%;font-weight:bold;display:block;background:#E8E8E8;padding:1px 0px 1px 1px;">
        <h:outputText value="#{class.classId} (#{class.title})"
          styleClass="textBox" style="width:95%"/>
        <h:commandButton action="#{classPoliciesBean.showClass}"
          value="#{objectBundle.show}"
          image="#{userSessionBean.icons.show}"
          alt="#{objectBundle.show}" title="#{objectBundle.show}" styleClass="showButton"/>
      </t:div>
      <t:dataTable id="data" value="#{classPoliciesBean.superClassPolicyViews}" var="row"
        rowClasses="row1,row2" headerClass="header" footerClass="footer"
        rowStyleClass="#{classPoliciesBean.rowEndDate != null ? 'disabledRow' : null}"
        bodyStyle="#{empty classPoliciesBean.superClassPolicyViews ? 'display:none' : ''}"
        styleClass="resultList" style="width:100%"
        rendered="#{classPoliciesBean.inheritedPoliciesRendered}">
        <t:column style="width:5%">
          <f:facet name="header">
            <h:outputText value="#{policyBundle.classPolicies_classPolicyId}:" />
          </f:facet>
          <h:outputText value="#{row.policy.policyId}"
                        rendered="#{row != null and row.policy != null}"/>
        </t:column>

        <t:column style="width:40%">
          <f:facet name="header">
            <h:outputText value="#{policyBundle.classPolicies_policy}:" />
          </f:facet>
          <h:outputText value="#{row.policy.title}"
                        rendered="#{row != null and row.policy != null }"/>
        </t:column>

        <t:column style="width:15%;text-align:center">
          <f:facet name="header">
            <h:outputText value="#{policyBundle.classPolicies_startDate}:" />
          </f:facet>
          <h:outputText value="#{classPoliciesBean.rowStartDate}"
                        rendered="#{row != null and row.classPolicy != null}">
            <f:convertDateTime pattern="dd/MM/yyyy" />
          </h:outputText>
        </t:column>

        <t:column style="width:15%;text-align:center">
          <f:facet name="header">
            <h:outputText value="#{policyBundle.classPolicies_endDate}:" />
          </f:facet>
          <h:outputText value="#{classPoliciesBean.rowEndDate}"
                        rendered="#{row != null and row.classPolicy != null}">
            <f:convertDateTime pattern="dd/MM/yyyy" />
          </h:outputText>
        </t:column>

        <t:column style="width:25%" styleClass="actionsColumn">
          <h:panelGroup>
            <h:commandButton action="#{classPoliciesBean.showPolicy}"
                             rendered="#{row.classPolicy != null}"
                             disabled="#{classPoliciesBean.editingClassPolicy != null}"
                             styleClass="showButton" value="#{objectBundle.show}"
                             image="#{userSessionBean.icons.show}"
                             alt="#{objectBundle.show}" title="#{objectBundle.show}" />
          </h:panelGroup>
        </t:column>
      </t:dataTable>
    </t:dataList>


    <t:div style="width:100%;font-weight:bold;display:block;background:#E8E8E8;padding:1px 0px 1px 1px;"
              rendered="#{classPoliciesBean.inheritedPoliciesRendered}">
      <h:outputText value="#{policyBundle.classPolicies_ownPolicies}"
                    styleClass="textBox" />
    </t:div>

    <t:dataTable id="data" value="#{classPoliciesBean.rows}" var="row"
      rowClasses="row1,row2" headerClass="header" footerClass="footer"
      rowStyleClass="#{classPoliciesBean.editingClassPolicy != null
        and row.classPolicy.classPolicyId == classPoliciesBean.editingClassPolicy.classPolicyId
                        ? 'selectedRow' :
                        classPoliciesBean.rowEndDate != null ? 'disabledRow' : null}"
      bodyStyle="#{empty classPoliciesBean.rows ? 'display:none' : ''}"
      styleClass="resultList" style="width:100%"
      rows="#{classPoliciesBean.pageSize}">

      <t:column style="width:5%">
        <f:facet name="header">
          <h:outputText value="#{policyBundle.classPolicies_classPolicyId}:" />
        </f:facet>
        <h:outputText value="#{row.policy.policyId}"
                      rendered="#{row != null and row.policy != null}"/>
      </t:column>

      <t:column style="width:40%">
        <f:facet name="header">
          <h:outputText value="#{policyBundle.classPolicies_policy}:" />
        </f:facet>
        <h:outputText value="#{row.policy.title}"
                      rendered="#{row != null and row.policy != null }"/>
      </t:column>

      <t:column style="width:15%;text-align:center">
        <f:facet name="header">
          <h:outputText value="#{policyBundle.classPolicies_startDate}:" />
        </f:facet>
        <h:outputText value="#{classPoliciesBean.rowStartDate}"
                      rendered="#{row != null and row.classPolicy != null}">
          <f:convertDateTime pattern="dd/MM/yyyy" />
        </h:outputText>
      </t:column>

      <t:column style="width:15%;text-align:center">
        <f:facet name="header">
          <h:outputText value="#{policyBundle.classPolicies_endDate}:" />
        </f:facet>
        <h:outputText value="#{classPoliciesBean.rowEndDate}"
                      rendered="#{row != null and row.classPolicy != null}">
          <f:convertDateTime pattern="dd/MM/yyyy" />
        </h:outputText>
      </t:column>

      <t:column style="width:25%" styleClass="actionsColumn">
        <h:panelGroup>
          <h:commandButton action="#{classPoliciesBean.showPolicy}"
                           rendered="#{row.classPolicy != null}"
                           disabled="#{classPoliciesBean.editingClassPolicy != null}"
                           styleClass="showButton" value="#{objectBundle.show}"
                           image="#{userSessionBean.icons.show}"
                           alt="#{objectBundle.show}" title="#{objectBundle.show}" />
          <h:commandButton action="#{classPoliciesBean.editClassPolicy}"
                           rendered="#{row.classPolicy != null}"
                           styleClass="editButton" value="#{objectBundle.edit}"
                           image="#{userSessionBean.icons.detail}"
                           alt="#{objectBundle.edit}" title="#{objectBundle.edit}"/>
          <h:commandButton value="#{objectBundle.delete}"           image="#{userSessionBean.icons.delete}"           alt="#{objectBundle.delete}" title="#{objectBundle.delete}"
                           action="#{classPoliciesBean.removeClassPolicy}"
                           rendered="#{row.classPolicy != null}"
                           disabled="#{classPoliciesBean.editingClassPolicy != null}"
                           styleClass="removeButton"
                           onclick="return confirm('#{objectBundle.confirm_remove}');"/>
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

  <h:outputText value="#{table}" escape="false"/>

  <t:div style="width:100%;text-align:right">
    <h:commandButton value="#{objectBundle.add}"
      image="#{userSessionBean.icons.add}"
      alt="#{objectBundle.add}" title="#{objectBundle.add}"
      action="#{classPoliciesBean.createClassPolicy}"
      rendered="#{row.classPolicy == null}"
      styleClass="addButton"  />
  </t:div>

  <t:div rendered="#{classPoliciesBean.editingClassPolicy != null}"
            styleClass="editingPanel">

    <t:div>
      <h:outputText value="#{policyBundle.classPolicies_policy}: "
                    style="width:15%" styleClass="textBox"/>
      <h:panelGroup>
        <t:selectOneMenu value="#{classPoliciesBean.editingClassPolicy.policyId}"
                         styleClass="selectBox" style="width:70%">
          <f:selectItems value="#{classPoliciesBean.policySelectItems}" />
        </t:selectOneMenu>
        <h:commandButton action="#{classPoliciesBean.searchPolicy}"
                         styleClass="searchButton" value="#{objectBundle.search}" />
      </h:panelGroup>
    </t:div>

    <t:div>
      <h:outputText value="#{policyBundle.classPolicies_reason}: "
                    style="width:15%" styleClass="textBox" />
      <h:inputText value="#{classPoliciesBean.editingClassPolicy.reason}"
                   styleClass="inputBox" style="width:75%"
                   maxlength="#{classPoliciesBean.propertySize.reason}"/>
    </t:div>

    <t:div>
      <h:outputText value="#{policyBundle.classPolicies_startDate}: "
                    style="width:15%" styleClass="textBox" />
      <sf:calendar value="#{classPoliciesBean.editingClassPolicy.startDate}"
                   styleClass="calendarBox" style="width:15%" buttonStyleClass="calendarButton"/>
    </t:div>
    <t:div>
      <h:outputText value="#{policyBundle.classPolicies_endDate}: "
                    style="width:15%" styleClass="textBox" />
      <sf:calendar value="#{classPoliciesBean.editingClassPolicy.endDate}"
                   styleClass="calendarBox" style="width:15%" buttonStyleClass="calendarButton"/>
    </t:div>


    <t:div>
      <h:outputText value="#{policyBundle.classPolicies_creation}: "
                    style="width:15%" styleClass="textBox" />
      <h:outputText value="#{classPoliciesBean.editingCreationDateTime}"
                    styleClass="outputBox" style="width:20%">
        <f:convertDateTime pattern="dd/MM/yyyy HH:mm:ss" />
      </h:outputText>
      <h:outputText value="#{policyBundle.by}: "
                    style="width:5%" styleClass="textBox" />
      <h:outputText value="#{classPoliciesBean.editingClassPolicy.creationUserId}"
                    styleClass="outputBox" style="width:20%"/>
    </t:div>


    <t:div>
      <h:outputText value="#{policyBundle.classPolicies_modify}: "
                    style="width:15%" styleClass="textBox" />
      <h:outputText value="#{classPoliciesBean.editingChangeDateTime}"
                    styleClass="outputBox" style="width:20%">
        <f:convertDateTime pattern="dd/MM/yyyy HH:mm:ss" />
      </h:outputText>
      <h:outputText value="#{policyBundle.by}: "
                    style="width:5%" styleClass="textBox" />
      <h:outputText value="#{classPoliciesBean.editingClassPolicy.changeUserId}"
                    styleClass="outputBox" style="width:20%"/>
    </t:div>


    <t:div styleClass="actionsRow">
      <h:commandButton action="#{classPoliciesBean.storeClassPolicy}"
                       styleClass="addButton" value="#{objectBundle.store}" />
      <h:commandButton action="#{classPoliciesBean.cancelClassPolicy}"
                       styleClass="cancelButton" value="#{objectBundle.cancel}" />
    </t:div>
  </t:div>

</jsp:root>
