<?xml version='1.0' encoding='windows-1252'?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
          xmlns:f="http://java.sun.com/jsf/core"
          xmlns:h="http://java.sun.com/jsf/html"
          xmlns:t="http://myfaces.apache.org/tomahawk"
          xmlns:sf="http://www.santfeliu.org/jsf">

  <f:loadBundle basename="org.santfeliu.cases.web.resources.CaseBundle" 
                var="caseBundle" />

  <t:div style="width:100%"
      rendered="#{caseSearchBean.headerBrowserUrl!=null and caseSearchBean.headerRender}"
      styleClass="headerDocument">
    <sf:browser url="#{caseSearchBean.headerBrowserUrl}"
      port="#{applicationBean.defaultPort}"
      translator="#{userSessionBean.translator}"
      translationGroup="#{userSessionBean.translationGroup}" />
  </t:div>

  <t:div styleClass="filterPanel" rendered="#{caseSearchBean.renderFilterPanel}">
    
    <t:div styleClass="header"></t:div>   
    <!-- caseId -->
    <t:div styleClass="column1" rendered="#{caseSearchBean.renderCaseId}">
      <h:outputLabel value="#{objectBundle.object_id}:" rendered="#{caseSearchBean.renderCaseId}" for="caseId"/>
    </t:div>
    <t:div styleClass="column2" rendered="#{caseSearchBean.renderCaseId}">
      <h:inputText value="#{caseSearchBean.caseId}" id="caseId"
                 styleClass="inputBox" style="width:20%"
                 rendered="#{caseSearchBean.renderCaseId}"/>
    </t:div>
    <!-- type -->
    <t:div styleClass="column1" rendered="#{caseSearchBean.renderCaseType}">
      <h:outputLabel for="typeId" value="#{caseBundle.case_type}:"
                    rendered="#{caseSearchBean.renderCaseType}"/>
    </t:div>
    <t:div styleClass="column2" rendered="#{caseSearchBean.renderCaseType}">
      <sf:commandMenu id="typeId" value="#{caseSearchBean.currentTypeId}"
                      styleClass="selectBox"
                      action="#{caseSearchBean.reset}">
        <f:selectItems value="#{caseSearchBean.typeSelectItems}" />
      </sf:commandMenu>

      <h:commandButton value="#{objectBundle.search}"
                       image="#{userSessionBean.icons.search}"
                       alt="#{objectBundle.search}" title="#{objectBundle.search}"
                       styleClass="searchButton"
                       action="#{caseSearchBean.searchType}"
                       />
    </t:div>
    <!-- title -->
    <t:div styleClass="column1" rendered="#{caseSearchBean.renderTitle}">    
      <h:outputLabel for="title" value="#{caseBundle.case_title}:"
                    />
    </t:div>
    <t:div styleClass="column2" rendered="#{caseSearchBean.renderTitle}">
      <h:inputText id="title" value="#{caseSearchBean.titleInput}"
                   styleClass="inputBox" style="width:90%"
                   />
    </t:div>
    <!-- description -->
    <t:div styleClass="column1" rendered="#{caseSearchBean.renderDescription}">
      <h:outputLabel for="description" value="#{caseBundle.case_description}:"
                     rendered="#{caseSearchBean.renderDescription}"/>
    </t:div>
    <t:div styleClass="column2" rendered="#{caseSearchBean.renderDescription}">
      <h:inputText id="description" value="#{caseSearchBean.description}"
                   styleClass="inputBox" style="width:90%"
                    rendered="#{caseSearchBean.renderDescription}"/>
    </t:div>    
    <!-- date -->
    <t:div styleClass="column1" rendered="#{caseSearchBean.renderDate}">
      <h:outputLabel for="date" value="#{caseBundle.caseSearch_date}:"
                    rendered="#{caseSearchBean.renderDate}"/>
    </t:div>
    <t:div styleClass="column2" rendered="#{caseSearchBean.renderDate}">
      <t:selectOneMenu id="date" value="#{caseSearchBean.dateComparator}"
                       styleClass="selectBox" style="vertical-align:middle">
        <f:selectItem itemLabel=" " itemValue="0" />
        <f:selectItem itemLabel="#{caseBundle.case_startDate}" itemValue="1" />
        <f:selectItem itemLabel="#{caseBundle.case_endDate}" itemValue="2" />
        <f:selectItem itemLabel="#{caseBundle.caseSearch_activeDate}" itemValue="3" />
      </t:selectOneMenu>
      <h:outputLabel for="dateBetween" value=" #{caseBundle.caseSearch_between} " />
      <sf:calendar id="dateBetween" value="#{caseSearchBean.fromDate}"
                   styleClass="calendarBox"
                   buttonStyleClass="calendarButton"
                   style="width:15%;margin-left:2px"
                   />
      <h:outputLabel for="dateAnd" value=" #{caseBundle.caseSearch_and} " />
      <sf:calendar id="dateAnd" 
        value="#{caseSearchBean.toDate}"
        styleClass="calendarBox"
        buttonStyleClass="calendarButton"
        style="width:15%;margin-left:2px"/>
    </t:div>
    <!-- classId -->
    <t:div styleClass="column1" rendered="#{caseSearchBean.renderClassId}">
      <h:outputLabel for="classId" value="#{caseBundle.case_classId}:"
                    rendered="#{caseSearchBean.renderClassId}"/>
    </t:div>
    <t:div styleClass="column2"  rendered="#{caseSearchBean.renderClassId}">
      <h:inputText id="classId" value="#{caseSearchBean.classId}" styleClass="inputBox" />
      <h:commandButton value="#{objectBundle.search}"
                       image="#{userSessionBean.icons.search}"
                       alt="#{objectBundle.search}" title="#{objectBundle.search}"
                       styleClass="searchButton"
                       action="#{caseSearchBean.searchClass}"/>
    </t:div>
    <!-- personId -->
    <t:div styleClass="column1" rendered="#{caseSearchBean.renderPersonId}">
      <h:outputLabel for="person" value="#{caseBundle.case_person}:"
                    rendered="#{caseSearchBean.renderPersonId}"/>
    </t:div>
    <t:div styleClass="column2" rendered="#{caseSearchBean.renderPersonId}">      
      <t:selectOneMenu value="#{caseSearchBean.personFlag}"
                       styleClass="selectBox" style="vertical-align:middle">
        <f:selectItem itemLabel=" " itemValue="" />
        <f:selectItem itemLabel="#{caseBundle.caseSearch_activePerson}" itemValue="1" />
        <f:selectItem itemLabel="#{caseBundle.caseSearch_inactivePerson}" itemValue="0" />
      </t:selectOneMenu>       

      <sf:commandMenu id="person" value="#{caseSearchBean.personId}"
                      styleClass="selectBox">
        <f:selectItems value="#{caseSearchBean.personSelectItems}" />
      </sf:commandMenu>

      <h:commandButton value="#{objectBundle.search}"
                       image="#{userSessionBean.icons.search}"
                       alt="#{objectBundle.search}" title="#{objectBundle.search}"
                       styleClass="searchButton"
                       action="#{caseSearchBean.searchPerson}" />

    </t:div> 
    
    <!-- searchExpression -->
    <t:div styleClass="column1" rendered="#{caseSearchBean.renderSearchExpression}">
      <h:outputLabel for="searchExpression" value="#{caseBundle.case_searchExpression}:"
                    rendered="#{caseSearchBean.renderSearchExpression}"/>
    </t:div>
    <t:div styleClass="column2" rendered="#{caseSearchBean.renderSearchExpression}">
      <h:inputText id="searchExpression" value="#{caseSearchBean.searchExpression}"
                   styleClass="inputBox" style="width:90%"
                   rendered="#{caseSearchBean.renderSearchExpression}"/>
    </t:div>

    <!-- property 1 -->
    <t:div styleClass="column1" rendered="#{caseSearchBean.renderPropertyValueFilter}">
      <h:outputLabel for="propertyName1" value="#{caseBundle.caseSearch_property} / #{caseBundle.caseSearch_value} 1:"
                    rendered="#{caseSearchBean.renderPropertyValueFilter}"/>
    </t:div>
    <t:div styleClass="column2" rendered="#{caseSearchBean.renderPropertyValueFilter}">
      <h:inputText id="propertyName1" value="#{caseSearchBean.propertyName1}"
                   styleClass="inputBox" style="width:25%"/>
      <h:outputLabel for="propertyValue1" value=":" />
      <h:inputText id="propertyValue1" value="#{caseSearchBean.propertyValue1}"
                   styleClass="inputBox" style="width:63%"/>
    </t:div>

    <!-- property 2 -->
    <t:div styleClass="column1" rendered="#{caseSearchBean.renderPropertyValueFilter}" >
      <h:outputLabel for="propertyName2" value="#{caseBundle.caseSearch_property} / #{caseBundle.caseSearch_value} 2:"
                    rendered="#{caseSearchBean.renderPropertyValueFilter}"/>
    </t:div>
    <t:div styleClass="column2" rendered="#{caseSearchBean.renderPropertyValueFilter}">
      <h:inputText id="propertyName2" value="#{caseSearchBean.propertyName2}"
                   styleClass="inputBox" style="width:25%"/>
      <h:outputLabel for="propertyValuw2" value=":" />
      <h:inputText id="propertyValue2" value="#{caseSearchBean.propertyValue2}"
                   styleClass="inputBox" style="width:63%"/>
    </t:div>

