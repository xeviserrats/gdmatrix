<?xml version='1.0' encoding='windows-1252'?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
          xmlns:f="http://java.sun.com/jsf/core"
          xmlns:h="http://java.sun.com/jsf/html"
          xmlns:t="http://myfaces.apache.org/tomahawk"
          xmlns:sf="http://www.santfeliu.org/jsf">

  <t:saveState value="#{cmsToolbarBean}" />

  <t:div rendered="#{userSessionBean.administrator and userSessionBean.menuModel.browserType == 'desktop'}" styleClass="webtoolbar">

    <h:panelGroup styleClass="block1">
      <h:outputLink value="/go.faces?xmid=#{userSessionBean.selectedMenuItem.properties.matrixInfoMid}"
                    rendered="#{userSessionBean.selectedMenuItem.properties.matrixInfoMid != null}" >
        <h:graphicImage url="/topframe/images/matrix.gif" alt="MATRIX" styleClass="matrixLogo" />
      </h:outputLink>
      <h:graphicImage url="/topframe/images/matrix.gif" alt="MATRIX" styleClass="matrixLogo"
                      rendered="#{userSessionBean.selectedMenuItem.properties.matrixInfoMid == null}" />
      <h:outputText value="#{applicationBean.version}" styleClass="matrixVersion" />
      <t:commandLink value="RENDER" disabled="#{userSessionBean.renderDisabled}"
                       styleClass="#{userSessionBean.renderViewSelected ? 'selectedButton' : 'unselectedButton'}"
                       action="#{userSessionBean.showRenderView}" immediate="true" />
      <t:commandLink value="EDIT"
                       styleClass="#{userSessionBean.editViewSelected ? 'selectedButton' : 'unselectedButton'}"
                       action="#{userSessionBean.showEditView}" immediate="true" />
      <t:commandLink value="CSS"
                       styleClass="#{userSessionBean.cssViewSelected ? 'selectedButton' : 'unselectedButton'}"
                       action="#{userSessionBean.showCssView}" immediate="true" />
      <t:commandLink value="SYNC"
                       styleClass="#{userSessionBean.syncViewSelected ? 'selectedButton' : 'unselectedButton'}"
                       action="#{userSessionBean.showSyncView}" immediate="true"
                       rendered="#{userSessionBean.cmsAdministrator}" />
      <h:commandLink value="SEARCH"
                       styleClass="#{userSessionBean.searchViewSelected ? 'selectedButton' : 'unselectedButton'}"
                       action="#{userSessionBean.showSearchView}" immediate="true" />
      <h:outputText value="#{userSessionBean.serverAddress}" styleClass="serverAddress" />
    </h:panelGroup>

    <h:panelGroup styleClass="block2">
      <h:outputText value="Workspace:" styleClass="workspace" />
      <sf:commandMenu action="#{cmsToolbarBean.loadWorkspace}"
                      value="#{userSessionBean.workspaceId}"
                      styleClass="workspaceSelect">
        <f:selectItems value="#{cmsToolbarBean.workspaceItems}" />
      </sf:commandMenu>

      <h:commandLink action="#{cmsToolbarBean.updateSnapshot}" immediate="true"
        styleClass="imageButton">
        <h:graphicImage url="/topframe/images/update.gif" alt="Update workspace" title="Update workspace" />
      </h:commandLink>
      <h:panelGroup rendered="#{cmsToolbarBean.renderWorkspaceActions}">
        <h:commandLink action="#{cmsToolbarBean.createWorkspace}" immediate="true"
          styleClass="imageButton">
          <h:graphicImage url="/topframe/images/create.gif" alt="Create workspace" title="Create workspace" />
        </h:commandLink>
        <h:commandLink action="#{cmsToolbarBean.copyWorkspace}" immediate="true"
          styleClass="imageButton">
          <h:graphicImage title="Copy workspace" url="/topframe/images/copy.gif" 
                          alt="Copy workspace" />
        </h:commandLink>
        <h:commandLink action="#{cmsToolbarBean.editWorkspace}" immediate="true"
          styleClass="imageButton">
          <h:graphicImage url="/topframe/images/edit.gif" alt="Edit workspace"
                          title="Edit workspace" />
        </h:commandLink>
        <t:commandLink action="#{cmsToolbarBean.removeWorkspace}" immediate="true"
          styleClass="imageButton" rendered="#{!userSessionBean.defaultWorkspaceSelected}"
          onclick="if(!confirm('Remove workspace #{userSessionBean.workspaceId}?')) return false;">
          <h:graphicImage url="/topframe/images/remove.gif" alt="Remove workspace" title="Remove workspace" />
        </t:commandLink>
      </h:panelGroup>
      <h:commandLink action="#{cmsToolbarBean.clearSnapshot}" immediate="true"
        styleClass="imageButton">
        <h:graphicImage url="/topframe/images/clear.gif" alt="Clear workspace" title="Clear workspace" />
      </h:commandLink>
    </h:panelGroup>

  </t:div>

</jsp:root>
