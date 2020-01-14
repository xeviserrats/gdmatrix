<?xml version='1.0' encoding='windows-1252'?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
          xmlns:f="http://java.sun.com/jsf/core"
          xmlns:h="http://java.sun.com/jsf/html"
          xmlns:t="http://myfaces.apache.org/tomahawk"
          xmlns:sf="http://www.santfeliu.org/jsf">

  <f:loadBundle basename="org.santfeliu.kernel.web.resources.KernelBundle" 
    var="kernelBundle" />

  <h:panelGrid columns="2" styleClass="filterPanel" summary=""
    columnClasses="column1, column2"
    headerClass="header" footerClass="footer">

    <f:facet name="header">
      <h:outputText />
    </f:facet>

    <h:outputText value="#{objectBundle.object_id}:" />
    <h:inputText value="#{addressSearchBean.addressId}"
      styleClass="inputBox" style="width:14%" />

    <h:outputText value="#{kernelBundle.city_name}:" />
    <h:inputText value="#{addressSearchBean.cityName}"
      styleClass="inputBox" style="width:40%" />
    
    <h:outputText value="#{kernelBundle.address_type}:" style="width:14%" />
    <h:panelGroup>
      <t:selectOneMenu value="#{addressSearchBean.filter.addressTypeId}"
        styleClass="selectBox" style="width:40%">
        <f:selectItem itemValue="" itemLabel=" " />
        <f:selectItems value="#{addressSearchBean.typeSelectItems}" />
      </t:selectOneMenu>
    </h:panelGroup> 
    
    <h:outputText value="#{kernelBundle.street_type}:" style="width:14%" />
    <h:panelGroup>
      <t:selectOneMenu value="#{addressSearchBean.filter.streetTypeId}"
        styleClass="selectBox" style="width:40%">
        <f:selectItem itemValue="" itemLabel=" " />
        <f:selectItems value="#{addressSearchBean.streetTypeSelectItems}" />
      </t:selectOneMenu>
    </h:panelGroup>      

    <h:outputText value="#{kernelBundle.street_name}:" />
    <h:inputText value="#{addressSearchBean.filter.streetName}"
      styleClass="inputBox" style="width:40%" />

    <h:outputText value="#{kernelBundle.address_number}:" />
    <h:inputText value="#{addressSearchBean.filter.number}"
      styleClass="inputBox" style="width:10%" />

    <h:outputText value="#{kernelBundle.address_floor}:" />
    <h:inputText value="#{addressSearchBean.filter.floor}"
      styleClass="inputBox" style="width:10%" />

    <h:outputText value="#{kernelBundle.address_door}:" />
    <h:inputText value="#{addressSearchBean.filter.door}"
      styleClass="inputBox" style="width:10%" />

    <h:outputText value="#{kernelBundle.address_gis_reference}:" />
    <h:inputText value="#{addressSearchBean.filter.gisReference}"
      styleClass="inputBox" />

    <h:outputText value="#{kernelBundle.address_comments}:" />
    <h:inputText value="#{addressSearchBean.filter.comments}"
      styleClass="inputBox" style="width:80%" />

    <f:facet name="footer">
      <h:panelGroup>
        <h:commandButton value="#{objectBundle.clear}"
               styleClass="searchButton"
               action="#{addressSearchBean.clearFilter}"/>  
        <h:commandButton id="default_button" value="#{objectBundle.search}"
          action="#{addressSearchBean.search}" styleClass="searchButton"
          onclick="showOverlay()"/>
      </h:panelGroup>
    </f:facet>
  </h:panelGrid>

  <t:div styleClass="actionsBar top" rendered="#{addressSearchBean.rowCount > 2}">
     <h:commandButton value="#{objectBundle.current}" 
       image="#{userSessionBean.icons.current}"
       alt="#{objectBundle.current}" title="#{objectBundle.current}"
       action="#{addressBean.show}" immediate="true"
       styleClass="currentButton" />
     <h:commandButton value="#{objectBundle.create}"        
       image="#{userSessionBean.icons.new}"
       alt="#{objectBundle.create}" title="#{objectBundle.create}"
       action="#{addressBean.create}" immediate="true"
       styleClass="createButton" />
  </t:div>
  
  <t:div styleClass="resultBar" rendered="#{addressSearchBean.rows != null}">
    <t:dataScroller for="data"
      firstRowIndexVar="firstRow"
      lastRowIndexVar="lastRow"
      rowsCountVar="rowCount"
      rendered="#{addressSearchBean.rowCount > 0}">
      <h:outputFormat value="#{objectBundle.resultRange}"
        style="margin-top:10px;display:block">
        <f:param value="#{firstRow}" />
        <f:param value="#{lastRow}" />
        <f:param value="#{rowCount}" />
      </h:outputFormat>
    </t:dataScroller>
    <h:outputText value="#{objectBundle.no_results_found}"
      rendered="#{addressSearchBean.rowCount == 0}" />
  </t:div>

  <t:dataTable id="data" value="#{addressSearchBean.rows}" var="row"
    rows="#{addressSearchBean.pageSize}"
    styleClass="resultList" summary="results"
    first="#{addressSearchBean.firstRowIndex}"
    rendered="#{addressSearchBean.rowCount > 0}"
    rowStyleClass="#{row.addressId == addressBean.objectId ? 'selectedRow' : null}"
    rowClasses="row1,row2" headerClass="header" footerClass="footer">
    <t:column style="width:10%">
      <f:facet name="header">
        <h:outputText value="Id" />
      </f:facet>
      <h:outputText value="#{row.addressId}" />
    </t:column>
    <t:column style="width:70%">
      <f:facet name="header">
        <h:outputText value="#{kernelBundle.address}" />
      </f:facet>
      <h:outputText value="#{row.description} - #{row.city} (#{row.province})" />
    </t:column>
    <t:column style="width:20%" styleClass="actionsColumn">
      <h:commandButton value="#{objectBundle.select}"
        image="#{userSessionBean.icons.back}"
        alt="#{objectBundle.select}" title="#{objectBundle.select}"
        rendered="#{controllerBean.selectableNode}"
        styleClass="selectButton" immediate="true"
        action="#{addressSearchBean.selectAddress}"/>
      <h:commandButton value="#{objectBundle.show}"
        image="#{userSessionBean.icons.show}"
        alt="#{objectBundle.show}" title="#{objectBundle.show}"
        styleClass="showButton"
        action="#{addressSearchBean.showAddress}" />
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
     <h:commandButton value="#{objectBundle.current}" 
       image="#{userSessionBean.icons.current}"
       alt="#{objectBundle.current}" title="#{objectBundle.current}"
       action="#{addressBean.show}" immediate="true"
       styleClass="currentButton" />
     <h:commandButton value="#{objectBundle.create}"        
       image="#{userSessionBean.icons.new}"
       alt="#{objectBundle.create}" title="#{objectBundle.create}"
       action="#{addressBean.create}" immediate="true"
       styleClass="createButton" />
  </t:div>

</jsp:root>
