<?xml version='1.0' encoding='windows-1252'?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
          xmlns:f="http://java.sun.com/jsf/core"
          xmlns:h="http://java.sun.com/jsf/html"
          xmlns:t="http://myfaces.apache.org/tomahawk"
          xmlns:sf="http://www.santfeliu.org/jsf">

  <t:saveState value="#{personFormBean}" />

  <sf:outputText value="#{personFormBean.message}"
    translator="#{instanceBean.translationEnabled ?
      applicationBean.translator : null}"
    translationGroup="wf:#{instanceBean.workflowName}"
    styleClass="workflowMessage" />

  <t:subform id="subForm1">
    <t:div>
      <h:outputText value="#{workflowBundle.name}*:" style="display:inline-block;width:20%"
                    rendered="#{personFormBean.scope == 'external'}"/>
      <h:outputText value="#{workflowBundle.name}:" style="display:inline-block;width:20%"
                    rendered="#{personFormBean.scope == 'internal'}"/>
      <h:inputText id="name" value="#{personFormBean.name}" 
                   required="#{personFormBean.scope == 'external'}"
        style="display:inline-block;width:24%;text-transform: uppercase" />
      <h:outputText value="No cal posar accents"
        style="font-style:italic;margin-left:4px;color:gray" />
      <h:message for="name"
         warnClass="warnMessage" errorClass="errorMessage" fatalClass="fatalMessage" />
    </t:div>

    <t:div rendered="#{personFormBean.personType == 'F'}">
      <h:outputText value="#{workflowBundle.surname1}*:" style="display:inline-block;width:20%" 
                    rendered="#{personFormBean.scope == 'external'}"/>
      <h:outputText value="#{workflowBundle.surname1}:" style="display:inline-block;width:20%"
                    rendered="#{personFormBean.scope == 'internal'}"/>  
      <h:inputText id="surname1" value="#{personFormBean.surname1}"
                   required="#{personFormBean.scope == 'external'}"
        style="display:inline-block;width:24%;text-transform: uppercase" />
      <h:message for="surname1"
        warnClass="warnMessage" errorClass="errorMessage" fatalClass="fatalMessage" />
    </t:div>

    <t:div rendered="#{personFormBean.personType == 'F'}">
      <h:outputText value="#{workflowBundle.surname2}:" style="display:inline-block;width:20%" />
      <h:inputText id="surname2" value="#{personFormBean.surname2}"
        style="display:inline-block;width:24%;text-transform: uppercase" />
      <h:message for="surname2"
        warnClass="warnMessage" errorClass="errorMessage" fatalClass="fatalMessage" />
    </t:div>

    <t:div rendered="#{personFormBean.personType == 'F'}">
      <h:outputText value="Sexe:" style="display:inline-block;width:20%" />
      <t:selectOneMenu value="#{personFormBean.sex}">
        <f:selectItems value="#{personFormBean.sexSelectItems}" />
        <f:converter converterId="EnumConverter" />
        <f:attribute name="enum" value="org.matrix.kernel.Sex" />
      </t:selectOneMenu>

    </t:div>

    <t:subform id="subForm2">
      <t:div rendered="#{personFormBean.personType == 'F'}">
        <h:outputText value="Tipus d'identificació:" style="display:inline-block;width:20%" />
        <t:selectOneMenu onchange="subForm2_submit();"
          value="#{personFormBean.identityType}">
          <f:selectItem itemValue="nif" itemLabel="NIF/NIE"/>
          <f:selectItem itemValue="passport" itemLabel="Passaport"/>
          <t:div rendered="#{!personFormBean.identityRequired}">
            <f:selectItem itemValue="none" itemLabel="Sense identificació" />
          </t:div>
        </t:selectOneMenu>
      </t:div>
    </t:subform>


    <t:div rendered="#{personFormBean.personType == 'F'
                       and personFormBean.identityType == 'nif'}">
      <h:outputText value="NIF/NIE*:" style="display:inline-block;width:20%"
                    rendered="#{personFormBean.scope == 'external'}"/>
      <h:outputText value="NIF/NIE:" style="display:inline-block;width:20%"
                    rendered="#{personFormBean.scope == 'internal'}"/>
      <h:inputText id="NIF" value="#{personFormBean.NIF}" 
        required="#{personFormBean.scope == 'external'}"
        style="display:inline-block;width:24%;text-transform: uppercase">
        <t:validateRegExpr pattern='((K|k|L|l|M|m|X|x|Y|y|Z|z|\d)\d{7}[a-zA-Z])' message="#{messageBundle.INVALID_NIF}"/>
      </h:inputText>
      <h:outputText value="Per exemple: 123456789X"
        style="font-style:italic;margin-left:4px;color:gray" />
      <h:message for="NIF"
        warnClass="warnMessage" errorClass="errorMessage" fatalClass="fatalMessage" />
    </t:div>

    <t:div rendered="#{personFormBean.personType == 'F'
                       and personFormBean.identityType == 'passport'}">
      <h:outputText value="Passaport*:" style="display:inline-block;width:20%"
        rendered="#{personFormBean.scope == 'external'}"/>
      <h:outputText value="Passaport:" style="display:inline-block;width:20%"
        rendered="#{personFormBean.scope == 'internal'}"/>
      <h:inputText id="passport" value="#{personFormBean.passport}" 
        required="#{personFormBean.scope == 'external'}"
        style="display:inline-block;width:24%"/>
      <h:message for="passport"
        warnClass="warnMessage" errorClass="errorMessage" fatalClass="fatalMessage" />
    </t:div>

    <t:div rendered="#{personFormBean.personType == 'F'}">
      <h:outputText value="Data naixement*:"
        style="display:inline-block;width:20%;vertical-align:middle" rendered="#{personFormBean.scope == 'external'}"/>
      <h:outputText value="Data naixement:"
        style="display:inline-block;width:20%;vertical-align:middle" rendered="#{personFormBean.scope == 'internal'}"/>

      <sf:calendar id="birthDate" value="#{personFormBean.birthDate}"
        styleClass="calendarBox"
        externalFormat="dd/MM/yyyy"
        internalFormat="yyyyMMdd"
        buttonStyleClass="calendarButton"
        style="width:14%;vertical-align:middle"
        required="#{personFormBean.scope == 'external'}"/>
      <h:message for="birthDate"
        warnClass="warnMessage" errorClass="errorMessage" fatalClass="fatalMessage" />
    </t:div>

    <t:div rendered="#{personFormBean.personType == 'F'}">
      <h:outputText value="Nacionalitat:"
        style="display:inline-block;width:20%" />
      <t:selectOneMenu value="#{personFormBean.nationalityId}">
        <f:selectItems value="#{personFormBean.countrySelectItems}" />
      </t:selectOneMenu>
    </t:div>

    <t:div rendered="#{personFormBean.personType == 'J'}">
      <h:outputText value="CIF*:"
        style="display:inline-block;width:20%" />
      <h:inputText id="CIF" value="#{personFormBean.CIF}" required="true"
        style="display:inline-block;width:24%"/>
      <h:outputText value="Per exemple: P0821000G"
        style="font-style:italic;margin-left:4px;color:gray" />
      <h:message for="CIF"
        warnClass="warnMessage" errorClass="errorMessage" fatalClass="fatalMessage" />
    </t:div>

    <t:div>
      <h:outputText value="#{workflowBundle.telephone}:"
        style="display:inline-block;width:20%" />
      <h:inputText id="phone" value="#{personFormBean.phone}"
        style="display:inline-block;width:24%">
        <t:validateRegExpr pattern='\d{9}' message="#{messageBundle.INVALID_PHONE}"/>
      </h:inputText>
      <h:outputText value="Per exemple: 936858016"
        style="font-style:italic;margin-left:4px;color:gray" />
      <h:message for="phone"
        warnClass="warnMessage" errorClass="errorMessage" fatalClass="fatalMessage"/>
    </t:div>

    <t:div>
      <h:outputText value="#{workflowBundle.eMail}:"
        style="display:inline-block;width:20%" />
      <h:inputText id="email" value="#{personFormBean.email}"
        style="display:inline-block;width:24%">
        <t:validateEmail />
      </h:inputText>
      <h:message for="email"
        warnClass="warnMessage" errorClass="errorMessage" fatalClass="fatalMessage"/>
    </t:div>

    <h:outputText styleClass="annotation" value="#{workflowBundle.requiredFields}"
                  rendered="#{personFormBean.scope == 'external'}"/>

    <t:div style="display:block;text-align:right">
      <h:commandButton value="#{webBundle.buttonFind}" action="#{personFormBean.searchPerson}" />
    </t:div>
  </t:subform>

  <t:dataTable value="#{personFormBean.options}" var="row" styleClass="resultList"
    rendered="#{personFormBean.options != null and not empty personFormBean.options}">
    <f:facet name="header">
      <h:outputText styleClass="annotation"
         rendered="#{personFormBean.scope == 'external'}"/>
    </f:facet>

    <t:column style="width:5%;vertical-align:top" styleClass="checkColumn">
      <t:selectOneRow groupName="selection" value="#{personFormBean.selectedRowIndex}" />
    </t:column>
    <t:column style="vertical-align:top"  styleClass="personColumn">
      <h:outputText value="#{row}"/>
      <t:div rendered="#{row.showInfo}" style="margin:5px;padding:5px;">
        <t:div style="margin:2px" styleClass="infoRow">
          <h:outputText value="personId:"
            styleClass="textBox" style="width:18%;display:inline-block;" />
          <h:outputText value="#{row.person.personId}"
            styleClass="inputBox" style="width:60%" />
        </t:div>

        <t:div style="margin:2px" styleClass="infoRow">
          <h:outputText value="#{workflowBundle.name}:"
            styleClass="textBox" style="width:18%;display:inline-block;" />
          <h:outputText value="#{row.person.name}"
            styleClass="inputBox" style="width:60%" />
        </t:div>

        <t:div style="margin:2px" rendered="#{personFormBean.personType == 'F'}"
                styleClass="infoRow">
          <h:outputText value="#{workflowBundle.surname1}:"
            styleClass="textBox" style="width:18%;display:inline-block;" />
          <t:outputText value="#{row.person.firstParticle}" style="margin-right:4px"
                        rendered="#{row.person.firstParticle != null}"/>
          <h:outputText value="#{row.person.firstSurname}" />
        </t:div>

        <t:div style="margin:2px" rendered="#{personFormBean.personType == 'F'}"
                styleClass="infoRow">
          <h:outputText value="#{workflowBundle.surname2}:"
            styleClass="textBox" style="width:18%;display:inline-block;" />
          <t:outputText value="#{row.person.secondParticle}" style="margin-right:4px"
                        rendered="#{row.person.secondParticle != null}"/>
          <h:outputText value="#{row.person.secondSurname}" />
        </t:div>

        <t:div style="margin:2px" rendered="#{personFormBean.personType == 'F'}"
                styleClass="infoRow">
          <h:outputText value="#{workflowBundle.sex}:"
            styleClass="textBox" style="width:18%;display:inline-block;" />
          <t:outputText value="#{row.sex}" >
            <f:converter converterId="EnumConverter" />
            <f:attribute name="enum" value="org.matrix.kernel.Sex" />
          </t:outputText>
        </t:div>

        <t:div style="margin:2px" styleClass="infoRow">
          <h:outputText value="#{workflowBundle.nif}:"
            styleClass="textBox" style="width:18%;display:inline-block;" />
          <h:outputText value="#{row.person.nif}"/>
        </t:div>

        <t:div style="margin:2px" rendered="#{personFormBean.personType == 'F'}"
            styleClass="infoRow">
          <h:outputText value="#{workflowBundle.passport}:"
            styleClass="textBox" style="width:18%;display:inline-block;" />
          <h:outputText value="#{row.person.passport}"/>
        </t:div>

        <t:div style="margin:2px" rendered="#{personFormBean.personType == 'F'}"
               styleClass="infoRow">
          <h:outputText value="#{workflowBundle.birthDate}:"
            styleClass="textBox" style="width:18%;display:inline-block;" />
          <h:outputText value="#{personMainBean.person.birthDate}" />
        </t:div>

        <t:div style="margin:2px" rendered="#{personFormBean.personType == 'F'}"
               styleClass="infoRow">
          <h:outputText value="#{workflowBundle.birthCity}:"
            styleClass="textBox" style="width:18%;display:inline-block;" />
          <h:outputText value="#{personFormBean.personBirthCity}" />
        </t:div>

        <t:div style="margin:2px" rendered="#{personFormBean.personType == 'F'}"
               styleClass="infoRow">
          <h:outputText value="#{workflowBundle.nationality}:"
            styleClass="textBox" style="width:18%;display:inline-block;" />
          <h:outputText value="#{personFormBean.personNationality}" />
        </t:div>

        <t:div style="margin:2px" rendered="#{personFormBean.personType == 'F'}"
               styleClass="infoRow">
          <h:outputText value="#{workflowBundle.father}:"
            styleClass="textBox" style="width:18%;display:inline-block;" />
          <h:outputText value="#{row.person.fatherName}" />
        </t:div>

        <t:div style="margin:2px" rendered="#{personFormBean.personType == 'F'}"
               styleClass="infoRow">
          <h:outputText value="#{workflowBundle.mother}:"
            styleClass="textBox" style="width:18%;display:inline-block;" />
          <h:outputText value="#{row.person.motherName}"/>
        </t:div>

        <t:div style="margin:2px"  styleClass="infoRow">
          <h:outputText value="#{workflowBundle.score}:"
            styleClass="textBox" style="width:18%;display:inline-block;" />
          <h:outputText value="#{row.formattedScore}"/>
        </t:div>

      </t:div>
    </t:column>

    <t:column rendered="#{row.person != null and personFormBean.scope == 'internal'}"
              style="vertical-align:top"
               styleClass="infoColumn">
      <h:commandLink action="#{personFormBean.showPerson}">
        <h:graphicImage value="/images/info.gif"/>
      </h:commandLink>
    </t:column>

  </t:dataTable>



</jsp:root>
