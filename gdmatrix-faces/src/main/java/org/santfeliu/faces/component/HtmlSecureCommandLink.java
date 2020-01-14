package org.santfeliu.faces.component;

import org.santfeliu.faces.HtmlRenderUtils;
import java.io.IOException;
import java.io.StringReader;
import java.io.StringWriter;
import java.util.Map;
import javax.faces.component.UICommand;
import javax.faces.context.FacesContext;
import javax.faces.context.ResponseWriter;
import javax.faces.el.ValueBinding;
import javax.faces.event.ActionEvent;
import javax.servlet.http.HttpServletRequest;
import org.santfeliu.faces.FacesUtils;
import org.santfeliu.faces.Translator;

public class HtmlSecureCommandLink extends UICommand
{
  private final String SECURE_COMMAND_LINK_SCRIPT = "SECURE_COMMAND_LINK_SCRIPT";
  private String _value;
  private String _scheme; 
  private String _port;
  private String _function;
  private String _style;
  private String _styleClass;
  private Integer _tabindex;
  private String _title;
  private String _ariaLabel;
  private Boolean _ariaHidden;
  private String _role;
  private Translator _translator;
  private String _translationGroup;  
  
  public HtmlSecureCommandLink()
  {
  }
  
  @Override
  public String getFamily()
  {
    return "SecureCommandLink";
  }

  public void setValue(String value)
  {
    this._value = value;
  }

  @Override
  public String getValue()
  {
    if (_value != null) return _value;
    ValueBinding vb = getValueBinding("value");
    return vb != null ? (String)vb.getValue(getFacesContext()) : null;
  }

  public void setScheme(String scheme)
  {
    this._scheme = scheme;
  }

  public String getScheme()
  {
    if (_scheme != null) return _scheme;
    ValueBinding vb = getValueBinding("scheme");
    return vb != null ? (String)vb.getValue(getFacesContext()) : null;
  }

  public void setPort(String port)
  {
    this._port = port;
  }

  public String getPort()
  {
    if (_port != null) return _port;
    ValueBinding vb = getValueBinding("port");
    return vb != null ? (String)vb.getValue(getFacesContext()) : null;
  }
  
  public void setFunction(String function)
  {
    this._function = function;
  }

  public String getFunction()
  {
    return _function;
  }

  public void setStyle(String style)
  {
    this._style = style;
  }

  public String getStyle()
  {
    if (_style != null) return _style;
    ValueBinding vb = getValueBinding("style");
    return vb != null ? (String)vb.getValue(getFacesContext()) : null;
  }

  public void setStyleClass(String styleClass)
  {
    this._styleClass = styleClass;
  }

  public String getStyleClass()
  {
    if (_styleClass != null) return _styleClass;
    ValueBinding vb = getValueBinding("styleClass");
    return vb != null ? (String)vb.getValue(getFacesContext()) : null;
  }
  
  public void setTabindex(Integer tabindex)
  {
    this._tabindex = tabindex;
  }

  public Integer getTabindex()
  {
    if (_tabindex != null) return _tabindex;
    ValueBinding vb = getValueBinding("tabindex");
    return vb != null ? (Integer)vb.getValue(getFacesContext()) : null;
  }
  
  public void setTitle(String _title)
  {
    this._title = _title;
  }
  
  public String getTitle()
  {
    if (_title != null)
      return _title;
    ValueBinding vb = getValueBinding("title");
    return vb != null? (String) vb.getValue(getFacesContext()): null;
  }

  public void setAriaLabel(String _ariaLabel)
  {
    this._ariaLabel = _ariaLabel;
  }
  
  public String getAriaLabel()
  {
    if (_ariaLabel != null)
      return _ariaLabel;
    ValueBinding vb = getValueBinding("ariaLabel");
    return vb != null? (String) vb.getValue(getFacesContext()): null;
  }  

