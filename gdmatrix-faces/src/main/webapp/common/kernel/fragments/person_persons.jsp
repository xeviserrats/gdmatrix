<?xml version='1.0' encoding='windows-1252'?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
          xmlns:f="http://java.sun.com/jsf/core"
          xmlns:h="http://java.sun.com/jsf/html"
          xmlns:t="http://myfaces.apache.org/tomahawk"
          xmlns:sf="http://www.santfeliu.org/jsf">

  <f:loadBundle basename="org.santfeliu.kernel.web.resources.KernelBundle" 
                var="kernelBundle" />

  <t:buffer into="#{table}">

    <t:dataTable id="data" value="#{personPersonsBean.rows}" var="row"
                 rowStyleClass="#{personPersonsBean.editingPerson != null and row.personPersonId == personPersonsBean.editingPerson.personPersonId ? 'selectedRow' : null}"
                 rowClasses="row1,row2" headerClass="header" footerClass="footer"
                 bodyStyle="#{empty personPersonsBean.rows ? 'display:none' : ''}"
                 styleClass="resultList" style="width:100%"
                 rows="#{personPersonsBean.pageSize}">
      <t:column style="width:10%">
        <f:facet name="header">
          <h:outputText value="Id:" />
        </f:facet>
        <h:outputText value="#{row.relPersonView.personId}" />
      </t:column>

      <t:column style="width:50%">
        <f:facet name="header">
          <h:outputText value="#{kernelBundle.person_full_name}:" />
        </f:facet>
        <h:outputText value="#{row.relPersonView.fullName}" />
      </t:column>

      <t:column style="width:20%">
        <f:facet name="header">
          <h:outputText value="#{kernelBundle.personPersons_type}:" />
        </f:facet>
        <h:outputText value="#{personPersonsBean.typeDescription}" />
      </t:column>

      <t:column style="width:20%" styleClass="actionsColumn">
        <h:panelGroup rendered="#{row.relPersonView != null}">
          <h:commandButton value="#{objectBundle.show}"
                           image="#{userSessionBean.icons.show}"
                           alt="#{objectBundle.show}" title="#{objectBundle.show}"
                           action="#{personPersonsBean.showPerson}"
                           styleClass="showButton" />
          <h:commandButton value="#{objectBundle.edit}"
                           image="#{userSessionBean.icons.detail}"
                           alt="#{objectBundle.edit}" title="#{objectBundle.edit}"
                           action="#{personPersonsBean.editPerson}"
                           styleClass="editButton" />
          <h:commandButton value="#{objectBundle.delete}"           
                           image="#{userSessionBean.icons.delete}"
                           alt="#{objectBundle.delete}" title="#{objectBundle.delete}"
                           action="#{personPersonsBean.removePerson}"
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

  <t:div styleClass="resultBar" rendered="#{personPersonsBean.rowCount > 0}">
    <t:dataScroller for="data"
                    rowsCountVar="rowCount">
      <h:outputFormat value="#{objectBundle.shortResultRange}">
        <f:param value="#{rowCount}" />
      </h:outputFormat>
    </t:dataScroller>
  </t:div>

  <h:outputText value="#{table}" escape="false"/>

  <t:div style="width:100%;text-align:right">
    <h:commandButton value="#{objectBundle.add}"
                     image="#{userSessionBean.icons.add}"
                     alt="#{objectBundle.add}"
                     title="#{objectBundle.add}"
                     rendered="#{row.relPersonView == null}"
                     action="#{personPersonsBean.addPerson}"
                     styleClass="addButton" />
  </t:div>

  <t:div styleClass="editingPanel"
            rendered="#{personPersonsBean.editingPerson != null}">
    <t:div>
      <h:outputText value="#{kernelBundle.personPersons_relPerson}: " styleClass="textBox" style="width:15%" />
      <h:panelGroup>
        <t:selectOneMenu value="#{personPersonsBean.editingPerson.relPersonId}"
                         style="width:350px" styleClass="selectBox">
          <f:selectItems value="#{personPersonsBean.personSelectItems}" />
        </t:selectOneMenu>
        
      </h:panelGroup>
      <h:commandButton value="#{objectBundle.search}"         
                       image="#{userSessionBean.icons.search}"
                       alt="#{objectBundle.search}" title="#{objectBundle.search}"
                       action="#{personPersonsBean.searchPerson}"
                       styleClass="searchButton" />
    </t:div>
    <t:div>
      <h:outputText value="#{kernelBundle.personPersons_type}:" styleClass="textBox" style="width:15%" />
      <t:selectOneMenu value="#{personPersonsBean.currentTypeId}"
                       styleClass="selectBox">
        <f:selectItems value="#{personPersonsBean.allTypeItems}" />
      </t:selectOneMenu>
    </t:div>
    <t:div>
      <h:outputText value="#{kernelBundle.personPersons_comments}:" styleClass="textBox" style="width:15%" />
      <h:inputText value="#{personPersonsBean.editingPerson.comments}"
                   styleClass="inputBox" style="width:440px"
                   maxlength="#{personMainBean.propertySize.comments}"        />
    </t:div>
    <t:div styleClass="actionsRow">
      <h:commandButton value="#{objectBundle.store}"
                       action="#{personPersonsBean.storePerson}"
                       styleClass="storeButton" />
      <h:commandButton value="#{objectBundle.cancel}"
                       action="#{personPersonsBean.cancelPerson}"
                       styleClass="cancelButton" />
    </t:div>
  </t:div>

</jsp:root>
