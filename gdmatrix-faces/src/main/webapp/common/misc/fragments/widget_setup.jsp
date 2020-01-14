<?xml version='1.0' encoding='windows-1252'?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
          xmlns:f="http://java.sun.com/jsf/core"
          xmlns:h="http://java.sun.com/jsf/html"
          xmlns:t="http://myfaces.apache.org/tomahawk"
          xmlns:sf="http://www.santfeliu.org/jsf">

  <f:loadBundle basename="org.santfeliu.web.obj.resources.ObjectBundle" 
    var="objectBundle" />
  <f:loadBundle basename="org.santfeliu.misc.widget.web.resources.WidgetBundle"
    var="miscBundle" />

  <t:saveState value="#{widgetBean.widgetCatalogue}" />
  
  <t:div rendered="#{userSessionBean.administrator}">
    <h:outputText value="Current custom layout:" />
    <h:outputText value="#{widgetBean.customLayout}" />
  </t:div>

  <t:div styleClass="portalHelpLayer">
    
    <t:div styleClass="leftColumn">
      <sf:browser url="#{widgetBean.infoPanelUrl}"
                  port="#{applicationBean.defaultPort}" />
      <t:div styleClass="infoPanelText">
        <t:div>
          <sf:outputText escape="false" value="#{userSessionBean.selectedMenuItem.properties.infoPanelText}"
                         translator="#{userSessionBean.translator}"
                         translationGroup="#{userSessionBean.translationGroup}" />        
        </t:div>
      </t:div>
    </t:div>

    <t:div styleClass="rightColumn">
      <t:dataTable id="data" value="#{widgetBean.widgetCatalogue}" var="widget"
                   rows="10"
                   rowClasses="widgetRow"
                   styleClass="widgetTable">

        <t:column styleClass="iconColumn">
          <h:graphicImage value="#{widget.iconUrl}"
                          rendered="#{widget.iconUrl != null}"/>
        </t:column>

        <t:column styleClass="titleColumn">
          <t:div styleClass="title">
            <sf:outputText rendered="#{!widget.selectorLinkRender or widget.infoUrl == null}"
              value="#{widget.label} "
              translator="#{userSessionBean.translator}"
              translationGroup="#{userSessionBean.translationGroup}"/>
            <h:outputLink rendered="#{widget.selectorLinkRender and widget.infoUrl != null}" value="#{widget.infoUrl}">
              <sf:outputText value="#{widget.label} "
                translator="#{userSessionBean.translator}"
                translationGroup="#{userSessionBean.translationGroup}"/>
            </h:outputLink>
            <h:graphicImage rendered="#{widget.selectorLinkRender and widget.properties['roles.select'] != null}" 
                            url="/common/misc/images/eye.png" 
                            alt="#{miscBundle.widget_read_role}: #{widget.readRolesDescription}" 
                            title="#{miscBundle.widget_read_role}: #{widget.readRolesDescription}" /> 
          </t:div>
          <t:div styleClass="info">
            <sf:outputText value="#{widget.info}" 
               translator="#{userSessionBean.translator}"
               translationGroup="#{userSessionBean.translationGroup}"/>
          </t:div>
        </t:column>

        <t:column styleClass="visibleColumn">
          <f:facet name="header">
            <h:outputText value="#{miscBundle.widget_visible}" />
          </f:facet>
          <h:selectBooleanCheckbox value="#{widget.visible}" />
        </t:column>

        <t:column styleClass="colColumn" 
                  rendered="#{widgetBean.customColumnWidgetType == null}">
          <f:facet name="header">
            <h:outputText value="#{miscBundle.widget_column}" />
          </f:facet>
          <h:inputText value="#{widget.column}"/>
        </t:column>
        
      </t:dataTable>

    <t:dataScroller for="data"
      fastStep="100"
      paginator="true"
      paginatorMaxPages="9"
      immediate="false"
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

      <t:div styleClass="applyBar">
        <sf:commandButton action="#{widgetBean.show}" renderBox="true"
          value="#{objectBundle.cancel}" styleClass="applyButton"/>
        <sf:commandButton action="#{widgetBean.apply}" renderBox="true"
          value="#{objectBundle.apply}" styleClass="applyButton"/>
      </t:div>

    </t:div>
    
  </t:div>
    
</jsp:root>