  public Boolean getAriaHidden()
  {
    if (_ariaHidden != null) return _ariaHidden;
    ValueBinding vb = getValueBinding("ariaHidden");
    return (vb != null ? (Boolean)vb.getValue(getFacesContext()) : 
      Boolean.FALSE);
  }

  public void setAriaHidden(Boolean ariaHidden)
  {
    this._ariaHidden = ariaHidden;
  }

  public String getRole()
  {
    if (_role != null)
      return _role;
    ValueBinding vb = getValueBinding("role");
    return vb != null? (String) vb.getValue(getFacesContext()): null;
  }

  public void setRole(String role)
  {
    this._role = role;
  }
  
  public void setTranslator(Translator translator)
  {
    this._translator = translator;
  }

  public Translator getTranslator()
  {
    if (_translator != null)
      return _translator;
    ValueBinding vb = getValueBinding("translator");
    return vb != null? (Translator) vb.getValue(getFacesContext()): null;
  }

  public void setTranslationGroup(String translationGroup)
  {
    this._translationGroup = translationGroup;
  }

  public String getTranslationGroup()
  {
    if (_translationGroup != null)
      return _translationGroup;
    ValueBinding vb = getValueBinding("translationGroup");
    return vb != null? (String) vb.getValue(getFacesContext()): null;
  }  
  
  @Override
  public void decode(FacesContext context)
  {
    try
    {
      if (!isRendered()) return;    
      String clientId = getClientId(context);
      Map parameterMap = context.getExternalContext().getRequestParameterMap();
      String formId = FacesUtils.getParentFormId(this, context);
      
      Object value = parameterMap.get(
        formId + ":" + HtmlRenderUtils.HIDDEN_LINK_ID);
      if (clientId.equals(value))
      {
        queueEvent(new ActionEvent(this));
      }
    }
    catch (Exception ex)
    {
      ex.printStackTrace();
    }
  }

