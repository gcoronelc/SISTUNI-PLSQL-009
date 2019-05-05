SET TERMOUT ON
SET ECHO OFF
SET SERVEROUTPUT ON


-- =============================================
-- CRACIÓN DE LA APLICACIÓN
-- =============================================

DECLARE
	N INT;
	COMMAND VARCHAR2(200);
BEGIN
	COMMAND := 'DROP USER sysmatriculas CASCADE';
	SELECT COUNT(*) INTO N
	FROM DBA_USERS
	WHERE USERNAME = 'sysmatriculas';
	IF ( N = 1 ) THEN
		EXECUTE IMMEDIATE COMMAND;
	END IF;
END;
/


CREATE USER sysmatriculas IDENTIFIED BY sysmatriculas;

GRANT CONNECT, RESOURCE TO sysmatriculas;

ALTER USER sysmatriculas
QUOTA UNLIMITED ON USERS;

GRANT CREATE VIEW TO sysmatriculas;


-- =============================================
-- CONECTARSE A LA APLICACIÓN
-- =============================================

CONNECT sysmatriculas/sysmatriculas@xe


-- =============================================
-- CREACIÓN DE LOS OBJETOS DE LA BASE DE DATOS
-- =============================================


CREATE TABLE ALUMNO
(
	alumnoCodigo         VARCHAR2(200) NOT NULL ,
	alumnoNombre         VARCHAR2(200) NULL ,
	alumnoDireccion      VARCHAR2(200) NULL ,
	alumnoTelefono       VARCHAR2(200) NULL ,
	alumnoEmail          VARCHAR2(200) NULL ,
	alumnoEstado         VARCHAR2(200) NULL 
);



CREATE UNIQUE INDEX XPKALUMNO ON ALUMNO
(alumnoCodigo   ASC);



ALTER TABLE ALUMNO
	ADD CONSTRAINT  XPKALUMNO PRIMARY KEY (alumnoCodigo);



CREATE TABLE CURSO
(
	cursoCodigo          VARCHAR2(200) NOT NULL ,
	cursoNombre          VARCHAR2(200) NULL ,
	cursoEstado          VARCHAR2(200) NULL 
);



CREATE UNIQUE INDEX XPKCURSO ON CURSO
(cursoCodigo   ASC);



ALTER TABLE CURSO
	ADD CONSTRAINT  XPKCURSO PRIMARY KEY (cursoCodigo);



CREATE TABLE CURSO_DOCENTE
(
	cursoCodigo          VARCHAR2(200) NOT NULL ,
	docenteCodigo        VARCHAR2(200) NOT NULL ,
	cursoDocenteEstado   VARCHAR2(200) NULL ,
	cursoDocenteCosto    INTEGER NULL ,
	cursoDocenteCantidad INTEGER NULL 
);



CREATE UNIQUE INDEX XPKCURSO_DOCENTE ON CURSO_DOCENTE
(cursoCodigo   ASC,docenteCodigo   ASC);



ALTER TABLE CURSO_DOCENTE
	ADD CONSTRAINT  XPKCURSO_DOCENTE PRIMARY KEY (cursoCodigo,docenteCodigo);



CREATE TABLE DOCENTE
(
	docenteCodigo        VARCHAR2(200) NOT NULL ,
	docenteNombre        VARCHAR2(200) NULL ,
	docenteDireccion     VARCHAR2(200) NULL ,
	docenteTelefono      VARCHAR2(200) NULL ,
	docenteEmail         VARCHAR2(200) NULL ,
	docenteEstado        VARCHAR2(200) NULL 
);



CREATE UNIQUE INDEX XPKDOCENTE ON DOCENTE
(docenteCodigo   ASC);



ALTER TABLE DOCENTE
	ADD CONSTRAINT  XPKDOCENTE PRIMARY KEY (docenteCodigo);



CREATE TABLE LOCAL
(
	localCodigo          VARCHAR2(200) NOT NULL ,
	localNombre          VARCHAR2(200) NULL ,
	localEstado          VARCHAR2(200) NULL 
);



CREATE UNIQUE INDEX XPKLOCAL ON LOCAL
(localCodigo   ASC);



ALTER TABLE LOCAL
	ADD CONSTRAINT  XPKLOCAL PRIMARY KEY (localCodigo);



CREATE TABLE MATRICULA
(
	matriculaCodigo      VARCHAR2(200) NOT NULL ,
	alumnoCodigo         VARCHAR2(200) NULL ,
	localCodigo          VARCHAR2(200) NULL ,
	cursoCodigo          VARCHAR2(200) NULL ,
	docenteCodigo        VARCHAR2(200) NULL ,
	matriculaEstado      VARCHAR2(200) NULL 
);



CREATE UNIQUE INDEX XPKMATRICULA ON MATRICULA
(matriculaCodigo   ASC);



ALTER TABLE MATRICULA
	ADD CONSTRAINT  XPKMATRICULA PRIMARY KEY (matriculaCodigo);



CREATE TABLE PAGO
(
	pagoCodigo           VARCHAR2(200) NOT NULL ,
	matriculaCodigo      VARCHAR2(200) NULL ,
	tipoComprobanteCodigo VARCHAR2(200) NULL ,
	pagoEstado           VARCHAR2(200) NULL ,
	pagoMonto            INTEGER NULL 
);



CREATE UNIQUE INDEX XPKPAGO ON PAGO
(pagoCodigo   ASC);



ALTER TABLE PAGO
	ADD CONSTRAINT  XPKPAGO PRIMARY KEY (pagoCodigo);



CREATE TABLE TIPOCOMPROBANTE
(
	tipoComprobanteCodigo VARCHAR2(200) NOT NULL ,
	tipoComprobanteNombre VARCHAR2(200) NULL ,
	tipoComprobanteEstado VARCHAR2(200) NULL 
);



CREATE UNIQUE INDEX XPKTIPOCOMPROBANTE ON TIPOCOMPROBANTE
(tipoComprobanteCodigo   ASC);



ALTER TABLE TIPOCOMPROBANTE
	ADD CONSTRAINT  XPKTIPOCOMPROBANTE PRIMARY KEY (tipoComprobanteCodigo);



ALTER TABLE CURSO_DOCENTE
	ADD (CONSTRAINT R_18 FOREIGN KEY (cursoCodigo) REFERENCES CURSO (cursoCodigo));



ALTER TABLE CURSO_DOCENTE
	ADD (CONSTRAINT R_19 FOREIGN KEY (docenteCodigo) REFERENCES DOCENTE (docenteCodigo));



ALTER TABLE MATRICULA
	ADD (CONSTRAINT R_7 FOREIGN KEY (alumnoCodigo) REFERENCES ALUMNO (alumnoCodigo) ON DELETE SET NULL);



ALTER TABLE MATRICULA
	ADD (CONSTRAINT R_9 FOREIGN KEY (localCodigo) REFERENCES LOCAL (localCodigo) ON DELETE SET NULL);



ALTER TABLE MATRICULA
	ADD (CONSTRAINT R_22 FOREIGN KEY (cursoCodigo, docenteCodigo) REFERENCES CURSO_DOCENTE (cursoCodigo, docenteCodigo) ON DELETE SET NULL);



ALTER TABLE PAGO
	ADD (CONSTRAINT R_12 FOREIGN KEY (matriculaCodigo) REFERENCES MATRICULA (matriculaCodigo) ON DELETE SET NULL);



ALTER TABLE PAGO
	ADD (CONSTRAINT R_14 FOREIGN KEY (tipoComprobanteCodigo) REFERENCES TIPOCOMPROBANTE (tipoComprobanteCodigo) ON DELETE SET NULL);
