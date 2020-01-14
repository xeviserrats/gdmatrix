<?xml version='1.0' encoding='windows-1252'?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
          xmlns:f="http://java.sun.com/jsf/core"
          xmlns:h="http://java.sun.com/jsf/html"
          xmlns:t="http://myfaces.apache.org/tomahawk"
          xmlns:sf="http://www.santfeliu.org/jsf">

  <f:loadBundle basename="org.santfeliu.cases.web.resources.CaseBundle" 
                var="caseBundle" />

  <t:div style="width:100%"
      rendered="#{interventionSearchBean.headerBrowserUrl!=null and interventionSearchBean.headerRender}"
      styleClass="headerDocument">
    <sf:browser url="#{interventionSearchBean.headerBrowserUrl}"
      port="#{applicationBean.defaultPort}"
      translator="#{userSessionBean.translator}"
      translationGroup="#{userSessionBean.translationGroup}" />
  </t:div>

  <h:panelGrid columns="2" styleClass="filterPanel" summary=""
               columnClasses="column1, column2"
               headerClass="header" footerClass="footer"
               rendered="#{interventionSearchBean.renderFilterPanel}">
    <f:facet name="header">
      <h:outputText />
    </f:facet>

    <h:outputText value="#{objectBundle.object_id}:"  rendered="#{interventionSearchBean.renderIntId}"/>
    <h:inputText value="#{interventionSearchBean.intId}"
                 styleClass="inputBox" style="width:20%"
                 rendered="#{interventionSearchBean.renderIntId}"/>
    
    <h:outputText value="#{caseBundle.caseInterventions_case}:" styleClass="textBox" 
       rendered="#{interventionSearchBean.renderCaseId}"/>
    <h:panelGroup>
      <t:selectOneMenu value="#{interventionSearchBean.caseId}"
        styleClass="selectBox" style="width:80%">
        <f:selectItems value="#{interventionSearchBean.caseSelectItems}" />
      </t:selectOneMenu>
      <h:commandButton value="#{objectBundle.search}"
        image="#{userSessionBean.icons.search}"
        alt="#{objectBundle.search}" title="#{objectBundle.search}"
        styleClass="searchButton"
        action="#{interventionSearchBean.searchCase}"/>
    </h:panelGroup>    

    <h:outputText value="#{caseBundle.caseInterventions_person}:" styleClass="textBox" 
       rendered="#{interventionSearchBean.renderPerson}"/>
    <h:panelGroup>
      <t:selectOneMenu value="#{interventionSearchBean.personId}"
        styleClass="selectBox">
        <f:selectItems value="#{interventionSearchBean.personSelectItems}" />
      </t:selectOneMenu>
      <h:commandButton value="#{objectBundle.search}"
        image="#{userSessionBean.icons.search}"
        alt="#{objectBundle.search}" title="#{objectBundle.search}"
        styleClass="searchButton"
        action="#{interventionSearchBean.searchPerson}"/>
    </h:panelGroup>

    <h:outputText value="#{caseBundle.caseInterventions_type}:"
                  rendered="#{interventionSearchBean.renderCaseType}"/>
    <h:panelGroup rendered="#{interventionSearchBean.renderCaseType}">

      <sf:commandMenu value="#{interventionSearchBean.currentTypeId}"
                      styleClass="selectBox"
                      action="#{interventionSearchBean.reset}">
        <f:selectItems value="#{interventionSearchBean.typeSelectItems}" />
      </sf:commandMenu>

      <h:commandButton value="#{objectBundle.search}"
                       image="#{userSessionBean.icons.search}"
                       alt="#{objectBundle.search}" title="#{objectBundle.search}"
                       styleClass="searchButton"
                       action="#{interventionSearchBean.searchType}" />
    </h:panelGroup>

    <h:outputText value="#{caseBundle.caseInterventions_comments}:"
                  rendered="#{interventionSearchBean.renderComments}"/>
    <h:inputText value="#{interventionSearchBean.comments}"
                 styleClass="inputBox" style="width:90%"
                 rendered="#{interventionSearchBean.renderComments}"/>

    <h:outputText value="#{caseBundle.caseSearch_date}:"
                  rendered="#{interventionSearchBean.renderDate}"/>
    <h:panelGroup rendered="#{interventionSearchBean.renderDate}">
      <t:selectOneMenu value="#{interventionSearchBean.dateComparator}"
                       styleClass="selectBox" style="vertical-align:middle">
        <f:selectItem itemLabel=" " itemValue="0" />
        <f:selectItem itemLabel="#{caseBundle.caseInterventions_startDate}" itemValue="1" />
        <f:selectItem itemLabel="#{caseBundle.caseInterventions_endDate}" itemValue="2" />
        <f:selectItem itemLabel="#{caseBundle.caseSearch_activeDate}" itemValue="3" />
      </t:selectOneMenu>
      <h:outputText value=" #{caseBundle.caseSearch_between} " />
      <sf:calendar value="#{interventionSearchBean.fromDate}"
                   styleClass="calendarBox"
                   buttonStyleClass="calendarButton"
                   style="width:15%;margin-left:2px"
                   />
      <h:outputText value=" #{caseBundle.caseSearch_and} " />
      <sf:calendar 
        value="#{interventionSearchBean.toDate}"
        styleClass="calendarBox"
        buttonStyleClass="calendarButton"
        style="width:15%;margin-left:2px"/>
    </h:panelGroup>

    <h:outputText value="#{caseBundle.caseSearch_property} / #{caseBundle.caseSearch_value} 1:"
                  rendered="#{interventionSearchBean.renderPropertyValueFilter}"/>
    
      <h:panelGroup rendered="#{interventionSearchBean.renderPropertyValueFilter}">
        <h:inputText value="#{interventionSearchBean.propertyName1}"
                     styleClass="inputBox" style="width:25%"/>
        <h:outputText value=":" />
        <h:inputText value="#{interventionSearchBean.propertyValue1}"
                     styleClass="inputBox" style="width:63%"/>
      </h:panelGroup>

    <h:outputText value="#{caseBundle.caseSearch_property} / #{caseBundle.caseSearch_value} 2:"
                  rendered="#{interventionSearchBean.renderPropertyValueFilter}"/>
    <h:panelGroup rendered="#{interventionSearchBean.renderPropertyValueFilter}">
      <h:inputText value="#{interventionSearchBean.propertyName2}"
                   styleClass="inputBox" style="width:25%"/>
      <h:outputText value=":" />
      <h:inputText value="#{interventionSearchBean.propertyValue2}"
                   styleClass="inputBox" style="width:63%"/>
    </h:panelGroup>