  @Override
  public void encodeBegin(FacesContext context) throws IOException
  {
    if (!isRendered()) return;
    
    HtmlRenderUtils.renderHiddenLink(this, context);
    
    String clientId = getClientId(context);
    ResponseWriter writer = context.getResponseWriter();
    String formId = FacesUtils.getParentFormId(this, context);
    HttpServletRequest request = 
      (HttpServletRequest)context.getExternalContext().getRequest();

    String scripted = (String)request.getAttribute(SECURE_COMMAND_LINK_SCRIPT);
    if (scripted == null)
    {
      request.setAttribute(SECURE_COMMAND_LINK_SCRIPT, "done");
      writer.startElement("script", this);
      writer.writeAttribute("type", "text/javascript", null);
      writer.writeText(
      "function changeScheme(scheme,port,cid){" +
      "var host=document.location.hostname;" +
      "var act; var fa=document.forms['" + formId + "'].action;" + 
      "var idx=fa.indexOf('://');" + 
      "if(idx==-1){act=fa;} else {" + 
      "fa=fa.substring(idx+3);" + 
      "idx=fa.indexOf('/');act=fa.substring(idx);}" + 
      "if (port!='') port=':'+port;" +
      "fa=scheme+'://'+host+port+act;" +
      "document.forms['" + formId + "'].action=fa;" +
      "document.forms['" + formId + "']['" + formId + ":" + 
      HtmlRenderUtils.HIDDEN_LINK_ID + "'].value=cid;" + 
      "document.forms['" + formId + "'].submit();}\n" +

      "function disableSubmitButtons(){" +
      "var num = document.forms['" + formId +"'].elements.length;" +
      "for (i=0;i<num;i++){var elem=document.forms['" + formId +"'][i];" +        
      "if (elem.type == 'submit') elem.disabled=true;}}\n" +

      "function changeSchemeEvt(scheme,port,cid,e){" +
      "if(e){var keynum;if(window.event){keynum = e.keyCode;}" +
      "else if(e.which){keynum = e.which;} " + 
      "if(keynum==13){disableSubmitButtons();" +
      "changeScheme(scheme,port,cid);}}" +
      "else{changeScheme(scheme,port,cid)};}", null);
     writer.endElement("script");
    }
    String scheme = getScheme();
    if (scheme == null) scheme = "https";

    String port = getPort();
    if (port == null) port = "";
    
    String function = getFunction();
    if (function != null)
    {
      writer.startElement("script", this);
      writer.writeAttribute("type", "text/javascript", null);
      writer.writeText(
        "function " + function + "(e){" + 
        "changeSchemeEvt('" + scheme + "','" + port + "','" +
        clientId + "',e)}", null);
      writer.endElement("script");
      writer.startElement("a", this);
      writer.writeAttribute("id", getClientId(context), null);
      writer.writeAttribute("href", "#", null);
      writer.writeAttribute("onclick", function + "()", null);
    }
    else
    {
      writer.startElement("a", this);
      writer.writeAttribute("id", getClientId(context), null);
      writer.writeAttribute("href", "#", null);
      writer.writeAttribute("onclick", 
      "changeScheme('" + 
        scheme + "','" + port + "','" + clientId + "')", null);
    }
    // set style attributes
    String style = getStyle();
    if (style != null)
    {
      writer.writeAttribute("style", style, null);
    }
    String styleClass = getStyleClass();
    if (styleClass != null)
    {
      writer.writeAttribute("class", styleClass, null);
    }
    Integer tabindex = getTabindex();
    if (tabindex != null)
    {
      writer.writeAttribute("tabindex", tabindex, null);      
    }
    String title = getTitle();
    if (title != null)
    {
      writer.writeAttribute("title", translate(title), null);
    }
    String ariaLabel = getAriaLabel();
    if (ariaLabel != null)
    {
      writer.writeAttribute("aria-label", translate(ariaLabel), null);
    }    
    if (getAriaHidden())
    {
      writer.writeAttribute("aria-hidden", "true", null);
    }
    String role = getRole();
    if (role != null)
    {
      writer.writeAttribute("role", role, null);
    }    
    String value = getValue();
    if (value != null)
    {
      writer.writeText(value, null);
    }
  }
  
  @Override
  public void encodeEnd(FacesContext context) throws IOException
  {
    if (!isRendered()) return;
    ResponseWriter writer = context.getResponseWriter();
    writer.endElement("a");
  }

  @Override
  public Object saveState(FacesContext context)
  {
    Object values[] = new Object[13];
    values[0] = super.saveState(context);
    values[1] = _value;
    values[2] = _scheme;
    values[3] = _port;
    values[4] = _function;
    values[5] = _style;
    values[6] = _styleClass;
    values[7] = _tabindex;
    values[8] = _title;
    values[9] = _ariaLabel;   
    values[10] = _translationGroup;     
    values[11] = _ariaHidden;     
    values[12] = _role;     
    
    return values;
  }

  @Override
  public void restoreState(FacesContext context, Object state)
  {
    Object[] values = (Object[])state;
    super.restoreState(context, values[0]);
    _value =(String)values[1];
    _scheme = (String)values[2];
    _port = (String)values[3];
    _function = (String)values[4];
    _style = (String)values[5];
    _styleClass = (String)values[6];
    _tabindex = (Integer)values[7];
    _title = (String)values[8];
    _ariaLabel = (String)values[9];
    _translationGroup = (String)values[10];
    _ariaHidden = (Boolean)values[11];    
    _role = (String)values[12];
  }
  
  private String translate(String text) throws IOException
  {
    Translator translator = getTranslator();
    if (translator != null)
    {
      String userLanguage = FacesUtils.getViewLanguage();
      StringWriter sw = new StringWriter();
      translator.translate(new StringReader(text), sw, "text/plain",
        userLanguage, getTranslationGroup());
      text = sw.toString();
    }
    return text;
  }   
}
