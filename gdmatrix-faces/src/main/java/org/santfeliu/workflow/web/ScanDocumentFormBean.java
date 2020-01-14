package org.santfeliu.workflow.web;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.ResourceBundle;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.santfeliu.faces.matrixclient.model.ScanMatrixClientModel;
import org.santfeliu.security.util.Credentials;
import org.santfeliu.security.util.StringCipher;
import org.santfeliu.security.util.URLCredentialsCipher;
import org.santfeliu.util.MatrixConfig;
import org.santfeliu.util.Properties;
import org.santfeliu.web.UserSessionBean;
import org.santfeliu.web.servlet.ScannerServlet;
import org.santfeliu.workflow.form.Form;


public class ScanDocumentFormBean extends FormBean
{
  public static final String ERROR_PREFIX = "ERROR: ";


  private String message;
  private String result;
  private String resultVar;
  private ScanMatrixClientModel model;
  private String token;

  public ScanDocumentFormBean()
  {
    model = new ScanMatrixClientModel();
    resultVar = "result";
  }

  public void setMessage(String message)
  {
    this.message = message;
  }

  public String getMessage()
  {
    return message;
  }

  public void setResult(String result)
  {
    this.result = result;
  }

  public String getResult()
  {
    return result;
  }

  public String getResultVar()
  {
    return resultVar;
  }

  public void setResultVar(String resultVar)
  {
    this.resultVar = resultVar;
  }

  public String show(Form form)
  {
    Properties parameters = form.getParameters();

    InstanceBean instanceBean = (InstanceBean)getBean("instanceBean");
    instanceBean.setForwardEnabled(false);
    instanceBean.setBackwardEnabled(false);

    for (Object key : parameters.keySet())
    {
      String parameterName = (String)key;
      Object value = parameters.get(parameterName);
      if (value != null)
      {
        if (parameterName.equals("message"))
          message = String.valueOf(value);
        else if (parameterName.equals("resultVar"))
          resultVar = String.valueOf(value);
        else
          addDocumentParameter(parameterName, parameters.get(parameterName));
      }
    }
    //system token
    token =  getToken();
    addDocumentParameter(ScannerServlet.TOKEN_HEADER, token);    

    return "scan_form";
  }

  public Map submit()
  {
    HashMap variables = new HashMap();
    variables.put(resultVar, result);
    variables.put("token", token);
    return variables;
  }

  //MatrixClient methods
  public ScanMatrixClientModel getModel()
  {
    return model;
  }

  public void setModel(ScanMatrixClientModel model)
  {
    this.model = model;
  }
  
  public String documentScanned()
  {
    try
    {
      result = (String)model.parseResult();
      if (result != null)
      {
        InstanceBean instanceBean = (InstanceBean)getBean("instanceBean");
        return instanceBean.forward();         
      }
    }
    catch (Exception ex)
    {
      String message = ex.getMessage();
      if (message != null && message.startsWith("<html>"))
      {
        final Pattern pattern = Pattern.compile("<h1>(.+?)</h1>");
        final Matcher matcher = pattern.matcher(message);        
        matcher.find();
        error(matcher.group(1));
      }
      else if (message != null && message.equals("INVALID_SCAN"))
      {
        ResourceBundle bundle = ResourceBundle.getBundle(
          "org.santfeliu.workflow.web.resources.WorkflowBundle", getLocale());
        error(bundle.getString(message));
      }
      else
        error(message);
      
      InstanceBean instanceBean = (InstanceBean)getBean("instanceBean");
      instanceBean.updateForm();
    }
    return null;
  }
  
  private String getToken()
  {
    //DateTime
    SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
    String dt = df.format(new Date());
    
    //Credentials
    String secret = 
      MatrixConfig.getProperty("org.santfeliu.security.urlCredentialsCipher.secret");    
    StringCipher strCipher = new StringCipher(secret);
    
    Credentials credentials = UserSessionBean.getCurrentInstance().getCredentials();
    URLCredentialsCipher urlCipher = new URLCredentialsCipher(secret);
    String ciphCredentials = strCipher.encrypt(urlCipher.putCredentials(model.getServletUrl(), credentials));

    return strCipher.encrypt(ScannerServlet.formatToken(ScannerServlet.TOKEN_PREFIX, dt, ciphCredentials));
  }

  private void addDocumentParameter(String name, Object value)
  {
    model.putParameter(ScannerServlet.HEADERS_PREFIX + name, value);
  }
}