<!-- Dynamic properties -->
    <f:facet name="footer">
      <h:panelGroup>
        <t:div style="text-align:left" rendered="#{interventionSearchBean.renderDynamicForm}">
          <t:collapsiblePanel var="collapsed"
                              rendered="#{interventionSearchBean.renderCollapsiblePanel}">
            <f:facet name="header">
              <t:div styleClass="title" >
                <t:headerLink immediate="true">
                  <h:graphicImage value="/images/expand.gif" rendered="#{collapsed}"/>
                  <h:graphicImage value="/images/collapse.gif" rendered="#{!collapsed}"/>
                </t:headerLink>
                <h:outputText value=" #{objectBundle.more_properties}: " />
              </t:div>
            </f:facet>
            <sf:dynamicForm
              form="#{interventionSearchBean.form}"
              rendererTypes="HtmlFormRenderer"
              value="#{interventionSearchBean.data}" />
          </t:collapsiblePanel>
          <sf:dynamicForm rendered="#{not interventionSearchBean.renderCollapsiblePanel}"
            form="#{interventionSearchBean.form}"
            rendererTypes="HtmlFormRenderer"
            value="#{interventionSearchBean.data}" />
        </t:div>
        <h:commandButton value="#{objectBundle.clear}"
                       styleClass="searchButton"
                       action="#{interventionSearchBean.clearFilter}"
                       rendered="#{interventionSearchBean.renderClearButton}"/>
        <h:commandButton id="default_button" value="#{objectBundle.search}"
                         styleClass="searchButton"
                         action="#{interventionSearchBean.search}" 
                         onclick="showOverlay()"/>
      </h:panelGroup>
    </f:facet>

  </h:panelGrid>

  <t:buffer into="#{table}">
    <t:dataTable rows="#{interventionSearchBean.pageSize}"
                 id="data" rowIndexVar="index"
                 first="#{interventionSearchBean.firstRowIndex}"
                 value="#{interventionSearchBean.rows}" var="row"
                 rendered="#{interventionSearchBean.rowCount > 0}"
                 rowStyleClass="#{interventionSearchBean.rowStyleClass} row#{(index % 2) + 1}"
                 styleClass="resultList"
                 rowClasses="row1,row2" headerClass="header" footerClass="footer">

      <t:columns value="#{interventionSearchBean.columnNames}" var="column"
                 style="#{interventionSearchBean.columnStyle}"
                 styleClass="#{interventionSearchBean.columnStyleClass}">
        <f:facet name="header">
          <h:outputText value="#{interventionSearchBean.localizedColumnName}"
                        rendered="#{not (interventionSearchBean.columnName == 'actions' and interventionSearchBean.customColumn)}"/>
        </f:facet>

        <!-- title link -->
        <h:panelGroup rendered="#{interventionSearchBean.columnName == 'comments' and interventionSearchBean.customColumn}">
          <t:div rendered="#{interventionSearchBean.columnName == 'comments' and interventionSearchBean.customColumn}"
                 styleClass="title">
             <h:commandLink target="_blank"
               action="#{interventionSearchBean.showCase}">
              <h:outputText value="#{interventionSearchBean.columnValue}" />
            </h:commandLink>
          </t:div>
        </h:panelGroup>

        <h:panelGroup rendered="#{!interventionSearchBean.customColumn}">
          <!-- render as command link -->
          <t:div rendered="#{interventionSearchBean.submitColumn and not interventionSearchBean.showParametersOnUrl}">
            <h:commandLink immediate="true"
                           action="#{interventionSearchBean.showCase}"
                           rendered="#{interventionSearchBean.submitColumn}">
              <h:outputText value="#{interventionSearchBean.columnValue}"/>
            </h:commandLink>
          </t:div>

          <!-- render as link -->
          <t:div rendered="#{interventionSearchBean.linkColumn}">
            <h:outputLink target="_blank" value="#{interventionSearchBean.columnValue}"
                          rendered="#{interventionSearchBean.linkColumn}">
              <h:outputText value="#{interventionSearchBean.columnValue}" rendered="#{interventionSearchBean.columnDescription == null}"/>
              <h:outputText value="#{interventionSearchBean.columnDescription}" rendered="#{interventionSearchBean.columnDescription != null}"/>
            </h:outputLink>
          </t:div>

          <!-- render as showlink -->
          <t:div rendered="#{interventionSearchBean.showParametersOnUrl}" styleClass="#{interventionSearchBean.columnName}">
            <h:outputLink value="#{interventionSearchBean.showLinkUrl}"
                          >
              <h:outputText value="#{interventionSearchBean.columnValue}" rendered="#{interventionSearchBean.columnDescription == null}"/>
              <h:outputText value="#{interventionSearchBean.columnDescription}" rendered="#{interventionSearchBean.columnDescription != null}"/>
            </h:outputLink>
          </t:div>

          <!-- render as image -->
          <t:div rendered="#{interventionSearchBean.imageColumn and interventionSearchBean.columnValue != null}">
            <h:graphicImage value="#{interventionSearchBean.columnValue}"
              rendered="#{interventionSearchBean.imageColumn and interventionSearchBean.columnValue != null}"
              alt="#{interventionSearchBean.columnDescription}"
              title="#{interventionSearchBean.columnDescription}"/>
          </t:div>

          <!-- render as text -->
          <t:div rendered="#{not interventionSearchBean.imageColumn and not interventionSearchBean.linkColumn
                             and not interventionSearchBean.submitColumn}">
            <h:outputText value="#{interventionSearchBean.columnValue}"
              rendered="#{not interventionSearchBean.imageColumn and not interventionSearchBean.linkColumn                        
                and not interventionSearchBean.submitColumn}"
              escape="#{interventionSearchBean.valueEscaped}" />
          </t:div>
        </h:panelGroup>

        <h:panelGroup rendered="#{interventionSearchBean.columnName == 'actions'
          and interventionSearchBean.customColumn}" styleClass="actionsColumn"
          style="width:20%">
          <h:commandButton value="#{objectBundle.select}"
                           image="#{userSessionBean.icons.back}"
                           alt="#{objectBundle.select}" title="#{objectBundle.select}"
                           rendered="#{controllerBean.selectableNode}"
                           styleClass="selectButton" immediate="true"
                           action="#{interventionSearchBean.selectIntervention}" />
          <h:commandButton value="#{objectBundle.show}"
                           image="#{userSessionBean.icons.show}"
                           alt="#{objectBundle.show}" title="#{objectBundle.show}"
                           styleClass="showButton" immediate="true"
                           action="#{interventionSearchBean.showIntervention}"/>
        </h:panelGroup>

      </t:columns>

      <f:facet name="footer">
        <t:dataScroller for="data"
                        fastStep="100"
                        paginator="true"
                        paginatorMaxPages="9"
                        immediate="true"
                        rendered="#{interventionSearchBean.rows != null}"
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

  <t:div styleClass="resultBar" rendered="#{interventionSearchBean.rows != null}">
    <t:dataScroller for="data"
                    firstRowIndexVar="firstRow"
                    lastRowIndexVar="lastRow"
                    rowsCountVar="rowCount"
                    rendered="#{interventionSearchBean.rowCount > 0}">
      <h:outputFormat value="#{objectBundle.resultRange}"
                      style="margin-top:10px;display:block">
        <f:param value="#{firstRow}" />
        <f:param value="#{lastRow}" />
        <f:param value="#{rowCount}" />
      </h:outputFormat>
    </t:dataScroller>
    <h:outputText value="#{objectBundle.no_results_found}"
                  rendered="#{interventionSearchBean.rowCount == 0}" />
  </t:div>
        
  <h:outputText value="#{table}" escape="false"/>          
          
  <t:div styleClass="actionsBar" rendered="#{interventionSearchBean.editorUser}">
    <h:commandButton value="#{objectBundle.current}"
                     image="#{userSessionBean.icons.current}"
                     alt="#{objectBundle.current}" title="#{objectBundle.current}"
                     action="#{caseBean.show}" immediate="true"
                     styleClass="currentButton" />
    <h:commandButton value="#{objectBundle.create}"
                     image="#{userSessionBean.icons.new}"
                     alt="#{objectBundle.create}" title="#{objectBundle.create}"
                     action="#{caseBean.create}" immediate="true"
                     styleClass="createButton" />
  </t:div>

  <t:div style="width:100%"
      rendered="#{interventionSearchBean.footerBrowserUrl!=null and interventionSearchBean.footerRender}"
      styleClass="headerDocument">
    <sf:browser url="#{interventionSearchBean.footerBrowserUrl}"
      port="#{applicationBean.defaultPort}"
      translator="#{userSessionBean.translator}"
      translationGroup="#{userSessionBean.translationGroup}" />
  </t:div>        

</jsp:root>
