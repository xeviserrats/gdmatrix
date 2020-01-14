<?xml version='1.0' encoding='windows-1252'?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
          xmlns:f="http://java.sun.com/jsf/core"
          xmlns:h="http://java.sun.com/jsf/html"
          xmlns:t="http://myfaces.apache.org/tomahawk"
          xmlns:sf="http://www.santfeliu.org/jsf">

  <f:loadBundle basename="org.santfeliu.web.obj.resources.ObjectBundle"
                var="objectBundle"/>
  <f:loadBundle basename="org.santfeliu.misc.mapviewer.web.resources.MapViewerBundle"
                var="mapViewerBundle"/>

  <t:saveState value="#{mapBean.map}" />

  <t:panelGroup id="mapEditor" forceId="true">

    <t:div id="subHeader" forceId="true">
      <t:div id="screenTitle" forceId="true">
        <h:outputText value="#{mapViewerBundle.mapEditor}" />
      </t:div>
      <t:div id="buttonsBar" forceId="true">
        <t:commandLink value="#{mapViewerBundle.newMap}"
          action="#{mapEditorBean.newMap}" styleClass="barButton" />
        <t:commandLink value="#{mapViewerBundle.copyMap}"
          rendered="#{mapBean.map.docId != null}"
          action="#{mapEditorBean.copyMap}" styleClass="barButton" />
        <t:commandLink value="#{mapViewerBundle.saveMap}" onclick="showOverlay();"
          action="#{mapEditorBean.saveMap}" styleClass="barButton" />
        <t:commandLink value="#{mapViewerBundle.fastSaveMap}" onclick="showOverlay();"
          action="#{mapEditorBean.fastSaveMap}" styleClass="barButton"
          rendered="#{mapBean.map.docId != null}" />
        <t:commandLink value="#{mapViewerBundle.deleteMap}"
          action="#{mapEditorBean.deleteMap}" styleClass="barButton"
          rendered="#{mapBean.map.docId != null}"
          onclick="if (!confirm('#{mapViewerBundle.delete_map}')) return false" />
        <t:commandLink value="#{mapViewerBundle.reloadMap}"
          action="#{mapEditorBean.reloadMap}" styleClass="barButton"
          onclick="if (!confirm('#{mapViewerBundle.discard_changes}')) return false"
          rendered="#{mapBean.map.docId != null}" immediate="true" />

        <t:commandLink value="#{mapViewerBundle.showMap}"
          action="#{mapEditorBean.showMap}" styleClass="barViewButton"
          rendered="#{mapBean.map.complete}" />
        <t:commandLink value="#{mapViewerBundle.editStyles}"
          action="#{sldEditorBean.show}" styleClass="barViewButton"
          rendered="#{mapViewerBean.editionEnabled and sldEditorBean.sldName != null}" />
        <t:commandLink value="#{mapViewerBundle.catalogue}"
          action="#{mapViewerBean.showCatalogue}" styleClass="barViewButton"
          onclick="if (!confirm('#{mapViewerBundle.discard_changes}')) return false"
          rendered="#{mapViewerBean.catalogueVisible}" immediate="true" />
      </t:div>
    </t:div>

    <t:div id="screenBody" forceId="true">

      <h:messages rendered="#{userSessionBean.facesMessagesQueued}" 
        showSummary="true"
        infoClass="infoMessage"
        warnClass="warnMessage"
        errorClass="errorMessage"
        fatalClass="fatalMessage" />

      <t:div>
        <h:outputLabel for="mapName" value="#{mapViewerBundle.mapName}:" styleClass="mapNameLabel" />
        <h:inputText id="mapName" value="#{mapBean.map.name}" styleClass="mapName"
          readonly="#{mapBean.map.docId != null}" />
      </t:div>

      <t:div>
        <h:outputLabel for="mapTitle" value="#{mapViewerBundle.mapTitle}:" styleClass="mapTitleLabel" />
        <h:inputText id="mapTitle" value="#{mapBean.map.title}" styleClass="mapTitle" />
        <h:outputLabel for="mapSRS" value="SRS:" styleClass="mapSRSLabel" />
        <h:inputText id="mapSRS" value="#{mapBean.map.srs}" styleClass="mapSRS" />
      </t:div>

      <t:div>
        <h:outputLabel for="mapDescription" value="#{mapViewerBundle.mapDescription}:"
          styleClass="mapDescriptionLabel" />
        <h:inputTextarea id="mapDescription" value="#{mapBean.map.description}" rows="3" cols="80"
          styleClass="mapDescription" />
        <t:div styleClass="descriptionHelp" 
          title="#{mapViewerBundle.descriptionHelp}">
        </t:div>
      </t:div>

      <t:div>
        <h:outputLabel for="mapBounds" value="#{mapViewerBundle.mapBounds}:"
          styleClass="mapBoundsLabel" />
        <h:inputText id="mapBounds" value="#{mapEditorBean.mapBounds}" styleClass="mapBounds" />
      </t:div>

      <t:div>
        <h:outputLabel for="thumbnailBounds" value="#{mapViewerBundle.thumbnailBounds}:"
          styleClass="mapBoundsLabel" />
        <h:inputText id="thumbnailBounds" value="#{mapEditorBean.thumbnailBounds}" styleClass="mapBounds" />
      </t:div>

      <t:panelTabbedPane id="tabbedPane"
        styleClass="tabbedPane" selectedIndex="#{mapEditorBean.selectedTabIndex}">
        <t:panelTab label="#{mapViewerBundle.metadata}" styleClass="mapMetadata">
          <t:div>
            <h:outputLabel for="mapCategory" value="#{mapViewerBundle.mapCategory}:"
              styleClass="mapCategoryLabel" />
            <t:selectOneMenu id="mapCategory" value="#{mapBean.map.category}" styleClass="mapCategorySelect">
              <f:selectItems value="#{mapEditorBean.categorySelectItems}" />
            </t:selectOneMenu>
          </t:div>
          <t:div>
            <h:outputLabel for="creationDate" value="#{mapViewerBundle.mapCreation}:"
              styleClass="mapCreationDateLabel" />        
            <sf:calendar id="creationDate" value="#{mapBean.map.creationDate}" 
              styleClass="creationDate calendarInput" buttonStyleClass="calendarButton" />            
          </t:div>
          <sf:dynamicForm form="#{mapEditorBean.metadataForm}"
          value="#{mapBean.map.metadata}"
          rendererTypes="HtmlFormRenderer,GenericFormRenderer" 
          rendered="#{mapEditorBean.metadataFormRendered}" />
          <t:div>
            <h:outputLabel for="mapDocId" value="DocId: " />
            <t:inputText id="mapDocId" value="#{mapBean.map.docId}" readonly="true" />
          </t:div>
          <t:div>
            <h:outputLabel for="thumbnailDocId" value="thumbnailDocId: " />
            <h:inputText id="thumbnailDocId" value="#{mapBean.map.thumbnailDocId}" readonly="true" />
          </t:div>
          <t:div>
            <h:outputLabel for="captureUserId" value="#{mapViewerBundle.captureUserId}: " />
            <h:inputText id="captureUserId" value="#{mapBean.map.captureUserId}" readonly="true" />
            <h:outputText value="#{mapEditorBean.captureUserDisplayName}" />
          </t:div>          
          <t:div>
            <h:outputLabel for="captureDateTime" value="#{mapViewerBundle.captureDateTime}: " />
            <h:inputText id="captureDateTime" value="#{mapBean.map.captureDateTime}" readonly="true">
              <f:converter converterId="DateTimeConverter" />
            </h:inputText>
            <h:outputFormat value="#{mapViewerBundle.yearsFromCapture}"
               rendered="#{mapBean.map.captureDateTime != null}">
              <f:param value="#{mapEditorBean.yearsFromCapture}" />
            </h:outputFormat>
          </t:div>
          <t:div>
            <h:outputLabel for="changeUserId" value="#{mapViewerBundle.changeUserId}: " />
            <h:inputText id="changeUserId" value="#{mapBean.map.changeUserId}" readonly="true" />
            <h:outputText value="#{mapEditorBean.changeUserDisplayName}" />
          </t:div>
          <t:div>
            <h:outputLabel for="changeDateTime" value="#{mapViewerBundle.changeDateTime}: " />
            <h:inputText id="changeDateTime" value="#{mapBean.map.changeDateTime}" readonly="true">
              <f:converter converterId="DateTimeConverter" />
            </h:inputText>
            <h:outputFormat value="#{mapViewerBundle.daysFromLastChange}" 
              rendered="#{mapBean.map.changeDateTime != null}">
              <f:param value="#{mapEditorBean.daysFromLastChange}" />
            </h:outputFormat>
          </t:div>
        </t:panelTab>

        <t:panelTab label="#{mapViewerBundle.services} (#{mapEditorBean.serviceCount})" styleClass="mapServices">
          <t:dataTable value="#{mapBean.map.services}"
            var="service" rowIndexVar="index" styleClass="mapTable"
            rowStyleClass="#{index == mapEditorBean.serviceIndex ? 'selected' : ''}"
            rendered="#{not empty mapBean.map.services}">
            <t:column styleClass="nameColumn">
              <f:facet name="header">
                <h:outputText value="#{mapViewerBundle.name}" />
              </f:facet>
              <h:outputText value="#{service.name}"
                styleClass="serviceName"
                rendered="#{mapEditorBean.serviceIndex != index}" />
              <h:inputText value="#{service.name}"
                styleClass="serviceName"
                rendered="#{mapEditorBean.serviceIndex == index}" />
            </t:column>
            <t:column styleClass="descriptionColumn">
              <f:facet name="header">
                <h:outputText value="#{mapViewerBundle.description}" />
              </f:facet>
              <h:outputText value="#{service.description}"
                styleClass="serviceDescription"
                rendered="#{mapEditorBean.serviceIndex != index}" />
              <h:inputText value="#{service.description}"
                styleClass="serviceDescription"
                rendered="#{mapEditorBean.serviceIndex == index}" />
            </t:column>
            <t:column styleClass="urlColumn">
              <f:facet name="header">
                <h:outputText value="Url" />
              </f:facet>
              <h:outputText value="#{service.url}"
                styleClass="serviceUrl"
                rendered="#{mapEditorBean.serviceIndex != index}"/>
              <h:inputText value="#{service.url}"
                styleClass="serviceUrl"
                rendered="#{mapEditorBean.serviceIndex == index}" />
            </t:column>
            <t:column styleClass="actionsColumn">
              <h:panelGroup rendered="#{mapEditorBean.serviceIndex != index}">
                <h:commandButton value="Edit"
                  action="#{mapEditorBean.editService}"
                  image="/common/misc/images/edit.png"
                  alt="#{objectBundle.edit}" title="#{objectBundle.edit}"
                  styleClass="smallButton" />
                <h:commandButton value="Capabilities"
                  action="#{mapEditorBean.showCapabilities}"
                  image="/common/misc/images/info.png"
                  alt="capabilities" title="capabilities"
                  styleClass="smallButton" />
                <h:commandButton value="Remove" action="#{mapEditorBean.removeService}"
                  image="/common/misc/images/remove.png" styleClass="smallButton"
                  alt="#{objectBundle.remove}" title="#{objectBundle.remove}"
                  immediate="true" />
              </h:panelGroup>
              <h:panelGroup rendered="#{mapEditorBean.serviceIndex == index}">
                <h:commandButton value="#{objectBundle.accept}"
                  action="#{mapEditorBean.saveService}" styleClass="smallButton" />
                <h:commandButton value="#{objectBundle.cancel}"
                  action="#{mapEditorBean.cancelService}"
                  immediate="true" styleClass="smallButton" />
              </h:panelGroup>
            </t:column>
          </t:dataTable>
          <h:commandButton image="/common/misc/images/add.png"
            action="#{mapEditorBean.addService}" title="#{mapViewerBundle.addService}"
            rendered="#{mapEditorBean.serviceIndex == -1}" styleClass="smallButton" />

          <t:div rendered="#{mapEditorBean.capabilities != null}" styleClass="capabilities">
            <t:div styleClass="capabilitiesField">
              <h:outputText value="Version:" styleClass="fieldName"/>
              <h:outputText value="#{mapEditorBean.capabilities.version}"
                styleClass="fieldValue"/>
            </t:div>
            <t:div styleClass="capabilitiesField" rendered="#{mapEditorBean.capabilities.name != null}">
              <h:outputText value="#{mapViewerBundle.name}:" styleClass="fieldName" />
              <h:outputText value="#{mapEditorBean.capabilities.name}"
                styleClass="fieldValue" />
            </t:div>
            <t:div styleClass="capabilitiesField" rendered="#{mapEditorBean.capabilities.title != null}">
              <h:outputText value="Title:" styleClass="fieldName" />
              <h:outputText value="#{mapEditorBean.capabilities.title}"
                styleClass="fieldValue" />
            </t:div>
            <t:div styleClass="capabilitiesField" rendered="#{mapEditorBean.capabilities.abstract != null}">
              <h:outputText value="Abstract:" styleClass="fieldName" />
              <h:outputText value="#{mapEditorBean.capabilities.abstract}"
                styleClass="fieldValue" />
            </t:div>
            <t:div styleClass="capabilitiesField"
              rendered="#{mapEditorBean.capabilities.contactInformation.personPrimary.person != null}">
              <h:outputText value="Contact person:" styleClass="fieldName"/>
              <h:outputText value="#{mapEditorBean.capabilities.contactInformation.personPrimary.person}"
                styleClass="fieldValue" />
            </t:div>
            <t:div styleClass="capabilitiesField">
              <h:outputText value="Organization:" styleClass="fieldName"
                rendered="#{mapEditorBean.capabilities.contactInformation.personPrimary.organization != null}"/>
              <h:outputText value="#{mapEditorBean.capabilities.contactInformation.personPrimary.organization}"
                styleClass="fieldValue" />
            </t:div>
            <t:div styleClass="capabilitiesField">
              <h:outputText value="Address:" styleClass="fieldName"
                rendered="#{mapEditorBean.capabilities.contactInformation.address.address != null}" />
              <h:outputText value="#{mapEditorBean.capabilities.contactInformation.address.address}"
                styleClass="fieldValue" />
            </t:div>
            <t:div styleClass="capabilitiesField"
              rendered="#{mapEditorBean.capabilities.contactInformation.address.city != null}">
              <h:outputText value="City:" styleClass="fieldName" />
              <h:outputText value="#{mapEditorBean.capabilities.contactInformation.address.city}"
                styleClass="fieldValue" />
            </t:div>
            <t:div styleClass="capabilitiesField"
              rendered="#{mapEditorBean.capabilities.contactInformation.address.country != null}">
              <h:outputText value="Country:" styleClass="fieldName" />
              <h:outputText value="#{mapEditorBean.capabilities.contactInformation.address.country}"
                styleClass="fieldValue" />
            </t:div>
            <t:div styleClass="capabilitiesField"
              rendered="#{mapEditorBean.capabilities.contactInformation.voiceTelephon != null}">
              <h:outputText value="Telephone:" styleClass="fieldName" />
              <h:outputText value="#{mapEditorBean.capabilities.contactInformation.voiceTelephon}"
                styleClass="fieldValue" />
            </t:div>
            <t:div styleClass="capabilitiesField"
               rendered="#{mapEditorBean.capabilities.contactInformation.electronicMailAddress != null}">
              <h:outputText value="Email:" styleClass="fieldName" />
              <h:outputText value="#{mapEditorBean.capabilities.contactInformation.electronicMailAddress}"
                styleClass="fieldValue" />
            </t:div>
            <t:div styleClass="capabilitiesField">
              <h:outputText value="SRS:" styleClass="fieldName" />
              <h:outputText value="#{mapEditorBean.capabilities.srs}" styleClass="supportedSRS" />
            </t:div>
            <t:dataTable value="#{mapEditorBean.capabilities.layers}" var="layer">
              <t:column>
                <f:facet name="header">
                  <h:outputText value="#{mapViewerBundle.name}:" />
                </f:facet>
                <h:outputText value="#{layer.name}" />
              </t:column>
              <t:column>
                <f:facet name="header">
                  <h:outputText value="Title:" />
                </f:facet>
                <h:outputText value="#{layer.title}" />
              </t:column>
              <t:column>
                <f:facet name="header">
                  <h:outputText value="SRS:" />
                </f:facet>
                <h:outputText value="#{layer.srs}" />
              </t:column>
              <t:column>
                <f:facet name="header">
                  <h:outputText value="#{mapViewerBundle.styles}:" />
                </f:facet>
                <h:outputText value="#{layer.styles}" />
              </t:column>
            </t:dataTable>
          </t:div>
        </t:panelTab>

        <t:panelTab label="#{mapViewerBundle.groups} (#{mapEditorBean.groupCount})" styleClass="mapGroups">
          <t:dataTable value="#{mapBean.map.groups}"
            var="group" rowIndexVar="index" styleClass="mapTable"
            rowStyleClass="#{index == mapEditorBean.groupIndex ? 'selected' : ''}"
            rendered="#{not empty mapBean.map.groups}">
            <t:column styleClass="nameColumn">
              <f:facet name="header">
                <h:outputText value="#{mapViewerBundle.name}" />
              </f:facet>
              <h:outputText value="#{group.name}" styleClass="groupName"
                rendered="#{mapEditorBean.groupIndex != index}" />
              <h:inputText value="#{group.name}" styleClass="groupName"
                rendered="#{mapEditorBean.groupIndex == index}" />
            </t:column>
            <t:column styleClass="labelColumn">
              <f:facet name="header">
                <h:outputText value="#{mapViewerBundle.label}" />
              </f:facet>
              <h:outputText value="#{group.label}" styleClass="groupLabel"
                rendered="#{mapEditorBean.groupIndex != index}" />
              <h:inputText value="#{group.label}" styleClass="groupLabel"
                rendered="#{mapEditorBean.groupIndex == index}" />
            </t:column>
            <t:column styleClass="actionsColumn">
              <h:panelGroup rendered="#{mapEditorBean.groupIndex != index}">
                <h:commandButton value="Edit" action="#{mapEditorBean.editGroup}"
                  image="/common/misc/images/edit.png" styleClass="smallButton"
                  alt="#{objectBundle.edit}" title="#{objectBundle.edit}"
                  immediate="true" />
                <h:commandButton value="Up" action="#{mapEditorBean.moveGroupUp}"
                  image="/common/misc/images/up.png" disabled="#{index == 0}"
                  styleClass="smallButton"
                  alt="#{mapViewerBundle.moveup}" title="#{mapViewerBundle.moveup}" />
                <h:commandButton value="Down" action="#{mapEditorBean.moveGroupDown}"
                  image="/common/misc/images/down.png"
                  disabled="#{index == mapEditorBean.groupCount - 1}"
                  styleClass="smallButton"
                  alt="#{mapViewerBundle.movedown}" title="#{mapViewerBundle.movedown}" />
                <h:commandButton value="Remove" action="#{mapEditorBean.removeGroup}"
                  image="/common/misc/images/remove.png" styleClass="smallButton"
                  alt="#{objectBundle.remove}" title="#{objectBundle.remove}"
                  immediate="true" />
              </h:panelGroup>
              <h:panelGroup rendered="#{mapEditorBean.groupIndex == index}">
                <h:commandButton value="#{objectBundle.accept}"
                  action="#{mapEditorBean.saveGroup}" styleClass="smallButton" />
                <h:commandButton value="#{objectBundle.cancel}"
                  action="#{mapEditorBean.cancelGroup}"
                  immediate="true" styleClass="smallButton" />
              </h:panelGroup>
            </t:column>
          </t:dataTable>
          <h:commandButton image="/common/misc/images/add.png"
            action="#{mapEditorBean.addGroup}" title="#{mapViewerBundle.addGroup}"
            rendered="#{mapEditorBean.groupIndex == -1}"
            styleClass="smallButton" />
        </t:panelTab>

        <t:panelTab label="#{mapViewerBundle.layers} (#{mapEditorBean.layerCount})" styleClass="mapLayers">
          <t:dataTable value="#{mapBean.map.layers}"
            var="layer" rowIndexVar="index" styleClass="mapTable"
            rowStyleClass="#{index == mapEditorBean.layerIndex ? 'selected' : ''}"
            rendered="#{!empty mapBean.map.services and mapEditorBean.editingLayer == null}">
            <t:column styleClass="idColumn">
              <f:facet name="header">
                <h:outputText value="Id" />
              </f:facet>
              <h:outputText value="#{layer.id}" />
            </t:column>
            <t:column styleClass="labelColumn">
              <f:facet name="header">
                <h:outputText value="#{mapViewerBundle.label}" />
              </f:facet>
              <h:outputText value="#{layer.label}" styleClass="layerLabel" />
              <h:outputText value=" (#{mapEditorBean.layerNames})" styleClass="code" />
            </t:column>
            <t:column styleClass="flagsColumn">
              <f:facet name="header">
                <h:outputText value="Flags" />
              </f:facet>
              <h:commandButton image="/common/misc/images/#{layer.baseLayer ? '' : 'no_'}baselayer.png"
                action="#{mapEditorBean.toggleBaseLayer}" title="#{layer.baseLayer ? 'baselayer' : 'overlay'}" />
              <h:commandButton image="/common/misc/images/#{layer.visible ? '' : 'no_'}visible.png"
                action="#{mapEditorBean.toggleVisible}" title="visible" />
              <h:commandButton image="/common/misc/images/#{layer.locatable ? '' : 'no_'}locatable.png"
                action="#{mapEditorBean.toggleLocatable}" title="locatable"/>
              <h:graphicImage value="/common/misc/images/#{mapEditorBean.filteredLayer ? '' : 'no_'}filter.png"
                title="#{layer.cqlFilter}" />
              <h:panelGroup rendered="#{not layer.baseLayer}">
                <h:commandButton image="/common/misc/images/#{layer.onLegend ? '' : 'no_'}legend.png"
                  action="#{mapEditorBean.toggleOnLegend}" title="on legend" />
                <h:commandButton image="/common/misc/images/#{layer.snap ? '' : 'no_'}snap.png"
                  action="#{mapEditorBean.toggleSnap}" title="#{layer.snap ? '' : 'no '} snap" />
                <h:commandButton image="/common/misc/images/#{layer.independent ? '' : 'no_'}independent.png"
                  action="#{mapEditorBean.toggleIndependent}" title="#{layer.independent ? '' : 'no '} independent" />
                <h:graphicImage value="/common/misc/images/#{layer.editable ? '' : 'no_'}editable.png"
                  title="#{layer.editable ? layer.editRolesString : ''}" />
              </h:panelGroup>
            </t:column>
            <t:column styleClass="groupColumn">
              <f:facet name="header">
                <h:outputText value="#{mapViewerBundle.group}" />
              </f:facet>
              <h:outputText value="#{layer.group == null ? '' : layer.group.label}" />
            </t:column>
            <t:column styleClass="styleColumn">
              <f:facet name="header">
                <h:outputText value="#{mapViewerBundle.style}" />
              </f:facet>
              <h:commandButton image="/common/misc/images/palette.png"
                rendered="#{layer.sld != null and layer.sld != ''}"
                styleClass="smallButton"
                action="#{mapEditorBean.editSLD}" title="#{objectBundle.edit}" />
              <h:outputText value="#{layer.sld} " styleClass="code"
                style="color:#000080"
                rendered="#{layer.sld != null}" />
              <h:outputText value="#{mapEditorBean.layerStyles}"
                styleClass="code" />
            </t:column>
            <t:column styleClass="actionsColumn">
              <h:outputLink value="#{mapEditorBean.layerTestUrl}" target="_blank"
                styleClass="smallButton">
                <h:graphicImage value="/common/misc/images/eye.png"
                  alt="" title="#{objectBundle.show}" style="vertical-align:middle" />
              </h:outputLink>
              <h:commandButton action="#{mapEditorBean.editLayer}"
                image="/common/misc/images/edit.png" styleClass="smallButton"
                alt="#{objectBundle.edit}" title="#{objectBundle.edit}" />
              <h:commandButton action="#{mapEditorBean.moveLayerUp}"
                image="/common/misc/images/up.png" disabled="#{index == 0}"
                styleClass="smallButton"
                alt="#{mapViewerBundle.moveup}" title="#{mapViewerBundle.moveup}" />
              <h:commandButton action="#{mapEditorBean.moveLayerDown}"
                image="/common/misc/images/down.png" styleClass="smallButton"
                disabled="#{index == mapEditorBean.layerCount - 1}"
                alt="#{mapViewerBundle.movedown}" title="#{mapViewerBundle.movedown}" />
              <h:commandButton action="#{mapEditorBean.removeLayer}"
                image="/common/misc/images/remove.png" styleClass="smallButton"
                alt="#{objectBundle.remove}" title="#{objectBundle.remove}" />
            </t:column>
          </t:dataTable>
          <h:commandButton image="/common/misc/images/add.png"
            action="#{mapEditorBean.addLayer}" title="#{mapViewerBundle.addLayer}"
            rendered="#{mapEditorBean.editingLayer == null}" styleClass="smallButton" />

          <t:div rendered="#{mapEditorBean.editingLayer != null}"
            styleClass="layerPanel">
            <t:div>
              <h:outputLabel for="serviceName" value="#{mapViewerBundle.service}:" styleClass="outputText" />
              <t:selectOneMenu id="serviceName" forceId="true"
                value="#{mapEditorBean.layerService}" styleClass="layerService">
                <f:selectItems value="#{mapEditorBean.serviceSelectItems}" />
              </t:selectOneMenu>
            </t:div>
            <t:div>
              <h:outputLabel for="layerName" value="#{mapViewerBundle.name}:" styleClass="outputText" />
              <t:inputText id="layerName" forceId="true"
                value="#{mapEditorBean.editingLayer.namesString}"
                onkeyup="autoCompleteLayer(this, event);"
                onfocus="disableAutoComplete(this);"
                styleClass="layerName" />
            </t:div>
            <t:div>
              <h:outputLabel for="layerLabel" value="#{mapViewerBundle.label}:" styleClass="outputText" />
              <h:inputText id="layerLabel" value="#{mapEditorBean.editingLayer.label}"
                styleClass="layerLabel" />
            </t:div>
            <t:div styleClass="layerFlags">
              <h:outputText value="Flags:" styleClass="outputText" />
              <h:outputLabel for="baseLayer" value="#{mapViewerBundle.baseLayer}:" styleClass="flags" />
              <h:selectBooleanCheckbox id="baseLayer" value="#{mapEditorBean.editingLayer.baseLayer}" />
              <h:outputLabel for="visibleLayer" value="Visible:" styleClass="flags" />
              <h:selectBooleanCheckbox id="visibleLayer" value="#{mapEditorBean.editingLayer.visible}" />
              <h:outputLabel for="locatableLayer" value="#{mapViewerBundle.locatable}:" styleClass="flags" />
              <h:selectBooleanCheckbox id="locatableLayer" value="#{mapEditorBean.editingLayer.locatable}" />
              <h:outputLabel for="legendLayer" value="#{mapViewerBundle.onLegend}:" styleClass="flags" />
              <h:selectBooleanCheckbox id="legendLayer" value="#{mapEditorBean.editingLayer.onLegend}" />
              <h:outputLabel for="snapLayer" value="#{mapViewerBundle.snap}:" styleClass="flags" />
              <h:selectBooleanCheckbox id="snapLayer" value="#{mapEditorBean.editingLayer.snap}" />
              <h:outputLabel for="indepLayer" value="#{mapViewerBundle.independent}:" styleClass="flags" />
              <h:selectBooleanCheckbox id="indepLayer" value="#{mapEditorBean.editingLayer.independent}" />
            </t:div>
            <t:div>
              <h:outputLabel for="layerGroup" value="#{mapViewerBundle.group}:" styleClass="outputText" />
              <t:selectOneMenu id="layerGroup" value="#{mapEditorBean.layerGroup}" styleClass="layerGroup">
                <f:selectItems value="#{mapEditorBean.groupSelectItems}" />
              </t:selectOneMenu>
            </t:div>
            <t:div>
              <h:outputLabel for="layerCQL" value="#{mapViewerBundle.cqlFilter}:" styleClass="outputText" />
              <h:inputText id="layerCQL" value="#{mapEditorBean.editingLayer.cqlFilter}"
                styleClass="layerFilter"
                onfocus="showCQLAssistant('layerName', this)"
                onblur="hideCQLAssistant()" />
            </t:div>
            <t:div>
              <h:outputLabel for="legengGraphic" value="#{mapViewerBundle.legend}:" styleClass="outputText" />
              <h:inputText id="legengGraphic" value="#{mapEditorBean.editingLayer.legendGraphic}"
                styleClass="layerLegendGraphic" />
              <h:outputText value="(auto or image id)" />
            </t:div>
            <t:div>
              <h:outputLabel for="layerSLD" value="SLD:" styleClass="outputText" />
              <h:inputText id="layerSLD" value="#{mapEditorBean.editingLayer.sld}"
                styleClass="layerSLD" />
            </t:div>
            <t:div>
              <h:outputLabel for="layerStyle" value="#{mapViewerBundle.style}:" styleClass="outputText" />
              <h:inputText id="layerStyle" value="#{mapEditorBean.editingLayer.stylesString}"
                styleClass="layerStyle" />
            </t:div>
            <t:div>
              <h:outputLabel for="layerOpacity" value="#{mapViewerBundle.opacity}:" styleClass="outputText" />
              <h:inputText id="layerOpacity" value="#{mapEditorBean.editingLayer.opacity}"
                styleClass="layerOpacity" />
              <h:outputText value="(0-1)" />
            </t:div>
            <t:div>
              <h:outputLabel for="layerTransparent" value="#{mapViewerBundle.transparentBackground}:" 
                             styleClass="outputText" style="vertical-align: middle;" />
              <h:selectBooleanCheckbox id="layerTransparent" value="#{mapEditorBean.editingLayer.transparentBackground}"
                styleClass="flags" style="vertical-align: middle;" />
            </t:div>
            <t:div>
              <h:outputLabel for="layerFormat" value="#{mapViewerBundle.format}:" styleClass="outputText" />
              <t:selectOneMenu id="layerFormat" value="#{mapEditorBean.editingLayer.format}"
                styleClass="layerFormat">
                <f:selectItem itemValue="image/png" itemLabel="PNG" />
                <f:selectItem itemValue="image/jpeg" itemLabel="JPEG" />
                <f:selectItem itemValue="image/gif" itemLabel="GIF" />
              </t:selectOneMenu>
            </t:div>
            <t:div styleClass="rolesGroup">
              <t:outputText value="#{mapViewerBundle.rolesGroup}:" />
            </t:div>
            <t:div>
              <h:outputLabel for="layerViewRoles" value="#{mapViewerBundle.viewRoles}:" styleClass="outputText" />
              <h:inputText id="layerViewRoles" value="#{mapEditorBean.editingLayer.viewRolesString}"
                styleClass="layerRoles" />
            </t:div>
            <t:div>
              <h:outputLabel for="layerEditRoles" value="#{mapViewerBundle.editRoles}:" styleClass="outputText" />
              <h:inputText id="layerEditRoles" value="#{mapEditorBean.editingLayer.editRolesString}"
                styleClass="layerRoles" />
            </t:div>
            <h:commandButton value="#{objectBundle.accept}" action="#{mapEditorBean.saveLayer}" styleClass="button" />
            <h:commandButton value="#{objectBundle.cancel}" action="#{mapEditorBean.cancelLayer}"
              immediate="true" styleClass="button" />
          </t:div>
        </t:panelTab>

        <t:panelTab label="#{mapViewerBundle.forms} (#{mapEditorBean.infoLayerCount})"
          styleClass="mapInfoLayers">
          <t:dataTable value="#{mapBean.map.infoLayers}"
            var="infoLayer" rowIndexVar="index" styleClass="mapTable"
            rowStyleClass="#{index == mapEditorBean.infoLayerIndex ? 'selected' : ''}"
            rendered="#{!empty mapBean.map.services and mapEditorBean.infoLayerCount gt 0}">
            <t:column styleClass="layerColumn">
              <f:facet name="header">
                <h:outputText value="#{mapViewerBundle.layer}" />
              </f:facet>
              <h:outputText value="#{infoLayer.name}" styleClass="infoLayerName"
                rendered="#{mapEditorBean.infoLayerIndex != index}" />
              <h:inputText value="#{infoLayer.name}" styleClass="infoLayerName"
                rendered="#{mapEditorBean.infoLayerIndex == index}" />
            </t:column>
            <t:column styleClass="formColumn">
              <f:facet name="header">
                <h:outputText value="#{mapViewerBundle.formSelector}" />
              </f:facet>
              <h:outputText value="#{infoLayer.formSelector}" styleClass="infoLayerForm"
                rendered="#{mapEditorBean.infoLayerIndex != index}"/>
              <h:inputText value="#{infoLayer.formSelector}" styleClass="infoLayerForm"
                rendered="#{mapEditorBean.infoLayerIndex == index}"/>
            </t:column>
            <t:column styleClass="highlightColumn">
              <f:facet name="header">
                <h:outputText value="#{mapViewerBundle.highlight}" />
              </f:facet>
              <h:graphicImage value="/common/misc/images/checkmark.png"
                rendered="#{mapEditorBean.infoLayerIndex != index and infoLayer.highlight}" />
              <h:selectBooleanCheckbox value="#{infoLayer.highlight}"
                rendered="#{mapEditorBean.infoLayerIndex == index}" />
            </t:column>
            <t:column styleClass="actionsColumn">
              <h:panelGroup rendered="#{mapEditorBean.infoLayerIndex != index}">
                <h:commandButton action="#{mapEditorBean.editInfoLayer}"
                  image="/common/misc/images/edit.png" styleClass="smallButton"
                  alt="#{objectBundle.edit}" title="#{objectBundle.edit}"
                  immediate="true" />
                <h:commandButton value="Up" action="#{mapEditorBean.moveInfoLayerUp}"
                  image="/common/misc/images/up.png" disabled="#{index == 0}"
                  styleClass="smallButton"
                  alt="#{mapViewerBundle.moveup}" title="#{mapViewerBundle.moveup}" />
                <h:commandButton value="Down" action="#{mapEditorBean.moveInfoLayerDown}"
                  image="/common/misc/images/down.png"
                  disabled="#{index == mapEditorBean.infoLayerCount - 1}"
                  styleClass="smallButton"
                  alt="#{mapViewerBundle.movedown}" title="#{mapViewerBundle.movedown}" />
                <h:commandButton action="#{mapEditorBean.removeInfoLayer}"
                  image="/common/misc/images/remove.png" styleClass="smallButton"
                  alt="#{objectBundle.remove}" title="#{objectBundle.remove}"
                  immediate="true" />
              </h:panelGroup>
              <h:panelGroup rendered="#{mapEditorBean.infoLayerIndex == index}">
                <h:commandButton value="#{objectBundle.accept}"
                  action="#{mapEditorBean.saveInfoLayer}" styleClass="smallButton" />
                <h:commandButton value="#{objectBundle.cancel}"
                  action="#{mapEditorBean.cancelInfoLayer}"
                  immediate="true" styleClass="smallButton" />
              </h:panelGroup>
            </t:column>
          </t:dataTable>
          <h:commandButton image="/common/misc/images/add.png"
            styleClass="smallButton"
            action="#{mapEditorBean.addInfoLayer}" title="#{mapViewerBundle.addLayer}" />
          <h:commandButton value="#{mapViewerBundle.addAllLayers}" styleClass="smallButton"
            action="#{mapEditorBean.addAllInfoLayers}" />
        </t:panelTab>

        <t:panelTab label="#{mapViewerBundle.properties} (#{mapEditorBean.propertyCount})" styleClass="mapProperties">
          <t:dataTable value="#{mapEditorBean.propertyNames}"
            var="propertyName" rowIndexVar="index" styleClass="mapTable"
            rowStyleClass="#{index == mapEditorBean.propertyIndex ? 'selected' : ''}"
            rendered="#{!empty mapEditorBean.propertyNames}">
            <t:column styleClass="nameColumn">
              <f:facet name="header">
                <h:outputText value="#{mapViewerBundle.name}" />
              </f:facet>
              <h:outputText value="#{propertyName}" styleClass="propertyName"
                rendered="#{mapEditorBean.propertyIndex != index}" />
              <h:inputText value="#{mapEditorBean.editingPropertyName}"
                styleClass="propertyValue"
                rendered="#{mapEditorBean.propertyIndex == index}"/>
            </t:column>
            <t:column styleClass="valueColumn">
              <f:facet name="header">
                <h:outputText value="#{mapViewerBundle.value}" />
              </f:facet>
              <h:outputText value="#{mapEditorBean.propertyValue}" styleClass="propertyValue"
                rendered="#{mapEditorBean.propertyIndex != index}"/>
              <h:inputText value="#{mapEditorBean.editingPropertyValue}"
                styleClass="propertyValue"
                rendered="#{mapEditorBean.propertyIndex == index}"/>
            </t:column>
            <t:column styleClass="actionsColumn">
              <h:panelGroup rendered="#{mapEditorBean.propertyIndex != index}">
                <h:commandButton value="Edit"
                  action="#{mapEditorBean.editProperty}"
                  image="/common/misc/images/edit.png"
                  alt="#{objectBundle.edit}" title="#{objectBundle.edit}"
                  styleClass="smallButton" />
                <h:commandButton value="remove"
                  action="#{mapEditorBean.removeProperty}"
                  image="/common/misc/images/remove.png"
                  alt="#{objectBundle.remove}" title="#{objectBundle.remove}"
                  styleClass="smallButton" />
              </h:panelGroup>
              <h:panelGroup rendered="#{mapEditorBean.propertyIndex == index}">
                <h:commandButton value="#{objectBundle.accept}" styleClass="smallButton"
                  action="#{mapEditorBean.saveProperty}" />
                <h:commandButton value="#{objectBundle.cancel}" styleClass="smallButton"
                  action="#{mapEditorBean.cancelProperty}" />
              </h:panelGroup>
            </t:column>
          </t:dataTable>
          <h:commandButton value="add"
            action="#{mapEditorBean.addProperty}"
            image="/common/misc/images/add.png"
            rendered="#{mapEditorBean.propertyIndex == -1}"
            alt="#{mapViewerBundle.addProperty}" title="#{mapViewerBundle.addProperty}"
            styleClass="smallButton" />
          <h:commandButton value="#{mapViewerBundle.addDefaultProperties}"
            action="#{mapEditorBean.addDefaultProperties}"
            rendered="#{mapEditorBean.propertyIndex == -1}"
            styleClass="smallButton" />
        </t:panelTab>

        <t:panelTab label="#{mapViewerBundle.roles} (#{mapEditorBean.roleCount})" styleClass="roles">
          <t:div styleClass="readRoles">
            <h:outputText value="#{mapViewerBundle.readRoles}:" styleClass="rolesHeader" />
            <t:dataList value="#{mapBean.map.readRoles}" var="role" layout="unorderedList">
              <h:outputText value="#{role}" styleClass="role" />
              <h:commandButton action="#{mapEditorBean.removeReadRole}" title="#{objectBundle.remove}"
                image="/common/misc/images/remove.png"
                styleClass="smallButton" />
            </t:dataList>
            <h:inputText value="#{mapEditorBean.readRole}" styleClass="newRole" />
            <h:commandButton action="#{mapEditorBean.addReadRole}" title="Add role"
               image="/common/misc/images/add.png"
               styleClass="smallButton" />
          </t:div>

          <t:div styleClass="writeRoles">
            <h:outputText value="#{mapViewerBundle.writeRoles}:" styleClass="rolesHeader" />
            <t:dataList value="#{mapBean.map.writeRoles}" var="role" layout="unorderedList">
              <h:outputText value="#{role}" styleClass="role" />
              <h:commandButton action="#{mapEditorBean.removeWriteRole}" title="#{objectBundle.remove}"
                image="/common/misc/images/remove.png"
                styleClass="smallButton" />
            </t:dataList>
            <h:inputText value="#{mapEditorBean.writeRole}" styleClass="newRole" />
            <h:commandButton action="#{mapEditorBean.addWriteRole}" title="Add role"
               image="/common/misc/images/add.png"
               styleClass="smallButton" />
          </t:div>
        </t:panelTab>

      </t:panelTabbedPane>

    </t:div>

    <h:outputLink value="/documents/#{mapBean.map.docId}/map.sld?cache=0" target="sld"
      rendered="#{mapBean.map.docId != null}" style="margin-left:4px">
      <h:outputText value="Source" />
    </h:outputLink>
    
  </t:panelGroup>

  <sf:saveScroll />
  <h:outputText value="#{mapEditorBean.scripts}" escape="false" />

</jsp:root>

