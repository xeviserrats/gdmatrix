<?xml version='1.0' encoding='windows-1252'?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
          xmlns:f="http://java.sun.com/jsf/core"
          xmlns:h="http://java.sun.com/jsf/html"
          xmlns:t="http://myfaces.apache.org/tomahawk"
          xmlns:sf="http://www.santfeliu.org/jsf">
  <f:loadBundle basename="org.santfeliu.news.web.resources.NewsBundle"
                var="newsBundle"/>

  <h:panelGroup rendered="#{newSearchBySectionBean.rootEditLinkRender}">
    <sf:saveScroll />
  </h:panelGroup>
  
  <sf:browser id="headerBrowser"
              url="#{newSearchBySectionBean.headerUrl}"
              port="#{applicationBean.defaultPort}"
              rendered="#{newSearchBySectionBean.headerRender}"
              translator="#{userSessionBean.translator}"
              translationGroup="#{userSessionBean.translationGroup}" />
  
  <t:div id="filterPanel" styleClass="filterPanel"
      rendered="#{newSearchBySectionBean.filterRender}">
    <t:div styleClass="header">
      <h:outputText />
    </t:div>
    
    <t:div styleClass="column1" rendered="#{newSearchBySectionBean.filterContentRender}">
      <h:outputLabel for="contentInputText" id="contentLabel" styleClass="textBox"
                  value="#{newsBundle.new_search_content}:" />
    </t:div>
    <t:div styleClass="column2" rendered="#{newSearchBySectionBean.filterContentRender}">
      <h:inputText id="contentInputText" value="#{newSearchBySectionBean.searchContent}"
                   styleClass="inputBox"                
                   style="width:80%"/>
    </t:div>  
    
    <sf:div styleClass="column1" rendered="#{newSearchBySectionBean.filterDateRender}" ariaHidden="true">
      <h:outputLabel id="startDayLabel" styleClass="textBox"
                    value="#{newsBundle.new_search_startDay}:"/>
    </sf:div>
    <t:div styleClass="column2"  rendered="#{newSearchBySectionBean.filterDateRender}">
      <sf:calendar id="startInputCalendar"
        externalFormat="dd/MM/yyyy|HH:mm"
        internalFormat="yyyyMMddHHmmss"
        value="#{newSearchBySectionBean.filter.startDateTime}"
        styleClass="calendarBox"
        buttonStyleClass="calendarButton"
        style="width:20%;"
        dayLabel="#{newsBundle.new_search_startDay}"
        hourLabel="#{newsBundle.new_search_startHour}"/>
    </t:div>
    
    <sf:div styleClass="column1"  rendered="#{newSearchBySectionBean.filterDateRender}" ariaHidden="true">
      <h:outputLabel id="endDayLabel" styleClass="textBox"
                    value="#{newsBundle.new_search_endDay}:"/>
    </sf:div>
    <t:div styleClass="column2" rendered="#{newSearchBySectionBean.filterDateRender}">
      <sf:calendar id="endInputCalendar"
        externalFormat="dd/MM/yyyy|HH:mm"
        internalFormat="yyyyMMddHHmmss"
        value="#{newSearchBySectionBean.filter.endDateTime}"
        styleClass="calendarBox"
        buttonStyleClass="calendarButton"
        style="width:20%;" 
        dayLabel="#{newsBundle.new_search_endDay}"
        hourLabel="#{newsBundle.new_search_endHour}" />
    </t:div>
    
    <t:div styleClass="column1" rendered="#{newSearchBySectionBean.filterUserRender}">
      <h:outputLabel for="userIdInputText" id="userIdLabel" styleClass="textBox" 
        value="#{newsBundle.new_search_user}:"/>
    </t:div>
    <t:div styleClass="column2" rendered="#{newSearchBySectionBean.filterUserRender}">
      <h:inputText id="userIdInputText" value="#{newSearchBySectionBean.filter.userId}"
                   styleClass="inputBox"
                   style="width:20%" /> 
    </t:div>    
    <t:div styleClass="footer">
      <h:panelGroup id="actionsBar" styleClass="actionsBar">
        <h:commandButton value="#{objectBundle.search}" styleClass="searchButton"
                         action="#{newSearchBySectionBean.search}" id="default_button"/>
      </h:panelGroup>
    </t:div>
  </t:div>

  <h:outputLink rendered="#{newSearchBySectionBean.rssEnabled}"
              value="#{newSearchBySectionBean.rssURL}" style="text-decoration:none;">
    <sf:graphicImage value="/images/rss.png" style="border:0px;margin-top:4px" 
                    alt="Accedir al canal RSS de #{newSearchBySectionBean.sectionDesc}" 
                    title="Accedir al canal RSS de #{newSearchBySectionBean.sectionDesc}" 
                    translator="#{userSessionBean.translator}"
                    translationGroup="#{userSessionBean.translationGroup}" />
  </h:outputLink>

  <t:div styleClass="resultBar" rendered="#{newSearchBySectionBean.rows != null and newSearchBySectionBean.rootResultBarRender}">
    <t:dataScroller for="newSearchRootList"
      firstRowIndexVar="firstRow"
      lastRowIndexVar="lastRow"
      rowsCountVar="rowCount"
      rendered="#{newSearchBySectionBean.rowCount > 0}">
      <h:outputFormat value="#{objectBundle.resultRange}"
        style="margin-top:10px;display:block">
        <f:param value="#{firstRow}" />
        <f:param value="#{lastRow}" />
        <f:param value="#{rowCount}" />
      </h:outputFormat>
    </t:dataScroller>
    <h:outputText value="#{objectBundle.no_results_found}"
      rendered="#{newSearchBySectionBean.rowCount == 0}" />
  </t:div>

  <t:div style="margin-top:12px" rendered="#{newSearchBySectionBean.rootSectionHeaderRender}">
    <sf:outputText id="rootSectionDesc" value="#{newSearchBySectionBean.sectionDesc}"
                  styleClass="sectionDesc"
                  translator="#{userSessionBean.translator}"
                  translationGroup="#{userSessionBean.translationGroup}" />
  </t:div>
  <t:dataTable id="newSearchRootList" rowIndexVar="rowIndex" value="#{newSearchBySectionBean.rows}"
               var="row" rendered="#{newSearchBySectionBean.rowCount > 0}"
               styleClass="resultList"
               rowClasses="row1,row2" headerClass="header"
               footerClass="footer" style="width:100%"
               rows="#{newSearchBySectionBean.pageSize}"
               first="#{newSearchBySectionBean.firstRowIndex}">
    <t:column id="resultListColumn1" style="width:100%">
      <h:panelGrid columns="1" id="resultNew" styleClass="rootNew"
                   style="width:100%">
        <h:panelGrid columns="1" style="text-align:left" rendered="#{row.draft}" >
          <h:outputText value="#{newsBundle.new_search_draft}" styleClass="draft" />
        </h:panelGrid>
        <h:panelGrid columns="1" rendered="#{newSearchBySectionBean.futureNew}" >
          <h:outputText value="#{newsBundle.new_search_future}" styleClass="future" />
        </h:panelGrid>
        <h:panelGrid columns="1" rendered="#{newSearchBySectionBean.expiredNew}" >
          <h:outputText value="#{newsBundle.new_search_expired}" styleClass="expired" />
        </h:panelGrid>        
        <h:panelGrid columns="1" styleClass="topPanel" id="rootNewRow1_d"
                     columnClasses="dateColFull"
                     rendered="#{newSearchBySectionBean.rootOnlyDateRender}"
                     style="width:100%;text-align:left">
          <h:outputText id="newDate" styleClass="newDate" value="#{newSearchBySectionBean.newDate}"/>
        </h:panelGrid>
        <h:panelGrid columns="1" id="rootNewRow1_h" styleClass="topPanel"
                     columnClasses="hlineColFull"
                     rendered="#{newSearchBySectionBean.rootOnlyHeadlineRender}"
                     style="width:100%;text-align:left">
          <h:outputLink value="#{newSearchBySectionBean.newLink}"
                        styleClass="headlineLink"
                        id="headlineLink">
            <sf:outputText id="headlineText" value="#{row.headline}"
                          styleClass="headlineText"
                          translator="#{userSessionBean.translator}"
                          translationGroup="#{newSearchBySectionBean.translationGroup}" />
          </h:outputLink>
        </h:panelGrid>
        <h:panelGrid columns="2" id="rootNewRow1_dh" styleClass="topPanel"
                     columnClasses="dateCol,hlineCol"
                     rendered="#{newSearchBySectionBean.rootDateAndHeadlineRender}"
                     style="width:100%;text-align:left">
          <h:outputText id="newDate_dh" styleClass="newDate"
                        value="#{newSearchBySectionBean.newDate}"/>
          <h:outputLink value="#{newSearchBySectionBean.newLink}"
                        styleClass="headlineLink"
                        id="headlineLink_dh">
            <sf:outputText id="headlineText_dh" value="#{row.headline}"
                          styleClass="headlineText"
                          translator="#{userSessionBean.translator}"
                          translationGroup="#{newSearchBySectionBean.translationGroup}" />
          </h:outputLink>
        </h:panelGrid>
        <h:panelGrid columns="1" id="rootNewRow2_i" styleClass="bottomPanel"
                     columnClasses="imgColFull"
                     rendered="#{newSearchBySectionBean.rootOnlyImageRender}"
                     style="width:100%">
          <h:graphicImage id="image" url="#{newSearchBySectionBean.newImageURL}"
                          styleClass="image"
                          style="width:#{newSearchBySectionBean.rootNewImageWidth}px;height:#{newSearchBySectionBean.rootNewImageHeight}px"
                          alt=""
                          rendered="#{!(newSearchBySectionBean.newImageURL == null)}"/>
        </h:panelGrid>
        <h:panelGrid columns="1" id="rootNewRow2_s" styleClass="bottomPanel"
                     columnClasses="summaryColFull"
                     rendered="#{newSearchBySectionBean.rootOnlySummaryRender}"
                     style="width:100%">
          <t:div id="summary" styleClass="summary">
            <sf:outputText value="#{row.summary}"
                          escape="false"
                          translator="#{userSessionBean.translator}"
                          translationGroup="#{newSearchBySectionBean.translationGroup}" />
          </t:div> 
        </h:panelGrid>
        <h:panelGrid columns="2" id="rootNewRow2_is_l"
                     styleClass="bottomPanel"
                     columnClasses="imgColL,summaryCol"
                     rendered="#{newSearchBySectionBean.rootImageAndSummaryRenderLeft}"
                     style="width:100%">
          <h:graphicImage id="image_is_l" url="#{newSearchBySectionBean.newImageURL}"
                          styleClass="image"
                          style="text-align:left;width:#{newSearchBySectionBean.rootNewImageWidth}px;height:#{newSearchBySectionBean.rootNewImageHeight}px"
                          alt=""
                          rendered="#{!(newSearchBySectionBean.newImageURL == null)}"/>
          <t:div id="summary_is_l" styleClass="summary">
            <sf:outputText value="#{row.summary}"
                           escape="false"
                          translator="#{userSessionBean.translator}"
                          translationGroup="#{newSearchBySectionBean.translationGroup}" />
          </t:div>
        </h:panelGrid>
        <h:panelGrid columns="2" id="rootNewRow2_is_r"
                     styleClass="bottomPanel"
                     columnClasses="summaryCol,imgColR"
                     rendered="#{newSearchBySectionBean.rootImageAndSummaryRenderRight}"
                     style="width:100%">
          <t:div id="summary_is_r" styleClass="summary">
            <sf:outputText value="#{row.summary}" 
                           escape="false"
                          translator="#{userSessionBean.translator}"
                          translationGroup="#{newSearchBySectionBean.translationGroup}" />
          </t:div>
          <h:graphicImage id="image_is_r" url="#{newSearchBySectionBean.newImageURL}"
                          styleClass="image"
                          style="text-align:right;width:#{newSearchBySectionBean.rootNewImageWidth}px;height:#{newSearchBySectionBean.rootNewImageHeight}px"
                          alt=""
                          rendered="#{!(newSearchBySectionBean.newImageURL == null)}"/>
        </h:panelGrid>
        <t:dataList var="doc"
                     value="#{newSearchBySectionBean.extendedInfoDocList}"
                     styleClass="documentList"
                     rendered="#{newSearchBySectionBean.rootDocumentsRender and 
                                (!newSearchBySectionBean.extendedInfoDocListEmpty)}"
                     style="width:100%" layout="unorderedList">
          <t:div id="documentListColumn">
            <h:panelGroup>
              <h:graphicImage url="#{newSearchBySectionBean.mimeTypePath}"
                              style="margin-right:3pt;vertical-align:middle;"/>
              <h:outputLink value="#{newSearchBySectionBean.documentUrl}"
                            styleClass="documentLink" target="_blank">
                <h:outputText id="documentListTitle" value="#{doc.title}"
                              styleClass="title"/>
              </h:outputLink>
            </h:panelGroup>
          </t:div>
        </t:dataList>
        <h:panelGrid id="rootNewRow2LinksGrid"
                     columns="1"
                     styleClass="bottomPanel"
                     style="width:100%;text-align:#{newSearchBySectionBean.rootLinksPosition}"
                     rendered="#{newSearchBySectionBean.rootBottomPanelRender}">
          <h:panelGroup>
            <h:graphicImage styleClass="sticky" alt="#{newsBundle.new_sections_sticky_on}" url="/common/news/images/sticky_on.png" rendered="#{newSearchBySectionBean.rootStickyIconRender}" /> 
            <sf:commandButton value="#{newSearchBySectionBean.rootReadLinkText}"
                             styleClass="readNewButton"
                             style="vertical-align:middle"
                             action="#{newSearchBySectionBean.goToNew}"
                             rendered="#{newSearchBySectionBean.rootReadLinkRender}"
                             translator="#{userSessionBean.translator}"
                             translationGroup="#{userSessionBean.translationGroup}" 
                             ariaLabel="#{newSearchBySectionBean.rootReadLinkText}: #{row.headline}"/>
            <h:commandButton value="#{newsBundle.new_search_moveUp}"
                              image="#{userSessionBean.icons.up}"
                              alt="#{newsBundle.new_search_moveUp}"
                              title="#{newsBundle.new_search_moveUp}"
                              styleClass="moveUpButton"
                              style="vertical-align:middle"
                              action="#{newSearchBySectionBean.moveUp}"
                              rendered="#{newSearchBySectionBean.moveUpButtonRender and userSessionBean.menuModel.browserType == 'desktop'}" />
            <h:commandButton value="#{newsBundle.new_search_moveDown}"
                              image="#{userSessionBean.icons.down}"
                              alt="#{newsBundle.new_search_moveDown}"
                              title="#{newsBundle.new_search_moveDown}"
                              styleClass="moveDownButton"
                              style="vertical-align:middle"
                              action="#{newSearchBySectionBean.moveDown}"
                              rendered="#{newSearchBySectionBean.moveDownButtonRender and userSessionBean.menuModel.browserType == 'desktop'}" />
            <h:commandButton value="#{objectBundle.edit}"
                             image="#{userSessionBean.icons.detail}"
                             alt="#{objectBundle.edit}" title="#{objectBundle.edit}"
                             styleClass="showButton"
                             style="vertical-align:middle"
                             immediate="true" action="#{newSearchBySectionBean.showNew}"
                             rendered="#{newSearchBySectionBean.rootEditLinkRender and userSessionBean.menuModel.browserType == 'desktop'}" />
          </h:panelGroup>
        </h:panelGrid>
      </h:panelGrid>
    </t:column>
  </t:dataTable>

  <t:dataScroller for="newSearchRootList"
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

  <t:dataTable value="#{newSearchBySectionBean.childrenSectionViewList}"
               var="sectionRow" newspaperColumns="#{newSearchBySectionBean.colNumber}"
               newspaperOrientation="#{newSearchBySectionBean.colOrientation}"
               id="childrenResultList" styleClass="newSearchChildrenList"
               rowClasses="row1" columnClasses="col1"
               style="width:100%"
               rendered="#{newSearchBySectionBean.childrenRender}">
    <t:column id="childrenResultListColumn1"
              style="vertical-align:top;width:#{newSearchBySectionBean.colWidth}%">
      <t:dataTable value="#{sectionRow.newView}" var="row" id="newList"
                   styleClass="resultList"
                   headerClass="header"
                   footerClass="footer" rowClasses="row1,row2"
                   style="width:100%">
        <f:facet name="header">
            <h:outputLink id="sectionLink" value="/go.faces?xmid=#{sectionRow.sectionId}" styleClass="sectionLink"
                          onclick="return goMid('#{sectionRow.sectionId}')"
                        style="width:100%">
            <sf:outputText id="sectionDesc" value="#{sectionRow.desc}"
                          styleClass="sectionDesc" style="width:100%"
                          translator="#{userSessionBean.translator}"
                          translationGroup="#{userSessionBean.translationGroup}" />
          </h:outputLink>
        </f:facet>
        <t:column id="newListColumn1" style="width:100%;vertical-align:top">
          <h:panelGrid columns="1" id="sectionNew" columnClasses="col1"
                       styleClass="sectionNew"                       
                       style="width:100%">
            <h:panelGrid columns="1"                         
                         style="text-align:left" rendered="#{row.draft}">
              <h:outputText value="#{newsBundle.new_search_draft}"
                            styleClass="draft" />
            </h:panelGrid>
            <h:panelGrid columns="1" id="sectionNewTopPanel"
                         styleClass="topPanel"
                         columnClasses="dateCol,showCol"                         
                         style="width:100%">
              <h:outputText id="sectionNewDate"
                            styleClass="newDate"
                            value="#{newSearchBySectionBean.newDate}"
                            rendered="#{newSearchBySectionBean.childrenDateRender}" />
            </h:panelGrid>
            <h:panelGrid columns="1"
                         style="width:100%">
              <h:outputLink value="#{newSearchBySectionBean.newLink}"
                            styleClass="headlineLink"
                            id="sectionNewHeadlineLink"
                            rendered="#{newSearchBySectionBean.childrenHeadlineRender}">
                <sf:outputText id="sectionNewHeadlineText" value="#{row.headline}"
                              styleClass="headlineText"
                              translator="#{userSessionBean.translator}"
                              translationGroup="#{newSearchBySectionBean.translationGroup}" />
              </h:outputLink>
            </h:panelGrid>
            <h:panelGrid columns="1" id="sectionNew_i"
                         styleClass="bottomPanel"
                         columnClasses="imgColFull"
                         rendered="#{newSearchBySectionBean.childrenOnlyImageRender}"
                         style="width:100%">
              <h:graphicImage id="sectionNewImage"
                              url="#{newSearchBySectionBean.newImageURL}"
                              style="width:#{newSearchBySectionBean.childrenNewImageWidth}px;height:#{newSearchBySectionBean.childrenNewImageHeight}px"
                              alt=""
                              styleClass="image"
                              rendered="#{!(newSearchBySectionBean.newImageURL == null)}" />
            </h:panelGrid>
            <h:panelGrid columns="1" id="sectionNew_s"
                         styleClass="bottomPanel"
                         columnClasses="summaryColFull"
                         rendered="#{newSearchBySectionBean.childrenOnlySummaryRender}"
                         style="width:100%">
              <t:div id="sectionNewSummary" styleClass="summary">
                <sf:outputText value="#{row.summary}" escape="false"
                              translator="#{userSessionBean.translator}"
                              translationGroup="#{newSearchBySectionBean.translationGroup}" />
              </t:div>              
            </h:panelGrid>
            <h:panelGrid columns="2" id="sectionNew_is_l"
                         styleClass="bottomPanel"
                         columnClasses="imgColL,summaryCol"
                         rendered="#{newSearchBySectionBean.childrenImageAndSummaryRenderLeft}"                         
                         style="width:100%">
              <h:graphicImage id="sectionNewImage_is_l"
                              url="#{newSearchBySectionBean.newImageURL}"
                              style="width:#{newSearchBySectionBean.childrenNewImageWidth}px;height:#{newSearchBySectionBean.childrenNewImageHeight}px"
                              alt=""
                              rendered="#{!(newSearchBySectionBean.newImageURL == null)}"
                              styleClass="image" />
              <t:div id="sectionNewSummary_is_l" styleClass="summary">
                <sf:outputText value="#{row.summary}" escape="false"
                              translator="#{userSessionBean.translator}"
                              translationGroup="#{newSearchBySectionBean.translationGroup}" />
              </t:div>
            </h:panelGrid>
            <h:panelGrid columns="2" id="sectionNew_is_r"
                         styleClass="bottomPanel"
                         columnClasses="summaryCol,imgColR"
                         rendered="#{newSearchBySectionBean.childrenImageAndSummaryRenderRight}"
                         style="width:100%">
              <t:div id="sectionNewSummary_is_r" styleClass="summary">
                <sf:outputText value="#{row.summary}" escape="false"
                              translator="#{userSessionBean.translator}"
                              translationGroup="#{newSearchBySectionBean.translationGroup}" />
              </t:div>
              <h:graphicImage id="sectionNewImage_is_r"
                              url="#{newSearchBySectionBean.newImageURL}"
                              style="width:#{newSearchBySectionBean.childrenNewImageWidth}px;height:#{newSearchBySectionBean.childrenNewImageHeight}px"
                              alt=""
                              rendered="#{!(newSearchBySectionBean.newImageURL == null)}"
                              styleClass="image" />
            </h:panelGrid>
            <t:dataList var="doc"
                         value="#{newSearchBySectionBean.extendedInfoDocList}"
                         styleClass="documentList"
                         rendered="#{newSearchBySectionBean.childrenDocumentsRender and 
                                    (!newSearchBySectionBean.extendedInfoDocListEmpty)}"
                         style="width:100%" layout="unorderedList">
              <t:div id="childDocumentListColumn">
                <h:panelGroup>
                  <h:graphicImage url="#{newSearchBySectionBean.mimeTypePath}"
                                  style="margin-right:3pt;vertical-align:middle;"/>
                  <h:outputLink value="#{newSearchBySectionBean.documentUrl}"
                                styleClass="documentLink" target="_blank">
                    <h:outputText id="childDocumentListTitle" value="#{doc.title}"
                                  styleClass="title"/>
                  </h:outputLink>
                </h:panelGroup>
              </t:div>
            </t:dataList>
            <h:panelGrid columns="1" id="sectionNew_linksGrid"
                         styleClass="bottomPanel"
                         columnClasses="summaryColFull"
                         style="width:100%;text-align:#{newSearchBySectionBean.childrenLinksPosition}"
                         rendered="#{newSearchBySectionBean.childrenBottomPanelRender}">
              <h:panelGroup id="sectionNewLinksGroup">
                <h:graphicImage styleClass="sticky" alt="#{newsBundle.new_sections_sticky_on}" url="/common/news/images/sticky_on.png" rendered="#{newSearchBySectionBean.sectionStickyIconRender}" />                            
                <sf:commandButton value="#{newSearchBySectionBean.childrenReadLinkText}"
                                 style="vertical-align:middle"
                                 styleClass="readNewButton"
                                 action="#{newSearchBySectionBean.goToNew}"
                                 id="sectionNewReadLinkText"
                                 rendered="#{newSearchBySectionBean.childrenReadLinkRender}"
                                 translator="#{userSessionBean.translator}"
                                 translationGroup="#{userSessionBean.translationGroup}"
                                 ariaLabel="#{newSearchBySectionBean.childrenReadLinkText}: #{row.headline}"/>
                <h:commandButton id="sectionNewShowButton"
                                 style="vertical-align:middle"
                                 immediate="true"
                                 image="#{userSessionBean.icons.detail}"
                                 styleClass="showButton"
                                 action="#{newSearchBySectionBean.showNew}"
                                 rendered="#{newSearchBySectionBean.sectionEditLinkRender and userSessionBean.menuModel.browserType == 'desktop'}"
                                 value="#{objectBundle.edit}" />
              </h:panelGroup>
            </h:panelGrid>
          </h:panelGrid>
        </t:column>
      </t:dataTable>
    </t:column>
  </t:dataTable>
  <t:div styleClass="actionsBar">
    <h:commandButton value="#{objectBundle.create}"        
                     image="#{userSessionBean.icons.new}"        
                     alt="#{objectBundle.create}" 
                     title="#{objectBundle.create}" 
                     styleClass="createButton"
                     action="#{newBean.create}" immediate="true"
                     id="createButton"
                     rendered="#{newSearchBySectionBean.rootEditLinkRender and userSessionBean.menuModel.browserType == 'desktop'}"/>
  </t:div>

  <sf:browser id="footerBrowser"
              url="#{newSearchBySectionBean.footerUrl}"
              port="#{applicationBean.defaultPort}"
              rendered="#{newSearchBySectionBean.footerRender}"
              translator="#{userSessionBean.translator}"
              translationGroup="#{userSessionBean.translationGroup}" />

</jsp:root>
