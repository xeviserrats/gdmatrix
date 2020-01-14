<?xml version='1.0' encoding='windows-1252'?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
          xmlns:f="http://java.sun.com/jsf/core"
          xmlns:h="http://java.sun.com/jsf/html"
          xmlns:t="http://myfaces.apache.org/tomahawk"
          xmlns:sf="http://www.santfeliu.org/jsf">

  <f:loadBundle basename="org.santfeliu.web.obj.resources.ObjectBundle"
                var="objectBundle" />

  <f:loadBundle basename="org.santfeliu.dic.web.resources.DictionaryBundle"
                var="dictionaryBundle" />

  <t:buffer into="#{table}">
    <t:dataTable id="data" value="#{enumTypeItemsBean.rows}" var="row"
                 rowStyleClass="#{enumTypeItemsBean.editingItem == null ? null :
                   (enumTypeItemsBean.editingItem.value == row.value ? 'selectedRow' : null)}"
                 rowClasses="row1,row2" headerClass="header" footerClass="footer"
                 styleClass="resultList" style="width:100%"
                 bodyStyle="#{empty enumTypeItemsBean.rows ? 'display:none' : ''}"
                 rendered="#{!enumTypeItemsBean.new}"
                 rows="#{enumTypeItemsBean.pageSize}"
                 first="#{enumTypeItemsBean.firstRowIndex}">
    <t:column style="width:10%">
      <f:facet name="header">
        <h:outputText value="#{dictionaryBundle.enumTypeItems_index}:" />
      </f:facet>
      <h:outputText value="#{row.index}" />
    </t:column>
    <t:column style="width:45%">
      <f:facet name="header">
        <h:outputText value="#{dictionaryBundle.enumTypeItems_label}:" />
      </f:facet>
      <h:outputText value="#{row.label}" />
    </t:column>
    <t:column style="width:20%">
      <f:facet name="header">
        <h:outputText value="#{dictionaryBundle.enumTypeItems_value}:" />
      </f:facet>
      <h:outputText value="#{row.value}" />
    </t:column>
    <t:column style="width:25%;text-align:right">
      <h:panelGroup>
        <h:commandButton value="#{objectBundle.moveUp}"
          image="#{userSessionBean.icons.up}"
          alt="#{objectBundle.moveUp}" title="#{objectBundle.moveUp}"
          action="#{enumTypeItemsBean.moveUpItem}"
          disabled="#{enumTypeItemsBean.editingItem != null}"
          rendered="#{enumTypeItemsBean.renderMoveUpIcon}"
          styleClass="addButton" />
        <h:commandButton value="#{objectBundle.moveDown}"
          image="#{userSessionBean.icons.down}"
          alt="#{objectBundle.moveDown}" title="#{objectBundle.moveDown}"
          action="#{enumTypeItemsBean.moveDownItem}"
          disabled="#{enumTypeItemsBean.editingItem != null}"
          rendered="#{enumTypeItemsBean.renderMoveDownIcon}"
          styleClass="addButton" />
        <h:commandButton value="#{objectBundle.insertHere}"
          image="#{userSessionBean.icons.add}"
          alt="#{objectBundle.insertHere}" title="#{objectBundle.insertHere}"
          action="#{enumTypeItemsBean.createItemBeforeRow}"
          disabled="#{enumTypeItemsBean.editingItem != null}"
          rendered="#{enumTypeItemsBean.renderInsertHereIcon}"
          styleClass="addButton" />
        <h:commandButton value="#{objectBundle.edit}"
          image="#{userSessionBean.icons.detail}"
          alt="#{objectBundle.edit}" title="#{objectBundle.edit}"
          action="#{enumTypeItemsBean.editItem}"
          disabled="#{enumTypeItemsBean.editingItem != null}"
          styleClass="addButton"  />
        <h:commandButton value="#{objectBundle.delete}"
          image="#{userSessionBean.icons.delete}"
          alt="#{objectBundle.delete}" title="#{objectBundle.delete}"
          action="#{enumTypeItemsBean.removeItem}"
          disabled="#{enumTypeItemsBean.editingItem != null}"
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

  <t:div styleClass="resultBar" rendered="#{enumTypeItemsBean.rowCount > 0}">
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
    <h:commandButton action="#{enumTypeItemsBean.createItem}"
                     disabled="#{enumTypeItemsBean.editingItem != null}"
                     styleClass="addButton" value="#{objectBundle.add}"
                     image="#{userSessionBean.icons.add}"
                     alt="#{objectBundle.add}" title="#{objectBundle.add}" />
  </t:div>

  <t:div styleClass="editingPanel" rendered="#{enumTypeItemsBean.editingItem != null}">

    <t:div>
      <h:outputText value="#{dictionaryBundle.enumTypeItems_index}:" styleClass="textBox"
                    style="width:15%" />
      <h:inputText value="#{enumTypeItemsBean.editingItem.index}" styleClass="inputBox"
                    style="width:10%" />
    </t:div>

    <t:div>
      <h:outputText value="#{dictionaryBundle.enumTypeItems_label}:" styleClass="textBox"
                    style="width:15%" />
      <h:inputText value="#{enumTypeItemsBean.editingItem.label}" styleClass="inputBox"
                    style="width:80%" />
    </t:div>

    <t:div>
      <h:outputText value="#{dictionaryBundle.enumTypeItems_value}:" styleClass="textBox"
                    style="width:15%" />

      <sf:calendar value="#{enumTypeItemsBean.editingItem.value}"
        styleClass="calendarBox"
        externalFormat="dd/MM/yyyy"
        internalFormat="yyyyMMddHHmmss"
        buttonStyleClass="calendarButton"
        style="width:14%;"
        rendered="#{enumTypeItemsBean.dateType}" />

      <t:selectOneMenu value="#{enumTypeItemsBean.editingItem.value}"
                       styleClass="selectBox"
                       rendered="#{enumTypeItemsBean.booleanType}">
        <f:selectItem itemLabel=" " itemValue="" />
        <f:selectItem itemLabel="true" itemValue="true" />
        <f:selectItem itemLabel="false" itemValue="false" />
      </t:selectOneMenu>
      
      <h:inputText value="#{enumTypeItemsBean.editingItem.value}" styleClass="inputBox"
                    style="width:80%" rendered="#{!enumTypeItemsBean.dateType
                    and !enumTypeItemsBean.booleanType}" />
    </t:div>

    <t:div>
      <h:outputText value="#{dictionaryBundle.enumTypeItems_description}:" styleClass="textBox"
                    style="width:15%" />
      <h:inputTextarea value="#{enumTypeItemsBean.editingItem.description}" styleClass="inputBox"
                    style="width:80%"  />
    </t:div>

    <t:div styleClass="actionsRow">
      <h:commandButton action="#{enumTypeItemsBean.storeItem}"
                       styleClass="addButton" value="#{objectBundle.store}"
                       alt="#{objectBundle.store}" title="#{objectBundle.store}" />
      <h:commandButton action="#{enumTypeItemsBean.cancelItem}"
                       styleClass="cancelButton" value="#{objectBundle.cancel}"
                       alt="#{objectBundle.cancel}" title="#{objectBundle.cancel}" />
    </t:div>

  </t:div>

</jsp:root>
