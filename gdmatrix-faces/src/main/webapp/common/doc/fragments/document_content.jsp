<?xml version='1.0' encoding='windows-1252'?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
          xmlns:f="http://java.sun.com/jsf/core"
          xmlns:h="http://java.sun.com/jsf/html"
          xmlns:t="http://myfaces.apache.org/tomahawk"
          xmlns:s="http://myfaces.apache.org/sandbox" 
          xmlns:sf="http://www.santfeliu.org/jsf">

  <f:loadBundle basename="org.santfeliu.doc.web.resources.DocumentBundle"
                var="documentBundle" />



  <t:div styleClass="documentContentPanel">
  <h:panelGrid columns="2" border="0" width="100%"
    columnClasses="docContentCol1,docContentCol2"
    rendered="#{!documentContentBean.renderMetadata}">
    <t:div rendered="#{documentContentBean.content.contentId != null}">
      <t:div styleClass="row">
        <h:outputText value="#{documentBundle.documentContent_contentId}:"
                    styleClass="textBox" style="width:25%" />
        <h:outputText value="#{documentContentBean.content.contentId}"
                  styleClass="outputBox" style="font-family:courier new" />
      </t:div>

      <t:div styleClass="row">
        <h:outputText value="#{documentBundle.documentContent_contentType}:"
                      styleClass="textBox" style="width:25%;" />
        <h:outputText value="#{documentContentBean.content.contentType}"
                      styleClass="outputBox" style="width:62%;" />
        <h:graphicImage url="#{documentContentBean.contentTypeImage}"
                        style="vertical-align: middle;margin-left:3px"
                        rendered="#{documentContentBean.contentTypeImage != null}"/>
      </t:div>

      <t:div styleClass="row"
         rendered="#{documentContentBean.content.formatDescription != null}">
        <h:outputText value="#{documentBundle.documentContent_format}:"
                      styleClass="textBox" style="width:25%" />
        <h:outputText value="#{documentContentBean.content.formatDescription}"
                      styleClass="outputBox" style="width:62%;height:auto" />
      </t:div>

      <t:div styleClass="row">
        <h:outputText value="#{documentBundle.documentContent_puid}:"
                      styleClass="textBox" style="width:25%" />
        <h:outputText value="#{documentContentBean.content.formatId}"
                      styleClass="outputBox" style="width:20%" />
      </t:div>

      <t:div styleClass="row"
        rendered="#{documentContentBean.content.language != null and
                    documentContentBean.content.language != ''}">
        <h:outputText value="#{documentBundle.documentContent_language}:"
                      styleClass="textBox" style="width:25%" />
        <h:outputText value="#{documentContentBean.contentLanguage}"
                      styleClass="outputBox" style="width:30%" />
        <h:graphicImage url="#{documentContentBean.languageFlag}"
                        rendered="#{documentContentBean.languageFlag != null and
                          documentContentBean.languageFlag != ''}"
                        styleClass="textBox"/>
      </t:div>

      <t:div styleClass="row">
        <h:outputText value="#{documentBundle.documentContent_storageType}:"
                      styleClass="textBox" style="width:25%" />
        <h:outputText value="#{documentContentBean.contentStorageType}"
                      styleClass="outputBox" style="width:30%" />
      </t:div>

      <t:div styleClass="row"
        rendered="#{documentContentBean.content.url != null}">
        <h:outputText value="#{documentBundle.documentContent_url}:"
                      styleClass="textBox" style="width:25%" />
        <h:outputText value="#{documentContentBean.content.url}"
                      styleClass="outputBox" style="width:62%" />
      </t:div>

      <t:div styleClass="row">
        <h:outputText value="#{documentBundle.documentContent_size}:"
                      styleClass="textBox" style="width:25%" />
        <h:outputText value="#{documentContentBean.content.size > 0 ? documentContentBean.contentSize : '0 B'}"
                      styleClass="outputBox" style="width:30%" />
      </t:div>

      <t:div styleClass="row">
        <h:outputText value="#{documentBundle.documentContent_captureDate}:"
                      styleClass="textBox" style="width:25%" />
        <h:outputText value="#{documentContentBean.captureDateTime}"
                      styleClass="outputBox" style="width:30%">
          <f:convertDateTime pattern="dd/MM/yyyy HH:mm:ss" />
        </h:outputText>
        <h:outputText value="#{documentBundle.documentContent_captureUser}:"
                      styleClass="textBox" style="width:5%" />
        <h:outputText value="#{documentContentBean.content.captureUserId}"
                      styleClass="outputBox" style="width:24%" />
      </t:div>

      <t:div styleClass="row">
        <h:outputText value="#{documentBundle.documentContent_downloadUrl}:"
                    styleClass="textBox" style="width:25%" />
        <h:outputText value="#{documentContentBean.fullURL}"
                    styleClass="outputBox"
                    style="font-family:courier new;width:62%;height:auto" />
      </t:div>
    </t:div>

    <t:div>
      <t:div rendered="#{!documentContentBean.renderMetadata}" style="text-align:center">
        <h:commandButton value="#{objectBundle.edit}"
           rendered="#{document2Bean.editable and documentContentBean.content != null and
           documentContentBean.content.url == null
           and (documentMainBean.document.lockUserId == null or userSessionBean.username == documentMainBean.document.lockUserId)
           and not userSessionBean.matrixClientEnabled}"
           styleClass="editButton" onclick="javascript:htmlSendFile_edit('#{documentMainBean.document.docId}','#{documentMainBean.document.content.language}');return false"
           image="#{userSessionBean.icons.edit}"
           alt="#{objectBundle.edit}" title="#{objectBundle.edit}" />
        <h:commandButton value="#{objectBundle.edit}"
           rendered="#{document2Bean.editable and documentContentBean.content != null and
           documentContentBean.content.url == null
           and (documentMainBean.document.lockUserId == null or userSessionBean.username == documentMainBean.document.lockUserId)
           and userSessionBean.matrixClientEnabled}"
           styleClass="editButton" onclick="javascript:editDocument({docId:'#{documentMainBean.document.docId}'});return false"
           image="#{userSessionBean.icons.edit}"
           alt="#{objectBundle.edit}" title="#{objectBundle.edit}" />
        
        <h:commandButton value="#{objectBundle.download}"
          onclick="javascript:window.open('#{documentContentBean.downloadURL}');return false"
          rendered="#{documentContentBean.content != null}"
          styleClass="editButton"
          image="#{userSessionBean.icons.download}"
          alt="#{objectBundle.download}" title="#{objectBundle.download}" />
      </t:div>

      <t:div style="text-align:center;margin-top:20px">
        <h:outputLink value="#{documentContentBean.documentURL}" target="_blank">
          <h:graphicImage url="#{documentContentBean.previewURL}"
            rendered="#{documentContentBean.previewURL != null}"
             style="border:none;width:60px"/>
        </h:outputLink>
      </t:div>
      <t:div style="text-align:center">
        <h:outputText value="#{documentBundle.documentContent_clickToOpen}"
                      rendered="#{documentContentBean.previewURL != null}"/>
      </t:div>
    </t:div>

  </h:panelGrid>

  <t:div styleClass="fileMessage"
         rendered="#{!documentContentBean.tempFile.emptyFile}">
    <h:outputText value="#{documentBundle.documentContent_fileMessage}: "  />
    <h:outputText value="#{documentContentBean.tempFile.fileName} (#{documentContentBean.tempFile.fileSize})."
                  styleClass="fileName"/>
    <t:div style="text-align:right;margin-top:5px">
      <h:commandButton action="#{documentContentBean.cancelNewContent}"
        value="#{objectBundle.cancel}" styleClass="cancelButton"
        disabled="#{not document2Bean.editable}"/>
    </t:div>
  </t:div>

  <t:div style="padding: 2px;">
    <h:outputText value="#{documentBundle.documentContent_changeContent}: "
      styleClass="textBox" style="width:30%" 
      rendered="#{documentContentBean.content.contentId != null}" />
    <t:panelTabbedPane width="100%" style="margin-top:4px">
      <t:panelTab label="#{documentBundle.documentContent_file}"
        styleClass="row">
        <t:div>
          <h:outputText styleClass="textBox"
            value="#{documentBundle.documentContent_file}: " style="width:16%" />
          <t:inputFileUpload styleClass="inputBox" size="70"
            value="#{documentContentBean.uploadedFile}" storage="file"
            disabled="#{not document2Bean.editable}"
            valueChangeListener="#{documentContentBean.uploadFile}"
            onchange="showOverlay();submit();"/>
          <h:outputText value=" (&lt; 100Mb)"/>
        </t:div>
      </t:panelTab>
      <t:panelTab label="URL" styleClass="row">
        <h:outputText styleClass="textBox" value="URL: " style="width:16%" />
        <h:inputText value="#{documentContentBean.contentUrl}"
          style="width:70%" styleClass="inputBox"
          readonly="#{not document2Bean.editable}"/>
      </t:panelTab>
      <t:panelTab label="ContentId" styleClass="row">
        <h:outputText styleClass="textBox" value="ContentId: " style="width:16%" />
        <h:inputText value="#{documentContentBean.contentId}"
          style="width:70%" styleClass="inputBox"
          readonly="#{not document2Bean.editable}"/>
      </t:panelTab>
    </t:panelTabbedPane>
  </t:div>

  <t:div>
    <h:selectBooleanCheckbox value="#{document2Bean.createNewVersion}"
                             style="vertical-align:middle;"
                             disabled="#{not document2Bean.editable}"/>
    <h:outputText value="#{documentBundle.document_createNewVersion}"
                  styleClass="textBox" style="vertical-align:middle;"/>
  </t:div>

  <sf:sendfile height="0" width="0" action="#{documentContentBean.refresh}"
    fileProperties="#{documentSearchBean.documentProperties}"
    docTypes="#{documentConfigBean.docTypes}"
    port="#{applicationBean.serverSecurePort}"
    rendered="#{not userSessionBean.matrixClientEnabled}"/>
  <sf:matrixclient command="org.santfeliu.matrix.client.cmd.doc.EditDocumentCommand"
    action="#{documentContentBean.documentEdited}"
    model="#{documentContentBean.model}" 
    function="editDocument"
    rendered="#{userSessionBean.matrixClientEnabled}"
    helpUrl="#{matrixClientBean.helpUrl}"/>  
  </t:div>
</jsp:root>
