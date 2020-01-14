<?xml version='1.0' encoding='windows-1252'?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
          xmlns:f="http://java.sun.com/jsf/core"
          xmlns:h="http://java.sun.com/jsf/html"
          xmlns:t="http://myfaces.apache.org/tomahawk"
          xmlns:sf="http://www.santfeliu.org/jsf">

  <f:loadBundle basename="org.santfeliu.kernel.web.resources.KernelBundle"
                var="kernelBundle" />

  <t:buffer into="#{table}">
    <t:dataTable id="data" value="#{personDocumentsBean.rows}" var="row"
                 rowClasses="row1,row2" headerClass="header" footerClass="footer"
                 styleClass="resultList" style="width:100%"
                 bodyStyle="#{empty personDocumentsBean.rows ? 'display:none' : ''}"
                 rendered="#{!personDocumentsBean.new}"
                 rows="#{personDocumentsBean.pageSize}">
      <t:column style="width:10%">
        <f:facet name="header">
          <h:outputText value="#{kernelBundle.personDocument_code}:" />
        </f:facet>
        <h:outputText value="#{row.document.docId}" />
      </t:column>
      <t:column style="width:45%">
        <f:facet name="header">
          <h:outputText value="#{kernelBundle.personDocument_title}:" />
        </f:facet>
        <h:outputText value="#{row.document.title}" />
      </t:column>

      <t:column style="width:15%">
        <f:facet name="header">
          <h:outputText value="#{kernelBundle.personDocument_typeId}:" />
        </f:facet>
        <h:outputText value="#{row.personDocTypeId}"/>
      </t:column>

      <t:column style="width:30%;text-align:right;">
        <h:panelGroup>
          <h:commandButton value="#{objectBundle.show}"
                           image="#{userSessionBean.icons.show}"
                           alt="#{objectBundle.show}" title="#{objectBundle.show}"
                           action="#{personDocumentsBean.showDocument}"
                           rendered="#{row.personDocId != null}"
                           styleClass="showButton"  />
          <h:commandButton
            action="#{personDocumentsBean.editPersonDocument}"
            rendered="#{row.personDocId != null}"
            styleClass="editButton" value="#{objectBundle.edit}"
            image="#{userSessionBean.icons.detail}"
            alt="#{objectBundle.edit}" title="#{objectBundle.edit}"/>
          <h:commandButton value="#{objectBundle.delete}"
                           image="#{userSessionBean.icons.delete}"
                           alt="#{objectBundle.delete}" title="#{objectBundle.delete}"
                           action="#{personDocumentsBean.removePersonDocument}"
                           rendered="#{row.personDocId != null}"
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

  <t:div styleClass="resultBar" rendered="#{personDocumentsBean.rowCount > 0}">
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
                     alt="#{objectBundle.add}" title="#{objectBundle.add}"
                     action="#{personDocumentsBean.createPersonDocument}"
                     rendered="#{row.personDocId == null}"
                     styleClass="addButton"/>
  </t:div>

  <t:div styleClass="editingPanel" rendered="#{personDocumentsBean.editingPersonDocument != null}">
    <t:div>
      <h:outputText value="#{kernelBundle.personDocument_document}: "
                    styleClass="textBox" style="width:15%" />
      <t:selectOneMenu value="#{personDocumentsBean.editingPersonDocument.docId}"
                       style="width:350px" styleClass="selectBox">
        <f:selectItems value="#{personDocumentsBean.personDocumentSelectItems}" />
      </t:selectOneMenu>
      <h:commandButton action="#{personDocumentsBean.searchDocument}"
                       styleClass="searchButton" value="#{objectBundle.search}"
                       image="#{userSessionBean.icons.search}"
                       alt="#{objectBundle.search}" title="#{objectBundle.search}"
                       />
    </t:div>

    <t:div>
      <h:outputText value="#{kernelBundle.personDocument_typeId}: "
                    style="width:15%" styleClass="textBox" />
      <t:selectOneMenu value="#{personDocumentsBean.editingPersonDocument.personDocTypeId}"
                       styleClass="selectBox">
        <f:selectItems
          value="#{personDocumentsBean.allTypeItems}" />
      </t:selectOneMenu>
      <h:commandButton action="#{personDocumentsBean.showType}"
        value="#{objectBundle.show}"
        image="#{userSessionBean.icons.show}"
        alt="#{objectBundle.show}" title="#{objectBundle.show}"
        styleClass="showButton"
        rendered="#{personDocumentsBean.renderShowTypeButton}" />
    </t:div>

    <t:div>
      <h:outputText value="#{kernelBundle.personDocument_comments}: "
                    style="width:15%" styleClass="textBox" />
      <h:inputTextarea value="#{personDocumentsBean.editingPersonDocument.comments}"
                       styleClass="inputBox" style="width:60%"
                       onkeypress="checkMaxLength(this, #{personDocumentsBean.propertySize.comments})"/>
    </t:div>

    <t:div rendered="#{personDocumentsBean.creationDateTime != null}">
      <h:outputText value="#{kernelBundle.personDocument_creationDateTime}:"
                    styleClass="textBox" style="width:15%" />
      <h:outputText value="#{personDocumentsBean.creationDateTime}"
                    styleClass="outputBox" style="width:22%">
        <f:convertDateTime pattern="dd/MM/yyyy HH:mm:ss" />
      </h:outputText>
      <h:outputText value="#{kernelBundle.personDocument_createdBy}:"
                    styleClass="textBox" style="width:5%"
                    rendered="#{personDocumentsBean.editingPersonDocument.creationUserId != null}"/>
      <h:outputText value="#{personDocumentsBean.editingPersonDocument.creationUserId}"
                    styleClass="outputBox" style="width:22%" />
    </t:div>

    <t:div rendered="#{personDocumentsBean.changeDateTime != null}">
      <h:outputText value="#{kernelBundle.personDocument_changeDateTime}:"
                    styleClass="textBox" style="width:15%" />
      <h:outputText value="#{personDocumentsBean.changeDateTime}"
                    styleClass="outputBox" style="width:22%">
        <f:convertDateTime pattern="dd/MM/yyyy HH:mm:ss" />
      </h:outputText>
      <h:outputText value="#{kernelBundle.personDocument_changedBy}:"
                    styleClass="textBox" style="width:5%"
                    rendered="#{personDocumentsBean.editingPersonDocument.changeUserId != null}"/>
      <h:outputText value="#{personDocumentsBean.editingPersonDocument.changeUserId}"
                    styleClass="outputBox" style="width:22%" />
    </t:div>

    <t:div styleClass="actionsRow">
      <h:commandButton value="#{objectBundle.store}"
                       action="#{personDocumentsBean.storePersonDocument}"
                       styleClass="storeButton" />
      <h:commandButton value="#{objectBundle.cancel}"
                       action="#{personDocumentsBean.cancelPersonDocument}"
                       styleClass="cancelButton" />
    </t:div>

  </t:div>

</jsp:root>
