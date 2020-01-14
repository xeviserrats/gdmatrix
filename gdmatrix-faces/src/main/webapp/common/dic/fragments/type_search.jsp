<?xml version='1.0' encoding='windows-1252'?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
          xmlns:f="http://java.sun.com/jsf/core"
          xmlns:h="http://java.sun.com/jsf/html"
          xmlns:t="http://myfaces.apache.org/tomahawk"
          xmlns:sf="http://www.santfeliu.org/jsf">

  <f:loadBundle basename="org.santfeliu.dic.web.resources.DictionaryBundle"
    var="dictionaryBundle" />

  <h:panelGrid columns="2" styleClass="filterPanel" summary=""
    columnClasses="column1, column2"
    headerClass="header" footerClass="footer">
    <f:facet name="header">
      <h:outputText />
    </f:facet>

    <h:outputText value="#{dictionaryBundle.type_rootTypeId}:" />
    <t:selectOneMenu value="#{typeSearchBean.rootTypeId}"
      styleClass="selectBox" style="font-family:Courier New;width:40%">
        <f:selectItem itemValue="" itemLabel=" " />
        <f:selectItems value="#{typeBean.rootTypeIdSelectItems}" />
    </t:selectOneMenu>

    <h:outputText value="#{dictionaryBundle.type_typeId}:" />
    <h:inputText value="#{typeSearchBean.filter.typeId}"
      styleClass="inputBox" style="font-family:Courier New;width:40%"/>

    <h:outputText value="#{dictionaryBundle.type_superTypeId}:" />
    <h:panelGroup>
      <h:inputText value="#{typeSearchBean.filter.superTypeId}"
        styleClass="inputBox" style="font-family:Courier New;width:40%"/>
    </h:panelGroup>

    <h:outputText value="#{dictionaryBundle.type_description}:" />
    <h:inputText value="#{typeSearchBean.filter.description}"
      styleClass="inputBox" style="width:80%"/>

    <f:facet name="footer">
      <h:commandButton id="default_button" value="#{objectBundle.search}"
        action="#{typeSearchBean.search}" styleClass="searchButton" />
    </f:facet>
  </h:panelGrid>

  <t:div rendered="#{typeSearchBean.navigationEnabled}" styleClass="resultBar">
    <h:outputText value="#{dictionaryBundle.typeSearch_derivedTypesFrom} " />
    <t:dataList value="#{typeSearchBean.typePathList}" var="typeId">
      <h:outputText value="/ " />
      <h:commandLink value="#{typeId}"
        action="#{typeSearchBean.findDerivedTypesFromPath}"
        style="font-family:Courier New" />
    </t:dataList>
    <h:outputText value=":" />
  </t:div>

  <t:div styleClass="resultBar" rendered="#{typeSearchBean.rows != null}">
    <t:dataScroller for="data"
      firstRowIndexVar="firstRow"
      lastRowIndexVar="lastRow"
      rowsCountVar="rowCount"
      rendered="#{typeSearchBean.rowCount > 0}">
      <h:outputFormat value="#{objectBundle.resultRange}"
        style="margin-top:10px;display:block">
        <f:param value="#{firstRow}" />
        <f:param value="#{lastRow}" />
        <f:param value="#{rowCount}" />
      </h:outputFormat>
    </t:dataScroller>
    <h:outputText value="#{objectBundle.no_results_found}"
      rendered="#{typeSearchBean.rowCount == 0}" />
  </t:div>

  <t:dataTable id="data" value="#{typeSearchBean.rows}" var="row"
    rows="#{typeSearchBean.pageSize}"
    first="#{typeSearchBean.firstRowIndex}"
    rendered="#{typeSearchBean.rowCount > 0}"
    rowStyleClass="#{row.typeId == typeBean.objectId ? 'selectedRow' : null}"
    styleClass="resultList"
    rowClasses="row1,row2" headerClass="header" footerClass="footer">
    <t:column style="width:10%" >
      <f:facet name="header">
        <h:outputText value="#{dictionaryBundle.type_type}" />
      </f:facet>
      <h:panelGroup>
        <h:outputText value="#{row.typeId}" style="font-family:Courier New"
          styleClass="#{row.typeId == typeBean.objectId ? 'selected' : ''}" />
        <h:commandLink action="#{typeSearchBean.showInTree}"
          rendered="#{typeTreeBean.showInTreeEnabled}">
          <h:graphicImage url="/common/dic/images/tree.gif"
            alt="#{dictionaryBundle.type_show_in_tree}"
            style="border:none;vertical-align:middle;margin-left:4px" />
        </h:commandLink>
        <h:commandLink action="#{typeSearchBean.findDerivedTypes}"
          rendered="#{not typeSearchBean.leafType}">
          <h:graphicImage url="/common/dic/images/down.gif"
            alt="#{dictionaryBundle.type_show_derived_types}"
            style="border:none;vertical-align:middle;margin-left:4px" />
        </h:commandLink>
      </h:panelGroup>
    </t:column>
    <t:column style="width:20%">
      <f:facet name="header">
        <h:outputText value="#{dictionaryBundle.type_description}" />
      </f:facet>
      <h:outputText value="#{row.description}"
        styleClass="#{row.typeId == typeBean.objectId ? 'selected' : ''}"/>
    </t:column>
    <t:column style="width:10%">
      <f:facet name="header">
        <h:outputText value="#{dictionaryBundle.type_superType}" />
      </f:facet>
      <h:outputText value="#{row.superTypeId}" style="font-family:Courier New"
        styleClass="#{row.typeId == typeBean.objectId ? 'selected' : ''}"/>
    </t:column>
    <t:column style="width:12%" styleClass="actionsColumn">
      <h:panelGroup>
      <h:commandButton value="#{objectBundle.select}"
        image="#{userSessionBean.icons.back}"
        alt="#{objectBundle.select}" title="#{objectBundle.select}"
        rendered="#{controllerBean.selectableNode}"
        styleClass="selectButton" immediate="true"
        action="#{typeSearchBean.selectType}" />
      <h:commandButton value="#{objectBundle.show}" 
        image="#{userSessionBean.icons.show}"
        alt="#{objectBundle.show}" title="#{objectBundle.show}"
        styleClass="showButton" immediate="true"
        action="#{typeSearchBean.showType}" />
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
     <h:commandButton value="#{objectBundle.current}" image="#{userSessionBean.icons.current}" alt="#{objectBundle.current}" title="#{objectBundle.current}"
       action="#{typeBean.show}" immediate="true"
       styleClass="currentButton" />
     <h:commandButton value="#{objectBundle.create}"        image="#{userSessionBean.icons.new}"        alt="#{objectBundle.create}" title="#{objectBundle.create}"
       action="#{typeBean.create}" immediate="true"
       styleClass="createButton" />
  </t:div>

</jsp:root>
