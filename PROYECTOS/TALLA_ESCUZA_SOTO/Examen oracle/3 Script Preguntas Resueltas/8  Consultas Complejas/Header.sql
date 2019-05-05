CREATE OR REPLACE PACKAGE SYSMATRICULAS.PKG_MATRICULA

  -- Author  : ESOTOP
  -- Created : 01/05/2019 14:40:39 p.m.
  -- Purpose : Efectuar el proceso de pago de matricula

IS

 PROCEDURE SP_matricular_alumno(
                                  p_codigoAlumno  IN VARCHAR2,
                                  p_pago         IN VARCHAR2,
                                  p_codigoEstado     OUT   NUMBER,
                                  p_msjEstado     OUT   varchar2);

 FUNCTION FN_TIPO_COMPROBANTE( p_pago in number) RETURN VARCHAR;
 FUNCTION FN_CODIGO_PAGO RETURN VARCHAR;

END PKG_MATRICULA;
