<?xml version='1.0' encoding='windows-1252'?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
          xmlns:f="http://java.sun.com/jsf/core"
          xmlns:h="http://java.sun.com/jsf/html"
          xmlns:t="http://myfaces.apache.org/tomahawk"
          xmlns:sf="http://www.santfeliu.org/jsf">

  <f:loadBundle basename="org.santfeliu.web.obj.resources.ObjectBundle" 
    var="objectBundle" />

  <f:loadBundle basename="org.santfeliu.misc.sqlweb.web.resources.SqlWebBundle" 
    var="sqlWebBundle" />

  <t:stylesheet path="/plugins/codemirror/codemirror.css" />
  
  <t:div id="sqlweb_header" forceId="true">
    <h:outputText value="#{userSessionBean.menuModel.selectedMenuItem.label}" />
    <h:outputLink value="javascript:showHideEditor()" styleClass="show_hide_button" rendered="#{sqlWebBean.editMode}" 
      title="#{sqlWebBundle.change_view}" />
  </t:div>
  <t:div id="sqlweb_editor" forceId="true">
    <h:panelGroup rendered="#{sqlWebBean.editMode}">
      <t:div>
        <t:outputLabel value="#{sqlWebBundle.driver}:" for="driver" styleClass="output_label" />
        <t:inputText id="driver" value="#{sqlWebBean.driver}" forceId="true" styleClass="input_text" />    
      </t:div>
      <t:div>
        <t:outputLabel value="#{sqlWebBundle.url}:" for="url" styleClass="output_label" />
        <t:inputText id="url" value="#{sqlWebBean.url}" forceId="true" styleClass="input_text" />    
      </t:div>
      <t:div>
        <t:outputLabel value="#{sqlWebBundle.username}:" for="username" styleClass="output_label" />
        <t:inputText id="username" value="#{sqlWebBean.username}" styleClass="input_text" forceId="true" />  
        <t:outputLabel value="#{sqlWebBundle.password}:" for="password" styleClass="output_label center" />
        <t:inputSecret id="password" value="#{sqlWebBean.password}" redisplay="true" styleClass="input_text" forceId="true" />    
      </t:div>
      <t:div>
        <t:outputLabel value="#{sqlWebBundle.sql_statement}:" for="sql_stmt" />
      </t:div>
      
      <t:inputTextarea id="sql_stmt" forceId="true" value="#{sqlWebBean.sql}" />
    </h:panelGroup>
    
    <t:div styleClass="result_info">
      <t:outputLabel value="#{sqlWebBundle.max_rows}:" for="max_rows" />
      <t:inputText id="max_rows" value="#{sqlWebBean.maxRows}" forceId="true" styleClass="input_text" />    
      <t:outputLabel value="#{sqlWebBundle.show_row_numbers}:" for="row_numbers" />
      <t:selectBooleanCheckbox id="row_numbers" value="#{sqlWebBean.showRowNumbers}" />    
    </t:div>

    <t:div styleClass="button_bar">
      <t:commandButton value="#{sqlWebBundle.execute}" action="#{sqlWebBean.execute}" onclick="showOverlay()" styleClass="button"
        rendered="#{sqlWebBean.task == null or sqlWebBean.task.terminated}" />
      <t:commandButton value="#{sqlWebBundle.abort}" action="#{sqlWebBean.abort}" styleClass="button"
        rendered="#{sqlWebBean.task != null and sqlWebBean.task.running}" />
      <t:commandButton value="#{sqlWebBundle.clone}" action="#{sqlWebBean.showFullscreen}" onclick="changeTarget();" styleClass="button"
        rendered="#{sqlWebBean.editMode and (sqlWebBean.task == null or sqlWebBean.task.terminated)}"/>
    </t:div>

    <sf:taskMonitor task="#{sqlWebBean.task}" action="#{sqlWebBean.showResult}" 
      styleClass="progressBar" />

    <f:verbatim> 
      <script type="text/javascript" src="/plugins/jquery/jquery-1.10.2.js">
      0;
      </script>
      <script type="text/javascript" src="/plugins/codemirror/codemirror.js">
      0;
      </script>
      <script type="text/javascript" src="/plugins/codemirror/sql.js">
      0;
      </script>
      <script type="text/javascript" src="/plugins/codemirror/runmode.js">
      0;
      </script>
      <script type="text/javascript" src="/plugins/codemirror/matchbrackets.js">
      0;
      </script>
      <script type="text/javascript" src="/plugins/table2csv/table2csv.js">
      0;
      </script>
      <script type="text/javascript" src="/plugins/pdfmake/pdfmake.min.js">
      0;
      </script>
      <script type="text/javascript" src="/plugins/pdfmake/vfs_fonts.js">
      0;
      </script>
      <script type="text/javascript" src="/plugins/pdfmake/table2pdf.js">
      0;
      </script>
      <script type="text/javascript">
        var editor = document.getElementById("sql_stmt");
        var myCodeMirror = CodeMirror.fromTextArea(editor, 
          {mode: 'text/x-sql', lineNumbers: false, matchBrackets: true, lineWrapping: true});
      </script>
    </f:verbatim>
  </t:div>

  <t:div rendered="#{sqlWebBean.task != null and sqlWebBean.task.terminated 
                     and not sqlWebBean.task.cancelled and sqlWebBean.task.exception == null 
                     and sqlWebBean.task.rows != null}" 
    id="table_container" forceId="true">
    <t:div styleClass="scroll">
      <t:dataTable id="result_table" forceId="true"
        value="#{sqlWebBean.task.rows}" var="row" rowIndexVar="rowIndex"
        styleClass="table" rowStyleClass="#{rowIndex % 2 == 0 ? 'even' : 'odd'}" 
        columnClasses="#{sqlWebBean.showRowNumbers ? 'index,' : ''}#{sqlWebBean.columnClasses}">
        <t:column rendered="#{sqlWebBean.showRowNumbers}">
          <f:facet name="header">
            <t:outputText value="#" />
          </f:facet>
          <t:outputText value="#{rowIndex + 1}" />
        </t:column>
        <t:columns value="#{sqlWebBean.task.columns}" var="column">
          <f:facet name="header">
            <t:outputText value="#{column.name}"
              title="#{sqlWebBean.columnType}" />
          </f:facet>
          <h:outputLink value="#{sqlWebBean.columnValue}" rendered="#{sqlWebBean.columnLinkRendered}" target="_blank">
            <h:outputText value="#{sqlWebBean.columnValue}" />
          </h:outputLink>
          <h:outputText value="#{sqlWebBean.columnValue}" rendered="#{not sqlWebBean.columnLinkRendered}" />
        </t:columns>
      </t:dataTable>
    </t:div>
  </t:div>

  <t:div id="table_bottom" forceId="true" rendered="#{sqlWebBean.task != null}">
    <t:outputText value="#{sqlWebBundle.rows_updated}: #{sqlWebBean.task.updateCount}." 
      rendered="#{sqlWebBean.task.updateCount != -1}" styleClass="message updateCount block" />
    <t:outputText value="#{sqlWebBean.task.exception}" 
      rendered="#{sqlWebBean.task.exception != null}" styleClass="message error block" />
    <t:outputText value="#{sqlWebBundle.statement_cancelled}" 
      rendered="#{sqlWebBean.task.terminated and sqlWebBean.task.cancelled}" styleClass="message error block" />
    <t:outputText value="#{sqlWebBundle.rows_selected}: #{sqlWebBean.task.rowCount}." 
      rendered="#{sqlWebBean.task.terminated and not sqlWebBean.task.cancelled and sqlWebBean.task.rows != null}" 
      styleClass="message row_count"/>
    <t:outputText value="#{sqlWebBundle.ellapsed_time}: #{sqlWebBean.task.duration} ms." 
      rendered="#{sqlWebBean.task.duration gt 0}" styleClass="message ellapsed"/>
    <h:outputLink value="#" onclick="exportTable2CSV('result_table'); return false;" styleClass="button"
      rendered="#{sqlWebBean.task.terminated and sqlWebBean.task.exception == null 
                  and not sqlWebBean.task.cancelled and sqlWebBean.task.rows != null}">
      <h:outputText value="#{sqlWebBundle.export_csv}" />
    </h:outputLink>
    <h:outputLink value="#" onclick="exportTable2Pdf('result_table'); return false;" styleClass="button"
      rendered="#{sqlWebBean.task.terminated and sqlWebBean.task.exception == null 
                  and not sqlWebBean.task.cancelled and sqlWebBean.task.rows != null}">
      <h:outputText value="#{sqlWebBundle.export_pdf} (#{sqlWebBundle.table})" />
    </h:outputLink>
    <h:outputLink value="#" onclick="exportLabels2Pdf('result_table'); return false;" styleClass="button"
      rendered="#{sqlWebBean.task.terminated and sqlWebBean.task.exception == null 
                  and not sqlWebBean.task.cancelled and sqlWebBean.task.rows != null}">
      <h:outputText value="#{sqlWebBundle.export_pdf} (#{sqlWebBundle.labels})" />
    </h:outputLink>
  </t:div>

  <f:verbatim>
    <script type="text/javascript">
      function showHideEditor()
      {
        var editorVisible = $("#sqlweb_editor").is(":visible");
        if (editorVisible)
        {
          $("#sqlweb_editor").hide();
        }
        else
        {
          $("#sqlweb_editor").show();          
        }
        updateScrollHeight();
      }
      
      function updateScrollHeight()
      {
        if (!$(".scroll")) return;

        var editorVisible = $("#sqlweb_editor").is(":visible");
        console.info(editorVisible);
        
        var pageHeight = editorVisible ? 
          $("#sqlweb_editor").offset().top + $("#sqlweb_editor").height() + 
            $("#table_bottom").height() :
          $("#sqlweb_header").offset().top + $("#sqlweb_header").height() + 
            $("#table_bottom").height();

        console.info("ph:" + pageHeight);
        var scrollHeight = $(window).height() - pageHeight - 30;
        console.info("sh:" + scrollHeight);
        if (scrollHeight &lt; 0) scrollHeight = 0;
        $(".scroll").height(scrollHeight);
      }
      
      if (myCodeMirror !== undefined)
      { 
        myCodeMirror.on("change", function(cm, change)
        {
          setTimeout(function(){updateScrollHeight();}, 0);
        });
      }
      $(document).ready(function() 
      { 
        updateScrollHeight();
        $(window).resize(function() 
        {
          updateScrollHeight();
        });
      });      
    </script>
  </f:verbatim>
      
</jsp:root>
