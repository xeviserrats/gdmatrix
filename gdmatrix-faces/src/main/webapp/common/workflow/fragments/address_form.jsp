<?xml version='1.0' encoding='windows-1252'?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
          xmlns:f="http://java.sun.com/jsf/core"
          xmlns:h="http://java.sun.com/jsf/html"
          xmlns:t="http://myfaces.apache.org/tomahawk"
          xmlns:sf="http://www.santfeliu.org/jsf">

  <f:loadBundle basename="org.santfeliu.kernel.web.resources.KernelBundle"
    var="kernelBundle" />

  <t:saveState value="#{addressFormBean}" />

  <sf:outputText value="#{addressFormBean.message}"
    translator="#{instanceBean.translationEnabled ?
      applicationBean.translator : null}"
    translationGroup="wf:#{instanceBean.workflowName}"
    styleClass="workflowMessage" />

  <t:div>
    <h:outputText value="Carrer*:" style="display:inline-block;width:20%" />
    <t:selectOneMenu value="#{addressFormBean.streetType}">
      <f:selectItem itemLabel="C." itemValue="C." />
      <f:selectItem itemLabel="Pl." itemValue="Pl." />
      <f:selectItem itemLabel="Av." itemValue="Av." />
      <f:selectItem itemLabel="Ptge." itemValue="Ptge." />
    </t:selectOneMenu>
    <h:inputText id="street" value="#{addressFormBean.street}" required="true"
      style="display:inline-block;width:40%;text-transform:uppercase;margin-left:4px" />
       warnClass="warnMessage" errorClass="errorMessage" fatalClass="fatalMessage" />
    <h:outputText value="No cal posar accents" 
      style="font-style:italic;margin-left:4px;color:gray" />
    <h:message for="street"
      warnClass="warnMessage" errorClass="errorMessage" fatalClass="fatalMessage" />
  </t:div>

  <t:div>
    <h:outputText value="Numero:" style="display:inline-block;width:20%" />
    <h:inputText id="number" value="#{addressFormBean.number}" maxlength="4" 
      style="width:6%" />
      <h:selectBooleanCheckbox value="#{addressFormBean.bis}" />
    <h:outputText value="Bis" />
    <h:selectBooleanCheckbox value="#{addressFormBean.noNumber}" />
    <h:outputText value="Sense n�mero" />
    <h:message for="number"
      warnClass="warnMessage" errorClass="errorMessage" fatalClass="fatalMessage" />
  </t:div>

  <t:div>
    <h:outputText value="Kilometre:" style="display:inline-block;width:20%" />
    <h:inputText  id="km" value="#{addressFormBean.km}" maxlength="8" style="width:10%" >
    </h:inputText>
    <h:outputText value="Nom�s necessari si no hi ha n�mero. Per exemple: 16.6"
      style="font-style:italic;margin-left:4px;color:gray" />
    <h:message for="km"
      warnClass="warnMessage" errorClass="errorMessage" fatalClass="fatalMessage" />
  </t:div>

  <t:div>
    <h:outputText value="Bloc:" style="display:inline-block;width:20%" />
    <h:inputText  id="block" value="#{addressFormBean.block}" maxlength="4" style="width:6%" />
    <h:outputText value="Omplir nom�s si correspon"
      style="font-style:italic;margin-left:4px;color:gray" />
    <h:message for="block"
      warnClass="warnMessage" errorClass="errorMessage" fatalClass="fatalMessage" />
  </t:div>

  <t:div>
    <h:outputText value="Portal:" style="display:inline-block;width:20%" />
    <h:inputText id="entranceHall" value="#{addressFormBean.entranceHall}" maxlength="4" style="width:6%" />
    <h:outputText value="Omplir nom�s si correspon"
      style="font-style:italic;margin-left:4px;color:gray" />
    <h:message for="entranceHall"
      warnClass="warnMessage" errorClass="errorMessage" fatalClass="fatalMessage" />
  </t:div>

  <t:div>
    <h:outputText value="Escala:" style="display:inline-block;width:20%" />
    <h:inputText  id="stair" value="#{addressFormBean.stair}" maxlength="4" style="width:6%" />
    <h:outputText value="Omplir nom�s si correspon"
      style="font-style:italic;margin-left:4px;color:gray" />
    <h:message for="stair"
      warnClass="warnMessage" errorClass="errorMessage" fatalClass="fatalMessage" />
  </t:div>

  <t:div>
    <h:outputText value="Pis:" style="display:inline-block;width:20%" />
    <h:inputText id="floor" value="#{addressFormBean.floor}" maxlength="4" style="width:6%" />
    <h:outputText value="Omplir nom�s si correspon"
      style="font-style:italic;margin-left:4px;color:gray" />
    <h:message for="floor"
      warnClass="warnMessage" errorClass="errorMessage" fatalClass="fatalMessage" />
  </t:div>

  <t:div>
    <h:outputText value="Porta:" style="display:inline-block;width:20%" />
    <h:inputText id="door" value="#{addressFormBean.door}" maxlength="4" style="width:6%" />
    <h:outputText value="Omplir nom�s si correspon"
      style="font-style:italic;margin-left:4px;color:gray" />
    <h:message for="door"
      warnClass="warnMessage" errorClass="errorMessage" fatalClass="fatalMessage" />
  </t:div>

  <t:div>
    <h:outputText value="Codi Postal:" style="display:inline-block;width:20%" />
    <h:inputText id="postalCode" value="#{addressFormBean.postalCode}" maxlength="8" style="width:10%" />
    <h:outputText value="Per exemple: 08980"
      style="font-style:italic;margin-left:4px;color:gray" />
    <h:message for="postalCode"
      warnClass="warnMessage" errorClass="errorMessage" fatalClass="fatalMessage" />
  </t:div>

  <t:div>
    <h:outputText value="Apartat de correus:" style="display:inline-block;width:20%" />
    <h:inputText id="postOfficeBox" value="#{addressFormBean.postOfficeBox}"
      maxlength="8" style="width:10%" />
    <h:message for="postOfficeBox"
      warnClass="warnMessage" errorClass="errorMessage" fatalClass="fatalMessage" />
  </t:div>

  <t:div>
    <t:div rendered="#{addressFormBean.forcedCity == null}">
      <h:outputText value="Poblaci�*:" style="display:inline-block;width:20%"/>
      <h:inputText id="city" value="#{addressFormBean.city}" required="true"
        style="display:inline-block;width:30%;text-transform:uppercase"/>
    </t:div>
    <t:div  rendered="#{addressFormBean.forcedCity != null}">
      <h:outputText value="Poblaci�:" style="display:inline-block;width:20%"/>
      <h:outputText value="#{addressFormBean.forcedCity}"
        style="display:inline-block;width:30%;text-transform:uppercase"/>
    </t:div>
    <h:message for="city"
      warnClass="warnMessage" errorClass="errorMessage" fatalClass="fatalMessage" />
  </t:div>

  <t:div rendered="#{addressFormBean.forcedCity == null}">
    <h:outputText value="Provincia:" style="display:inline-block;width:20%" />
    <h:inputText id="province" value="#{addressFormBean.province}"
      style="display:inline-block;width:30%;text-transform:uppercase" />
    <h:message for="province"
      warnClass="warnMessage" errorClass="errorMessage" fatalClass="fatalMessage" />
  </t:div>

  <t:div rendered="#{addressFormBean.forcedCity == null}">
    <h:outputText value="Pais*:" style="display:inline-block;width:20%" />
    <t:selectOneMenu value="#{addressFormBean.countryId}">
      <f:selectItems value="#{addressFormBean.countrySelectItems}" />
    </t:selectOneMenu>
  </t:div>

  <h:outputText styleClass="annotation" value="#{workflowBundle.requiredFields}" />

  <t:div style="display:block;text-align:right">
    <h:commandButton value="#{webBundle.buttonFind}" action="#{addressFormBean.searchAddress}" />
  </t:div>

  <h:selectOneRadio id="options"
    layout="pageDirection" styleClass="resultList"
    enabledClass="#{addressFormBean.selectItemClass}"
    value="#{addressFormBean.addressId}" 
    rendered="#{addressFormBean.addressSelectItems != null}">
    <f:selectItems value="#{addressFormBean.addressSelectItems}" />
  </h:selectOneRadio>

</jsp:root>
