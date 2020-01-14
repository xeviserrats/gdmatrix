<?xml version='1.0' encoding='windows-1252'?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
          xmlns:f="http://java.sun.com/jsf/core"
          xmlns:h="http://java.sun.com/jsf/html"
          xmlns:t="http://myfaces.apache.org/tomahawk"
          xmlns:sf="http://www.santfeliu.org/jsf">

  <f:loadBundle basename="org.santfeliu.policy.web.resources.PolicyBundle"
    var="policyBundle" />

  <h:panelGrid columns="2" styleClass="filterPanel" summary=""
    columnClasses="column1, column2"
    headerClass="header" footerClass="footer">
    <f:facet name="header">
      <h:outputText />
    </f:facet>

    <h:outputText value="#{policyBundle.documentPolicySearch_docId}:" />
    <h:inputText value="#{documentPolicySearchBean.filter.docId}" 
      styleClass="inputBox" style="width:14%" />

    <h:outputText value="#{policyBundle.documentPolicySearch_policy}:" />
    <h:panelGroup>
      <t:selectOneMenu value="#{documentPolicySearchBean.filter.policyId}"
                       styleClass="selectBox" style="width:70%">
        <f:selectItems value="#{policyBean.selectItems}" />
      </t:selectOneMenu>
      <h:commandButton action="#{documentPolicySearchBean.searchPolicy}" 
                       styleClass="searchButton" value="#{objectBundle.search}"
                       image="#{userSessionBean.icons.search}"
                       alt="#{objectBundle.search}" title="#{objectBundle.search}" />
    </h:panelGroup>
    
    <h:outputText value="#{policyBundle.documentPolicySearch_state}:" />
    <t:selectOneMenu value="#{documentPolicySearchBean.filter.state}"
      styleClass="selectBox" style="width:20%" >
      <f:selectItem itemLabel=" " itemValue="" />
      <f:selectItems value="#{documentPolicySearchBean.stateSelectItems}" />
      <f:converter converterId="EnumConverter" />
      <f:attribute name="enum" value="org.matrix.policy.PolicyState" />
    </t:selectOneMenu>

    <h:outputText value="#{policyBundle.documentPolicySearch_creationDates}" />
    <t:div>
      <sf:calendar value="#{documentPolicySearchBean.filter.startCreationDate}"
        styleClass="calendarBox" buttonStyleClass="calendarButton"
        style="width:14%"/>
      <h:outputText value=" #{policyBundle.documentPolicySearch_and} " />
      <sf:calendar value="#{documentPolicySearchBean.filter.endCreationDate}"
        styleClass="calendarBox" buttonStyleClass="calendarButton"
        style="width:14%"/>
    </t:div>

    <h:outputText value="#{policyBundle.documentPolicySearch_approvalDates}" />
    <t:div>
      <sf:calendar value="#{documentPolicySearchBean.filter.startApprovalDate}"
        styleClass="calendarBox" buttonStyleClass="calendarButton"
        style="width:14%"/>
      <h:outputText value=" #{policyBundle.documentPolicySearch_and} " />
      <sf:calendar value="#{documentPolicySearchBean.filter.endApprovalDate}"
        styleClass="calendarBox" buttonStyleClass="calendarButton"
        style="width:14%"/>
    </t:div>

    <h:outputText value="#{policyBundle.documentPolicySearch_activationDates}" />
    <t:div>
      <sf:calendar value="#{documentPolicySearchBean.filter.startActivationDate}"
        styleClass="calendarBox" buttonStyleClass="calendarButton"
        style="width:14%"/>
      <h:outputText value=" #{policyBundle.documentPolicySearch_and} " />
      <sf:calendar value="#{documentPolicySearchBean.filter.endActivationDate}"
        styleClass="calendarBox" buttonStyleClass="calendarButton"
        style="width:14%"/>
    </t:div>
    
    <h:outputText value="#{policyBundle.documentPolicySearch_executionDates}" />
    <t:div>
      <sf:calendar value="#{documentPolicySearchBean.filter.startExecutionDate}"
        styleClass="calendarBox" buttonStyleClass="calendarButton"
        style="width:14%"/>
      <h:outputText value=" #{policyBundle.documentPolicySearch_and} " />
      <sf:calendar value="#{documentPolicySearchBean.filter.endExecutionDate}"
        styleClass="calendarBox" buttonStyleClass="calendarButton"
        style="width:14%"/>
    </t:div>
    
    <f:facet name="footer">
      <h:commandButton id="default_button" value="#{objectBundle.search}"
        action="#{documentPolicySearchBean.search}" styleClass="searchButton" />
    </f:facet>
  </h:panelGrid>

  <t:div styleClass="resultBar" rendered="#{documentPolicySearchBean.rows != null}">
    <t:dataScroller for="data"
      firstRowIndexVar="firstRow"
      lastRowIndexVar="lastRow"
      rowsCountVar="rowCount"
      rendered="#{documentPolicySearchBean.rowCount > 0}">
      <h:outputFormat value="#{objectBundle.resultRange}"
        style="margin-top:10px;display:block">
        <f:param value="#{firstRow}" />
        <f:param value="#{lastRow}" />
        <f:param value="#{rowCount}" />
      </h:outputFormat>
    </t:dataScroller>
    <h:outputText value="#{objectBundle.no_results_found}"
      rendered="#{documentPolicySearchBean.rowCount == 0}" />
  </t:div>

  <t:dataTable rows="#{documentPolicySearchBean.pageSize}" id="data"
    first="#{documentPolicySearchBean.firstRowIndex}"
    value="#{documentPolicySearchBean.rows}" var="row"
    rendered="#{documentPolicySearchBean.rowCount > 0}"
    styleClass="resultList"
    rowClasses="row1,row2" headerClass="header" footerClass="footer">

    <t:column style="width:50%;vertical-align:top" >
      <f:facet name="header">
        <h:outputText value="#{policyBundle.documentPolicySearch_document}" />
      </f:facet>
      <h:panelGroup>
        <t:div style="margin-bottom: 4px" styleClass="item">
          <h:outputText value="#{policyBundle.documentPolicySearch_docId}: "
            style="font-weight:bold"/>
          <h:outputText value="#{row.docPolicy.docId}" rendered="#{row.document == null}"/>
          <h:outputText value="#{row.document.docId}-#{row.document.version}"
            rendered="#{row.document != null}"/>
          <h:commandButton value="#{objectBundle.show}"           
            image="#{userSessionBean.icons.show}"
            alt="#{objectBundle.show}" title="#{objectBundle.show}"
            styleClass="showButton" immediate="true"
            action="#{documentPolicySearchBean.showDocument}"
            rendered="#{row.document != null}"/>
        </t:div>
        <t:div rendered="#{row.document != null}" styleClass="item">
          <h:outputText value="#{policyBundle.documentPolicySearch_document}: "
            style="font-weight:bold"/>
          <h:graphicImage url="#{documentPolicySearchBean.fileTypeImage}"
            height="16" width="16"
            style="border:0;vertical-align:middle;margin-right:2px" />
          <h:outputLink target="_blank" styleClass="documentLink"
            value="#{documentPolicySearchBean.documentUrl}" >
          <h:outputText value="#{row.document.title}"/>
          </h:outputLink>
        </t:div>
        <t:div rendered="#{row.document != null}" styleClass="item">
          <h:outputText value="#{policyBundle.documentPolicySearch_documentType}: "
            style="font-weight:bold"/>
          <h:outputText value="#{row.document.docTypeId}"/>
        </t:div>
        <t:div rendered="#{row.document != null}" styleClass="item">
          <h:outputText value="#{policyBundle.documentPolicySearch_class}: "
            style="font-weight:bold"/>
          <h:outputText value="#{documentPolicySearchBean.documentClassId}"/>
        </t:div>
        <t:div rendered="#{row.document != null}" styleClass="item">
          <h:outputText value="#{policyBundle.documentPolicySearch_size}: "
            style="font-weight:bold"/>
          <h:outputText value="#{documentPolicySearchBean.documentSize}"/>
        </t:div>
      </h:panelGroup>
    </t:column>

    <t:column style="width:50%;vertical-align:top" >
      <f:facet name="header">
        <h:outputText value="#{policyBundle.documentPolicySearch_policyApplication}" />
      </f:facet>
      <h:panelGroup>
        <t:div styleClass="item">
          <h:outputText value="#{policyBundle.documentPolicySearch_policyId}: "
            style="font-weight:bold"/>
          <h:outputText value="#{row.policy.policyId}"/>
          <h:commandButton value="#{objectBundle.show}"           
            image="#{userSessionBean.icons.show}"
            alt="#{objectBundle.show}" title="#{objectBundle.show}"
            styleClass="showButton" immediate="true"
            action="#{documentPolicySearchBean.showPolicy}" />
        </t:div>
        <t:div styleClass="item">
          <h:outputText value="#{policyBundle.documentPolicySearch_policy}: "
            style="font-weight:bold"/>
          <h:outputText value="#{row.policy.title}"/>
        </t:div>
        <t:div styleClass="item">
          <h:outputText value="#{policyBundle.documentPolicySearch_policyType}: "
            style="font-weight:bold"/>
          <h:outputText value="#{row.policy.policyTypeId}"/>
        </t:div>
        <t:div styleClass="item">
          <h:outputText value="#{policyBundle.documentPolicySearch_automatic}: "
            style="font-weight:bold"/>
          <h:outputText value="#{row.policy.automaticExecution}"/>
        </t:div>
        <t:div rendered="#{row.docPolicy.reason != null}" styleClass="item">
          <h:outputText value="#{policyBundle.documentPolicySearch_reason}: "
            style="font-weight:bold"/>
          <h:outputText value="#{row.docPolicy.reason}" />
        </t:div>
        <t:div rendered="#{row.docPolicy.creationDateTime != null}" styleClass="item">
          <h:outputText value="#{policyBundle.documentPolicySearch_creation}: "
            style="font-weight:bold"/>
          <h:outputText value="#{row.docPolicy.creationDateTime}">
            <f:converter converterId="DateTimeConverter" />
            <f:attribute name="userFormat" value="dd/MM/yyyy HH:mm:ss" />
            <f:attribute name="internalFormat" value="yyyyMMddHHmmss" />
          </h:outputText>
          <h:outputText value=" (#{row.docPolicy.creationUserId})" />
        </t:div>
        <t:div rendered="#{row.docPolicy.approvalDateTime != null}" styleClass="item">
          <h:outputText value="#{policyBundle.documentPolicySearch_approval}: "
            style="font-weight:bold"/>
          <h:outputText value="#{row.docPolicy.approvalDateTime}">
            <f:converter converterId="DateTimeConverter" />
            <f:attribute name="userFormat" value="dd/MM/yyyy HH:mm:ss" />
            <f:attribute name="internalFormat" value="yyyyMMddHHmmss" />
          </h:outputText>
          <h:outputText value=" (#{row.docPolicy.approvalUserId})" />
        </t:div>
        <t:div rendered="#{row.docPolicy.activationDate != null}" styleClass="item">
          <h:outputText value="#{policyBundle.documentPolicySearch_activation}: "
            style="font-weight:bold"/>
          <h:outputText value="#{row.docPolicy.activationDate}">
            <f:converter converterId="DateTimeConverter" />
            <f:attribute name="userFormat" value="dd/MM/yyyy" />
            <f:attribute name="internalFormat" value="yyyyMMdd" />
          </h:outputText>
        </t:div>
        <t:div rendered="#{row.docPolicy.executionDateTime != null}" styleClass="item">
          <h:outputText value="#{policyBundle.documentPolicySearch_execution}: "
            style="font-weight:bold"/>
          <h:outputText value="#{row.docPolicy.executionDateTime}">
            <f:converter converterId="DateTimeConverter" />
            <f:attribute name="userFormat" value="dd/MM/yyyy HH:mm:ss" />
            <f:attribute name="internalFormat" value="yyyyMMddHHmmss" />
          </h:outputText>
          <h:outputText value=" (#{row.docPolicy.executionUserId})" />
        </t:div>
        <t:div styleClass="item">
          <h:outputText value="#{row.docPolicy.executionResult}" 
            style="word-break: break-all; font-family: monospace" />
        </t:div>
        <t:div styleClass="item">
          <h:outputText value="#{policyBundle.documentPolicySearch_state}: "
            style="font-weight:bold"/>
          <t:selectOneMenu value="#{documentPolicySearchBean.rowState}"
            styleClass="selectBox"
            style="#{documentPolicySearchBean.rowStateChanged?'background-color:yellow':null}"
            onchange="this.style.background='#ffff00'">
            <f:selectItems value="#{documentPolicySearchBean.stateSelectItems}" />
            <f:converter converterId="EnumConverter" />
            <f:attribute name="enum" value="org.matrix.policy.PolicyState" />
          </t:selectOneMenu>
        </t:div>
      </h:panelGroup>
    </t:column>

    <f:facet name="footer">
      <t:dataScroller for="data"
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
  
  <t:div styleClass="actionsBar">
     <h:commandButton value="#{objectBundle.apply}"
       action="#{documentPolicySearchBean.changeState}"
       styleClass="createButton" />
     <h:commandButton value="#{objectBundle.cancel}"
       action="#{documentPolicySearchBean.cancelChanges}"
       styleClass="createButton" />
  </t:div>



</jsp:root>