<!-- Dynamic properties -->

    <t:div styleClass="footer">
        <t:div style="text-align:left" rendered="#{caseSearchBean.renderDynamicForm}">
          <t:collapsiblePanel var="collapsed" 
                              rendered="#{caseSearchBean.renderCollapsiblePanel}"
                              value="#{caseSearchBean.collapsePanel}">
            <f:facet name="header">
              <t:div styleClass="title" >
                <t:headerLink immediate="true">
                  <h:graphicImage value="/images/expand.gif" rendered="#{collapsed}"/>
                  <h:graphicImage value="/images/collapse.gif" rendered="#{!collapsed}"/>
                </t:headerLink>
                <sf:outputText value=" #{objectBundle.more_properties}: " 
                               translator="#{caseSearchBean.translator}"
                               translationGroup="#{userSessionBean.translationGroup}" />
              </t:div>
            </f:facet>
            <sf:dynamicForm
              form="#{caseSearchBean.form}"
              rendererTypes="HtmlFormRenderer"
              value="#{caseSearchBean.data}" />
          </t:collapsiblePanel>
          <sf:dynamicForm rendered="#{not caseSearchBean.renderCollapsiblePanel}"
            form="#{caseSearchBean.form}"
            rendererTypes="HtmlFormRenderer"
            value="#{caseSearchBean.data}"
            translator="#{userSessionBean.translator}"
            translationGroup="#{userSessionBean.translationGroup}"/>
        </t:div>
        
        <h:commandButton value="#{objectBundle.clear}"
                       styleClass="searchButton"
                       action="#{caseSearchBean.clearFilter}"
                       rendered="#{caseSearchBean.renderClearButton}"/>
        <h:commandButton id="default_button" value="#{objectBundle.search}"
                         styleClass="searchButton"
                         action="#{caseSearchBean.search}" 
                         onclick="showOverlay()"/>

      </t:div>
  </t:div>

  <t:buffer into="#{table}">
    <t:dataTable rows="#{caseSearchBean.pageSize}"
                 id="data" rowIndexVar="index"
                 first="#{caseSearchBean.firstRowIndex}"
                 value="#{caseSearchBean.rows}" var="row"
                 rendered="#{caseSearchBean.rowCount > 0}"
                 rowStyleClass="#{caseSearchBean.rowStyleClass} row#{(index % 2) + 1}"
                 styleClass="resultList"
                 rowClasses="row1,row2" headerClass="header" footerClass="footer">

      <t:columns value="#{caseSearchBean.columnNames}" var="column"
                 style="#{caseSearchBean.columnStyle}"
                 styleClass="#{caseSearchBean.columnStyleClass}">
        <f:facet name="header">
          <sf:outputText value="#{caseSearchBean.localizedColumnName}"
                        rendered="#{not (caseSearchBean.columnName == 'actions' and caseSearchBean.customColumn)}"
                        translator="#{caseSearchBean.translator}"
                        translationGroup="#{userSessionBean.translationGroup}"/>
        </f:facet>

        <!-- title link -->
        <h:panelGroup rendered="#{caseSearchBean.columnName == 'title' and caseSearchBean.customColumn}">
          <t:div rendered="#{caseSearchBean.columnName == 'title' and caseSearchBean.customColumn}"
                 styleClass="title">
             <h:commandLink target="_blank"
               action="#{caseSearchBean.showCase}">
              <sf:outputText value="#{caseSearchBean.columnValue}" escape="#{caseSearchBean.valueEscaped}" 
                             translator="#{caseSearchBean.translator}"
                             translationGroup="#{userSessionBean.translationGroup}"/>
            </h:commandLink>
          </t:div>
          <t:div styleClass="description">
            <sf:outputText value="#{row.description}" escape="#{caseSearchBean.valueEscaped}" 
                           translator="#{caseSearchBean.translator}"
                           translationGroup="#{userSessionBean.translationGroup}" />
          </t:div>
        </h:panelGroup>

        <h:panelGroup rendered="#{!caseSearchBean.customColumn}">
          <!-- render as command link -->
          <t:div rendered="#{caseSearchBean.submitColumn and not caseSearchBean.showParametersOnUrl}">
            <h:commandLink immediate="true"
                           action="#{caseSearchBean.showCase}"
                           rendered="#{caseSearchBean.submitColumn}">
              <sf:outputText value="#{caseSearchBean.columnValue}" escape="#{caseSearchBean.valueEscaped}"
                             translator="#{caseSearchBean.translator}"
                             translationGroup="#{userSessionBean.translationGroup}"/>
            </h:commandLink>
          </t:div>

          <!-- render as link -->
          <t:div rendered="#{caseSearchBean.linkColumn}">
            <h:outputLink target="_blank" value="#{caseSearchBean.columnValue}"
                          rendered="#{caseSearchBean.linkColumn}">
              <sf:outputText value="#{caseSearchBean.columnValue}" rendered="#{caseSearchBean.columnDescription == null}" escape="#{caseSearchBean.valueEscaped}" 
                             translator="#{caseSearchBean.translator}"
                             translationGroup="#{userSessionBean.translationGroup}"/>
              <sf:outputText value="#{caseSearchBean.columnDescription}" rendered="#{caseSearchBean.columnDescription != null}" escape="#{caseSearchBean.valueEscaped}" 
                             translator="#{caseSearchBean.translator}"
                             translationGroup="#{userSessionBean.translationGroup}" />
            </h:outputLink>
          </t:div>

          <!-- render as showlink -->
          <t:div rendered="#{caseSearchBean.showParametersOnUrl}" styleClass="#{caseSearchBean.columnName}">
            <h:outputLink value="#{caseSearchBean.showLinkUrl}"
                          >
              <sf:outputText value="#{caseSearchBean.columnValue}" rendered="#{caseSearchBean.columnDescription == null}" escape="#{caseSearchBean.valueEscaped}" 
                             translator="#{caseSearchBean.translator}"
                             translationGroup="#{userSessionBean.translationGroup}" />
              <sf:outputText value="#{caseSearchBean.columnDescription}" rendered="#{caseSearchBean.columnDescription != null}" escape="#{caseSearchBean.valueEscaped}" 
                             translator="#{caseSearchBean.translator}"
                             translationGroup="#{userSessionBean.translationGroup}"/>
            </h:outputLink>
          </t:div>

          <!-- render as image -->
          <t:div rendered="#{caseSearchBean.imageColumn and caseSearchBean.columnValue != null}">
            <h:graphicImage value="#{caseSearchBean.columnValue}"
              rendered="#{caseSearchBean.imageColumn and caseSearchBean.columnValue != null}"
              alt="#{caseSearchBean.columnDescription}"
              title="#{caseSearchBean.columnDescription}"/>
          </t:div>

          <!-- render as text -->
          <t:div rendered="#{not caseSearchBean.imageColumn and not caseSearchBean.linkColumn
                             and not caseSearchBean.submitColumn}">
            <sf:outputText value="#{caseSearchBean.columnValue}"
              rendered="#{not caseSearchBean.imageColumn and not caseSearchBean.linkColumn                        
                and not caseSearchBean.submitColumn}"
              escape="#{caseSearchBean.valueEscaped}" 
              translator="#{caseSearchBean.translator}"
              translationGroup="#{userSessionBean.translationGroup}" />
          </t:div>
        </h:panelGroup>

        <h:panelGroup rendered="#{caseSearchBean.columnName == 'actions'
          and caseSearchBean.customColumn}" styleClass="actionsColumn"
                      style="width:20%">
          <t:commandButton value="#{objectBundle.select}"
                           image="#{userSessionBean.icons.back}"
                           alt="#{objectBundle.select}" title="#{objectBundle.select}"
                           rendered="#{controllerBean.selectableNode}"
                           styleClass="selectButton" immediate="true"
                           action="#{caseSearchBean.selectCase}" />
          <t:commandButton value="#{objectBundle.show}"
                           image="#{userSessionBean.icons.show}"
                           alt="#{objectBundle.show}" title="#{objectBundle.show}"
                           styleClass="showButton" immediate="true"
                           onclick="showOverlay(); return true;"
                           action="#{caseSearchBean.showCase}"/>
        </h:panelGroup>

      </t:columns>

    </t:dataTable>
        
    <t:dataScroller for="data"
                    fastStep="100"
                    paginator="true"
                    paginatorMaxPages="9"
                    immediate="true"
                    rendered="#{caseSearchBean.rows != null}"
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
        <h:graphicImage value="/themes/#{userSessionBean.theme}/images/first.png" alt="#{objectBundle.first}" title="#{objectBundle.first}"/>
      </f:facet>
      <f:facet name="last">
        <h:graphicImage value="/themes/#{userSessionBean.theme}/images/last.png" alt="#{objectBundle.last}" title="#{objectBundle.last}"/>
      </f:facet>
      <f:facet name="previous">
        <h:graphicImage value="/themes/#{userSessionBean.theme}/images/previous.png" alt="#{objectBundle.previous}" title="#{objectBundle.previous}"/>
      </f:facet>
      <f:facet name="next">
        <h:graphicImage value="/themes/#{userSessionBean.theme}/images/next.png" alt="#{objectBundle.next}" title="#{objectBundle.next}"/>
      </f:facet>
      <f:facet name="fastrewind">
        <h:graphicImage value="/themes/#{userSessionBean.theme}/images/fastrewind.png" alt="#{objectBundle.fastRewind}" title="#{objectBundle.fastRewind}"/>
      </f:facet>
      <f:facet name="fastforward">
        <h:graphicImage value="/themes/#{userSessionBean.theme}/images/fastforward.png" alt="#{objectBundle.fastForward}" title="#{objectBundle.fastForward}"/>
      </f:facet>
    </t:dataScroller> 

  </t:buffer>

  <t:div styleClass="actionsBar top" 
    rendered="#{caseSearchBean.editorUser and userSessionBean.menuModel.browserType == 'desktop' 
                and caseSearchBean.rowCount > 2}">
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
          
  <t:div styleClass="resultBar" rendered="#{caseSearchBean.rows != null}">
    <t:dataScroller for="data"
                    firstRowIndexVar="firstRow"
                    lastRowIndexVar="lastRow"
                    rowsCountVar="rowCount"
                    rendered="#{caseSearchBean.rowCount > 0}">
      <h:outputFormat value="#{objectBundle.resultRange}"
                      style="margin-top:10px;display:block">
        <f:param value="#{firstRow}" />
        <f:param value="#{lastRow}" />
        <f:param value="#{rowCount}" />
      </h:outputFormat>
    </t:dataScroller>
    <sf:outputText value="#{objectBundle.no_results_found}"
                  rendered="#{caseSearchBean.rowCount == 0}" 
                  translator="#{caseSearchBean.translator}"
                  translationGroup="#{userSessionBean.translationGroup}" />
  </t:div>
          
  <t:div>                
    <h:outputText value="#{table}" escape="false"/>  
  </t:div>
          
  <t:div styleClass="actionsBar" rendered="#{caseSearchBean.editorUser and userSessionBean.menuModel.browserType == 'desktop'}">
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
      rendered="#{caseSearchBean.footerBrowserUrl!=null and caseSearchBean.footerRender}"
      styleClass="headerDocument">
    <sf:browser url="#{caseSearchBean.footerBrowserUrl}"
      port="#{applicationBean.defaultPort}"
      translator="#{userSessionBean.translator}"
      translationGroup="#{userSessionBean.translationGroup}" />
  </t:div>        

</jsp:root>
