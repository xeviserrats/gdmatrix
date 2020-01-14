<?xml version='1.0' encoding='windows-1252'?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
          xmlns:f="http://java.sun.com/jsf/core"
          xmlns:h="http://java.sun.com/jsf/html"
          xmlns:t="http://myfaces.apache.org/tomahawk"
          xmlns:sf="http://www.santfeliu.org/jsf">

  <f:loadBundle basename="org.santfeliu.cases.web.resources.CaseBundle" 
                var="caseBundle" />

  <f:loadBundle basename="org.santfeliu.web.obj.resources.ObjectBundle" 
                var="objectBundle" />
  
  <t:div rendered="#{caseProblemsBean.renderGroupButtonMode}"
         styleClass="buttonGroupSelection">
    <t:dataList value="#{caseProblemsBean.groups}" var="group"
                rows="#{caseProblemsBean.groupsPageSize}"
                rendered="#{caseProblemsBean.renderGroupSelection}">
      <h:commandButton value="#{group.description}"
                       styleClass="#{caseProblemsBean.renderGroup ? 'buttonDisabled' : 'buttonEnabled'}"
                       action="#{caseProblemsBean.showGroup}" />
    </t:dataList>
  </t:div>    
  
  <t:dataList id="dataList" value="#{caseProblemsBean.groups}" 
              var="group" rows="#{caseProblemsBean.groupsPageSize}" 
              rowIndexVar="groupIndex" rowCountVar="groupCount">

    <t:div rendered="#{caseProblemsBean.renderGroupBarMode}"
           styleClass="barGroupSelection">
      <h:commandLink action="#{caseProblemsBean.showGroup}" style="color:black">
        <h:graphicImage value="/images/expand.gif" rendered="#{not caseProblemsBean.renderGroup}"/>
        <h:graphicImage value="/images/collapse.gif" rendered="#{caseProblemsBean.renderGroup}"/>
        <h:outputText value="#{group.description}" style="margin-left:2px"/>
      </h:commandLink>
    </t:div>    

  <t:buffer into="#{table}">
    <t:dataTable id="dataTable" value="#{caseProblemsBean.rows}" var="row"
                 rowClasses="row1,row2" headerClass="header" footerClass="footer"
                 rowStyleClass="#{caseProblemsBean.editingProblem != null and row.probId == caseProblemsBean.editingProblem.probId ? 'selectedRow' : null}"
                 styleClass="resultList" style="width:100%"
                 rows="#{caseProblemsBean.pageSize}"
                 bodyStyle="#{empty caseProblemsBean.rows ? 'display:none' : ''}"
                 rendered="#{caseInterventionsBean.renderGroup}">
        
      <f:facet name="header">
        <t:div styleClass="theader">
          <h:outputText value="#{group.description != '' ? (caseProblemsBean.renderGroupSelection ? ' ' : group.description) : userSessionBean.selectedMenuItem.label}"
                        styleClass="textBox" style="width:85%"/>
          <t:dataScroller for="dataTable"
                          rowsCountVar="rowCount">
            <h:outputFormat styleClass="textBox" value="#{objectBundle.shortResultRange}">
              <f:param value="#{rowCount}" />
            </h:outputFormat>
          </t:dataScroller>
        </t:div>
      </f:facet>        
        
      <t:column style="width:10%;vertical-align:top">
        <f:facet name="header">
          <h:outputText value="#{caseBundle.caseProblems_id}:" />
        </f:facet>
        <h:outputText value="#{row.probId}" />
      </t:column>

      <t:column style="vertical-align:top">
        <f:facet name="header">
          <h:outputText value="#{caseBundle.caseProblems_type}:" />
        </f:facet>
        <h:outputText value="#{row.probTypeId}" rendered="#{row.probTypeId != null}"/>
      
        <t:div style="margin-top: 5px">
          <t:dataList value="#{caseProblemsBean.interventions}" 
            var="intProbView"
            rendered="#{caseInterventionsBean.renderProblems}">
            <t:div>
              <t:graphicImage value="/images/item.gif" style="vertical-align:middle;margin-right:5px"/>
              <h:outputText value="#{intProbView.intId}: #{intProbView.type}"
                            rendered="#{intProbView != ''}"
                            style="vertical-align:middle"/>
              <h:commandButton action="#{caseProblemsBean.showIntervention}"
                rendered="#{intProbView != ''}"
                value="#{objectBundle.show}"
                image="#{userSessionBean.icons.show}"
                alt="#{objectBundle.show}" title="#{objectBundle.show}"
                styleClass="showButton" style="vertical-align:middle"/>             
            </t:div>
            <t:div style="margin-left: 12px;font-size:smaller">
              <h:outputText value="#{intProbView.comments}"
                            rendered="#{intProbView != ''}" />
            </t:div>

          </t:dataList>        
        </t:div>
      </t:column>

      <t:column style="width:30%;vertical-align:top" 
        rendered="#{caseProblemsBean.renderPerson and not (caseProblemsBean.renderGroup and caseProblemsBean.groupBy == 'personView.fullName')}">
        <f:facet name="header">
          <h:outputText value="#{caseBundle.caseProblems_person}:" />
        </f:facet>
        <h:outputText value="#{row.personView.fullName}" />
        <h:commandButton action="#{caseProblemsBean.showRowPerson}"
                         value="#{objectBundle.show}"
                         image="#{userSessionBean.icons.show}"
                         alt="#{objectBundle.show}" title="#{objectBundle.show}"
                         styleClass="showButton"
                         rendered="#{row.personView != null}"/>
      </t:column>

      <t:column style="width:15%;vertical-align:top" styleClass="actionsColumn">
        <h:panelGroup>
          <h:commandButton action="#{caseProblemsBean.showRowType}"
            rendered="#{row.probTypeId != null and !caseProblemsBean.renderPerson}" 
            value="#{objectBundle.show}"
            image="#{userSessionBean.icons.show}"
            alt="#{objectBundle.show}" title="#{objectBundle.show}"
            styleClass="showButton" />          
          <h:commandButton action="#{caseProblemsBean.editProblem}"
            rendered="#{row.probId != null}"
            styleClass="editButton" value="#{objectBundle.edit}"
            image="#{userSessionBean.icons.detail}"
            alt="#{objectBundle.edit}" title="#{objectBundle.edit}" />
          <h:commandButton value="#{objectBundle.delete}"           
            image="#{userSessionBean.icons.delete}"           
            alt="#{objectBundle.delete}" title="#{objectBundle.delete}"
            action="#{caseProblemsBean.removeProblem}"
            rendered="#{row.probId != null}"
            disabled="#{!caseBean.editable}"
            styleClass="removeButton"
            onclick="return confirm('#{objectBundle.confirm_remove}');" />
        </h:panelGroup>
      </t:column>

      <f:facet name="footer">
        <t:dataScroller for="dataTable"
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
  
    <t:dataScroller for="dataList"
                    fastStep="5"
                    paginator="true"
                    paginatorMaxPages="5"
                    immediate="true"
                    rendered="#{!caseProblemsBean.singleGroup and ((groupIndex + 1) mod caseProblemsBean.groupsPageSize == 0 or (groupIndex + 1 == groupCount))}"
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
  </t:dataList>    

  <t:div style="width:100%;text-align:right">
    <h:commandButton value="#{objectBundle.add}"        
      image="#{userSessionBean.icons.add}"        
      alt="#{objectBundle.add}" title="#{objectBundle.add}"
      action="#{caseProblemsBean.createProblem}"
      rendered="#{row.probId == null}"
      disabled="#{!caseBean.editable or caseProblemsBean.editingProblem != null}"
      styleClass="addButton"  />
  </t:div>

  <t:div rendered="#{caseProblemsBean.editingProblem != null}" 
    styleClass="editingPanel">

    <t:div>
      <h:outputText value="#{caseBundle.caseProblems_type}:" 
                    style="width:15%" styleClass="textBox"/>
      <t:selectOneMenu value="#{caseProblemsBean.editingProblem.probTypeId}"
                       styleClass="selectBox"
                       disabled="#{!caseBean.editable}">
        <f:selectItems value="#{caseProblemsBean.allTypeItems}" />
      </t:selectOneMenu>
      <h:commandButton action="#{caseProblemsBean.showEditType}"
        value="#{objectBundle.show}"
        image="#{userSessionBean.icons.show}"
        alt="#{objectBundle.show}" title="#{objectBundle.show}"
        styleClass="showButton"
        rendered="#{caseProblemsBean.renderShowEditTypeButton}" />
    </t:div>

    <t:div rendered="#{caseProblemsBean.renderPerson}">
      <h:outputText value="#{caseBundle.caseProblems_person}: "  
                    style="width:15%" styleClass="textBox"/>
      <h:panelGroup>
        <t:selectOneMenu value="#{caseProblemsBean.editingProblem.personId}"
                         styleClass="selectBox"
                         disabled="#{!caseBean.editable}">
          <f:selectItems value="#{caseProblemsBean.casePersonsSelectItems}" />
        </t:selectOneMenu>
        <h:commandButton action="#{caseProblemsBean.showEditPerson}"
                         value="#{objectBundle.show}"
                         image="#{userSessionBean.icons.show}"
                         alt="#{objectBundle.show}" title="#{objectBundle.show}"
                         styleClass="showButton"
                         rendered="#{caseProblemsBean.renderShowEditPersonButton}" />
      </h:panelGroup>
    </t:div>
    
    <t:div>
      <h:outputText value="#{caseBundle.caseProblems_startDate}: "
        style="width:15%" styleClass="textBox"/>
      <sf:calendar value="#{caseProblemsBean.editingProblem.startDate}"
                   styleClass="calendarBox"
                   externalFormat="dd/MM/yyyy"
                   internalFormat="yyyyMMdd"
                   buttonStyleClass="calendarButton"
                   style="width:14%"
                   disabled="#{!caseBean.editable}"/>
    </t:div>

    <t:div>
      <h:outputText value="#{caseBundle.caseProblems_endDate}: "
         style="width:15%" styleClass="textBox"/>
      <sf:calendar value="#{caseProblemsBean.editingProblem.endDate}"
                   styleClass="calendarBox"
                   externalFormat="dd/MM/yyyy"
                   internalFormat="yyyyMMdd"
                   buttonStyleClass="calendarButton"
                   style="width:14%"
                   disabled="#{!caseBean.editable}"/>
    </t:div>  
    
    <t:div rendered="#{caseProblemsBean.renderReason}">
      <h:outputText value="#{caseBundle.caseProblems_reason}: "  
                    style="width:15%" styleClass="textBox"/>
      <h:panelGroup>
        <t:selectOneMenu value="#{caseProblemsBean.editingProblem.reason}"
                         styleClass="selectBox"
                         disabled="#{!caseBean.editable}">
          <f:selectItem itemLabel=" " itemValue="" />
          <f:selectItems value="#{caseProblemsBean.reasonSelectItems}" />
        </t:selectOneMenu>
      </h:panelGroup>
    </t:div>    
    
    <t:div rendered="#{caseProblemsBean.renderPriority}">
      <h:outputText value="#{caseBundle.caseProblems_priority}: " 
                    style="width:15%;vertical-align:top" styleClass="textBox"/>
      <h:inputText value="#{caseProblemsBean.editingProblem.priority}"
                       styleClass="inputBox" style="width:10%"
                       readonly="#{!caseBean.editable}"/>
    </t:div>

    <t:div>
      <h:outputText value="#{caseBundle.caseProblems_comments}: " 
                    style="width:15%;vertical-align:top" styleClass="textBox"/>
      <h:inputTextarea value="#{caseProblemsBean.editingProblem.comments}"
                       styleClass="inputBox" style="width:80%"
                       onkeypress="checkMaxLength(this, #{caseProblemsBean.propertySize.comments})"
                       readonly="#{!caseBean.editable}"/>
    </t:div>

    <t:div styleClass="actionsRow">
      <h:commandButton action="#{caseProblemsBean.storeProblem}"
                       styleClass="addButton" value="#{objectBundle.store}"
                       disabled="#{!caseBean.editable}"
                       onclick="showOverlay()"/>
      <h:commandButton action="#{caseProblemsBean.cancelProblem}"
                       styleClass="cancelButton" value="#{objectBundle.cancel}" 
                       immediate="true"/>
    </t:div>
  </t:div>

</jsp:root>
