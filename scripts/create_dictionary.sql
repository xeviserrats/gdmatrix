INSERT INTO DIC_TYPE
(TYPEID, SUPERTYPEID, DESCRIPTION, INSTANTIABLE, CREATIONDT, CREATIONUSERID, MODIFYDT, MODIFYUSERID, REMOVED, TYPEPATH, RESTRICTED)
VALUES
('Address', NULL, 'Domicili', 'F', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', NULL, '/Address/', NULL);

INSERT INTO DIC_TYPE
(TYPEID, SUPERTYPEID, DESCRIPTION, INSTANTIABLE, CREATIONDT, CREATIONUSERID, MODIFYDT, MODIFYUSERID, REMOVED, TYPEPATH, RESTRICTED)
VALUES
('Case', NULL, 'Expedient', 'T', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', NULL, '/Case/', 'F');

INSERT INTO DIC_TYPE
(TYPEID, SUPERTYPEID, DESCRIPTION, INSTANTIABLE, CREATIONDT, CREATIONUSERID, MODIFYDT, MODIFYUSERID, REMOVED, TYPEPATH, RESTRICTED)
VALUES
('CaseIntervention', NULL, 'Intervenci� d''un cas', 'F', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', 'T', '/CaseIntervention/', NULL);

INSERT INTO DIC_TYPE
(TYPEID, SUPERTYPEID, DESCRIPTION, INSTANTIABLE, CREATIONDT, CREATIONUSERID, MODIFYDT, MODIFYUSERID, REMOVED, TYPEPATH, RESTRICTED)
VALUES
('CasePerson', NULL, 'Persona vinculada a un expedient', 'F', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', 'F', '/CasePerson/', NULL);

INSERT INTO DIC_TYPE
(TYPEID, SUPERTYPEID, DESCRIPTION, INSTANTIABLE, CREATIONDT, CREATIONUSERID, MODIFYDT, MODIFYUSERID, REMOVED, TYPEPATH, RESTRICTED)
VALUES
('CaseProblem', NULL, 'Problema d''un expedient', 'F', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', 'T', '/CaseProblem/', NULL);

INSERT INTO DIC_TYPE
(TYPEID, SUPERTYPEID, DESCRIPTION, INSTANTIABLE, CREATIONDT, CREATIONUSERID, MODIFYDT, MODIFYUSERID, REMOVED, TYPEPATH, RESTRICTED)
VALUES
('CaseAddress', NULL, 'Adre�a vinculada a un expedient', 'F', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', 'T', '/CaseAddress/', NULL);

INSERT INTO DIC_TYPE
(TYPEID, SUPERTYPEID, DESCRIPTION, INSTANTIABLE, CREATIONDT, CREATIONUSERID, MODIFYDT, MODIFYUSERID, REMOVED, TYPEPATH, RESTRICTED)
VALUES
('City', NULL, 'Municipi', 'F', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', NULL, '/City/', NULL);

INSERT INTO DIC_TYPE
(TYPEID, SUPERTYPEID, DESCRIPTION, INSTANTIABLE, CREATIONDT, CREATIONUSERID, MODIFYDT, MODIFYUSERID, REMOVED, TYPEPATH, RESTRICTED)
VALUES
('Class', NULL, 'Serie documental', 'F', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', NULL, '/Class/', NULL);

INSERT INTO DIC_TYPE
(TYPEID, SUPERTYPEID, DESCRIPTION, INSTANTIABLE, CREATIONDT, CREATIONUSERID, MODIFYDT, MODIFYUSERID, REMOVED, TYPEPATH, RESTRICTED)
VALUES
('Content', NULL, 'Contingut d''un document', 'T', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', NULL, '/Content/', NULL);

INSERT INTO DIC_TYPE
(TYPEID, SUPERTYPEID, DESCRIPTION, INSTANTIABLE, CREATIONDT, CREATIONUSERID, MODIFYDT, MODIFYUSERID, REMOVED, TYPEPATH, RESTRICTED)
VALUES
('Country', NULL, 'Pais', 'F', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', NULL, '/Country/', NULL);

INSERT INTO DIC_TYPE
(TYPEID, SUPERTYPEID, DESCRIPTION, INSTANTIABLE, CREATIONDT, CREATIONUSERID, MODIFYDT, MODIFYUSERID, REMOVED, TYPEPATH, RESTRICTED)
VALUES
('Course', NULL, 'Curs', 'F', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', NULL, '/Course/', NULL);

INSERT INTO DIC_TYPE
(TYPEID, SUPERTYPEID, DESCRIPTION, INSTANTIABLE, CREATIONDT, CREATIONUSERID, MODIFYDT, MODIFYUSERID, REMOVED, TYPEPATH, RESTRICTED)
VALUES
('Demand', NULL, 'Demanda d''un expedient', 'F', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', NULL, '/Demand/', NULL);

INSERT INTO DIC_TYPE
(TYPEID, SUPERTYPEID, DESCRIPTION, INSTANTIABLE, CREATIONDT, CREATIONUSERID, MODIFYDT, MODIFYUSERID, REMOVED, TYPEPATH, RESTRICTED)
VALUES
('DispositionRule', NULL, 'Regla de disposici�', 'F', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', NULL, '/DispositionRule/', NULL);

INSERT INTO DIC_TYPE
(TYPEID, SUPERTYPEID, DESCRIPTION, INSTANTIABLE, CREATIONDT, CREATIONUSERID, MODIFYDT, MODIFYUSERID, REMOVED, TYPEPATH, RESTRICTED)
VALUES
('Document', NULL, 'Document', 'T', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', NULL, '/Document/', 'F');

INSERT INTO DIC_TYPE
(TYPEID, SUPERTYPEID, DESCRIPTION, INSTANTIABLE, CREATIONDT, CREATIONUSERID, MODIFYDT, MODIFYUSERID, REMOVED, TYPEPATH, RESTRICTED)
VALUES
('Event', NULL, 'Esdeveniment de l''agenda', 'F', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', NULL, '/Event/', NULL);

INSERT INTO DIC_TYPE
(TYPEID, SUPERTYPEID, DESCRIPTION, INSTANTIABLE, CREATIONDT, CREATIONUSERID, MODIFYDT, MODIFYUSERID, REMOVED, TYPEPATH, RESTRICTED)
VALUES
('Attendant', NULL, 'Assistent d''un esdeveniment', 'F', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', NULL, '/Attendant/', NULL);

INSERT INTO DIC_TYPE
(TYPEID, SUPERTYPEID, DESCRIPTION, INSTANTIABLE, CREATIONDT, CREATIONUSERID, MODIFYDT, MODIFYUSERID, REMOVED, TYPEPATH, RESTRICTED)
VALUES
('Inscription', NULL, 'Inscripci� a curs', 'F', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', NULL, '/Inscription/', NULL);

INSERT INTO DIC_TYPE
(TYPEID, SUPERTYPEID, DESCRIPTION, INSTANTIABLE, CREATIONDT, CREATIONUSERID, MODIFYDT, MODIFYUSERID, REMOVED, TYPEPATH, RESTRICTED)
VALUES
('Intervention', NULL, 'Actuaci� d''un expedient', 'F', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', NULL, '/Intervention/', NULL);

INSERT INTO DIC_TYPE
(TYPEID, SUPERTYPEID, DESCRIPTION, INSTANTIABLE, CREATIONDT, CREATIONUSERID, MODIFYDT, MODIFYUSERID, REMOVED, TYPEPATH, RESTRICTED)
VALUES
('New', NULL, 'Not�cia', 'F', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', NULL, '/New/', NULL);

INSERT INTO DIC_TYPE
(TYPEID, SUPERTYPEID, DESCRIPTION, INSTANTIABLE, CREATIONDT, CREATIONUSERID, MODIFYDT, MODIFYUSERID, REMOVED, TYPEPATH, RESTRICTED)
VALUES
('NewDocument', NULL, 'Document d''una not�cia', 'F', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', NULL, '/NewDocument/', NULL);

INSERT INTO DIC_TYPE
(TYPEID, SUPERTYPEID, DESCRIPTION, INSTANTIABLE, CREATIONDT, CREATIONUSERID, MODIFYDT, MODIFYUSERID, REMOVED, TYPEPATH, RESTRICTED)
VALUES
('NewDocumentCarouselImage', 'NewDocument', 'Imatge de carrousel d''una not�cia', 'T', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', NULL, '/NewDocument/NewDocumentCarouselImage/', NULL);

INSERT INTO DIC_TYPE
(TYPEID, SUPERTYPEID, DESCRIPTION, INSTANTIABLE, CREATIONDT, CREATIONUSERID, MODIFYDT, MODIFYUSERID, REMOVED, TYPEPATH, RESTRICTED)
VALUES
('NewDocumentDetailsImage', 'NewDocument', 'Imatge de detall d''una not�cia', 'T', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', NULL, '/NewDocument/NewDocumentDetailsImage/', NULL);

INSERT INTO DIC_TYPE
(TYPEID, SUPERTYPEID, DESCRIPTION, INSTANTIABLE, CREATIONDT, CREATIONUSERID, MODIFYDT, MODIFYUSERID, REMOVED, TYPEPATH, RESTRICTED)
VALUES
('NewDocumentExtendedInfo', 'NewDocument', 'Document d''informaci� extendida d''una not�cia', 'T', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', NULL, '/NewDocument/NewDocumentExtendedInfo/', NULL);

INSERT INTO DIC_TYPE
(TYPEID, SUPERTYPEID, DESCRIPTION, INSTANTIABLE, CREATIONDT, CREATIONUSERID, MODIFYDT, MODIFYUSERID, REMOVED, TYPEPATH, RESTRICTED)
VALUES
('NewDocumentListAndDetailsImage', 'NewDocument', 'Imatge de llistat i detall d''una not�cia', 'T', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', NULL, '/NewDocument/NewDocumentListAndDetailsImage/', NULL);

INSERT INTO DIC_TYPE
(TYPEID, SUPERTYPEID, DESCRIPTION, INSTANTIABLE, CREATIONDT, CREATIONUSERID, MODIFYDT, MODIFYUSERID, REMOVED, TYPEPATH, RESTRICTED)
VALUES
('NewDocumentCarouselAndDetailsImage', 'NewDocument', 'Imatge de carrousel i detall d''una not�cia', 'T', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', NULL, '/NewDocument/NewDocumentCarouselAndDetailsImage/', NULL);

INSERT INTO DIC_TYPE
(TYPEID, SUPERTYPEID, DESCRIPTION, INSTANTIABLE, CREATIONDT, CREATIONUSERID, MODIFYDT, MODIFYUSERID, REMOVED, TYPEPATH, RESTRICTED)
VALUES
('NewDocumentListImage', 'NewDocument', 'Imatge de llistat d''una not�cia', 'T', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', NULL, '/NewDocument/NewDocumentListImage/', NULL);

INSERT INTO DIC_TYPE
(TYPEID, SUPERTYPEID, DESCRIPTION, INSTANTIABLE, CREATIONDT, CREATIONUSERID, MODIFYDT, MODIFYUSERID, REMOVED, TYPEPATH, RESTRICTED)
VALUES
('Folder', NULL, 'Folder', 'F', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', NULL, '/Folder/', NULL);

INSERT INTO DIC_TYPE
(TYPEID, SUPERTYPEID, DESCRIPTION, INSTANTIABLE, CREATIONDT, CREATIONUSERID, MODIFYDT, MODIFYUSERID, REMOVED, TYPEPATH, RESTRICTED)
VALUES
('Feed', NULL, 'Feed', 'F', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', NULL, '/Feed/', NULL);

INSERT INTO DIC_TYPE
(TYPEID, SUPERTYPEID, DESCRIPTION, INSTANTIABLE, CREATIONDT, CREATIONUSERID, MODIFYDT, MODIFYUSERID, REMOVED, TYPEPATH, RESTRICTED)
VALUES
('Person', NULL, 'Persona', 'T', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', NULL, '/Person/', NULL);

INSERT INTO DIC_TYPE
(TYPEID, SUPERTYPEID, DESCRIPTION, INSTANTIABLE, CREATIONDT, CREATIONUSERID, MODIFYDT, MODIFYUSERID, REMOVED, TYPEPATH, RESTRICTED)
VALUES
('PersonPerson', NULL, 'Persona reacionada amb unaltra persona', 'T', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', NULL, '/PersonPerson/', NULL);

INSERT INTO DIC_TYPE
(TYPEID, SUPERTYPEID, DESCRIPTION, INSTANTIABLE, CREATIONDT, CREATIONUSERID, MODIFYDT, MODIFYUSERID, REMOVED, TYPEPATH, RESTRICTED)
VALUES
('Policy', NULL, 'Pol�tica de gesti� documental', 'F', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', 'F', '/Policy/', NULL);

INSERT INTO DIC_TYPE
(TYPEID, SUPERTYPEID, DESCRIPTION, INSTANTIABLE, CREATIONDT, CREATIONUSERID, MODIFYDT, MODIFYUSERID, REMOVED, TYPEPATH, RESTRICTED)
VALUES
('Problem', NULL, 'Problema d''un expedient', 'F', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', NULL, '/Problem/', NULL);

INSERT INTO DIC_TYPE
(TYPEID, SUPERTYPEID, DESCRIPTION, INSTANTIABLE, CREATIONDT, CREATIONUSERID, MODIFYDT, MODIFYUSERID, REMOVED, TYPEPATH, RESTRICTED)
VALUES
('Province', NULL, 'Provincia', 'F', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', NULL, '/Province/', NULL);

INSERT INTO DIC_TYPE
(TYPEID, SUPERTYPEID, DESCRIPTION, INSTANTIABLE, CREATIONDT, CREATIONUSERID, MODIFYDT, MODIFYUSERID, REMOVED, TYPEPATH, RESTRICTED)
VALUES
('Role', NULL, 'Rol d''acc�s', 'F', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', NULL, '/Role/', NULL);

INSERT INTO DIC_TYPE
(TYPEID, SUPERTYPEID, DESCRIPTION, INSTANTIABLE, CREATIONDT, CREATIONUSERID, MODIFYDT, MODIFYUSERID, REMOVED, TYPEPATH, RESTRICTED)
VALUES
('Room', NULL, 'Sala', 'T', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', NULL, '/Room/', NULL);

INSERT INTO DIC_TYPE
(TYPEID, SUPERTYPEID, DESCRIPTION, INSTANTIABLE, CREATIONDT, CREATIONUSERID, MODIFYDT, MODIFYUSERID, REMOVED, TYPEPATH, RESTRICTED)
VALUES
('Street', NULL, 'Carrer', 'F', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', NULL, '/Street/', NULL);

INSERT INTO DIC_TYPE
(TYPEID, SUPERTYPEID, DESCRIPTION, INSTANTIABLE, CREATIONDT, CREATIONUSERID, MODIFYDT, MODIFYUSERID, REMOVED, TYPEPATH, RESTRICTED)
VALUES
('Survey', NULL, 'Enquesta', 'F', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', NULL, '/Survey/', NULL);

INSERT INTO DIC_TYPE
(TYPEID, SUPERTYPEID, DESCRIPTION, INSTANTIABLE, CREATIONDT, CREATIONUSERID, MODIFYDT, MODIFYUSERID, REMOVED, TYPEPATH, RESTRICTED)
VALUES
('test', NULL, 'prova', 'F', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', 'T', '/test/', 'F');

INSERT INTO DIC_TYPE
(TYPEID, SUPERTYPEID, DESCRIPTION, INSTANTIABLE, CREATIONDT, CREATIONUSERID, MODIFYDT, MODIFYUSERID, REMOVED, TYPEPATH, RESTRICTED)
VALUES
('User', NULL, 'Usuari del sistema', 'F', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', NULL, '/User/', NULL);

INSERT INTO DIC_PROPDEF
(TYPEID, PROPNAME, DESCRIPTION, PROPTYPE, PROPSIZE, MINOCCURS, MAXOCCURS, DEFAULTVALUE, HIDDEN, READONLY)
VALUES
('Case', 'caseId', 'Identificador de l''expedient', 'T', '0', '1', '1', NULL, 'F', 'F');

INSERT INTO DIC_PROPDEF
(TYPEID, PROPNAME, DESCRIPTION, PROPTYPE, PROPSIZE, MINOCCURS, MAXOCCURS, DEFAULTVALUE, HIDDEN, READONLY)
VALUES
('Case', 'caseTypeId', 'Tipus', 'T', '0', '1', '1', NULL, 'F', 'F');

INSERT INTO DIC_PROPDEF
(TYPEID, PROPNAME, DESCRIPTION, PROPTYPE, PROPSIZE, MINOCCURS, MAXOCCURS, DEFAULTVALUE, HIDDEN, READONLY)
VALUES
('Case', 'changeDateTime', 'Data i hora de modificaci�', 'D', '0', '0', '0', NULL, 'F', 'T');

INSERT INTO DIC_PROPDEF
(TYPEID, PROPNAME, DESCRIPTION, PROPTYPE, PROPSIZE, MINOCCURS, MAXOCCURS, DEFAULTVALUE, HIDDEN, READONLY)
VALUES
('Case', 'changeUserId', 'Usuari de modificaci�', 'T', '0', '0', '0', NULL, 'F', 'T');

INSERT INTO DIC_PROPDEF
(TYPEID, PROPNAME, DESCRIPTION, PROPTYPE, PROPSIZE, MINOCCURS, MAXOCCURS, DEFAULTVALUE, HIDDEN, READONLY)
VALUES
('Case', 'comments', 'Observacions', 'T', '0', '0', '1', NULL, 'F', 'F');

INSERT INTO DIC_PROPDEF
(TYPEID, PROPNAME, DESCRIPTION, PROPTYPE, PROPSIZE, MINOCCURS, MAXOCCURS, DEFAULTVALUE, HIDDEN, READONLY)
VALUES
('Case', 'creationDateTime', 'Data i hora de creaci�', 'D', '0', '0', '0', NULL, 'F', 'T');

INSERT INTO DIC_PROPDEF
(TYPEID, PROPNAME, DESCRIPTION, PROPTYPE, PROPSIZE, MINOCCURS, MAXOCCURS, DEFAULTVALUE, HIDDEN, READONLY)
VALUES
('Case', 'creationUserId', 'Usuari de creaci�', 'T', '0', '0', '0', NULL, 'F', 'T');

INSERT INTO DIC_PROPDEF
(TYPEID, PROPNAME, DESCRIPTION, PROPTYPE, PROPSIZE, MINOCCURS, MAXOCCURS, DEFAULTVALUE, HIDDEN, READONLY)
VALUES
('Case', 'description', 'Assumpte', 'T', '0', '1', '0', NULL, 'F', 'F');

INSERT INTO DIC_PROPDEF
(TYPEID, PROPNAME, DESCRIPTION, PROPTYPE, PROPSIZE, MINOCCURS, MAXOCCURS, DEFAULTVALUE, HIDDEN, READONLY)
VALUES
('Case', 'endDate', 'Data de tancament', 'D', '0', '0', '1', NULL, 'F', 'F');

INSERT INTO DIC_PROPDEF
(TYPEID, PROPNAME, DESCRIPTION, PROPTYPE, PROPSIZE, MINOCCURS, MAXOCCURS, DEFAULTVALUE, HIDDEN, READONLY)
VALUES
('Case', 'endTime', 'Hora de tancament', 'T', '0', '0', '0', NULL, 'F', 'F');

INSERT INTO DIC_PROPDEF
(TYPEID, PROPNAME, DESCRIPTION, PROPTYPE, PROPSIZE, MINOCCURS, MAXOCCURS, DEFAULTVALUE, HIDDEN, READONLY)
VALUES
('Case', 'source', 'Font', 'T', '0', '0', '0', NULL, 'F', 'F');

INSERT INTO DIC_PROPDEF
(TYPEID, PROPNAME, DESCRIPTION, PROPTYPE, PROPSIZE, MINOCCURS, MAXOCCURS, DEFAULTVALUE, HIDDEN, READONLY)
VALUES
('Case', 'startDate', 'Data obertura', 'D', '0', '1', '1', NULL, 'F', 'F');

INSERT INTO DIC_PROPDEF
(TYPEID, PROPNAME, DESCRIPTION, PROPTYPE, PROPSIZE, MINOCCURS, MAXOCCURS, DEFAULTVALUE, HIDDEN, READONLY)
VALUES
('Case', 'startTime', 'Hora d''obertura', 'T', '0', '0', '0', NULL, 'F', 'F');

INSERT INTO DIC_PROPDEF
(TYPEID, PROPNAME, DESCRIPTION, PROPTYPE, PROPSIZE, MINOCCURS, MAXOCCURS, DEFAULTVALUE, HIDDEN, READONLY)
VALUES
('Case', 'state', 'Estat de l''expedient', 'T', '0', '0', '1', NULL, 'F', 'F');

INSERT INTO DIC_PROPDEF
(TYPEID, PROPNAME, DESCRIPTION, PROPTYPE, PROPSIZE, MINOCCURS, MAXOCCURS, DEFAULTVALUE, HIDDEN, READONLY)
VALUES
('Case', 'title', 'T�tol', 'T', '0', '0', '1', NULL, 'F', 'F');

INSERT INTO DIC_PROPDEF
(TYPEID, PROPNAME, DESCRIPTION, PROPTYPE, PROPSIZE, MINOCCURS, MAXOCCURS, DEFAULTVALUE, HIDDEN, READONLY)
VALUES
('Document', 'captureDateTime', 'Data de captura', 'D', '0', '0', '1', NULL, 'F', 'F');

INSERT INTO DIC_PROPDEF
(TYPEID, PROPNAME, DESCRIPTION, PROPTYPE, PROPSIZE, MINOCCURS, MAXOCCURS, DEFAULTVALUE, HIDDEN, READONLY)
VALUES
('Document', 'captureUserId', 'Usuari de captura', 'T', '0', '0', '1', NULL, 'F', 'F');

INSERT INTO DIC_PROPDEF
(TYPEID, PROPNAME, DESCRIPTION, PROPTYPE, PROPSIZE, MINOCCURS, MAXOCCURS, DEFAULTVALUE, HIDDEN, READONLY)
VALUES
('Document', 'changeDateTime', 'Data de modificaci�', 'D', '0', '0', '1', NULL, 'F', 'F');

INSERT INTO DIC_PROPDEF
(TYPEID, PROPNAME, DESCRIPTION, PROPTYPE, PROPSIZE, MINOCCURS, MAXOCCURS, DEFAULTVALUE, HIDDEN, READONLY)
VALUES
('Document', 'changeUserId', 'Usuari de modificaci�', 'T', '0', '0', '1', NULL, 'F', 'F');

INSERT INTO DIC_PROPDEF
(TYPEID, PROPNAME, DESCRIPTION, PROPTYPE, PROPSIZE, MINOCCURS, MAXOCCURS, DEFAULTVALUE, HIDDEN, READONLY)
VALUES
('Document', 'classId', 'Codis de s�rie', 'T', '0', '0', '0', NULL, 'F', 'F');

INSERT INTO DIC_PROPDEF
(TYPEID, PROPNAME, DESCRIPTION, PROPTYPE, PROPSIZE, MINOCCURS, MAXOCCURS, DEFAULTVALUE, HIDDEN, READONLY)
VALUES
('Document', 'creationDate', 'Data de creaci�', 'D', '0', '0', '1', NULL, 'F', 'F');

INSERT INTO DIC_PROPDEF
(TYPEID, PROPNAME, DESCRIPTION, PROPTYPE, PROPSIZE, MINOCCURS, MAXOCCURS, DEFAULTVALUE, HIDDEN, READONLY)
VALUES
('Document', 'docId', 'Identificador del document', 'T', '0', '1', '1', NULL, 'F', 'F');

INSERT INTO DIC_PROPDEF
(TYPEID, PROPNAME, DESCRIPTION, PROPTYPE, PROPSIZE, MINOCCURS, MAXOCCURS, DEFAULTVALUE, HIDDEN, READONLY)
VALUES
('Document', 'docTypeId', 'Tipus del document', 'T', '0', '0', '1', NULL, 'F', 'F');

INSERT INTO DIC_PROPDEF
(TYPEID, PROPNAME, DESCRIPTION, PROPTYPE, PROPSIZE, MINOCCURS, MAXOCCURS, DEFAULTVALUE, HIDDEN, READONLY)
VALUES
('Document', 'language', 'Idioma del document', 'T', '0', '0', '1', NULL, 'F', 'F');

INSERT INTO DIC_PROPDEF
(TYPEID, PROPNAME, DESCRIPTION, PROPTYPE, PROPSIZE, MINOCCURS, MAXOCCURS, DEFAULTVALUE, HIDDEN, READONLY)
VALUES
('Document', 'lockUserId', 'Usuari de bloqueig', 'T', '0', '0', '1', NULL, 'F', 'F');

INSERT INTO DIC_PROPDEF
(TYPEID, PROPNAME, DESCRIPTION, PROPTYPE, PROPSIZE, MINOCCURS, MAXOCCURS, DEFAULTVALUE, HIDDEN, READONLY)
VALUES
('Document', 'state', 'Estat del document', 'T', '0', '0', '1', NULL, 'F', 'F');

INSERT INTO DIC_PROPDEF
(TYPEID, PROPNAME, DESCRIPTION, PROPTYPE, PROPSIZE, MINOCCURS, MAXOCCURS, DEFAULTVALUE, HIDDEN, READONLY)
VALUES
('Document', 'summary', 'Resum', 'T', '0', '0', '0', NULL, 'F', 'T');

INSERT INTO DIC_PROPDEF
(TYPEID, PROPNAME, DESCRIPTION, PROPTYPE, PROPSIZE, MINOCCURS, MAXOCCURS, DEFAULTVALUE, HIDDEN, READONLY)
VALUES
('Document', 'title', 'T�tol', 'T', '0', '1', '1', NULL, 'F', 'F');

INSERT INTO DIC_PROPDEF
(TYPEID, PROPNAME, DESCRIPTION, PROPTYPE, PROPSIZE, MINOCCURS, MAXOCCURS, DEFAULTVALUE, HIDDEN, READONLY)
VALUES
('Document', 'version', 'Versi� del document', 'N', '0', '1', '1', NULL, 'F', 'F');

INSERT INTO DIC_PROPDEF
(TYPEID, PROPNAME, DESCRIPTION, PROPTYPE, PROPSIZE, MINOCCURS, MAXOCCURS, DEFAULTVALUE, HIDDEN, READONLY)
VALUES
('Person', 'cognom', 'Cognom', 'T', '0', '0', '0', NULL, NULL, NULL);

INSERT INTO DIC_PROPDEF
(TYPEID, PROPNAME, DESCRIPTION, PROPTYPE, PROPSIZE, MINOCCURS, MAXOCCURS, DEFAULTVALUE, HIDDEN, READONLY)
VALUES
('Person', 'nom', 'Nom', 'T', '0', '0', '0', NULL, NULL, NULL);

INSERT INTO DIC_ACL
(TYPEID, ROLEID, ACTION)
VALUES
('Case', 'CASE_ADMIN', 'DeriveDefinition');

INSERT INTO DIC_ACL
(TYPEID, ROLEID, ACTION)
VALUES
('Document', 'DOC_ADMIN', 'DeriveDefinition');

INSERT INTO DIC_ACL
(TYPEID, ROLEID, ACTION)
VALUES
('Document', 'EVERYONE', 'Create');

INSERT INTO DIC_ACL
(TYPEID, ROLEID, ACTION)
VALUES
('Document', '[realor]', 'Write');

INSERT INTO DIC_ACL
(TYPEID, ROLEID, ACTION)
VALUES
('Person', 'WEBMASTER', 'Create');

INSERT INTO DIC_ACL
(TYPEID, ROLEID, ACTION)
VALUES
('Person', 'WEBMASTER', 'Read');

INSERT INTO DIC_TYPE
(TYPEID, SUPERTYPEID, DESCRIPTION, INSTANTIABLE, CREATIONDT, CREATIONUSERID, MODIFYDT, MODIFYUSERID, REMOVED, TYPEPATH, RESTRICTED)
VALUES
('FORM', 'Document', 'Formulari', 'T', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', NULL, '/Document/FORM/', NULL);

INSERT INTO DIC_TYPE
(TYPEID, SUPERTYPEID, DESCRIPTION, INSTANTIABLE, CREATIONDT, CREATIONUSERID, MODIFYDT, MODIFYUSERID, REMOVED, TYPEPATH, RESTRICTED)
VALUES
('IMAGE', 'Document', 'IMAGE', 'T', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', NULL, '/Document/IMAGE/', NULL);

INSERT INTO DIC_TYPE
(TYPEID, SUPERTYPEID, DESCRIPTION, INSTANTIABLE, CREATIONDT, CREATIONUSERID, MODIFYDT, MODIFYUSERID, REMOVED, TYPEPATH, RESTRICTED)
VALUES
('MAP', 'Document', 'MAP', 'T', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', NULL, '/Document/MAP/', NULL);

INSERT INTO DIC_TYPE
(TYPEID, SUPERTYPEID, DESCRIPTION, INSTANTIABLE, CREATIONDT, CREATIONUSERID, MODIFYDT, MODIFYUSERID, REMOVED, TYPEPATH, RESTRICTED)
VALUES
('REPORT', 'Document', 'REPORT', 'T', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', NULL, '/Document/REPORT/', NULL);

INSERT INTO DIC_TYPE
(TYPEID, SUPERTYPEID, DESCRIPTION, INSTANTIABLE, CREATIONDT, CREATIONUSERID, MODIFYDT, MODIFYUSERID, REMOVED, TYPEPATH, RESTRICTED)
VALUES
('SIGNATURE', 'Document', 'Document de signatura', 'T', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', NULL, '/Document/SIGNATURE/', NULL);

INSERT INTO DIC_TYPE
(TYPEID, SUPERTYPEID, DESCRIPTION, INSTANTIABLE, CREATIONDT, CREATIONUSERID, MODIFYDT, MODIFYUSERID, REMOVED, TYPEPATH, RESTRICTED)
VALUES
('TEMPLATE', 'Document', 'TEMPLATE', 'T', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', NULL, '/Document/TEMPLATE/', NULL);

INSERT INTO DIC_TYPE
(TYPEID, SUPERTYPEID, DESCRIPTION, INSTANTIABLE, CREATIONDT, CREATIONUSERID, MODIFYDT, MODIFYUSERID, REMOVED, TYPEPATH, RESTRICTED)
VALUES
('WORKFLOW', 'Document', 'Diagrama de flux', 'T', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', NULL, '/Document/WORKFLOW/', NULL);

INSERT INTO DIC_TYPE
(TYPEID, SUPERTYPEID, DESCRIPTION, INSTANTIABLE, CREATIONDT, CREATIONUSERID, MODIFYDT, MODIFYUSERID, REMOVED, TYPEPATH, RESTRICTED)
VALUES
('XSLT', 'Document', 'XSLT', 'T', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', to_char(sysdate, 'YYYYMMDDHH24MISS'), 'admin', NULL, '/Document/XSLT/', NULL);

INSERT INTO DIC_ACL
(TYPEID, ROLEID, ACTION)
VALUES
('FORM', 'EVERYONE', 'Read');

INSERT INTO DIC_ACL
(TYPEID, ROLEID, ACTION)
VALUES
('FORM', 'EVERYONE', 'Write');

INSERT INTO DIC_ACL
(TYPEID, ROLEID, ACTION)
VALUES
('MAP', 'WEBMASTER', 'Create');

INSERT INTO DIC_ACL
(TYPEID, ROLEID, ACTION)
VALUES
('MAP', 'WEBMASTER', 'Read');

INSERT INTO DIC_ACL
(TYPEID, ROLEID, ACTION)
VALUES
('REPORT', 'WEBMASTER', 'Create');

INSERT INTO DIC_ACL
(TYPEID, ROLEID, ACTION)
VALUES
('REPORT', 'WEBMASTER', 'Read');

INSERT INTO DIC_ACL
(TYPEID, ROLEID, ACTION)
VALUES
('SIGNATURE', 'EVERYONE', 'Create');

INSERT INTO DIC_ACL
(TYPEID, ROLEID, ACTION)
VALUES
('TEMPLATE', 'WEBMASTER', 'Create');

INSERT INTO DIC_ACL
(TYPEID, ROLEID, ACTION)
VALUES
('TEMPLATE', 'WEBMASTER', 'Read');

INSERT INTO DIC_ACL
(TYPEID, ROLEID, ACTION)
VALUES
('WORKFLOW', 'EVERYONE', 'Read');

INSERT INTO DIC_ACL
(TYPEID, ROLEID, ACTION)
VALUES
('XSLT', 'WEBMASTER', 'Create');

INSERT INTO DIC_ACL
(TYPEID, ROLEID, ACTION)
VALUES
('XSLT', 'WEBMASTER', 'Read');

COMMIT;
