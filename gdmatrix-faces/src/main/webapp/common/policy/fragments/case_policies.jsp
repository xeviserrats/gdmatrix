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
  <t:dataTable id="data" value="#{casePoliciesBean.rows}" var="row"
    rowClasses="row1,row2" headerClass="header" footerClass="footer"
    rowStyleClass="#{casePoliciesBean.editingCasePolicy != null and
      row.casePolicy.casePolicyId == casePoliciesBean.editingCasePolicy.casePolicyId ? 'selectedRow' : null}"
    bodyStyle="#{empty casePoliciesBean.rows ? 'display:none' : ''}"
    styleClass="resultList" style="width:100%"
    rows="#{casePoliciesBean.pageSize}">

    <t:column style="width:5%">
      <f:facet name="header">
        <h:outputText value="#{policyBundle.casePolicies_casePolicyId}:" />
      </f:facet>
      <h:outputText value="#{row.policy.policyId}"
        rendered="#{row != null and row.policy != null}"/>
    </t:column>

    <t:column style="width:30%">
      <f:facet name="header">
        <h:outputText value="#{policyBundle.casePolicies_policy}:" />
      </f:facet>
      <h:outputText value="#{row.policy.title}"
        rendered="#{row != null and row.policy != null }"/>
    </t:column>

    <t:column style="width:15%">
      <f:facet name="header">
        <h:outputText value="#{policyBundle.casePolicies_activationDate}:" />
      </f:facet>
      <h:outputText value="#{casePoliciesBean.rowActivationDate}"
        rendered="#{row != null and row.casePolicy != null}">
          <f:convertDateTime pattern="dd/MM/yyyy" />
      </h:outputText>
    </t:column>

    <t:column style="width:12%">
      <f:facet name="header">
        <h:outputText value="#{policyBundle.casePolicies_type}:" />
      </f:facet>
      <h:outputText value="#{row.policy.policyTypeId}"
        rendered="#{row != null and row.policy != null }"/>
    </t:column>

    <t:column style="width:12%">
      <f:facet name="header">
        <h:outputText value="#{policyBundle.casePolicies_state}:" />
      </f:facet>
      <h:outputText value="#{casePoliciesBean.policyState}"
        rendered="#{row.policy != null}">
      </h:outputText>
    </t:column>

    <t:column style="width:25%" styleClass="actionsColumn">
      <h:panelGroup>
        <h:commandButton action="#{casePoliciesBean.showPolicy}"
          rendered="#{row.casePolicy != null}"
          disabled="#{casePoliciesBean.editingCasePolicy != null}"
          styleClass="showButton" value="#{objectBundle.show}"
          image="#{userSessionBean.icons.show}"
          alt="#{objectBundle.show}" title="#{objectBundle.show}" />
        <h:commandButton action="#{casePoliciesBean.editCasePolicy}"
          rendered="#{row.casePolicy != null}"
          styleClass="editButton" value="#{objectBundle.edit}"
          image="#{userSessionBean.icons.detail}"
          alt="#{objectBundle.edit}" title="#{objectBundle.edit}"/>
        <h:commandButton value="#{objectBundle.delete}"
          image="#{userSessionBean.icons.delete}"
          alt="#{objectBundle.delete}" title="#{objectBundle.delete}"
          action="#{casePoliciesBean.removeCasePolicy}"
          rendered="#{row.casePolicy != null}"
          disabled="#{!caseBean.editable or casePoliciesBean.editingCasePolicy != null}"
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

  <t:div styleClass="resultBar" rendered="#{casePoliciesBean.rowCount > 0}">
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
    <h:commandButton value="#{objectBundle.add}"
      image="#{userSessionBean.icons.add}"
      alt="#{objectBundle.add}" title="#{objectBundle.add}"
      action="#{casePoliciesBean.createCasePolicy}"
      rendered="#{row.casePolicy == null}"
      disabled="#{!caseBean.editable}"
      styleClass="addButton"  />
    <h:commandButton value="#{policyBundle.analyze}"
      action="#{casePoliciesBean.analyzeCase}"
      rendered="#{row.casePolicy == null}"
      disabled="#{!caseBean.editable}"
      styleClass="addButton"  />
  </t:div>

  <t:div rendered="#{casePoliciesBean.editingCasePolicy != null}"
    styleClass="editingPanel">
    <t:div>
      <h:outputText value="#{policyBundle.casePolicies_policy}: "
         style="width:15%" styleClass="textBox"/>
      <h:panelGroup>
        <t:selectOneMenu value="#{casePoliciesBean.editingCasePolicy.policyId}"
          styleClass="selectBox" style="width:70%"
          disabled="#{not caseBean.editable}">
          <f:selectItems value="#{casePoliciesBean.policySelectItems}" />
        </t:selectOneMenu>
        <h:commandButton action="#{casePoliciesBean.searchPolicy}"
          styleClass="searchButton" value="#{objectBundle.search}"
          image="#{userSessionBean.icons.search}"        
          alt="#{objectBundle.search}" title="#{objectBundle.search}"
          disabled="#{not caseBean.editable}"/>
      </h:panelGroup>
    </t:div>

    <t:div>
      <h:outputText value="#{policyBundle.casePolicies_state}: "
         style="width:15%" styleClass="textBox" />
      <t:selectOneMenu value="#{casePoliciesBean.editingCasePolicy.state}"
        styleClass="selectBox" style="width:20%" disabled="#{not caseBean.editable}">
        <f:selectItems value="#{casePoliciesBean.policyStateSelectItems}" />
        <f:converter converterId="EnumConverter" />
        <f:attribute name="enum" value="org.matrix.policy.PolicyState" />
      </t:selectOneMenu>
    </t:div>

    <t:div>
      <h:outputText value="#{policyBundle.casePolicies_reason}: "
         style="width:15%" styleClass="textBox" />
      <h:inputText value="#{casePoliciesBean.editingCasePolicy.reason}"
        styleClass="inputBox" style="width:75%"
        maxlength="#{casePoliciesBean.propertySize.reason}"
        disabled="#{not caseBean.editable}"/>
    </t:div>

    <t:div>
      <h:outputText value="#{policyBundle.casePolicies_activationDate}: "
         style="width:15%" styleClass="textBox" />
      <sf:calendar value="#{casePoliciesBean.editingCasePolicy.activationDate}"
         styleClass="calendarBox" buttonStyleClass="calendarButton" style="width:20%"/>
    </t:div>

    <t:div>
      <h:outputText value="#{policyBundle.casePolicies_creation}: "
         style="width:15%" styleClass="textBox" />
         <h:outputText value="#{casePoliciesBean.editingCreationDateTime}"
        styleClass="outputBox" style="width:22%">
          <f:convertDateTime pattern="dd/MM/yyyy HH:mm:ss" />
      </h:outputText>
      <h:outputText value="#{policyBundle.by}: " styleClass="textBox" />
      <h:outputText value="#{casePoliciesBean.editingCasePolicy.creationUserId}"
        styleClass="outputBox" style="width:20%"/>
    </t:div>

    <t:div>
      <h:outputText value="#{policyBundle.casePolicies_approval}: "
         style="width:15%" styleClass="textBox" />
      <h:outputText value="#{casePoliciesBean.editingApprovalDateTime}"
        styleClass="outputBox" style="width:22%">
          <f:convertDateTime pattern="dd/MM/yyyy HH:mm:ss" />
      </h:outputText>
      <h:outputText value="#{policyBundle.by}: " styleClass="textBox" />
      <h:outputText value="#{casePoliciesBean.editingCasePolicy.approvalUserId}"
        styleClass="outputBox" style="width:20%"/>
    </t:div>

    <t:div>
      <h:outputText value="#{policyBundle.casePolicies_execution}: "
         style="width:15%" styleClass="textBox" />
         <h:outputText value="#{casePoliciesBean.editingExecutionDateTime}"
        styleClass="outputBox" style="width:22%">
          <f:convertDateTime pattern="dd/MM/yyyy HH:mm:ss" />
      </h:outputText>
      <h:outputText value="#{policyBundle.by}: " styleClass="textBox" />
      <h:outputText value="#{casePoliciesBean.editingCasePolicy.executionUserId}"
        styleClass="outputBox" style="width:20%"/>
    </t:div>

    <t:div>
      <h:outputText value="#{policyBundle.casePolicies_executionResult}: "
        style="width:15%" styleClass="textBox" />
      <h:inputTextarea value="#{casePoliciesBean.editingCasePolicy.executionResult}"
        styleClass="inputBox" style="width:75%" readonly="#{not caseBean.editable}"/>
    </t:div>

    <t:div styleClass="actionsRow">
      <h:commandButton action="#{casePoliciesBean.storeCasePolicy}"
        styleClass="addButton" value="#{objectBundle.store}"
        disabled="#{not caseBean.editable}"/>
      <h:commandButton action="#{casePoliciesBean.cancelCasePolicy}"
        styleClass="cancelButton" value="#{objectBundle.cancel}" />
    </t:div>
  </t:div>

  <t:div rendered="#{not empty casePoliciesBean.messageList}" styleClass="analyzer">
    <t:dataList value="#{casePoliciesBean.messageList}" var="row" layout="simple" rowIndexVar="rowIndex">
      <h:outputText value="#{row}" styleClass="#{rowIndex % 2 == 0 ? 'row0' : 'row1'}" />
    </t:dataList>
  </t:div>

</jsp:root>

