CREATE TABLE SQL_CONNECTION 
(
  ALIAS VARCHAR2(50) NOT NULL, 
  DRIVER VARCHAR2(100) NOT NULL, 
  URL VARCHAR2(100 BYTE) NOT NULL,
  CONSTRAINT SQL_CONNECTION_PK PRIMARY KEY (ALIAS) ENABLE
);

