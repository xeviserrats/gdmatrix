<?xml version='1.0' encoding='windows-1252'?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
          xmlns:f="http://java.sun.com/jsf/core"
          xmlns:h="http://java.sun.com/jsf/html"
          xmlns:t="http://myfaces.apache.org/tomahawk"
          xmlns:sf="http://www.santfeliu.org/jsf">

  <f:loadBundle basename="org.santfeliu.kernel.web.resources.KernelBundle"
    var="kernelBundle" />

  <t:div rendered="#{!personBean.new}">
    <h:outputText value="#{objectBundle.object_id}:" styleClass="textBox"
      style="width:18%" />
    <h:outputText value="#{personMainBean.person.personId}" styleClass="outputBox"
      style="width:10%" />
  </t:div>

  <t:div>
    <h:outputText value="#{kernelBundle.person_type}:"
      styleClass="textBox" style="width:18%" />
    <sf:commandMenu value="#{personMainBean.person.personTypeId}"
      styleClass="selectBox">
      <f:selectItem itemLabel=" " itemValue="" />
      <f:selectItems value="#{personMainBean.allTypeItems}" />
    </sf:commandMenu>
    <h:commandButton action="#{personMainBean.showType}"
      value="#{objectBundle.show}"
      image="#{userSessionBean.icons.show}"
      alt="#{objectBundle.show}" title="#{objectBundle.show}"
      styleClass="showButton"
      rendered="#{personMainBean.renderShowTypeButton}" />
  </t:div>

  <t:div>
    <h:outputText value="#{kernelBundle.person_name}:"
      styleClass="textBox" style="width:18%" />
    <h:inputText value="#{personMainBean.person.name}"
      styleClass="inputBox" style="width:60%"
      maxlength="#{personMainBean.propertySize.name}" />
  </t:div>

  <t:div rendered="#{not personMainBean.juristicPerson}">
    <h:outputText value="#{kernelBundle.person_surname1}:"
      styleClass="textBox" style="width:18%" />
    <t:selectOneMenu value="#{personMainBean.person.firstParticle}"
      styleClass="selectBox" style="margin-right:4px">
      <f:selectItems value="#{personMainBean.personParticleSelectItems}" />
    </t:selectOneMenu>
    <h:inputText value="#{personMainBean.person.firstSurname}"
      size="25" maxlength="#{personMainBean.propertySize.firstSurname}"
      styleClass="inputBox" />
  </t:div>

  <t:div rendered="#{not personMainBean.juristicPerson}">
    <h:outputText value="#{kernelBundle.person_surname2}:"
      styleClass="textBox" style="width:18%" />
    <t:selectOneMenu value="#{personMainBean.person.secondParticle}"
      styleClass="selectBox" style="margin-right:4px">
      <f:selectItems value="#{personMainBean.personParticleSelectItems}" />
    </t:selectOneMenu>
    <h:inputText value="#{personMainBean.person.secondSurname}"
      size="25"  maxlength="#{personMainBean.propertySize.secondSurname}"
      styleClass="inputBox" />
  </t:div>

  <t:div rendered="#{not personMainBean.juristicPerson}">
    <h:outputText value="#{kernelBundle.person_sex}:"
      styleClass="textBox" style="width:18%" />
    <t:selectOneMenu value="#{personMainBean.person.sex}" styleClass="selectBox">
      <f:selectItems value="#{personMainBean.sexSelectItems}" />
      <f:converter converterId="EnumConverter" />
      <f:attribute name="enum" value="org.matrix.kernel.Sex" />
    </t:selectOneMenu>
  </t:div>

  <t:div>
    <h:outputText value="#{kernelBundle.person_nif}:"
      styleClass="textBox" style="width:18%" />
    <h:inputText value="#{personMainBean.person.nif}"
      styleClass="inputBox"
      maxlength="#{personMainBean.propertySize.nif}"/>
  </t:div>

  <t:div rendered="#{not personMainBean.juristicPerson}">
    <h:outputText value="#{kernelBundle.person_passport}:"
      styleClass="textBox" style="width:18%" />
    <h:inputText value="#{personMainBean.person.passport}"
      styleClass="inputBox"
      maxlength="#{personMainBean.propertySize.passport}"/>
  </t:div>

  <t:div rendered="#{not personMainBean.juristicPerson}">
    <h:outputText value="#{kernelBundle.person_birthDate}:"
      styleClass="textBox" style="width:18%" />
    <sf:calendar value="#{personMainBean.person.birthDate}"
      styleClass="calendarBox" style="width:12%"
      buttonStyleClass="calendarButton" />
    <h:outputText value="#{kernelBundle.person_age}: #{personMainBean.age}"
      rendered="#{personMainBean.person.birthDate != null}"
      style="margin-left:6px" />
  </t:div>

  <t:div rendered="#{not personMainBean.juristicPerson}">
    <h:outputText value="#{kernelBundle.person_birthCity}:"
      styleClass="textBox" style="width:18%" />
    <t:selectOneMenu value="#{personMainBean.person.birthCityId}"
      styleClass="selectBox" style="width:50%">
      <f:selectItems value="#{personMainBean.citySelectItems}" />
    </t:selectOneMenu>
    <h:commandButton value="#{objectBundle.search}"
      image="#{userSessionBean.icons.search}"
      alt="#{objectBundle.search}" title="#{objectBundle.search}"
      action="#{personMainBean.searchBirthCity}"
      styleClass="searchButton" />
    <h:commandButton value="#{objectBundle.show}"
      image="#{userSessionBean.icons.show}"
      alt="#{objectBundle.show}" title="#{objectBundle.show}"
      action="#{personMainBean.showBirthCity}"
      styleClass="showButton" />
  </t:div>

  <t:div>
    <h:outputText value="#{kernelBundle.person_nationality}:"
      styleClass="textBox" style="width:18%" />
    <t:selectOneMenu value="#{personMainBean.person.nationalityId}"
      styleClass="selectBox" style="width:50%">
      <f:selectItems value="#{personMainBean.nationalitySelectItems}" />
    </t:selectOneMenu>
    <h:commandButton value="#{objectBundle.search}"
      image="#{userSessionBean.icons.search}"
      alt="#{objectBundle.search}" title="#{objectBundle.search}"
      action="#{personMainBean.searchNationality}"
      styleClass="searchButton" />
    <h:commandButton value="#{objectBundle.show}"
      image="#{userSessionBean.icons.show}"
      alt="#{objectBundle.show}" title="#{objectBundle.show}"
      action="#{personMainBean.showNationality}"
      styleClass="showButton" />
  </t:div>

  <t:div rendered="#{not personMainBean.juristicPerson}">
    <h:outputText value="#{kernelBundle.person_father}:"
      styleClass="textBox" style="width:18%" />
    <h:inputText value="#{personMainBean.person.fatherName}"
      styleClass="inputBox"
      maxlength="#{personMainBean.propertySize.fatherName}"/>
    <h:outputText value="#{kernelBundle.person_mother}:"
      styleClass="textBox" />
    <h:inputText  value="#{personMainBean.person.motherName}"
      styleClass="inputBox"
      maxlength="#{personMainBean.propertySize.motherName}"/>
  </t:div>

</jsp:root>
