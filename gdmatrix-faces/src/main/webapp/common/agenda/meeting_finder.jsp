<?xml version='1.0' encoding='windows-1252'?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0" xmlns:c="http://java.sun.com/jsp/jstl/core">
  <jsp:directive.page contentType="text/html;charset=UTF-8"/>

  <c:set var="_css" scope="request" value="/common/agenda/css/agenda.css" />
  <c:set var="_body" scope="request" value="/common/agenda/fragments/meeting_finder.jsp" />
  <jsp:include page="/topframe/frame.jsp"/>
</jsp:root>