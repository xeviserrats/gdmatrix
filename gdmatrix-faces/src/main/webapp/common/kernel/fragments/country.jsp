<?xml version='1.0' encoding='windows-1252'?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
          xmlns:f="http://java.sun.com/jsf/core"
          xmlns:h="http://java.sun.com/jsf/html"
          xmlns:t="http://myfaces.apache.org/tomahawk"
          xmlns:sf="http://www.santfeliu.org/jsf">

    <t:div styleClass="header">
      <h:outputText value="#{kernelBundle.country} #{countryToStreetBean.country.countryId}:" />
    </t:div>
    <t:div styleClass="tabs" style="height:10px" />

    <t:div styleClass="sheet" 
      style="padding-top:10px;padding-bottom:20px">
      <t:div>
        <h:outputText value="#{kernelBundle.country}:" 
          styleClass="textBox" style="width:15%" />
        <h:inputText value="#{countryToStreetBean.country.name}" 
          styleClass="inputBox" style="width:70%" />
      </t:div>
      <t:div>
        <h:outputText value="#{kernelBundle.country_ISOcode}:"
          styleClass="textBox" style="width:15%" />
        <h:inputText value="#{countryToStreetBean.country.ISOCode}"
          styleClass="inputBox" />
      </t:div>
      <t:div>
        <h:outputText value="#{kernelBundle.country_language}:"
          styleClass="textBox" style="width:15%" />
        <h:inputText value="#{countryToStreetBean.country.language}"
          styleClass="inputBox" />
      </t:div>
    </t:div>
    
    <t:div styleClass="footer">
      <h:commandButton value="#{objectBundle.store}"
        action="#{countryToStreetBean.storeCountry}" 
        styleClass="storeButton" />
      <h:commandButton value="#{objectBundle.cancel}"
        action="#{countryToStreetBean.cancel}" 
        immediate="true"
        styleClass="cancelButton" />
    </t:div>

</jsp:root>
