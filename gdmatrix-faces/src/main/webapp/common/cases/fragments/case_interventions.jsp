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

  <sf:saveScroll resetIfError="true" value="#{caseInterventionsBean.objectPageScroll}" />    

  <t:div rendered="#{caseInterventionsBean.renderGroupButtonMode}"
         styleClass="buttonGroupSelection">
    <t:dataList value="#{caseInterventionsBean.groups}" var="group"                
                rows="#{caseInterventionsBean.groupsPageSize}"
                rendered="#{caseInterventionsBean.renderGroupSelection}">
      <h:commandButton value="#{group.description}"
                       styleClass="#{caseInterventionsBean.renderGroup ? 'buttonEnabled' : 'buttonDisabled'}"
                       action="#{caseInterventionsBean.showGroup}" />
    </t:dataList>
  </t:div>  

  <t:dataList id="dataList" value="#{caseInterventionsBean.groups}" 
              var="group" rows="#{caseInterventionsBean.groupsPageSize}" 
              rowIndexVar="groupIndex" rowCountVar="groupCount">

    <t:div rendered="#{caseInterventionsBean.renderGroupBarMode}"
           styleClass="barGroupSelection">
      <h:commandLink action="#{caseInterventionsBean.showGroup}" style="color:black">
        <h:graphicImage value="/images/expand.gif" rendered="#{not caseInterventionsBean.renderGroup}"/>
        <h:graphicImage value="/images/collapse.gif" rendered="#{caseInterventionsBean.renderGroup}"/>
        <h:outputText value="#{group.description}" style="margin-left:2px"/>
      </h:commandLink>
    </t:div>    

    <t:buffer into="#{table}">
      
      <t:div rendered="#{caseInterventionsBean.inactiveHidden}" styleClass="warnMessage_line">
        <t:outputText value="#{caseBundle.caseInterventions_inactiveHiddenWarning}" />
      </t:div>

      <t:dataTable id="dataTable" 
        first="#{caseInterventionsBean.firstRowIndex}"
        value="#{caseInterventionsBean.rows}" 
        var="row"
        rowClasses="row1,row2" headerClass="header" footerClass="footer"
        rowIndexVar="index"
        rowStyleClass="#{caseInterventionsBean.editingIntervention != null and row.intId == caseInterventionsBean.editingIntervention.intId ? 'selectedRow' : ''} #{caseInterventionsBean.rowStyleClass} row#{(index % 2) + 1}"
        bodyStyle="#{empty caseInterventionsBean.rows ? 'display:none' : ''}"
        styleClass="resultList" style="width:100%"
        rows="#{caseInterventionsBean.pageSize}"
        rendered="#{caseInterventionsBean.renderGroup}">

        <f:facet name="header">
          <t:div styleClass="theader">
            <h:outputText value="#{group.description != '' ? (caseInterventionsBean.renderGroupSelection ? ' ' : group.description) : userSessionBean.selectedMenuItem.label}"
                          styleClass="textBox" style="width:85%"/>
            <t:dataScroller for="dataTable"
                            rowsCountVar="rowCount">
              <h:outputFormat styleClass="textBox" value="#{objectBundle.shortResultRange}">
                <f:param value="#{rowCount}" />
              </h:outputFormat>
            </t:dataScroller>
          </t:div>
        </f:facet>

        <t:column style="width:9%">
          <f:facet name="header">
            <h:outputText value="#{caseBundle.caseInterventions_id}:" />
          </f:facet>
          <h:outputText value="#{row.intId}" />
        </t:column>

        <t:column style="width:72%">

          <f:facet name="header">
            <h:outputText value="#{caseBundle.caseInterventions_startDate} / #{caseBundle.caseInterventions_type}:" />
          </f:facet>

          <t:div rendered="#{row.intId != null}">

            <t:div styleClass="mainProperties">
              <h:outputText value="#{caseInterventionsBean.viewStartDateTime}"/>
              <h:outputText value=" - #{caseInterventionsBean.viewEndDateTime}"
                            rendered="#{row.endDate != null and caseInterventionsBean.renderEndDate}" />
              <h:outputText value=": " rendered="#{row.startDate != null or row.endDate != null}" />
              <h:outputText value="#{caseInterventionsBean.typeDescription}"/>
            </t:div>

            <t:dataList value="#{caseInterventionsBean.viewProperties}" 
                        var="property">
              <t:div styleClass="propertyRow" rendered="#{caseInterventionsBean.propertyVisible and property.value != null and property.value != ''}">              
                <t:div styleClass="propName">
                  <h:outputText value="#{property.description}:" />
                </t:div>
                <t:div styleClass="propValue">
                  <h:outputText escape="false" value="#{property.value}" />
                </t:div>
              </t:div>
            </t:dataList>
            
            <t:div style="margin-top: 5px">
              <t:dataList value="#{caseInterventionsBean.problems}" 
                var="intProbView"
                rendered="#{caseInterventionsBean.renderProblems}">
                <t:div>
                  <t:graphicImage value="/images/item.gif" style="vertical-align:middle;margin-right:5px"/>
                  <h:outputText value="#{intProbView.probId}: #{intProbView.type}"
                                rendered="#{intProbView != ''}"
                                style="vertical-align:middle"/>
                  <h:commandButton action="#{caseInterventionsBean.showProblem}"
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
            
          </t:div>
        </t:column>

        <t:column style="width:19%" styleClass="actionsColumn">
          <h:panelGroup>
            <h:commandButton action="#{caseInterventionsBean.editIntervention}"
                             rendered="#{row.intId != null}"
                             disabled="#{!caseInterventionsBean.rowEditable}"
                             styleClass="editButton" value="#{objectBundle.edit}"
                             image="#{userSessionBean.icons.detail}"
                             alt="#{objectBundle.edit}" title="#{objectBundle.edit}" />
            <h:commandButton value="#{objectBundle.delete}"           
                             image="#{userSessionBean.icons.delete}"           
                             alt="#{objectBundle.delete}" title="#{objectBundle.delete}"
                             action="#{caseInterventionsBean.removeIntervention}"
                             rendered="#{row.intId != null}"
                             disabled="#{!caseBean.editable or !caseInterventionsBean.rowRemovable}"
                             styleClass="removeButton"
                             onclick="return confirm('#{objectBundle.confirm_remove}');" />
          </h:panelGroup>
        </t:column>
        <f:facet name="footer">
              <t:dataScroller for="dataTable"
                              fastStep="5"
                              paginator="true"
                              paginatorMaxPages="5"
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
                              renderFacetsIfSinglePage="false"
                              firstRowIndexVar="firstRow">
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
                    rendered="#{!caseInterventionsBean.singleGroup and ((groupIndex + 1) mod caseInterventionsBean.groupsPageSize == 0 or (groupIndex + 1 == groupCount))}"
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
    <t:commandButton action="#{caseInterventionsBean.switchInactive}" 
      image="#{caseInterventionsBean.inactiveHidden ? userSessionBean.icons.inactive_on :  userSessionBean.icons.inactive_off}"
      alt="#{caseInterventionsBean.inactiveHidden ? caseBundle.caseInterventions_showInactive : caseBundle.caseInterventions_hideInactive}" 
      title="#{caseInterventionsBean.inactiveHidden ? caseBundle.caseInterventions_showInactive : caseBundle.caseInterventions_hideInactive}" 
      styleClass="addButton"
      rendered="#{caseInterventionsBean.renderInactiveButton}"/>
    <h:commandButton value="#{objectBundle.add}"        
                     image="#{userSessionBean.icons.add}"
                     alt="#{objectBundle.add}" title="#{objectBundle.add}"
                     action="#{caseInterventionsBean.createIntervention}"
                     styleClass="addButton"
                     disabled="#{not caseBean.editable}"/>
  </t:div>

  <t:div rendered="#{caseInterventionsBean.editingIntervention != null}"
         styleClass="editingPanel">

    <t:div rendered="#{caseInterventionsBean.rootTypeId != 'Intervention'}">
      <h:outputText value="#{caseBundle.caseInterventions_type}:"
                    style="width:16%" styleClass="textBox"/>
      <sf:commandMenu value="#{caseInterventionsBean.currentTypeId}"
                      action="#{caseInterventionsBean.show}" styleClass="selectBox"
                      disabled="#{!caseBean.editable}">
        <f:selectItem itemLabel=" " itemValue="" />
        <f:selectItems value="#{caseInterventionsBean.allTypeItems}" />
      </sf:commandMenu>
      <h:commandButton action="#{caseInterventionsBean.showType}"
                       value="#{objectBundle.show}"
                       image="#{userSessionBean.icons.show}"
                       alt="#{objectBundle.show}" title="#{objectBundle.show}"
                       styleClass="showButton"
                       rendered="#{caseInterventionsBean.renderShowTypeButton}" /> 
    </t:div>

    <t:div>
      <h:outputText value="#{caseBundle.caseInterventions_startDate}: "  
                    style="width:16%" styleClass="textBox"/>
      <sf:calendar value="#{caseInterventionsBean.startDateTime}"
                   styleClass="calendarBox"
                   externalFormat="dd/MM/yyyy|HH:mm:ss"
                   internalFormat="yyyyMMddHHmmss"
                   buttonStyleClass="calendarButton"
                   style="width:14%;"
                   disabled="#{!caseBean.editable}"/>
    </t:div>

    <t:div rendered="#{!caseInterventionsBean.immediateClosing}">
      <h:outputText value="#{caseBundle.caseInterventions_endDate}: " 
                    style="width:16%" styleClass="textBox"/>
      <sf:calendar value="#{caseInterventionsBean.endDateTime}"
                   styleClass="calendarBox"
                   externalFormat="dd/MM/yyyy|HH:mm:ss"
                   internalFormat="yyyyMMddHHmmss"
                   buttonStyleClass="calendarButton"
                   style="width:14%"
                   disabled="#{!caseBean.editable}"/>
    </t:div>

    <t:div rendered="#{userSessionBean.selectedMenuItem.properties.showPersons != 'false' 
                       and caseInterventionsBean.renderPerson}">
      <h:outputText value="#{caseBundle.caseInterventions_person}: "  
                    style="width:16%" styleClass="textBox"/>
      <h:panelGroup>
        <t:selectOneMenu value="#{caseInterventionsBean.editingIntervention.personId}"
                         styleClass="selectBox" style="width:70%"
                         disabled="#{!caseBean.editable}">
          <f:selectItems value="#{caseInterventionsBean.personSelectItems}" />
        </t:selectOneMenu>
        <h:commandButton action="#{caseInterventionsBean.searchPerson}" 
                         styleClass="searchButton" value="#{objectBundle.search}"
                         image="#{userSessionBean.icons.search}"
                         alt="#{objectBundle.search}" title="#{objectBundle.search}"
                         disabled="#{!caseBean.editable}"
                         rendered="#{!caseInterventionsBean.renderCasePersons}"/>
        <h:commandButton action="#{caseInterventionsBean.showPerson}"
                         value="#{objectBundle.show}"
                         image="#{userSessionBean.icons.show}"
                         alt="#{objectBundle.show}" title="#{objectBundle.show}"
                         styleClass="showButton"
                         rendered="#{caseInterventionsBean.renderShowPersonButton}" />
      </h:panelGroup>
    </t:div>

    <t:div>
      <h:outputText value="#{caseBundle.caseInterventions_comments}: " 
                    style="width:16%;vertical-align:top" styleClass="textBox"/>
      <h:inputTextarea value="#{caseInterventionsBean.editingIntervention.comments}"
                       styleClass="inputBox" style="width:81%" rows="4"
                       onkeypress="checkMaxLength(this, #{caseInterventionsBean.propertySize.comments})"
                       readonly="#{!caseBean.editable}"/>
    </t:div>

 
    <!-- InterventionProblems -->
    <t:div rendered="#{caseInterventionsBean.renderProblems}"
           style="margin-top:20px">
      <h:outputText value="#{caseBundle.caseInterventions_solvedProblems}: "
        styleClass="blockHeader" />
    </t:div>       

      <t:div style="width:100%;margin-top:5px" rendered="#{caseInterventionsBean.renderProblems and not empty caseInterventionsBean.selectableProblemSelectItems}">
        <h:outputText value="#{caseBundle.caseInterventions_problem} :" 
                  style="width:16%" styleClass="textBox"/>
        <t:selectOneMenu value="#{caseInterventionsBean.selectedProblem}"
                      styleClass="selectBox"
                      style="width:77%">
          <f:selectItem itemLabel=" " itemValue="" />
          <f:selectItems value="#{caseInterventionsBean.selectableProblemSelectItems}" />
        </t:selectOneMenu>
        <h:commandButton value="#{objectBundle.add}"
                         image="#{userSessionBean.icons.add}"
                         alt="#{objectBundle.add}" title="#{objectBundle.add}"
                         styleClass="addButton"
                         action="#{caseInterventionsBean.addProblem}" 
                         rendered="#{not empty caseInterventionsBean.selectableProblemSelectItems}"
                         style="text-align:right"/>
      </t:div> 
    
      <t:dataList value="#{caseInterventionsBean.solvedProblems}" var="intProb" 
        style="width:100%" rowIndexVar="rowIndex" rowClasses="row1,row2"
        rendered="#{caseInterventionsBean.renderProblems}">
        <t:div style="width:100%;margin-top:5px">        
            <h:outputText value="#{caseBundle.caseInterventions_problem} #{rowIndex + 1}:" 
                          style="width:16%" styleClass="textBox"/>

            <h:outputText value="#{intProb.problem.probId} - #{caseInterventionsBean.intProbTypeDescription}" style="width:77%" styleClass="outputBox"/>
            <h:commandButton value="#{objectBundle.remove}"
                             image="#{userSessionBean.icons.remove}"
                             alt="#{objectBundle.remove}" title="#{objectBundle.remove}"
                             styleClass="removeButton"
                             action="#{caseInterventionsBean.removeProblem}" />
        </t:div>              
      </t:dataList>
    
    <t:div rendered="#{not caseInterventionsBean.typeUndefined and
                       caseInterventionsBean.selector != null}"
           style="margin-top:20px">
      <h:outputText value="#{caseBundle.caseInterventions_otherProperties}: "
        styleClass="blockHeader" />
    </t:div>        

    <t:div rendered="#{caseInterventionsBean.propertyEditorVisible || caseInterventionsBean.renderFormSelector}">
      <h:outputText value="#{caseBundle.caseInterventions_form}:"
                    styleClass="textBox" style="width:16%" />
      <sf:commandMenu value="#{caseInterventionsBean.selector}"
                      styleClass="selectBox" style="width:77%">
        <f:selectItems value="#{caseInterventionsBean.formSelectItems}" />
      </sf:commandMenu>
      <h:commandButton value="#{objectBundle.update}"
                       image="#{userSessionBean.icons.update}"
                       alt="#{objectBundle.update}" title="#{objectBundle.update}"
                       styleClass="showButton"
                       rendered="#{not caseInterventionsBean.propertyEditorVisible}"
                       action="#{caseInterventionsBean.updateForm}" />
    </t:div>

    <t:div rendered="#{caseInterventionsBean.renderForm}">
      <sf:dynamicForm 
        form="#{caseInterventionsBean.form}"
        rendererTypes="#{caseBean.editable ? 'HtmlFormRenderer,GenericFormRenderer' : 'DisabledHtmlFormRenderer'}"
        value="#{caseInterventionsBean.data}" 
        rendered="#{not caseInterventionsBean.propertyEditorVisible}" />
      <h:inputTextarea value="#{caseInterventionsBean.propertyEditorString}"
                       rendered="#{caseInterventionsBean.propertyEditorVisible}"
                       validator="#{caseInterventionsBean.validatePropertyEditorString}"
                       style="width:98%;height:100px; font-family:Courier New"
                       styleClass="inputBox"
                       readonly="#{!caseBean.editable}"/>
    </t:div>

    <t:div styleClass="actionsRow">
      <h:commandButton action="#{caseInterventionsBean.storeIntervention}" 
                       styleClass="addButton" value="#{objectBundle.store}"
                       disabled="#{!caseBean.editable}"
                       onclick="showOverlay()"/>
      <h:commandButton action="#{caseInterventionsBean.cancelIntervention}" 
                       styleClass="cancelButton" value="#{objectBundle.cancel}"
                       immediate="true"/>
    </t:div>
  </t:div>
    
    <t:saveState value="#{caseInterventionsBean}" />

</jsp:root>



