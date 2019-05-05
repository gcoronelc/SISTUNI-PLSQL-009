CREATE OR REPLACE PACKAGE BODY SYSMATRICULAS.PKG_MATRICULA IS


PROCEDURE SP_matricular_alumno
(
    p_codigoAlumno  IN VARCHAR2,
    p_pago         IN VARCHAR2,
    p_codigoEstado     OUT   NUMBER,
    p_msjEstado     OUT   varchar2
)
IS
v_validaMatricula NUMBER;
v_codigoMatricula varchar2(50);
v_pago NUMBER;
v_codTipoBoleta varchar(10);
v_codigoPago varchar(10);
v_msg varchar2(1000);

-- DBMS_OUTPUT.PUT_LINE (v_validaMatricula);
BEGIN

 --Valido que el Alumno este matriculado.

 select count(*) into v_validaMatricula  from sysmatriculas.matricula a where a.alumnocodigo=p_codigoAlumno;

     IF(v_validaMatricula = 0 )  THEN
      p_codigoEstado:=1;
      p_msjEstado:= 'EL ALUMNO NO EXISTE ';

       ELSE

         select a.matriculacodigo into v_codigoMatricula  from sysmatriculas.matricula a where a.alumnocodigo=p_codigoAlumno;
         select count(*) into v_pago  from sysmatriculas.pago b where b.matriculacodigo=v_codigoMatricula;

                  IF(v_pago= 0) THEN
                    p_msjEstado:= 'AUN NO PAGA';
                      select sysmatriculas.FN_TIPO_COMPROBANTE(v_pago) INTO v_codTipoBoleta from dual;
                      SELECT sysmatriculas.FN_CODIGO_PAGO() INTO v_codigoPago FROM DUAL;

                      INSERT INTO sysmatriculas.pago(PAGOCODIGO,MATRICULACODIGO,TIPOCOMPROBANTECODIGO,PAGOESTADO,PAGOMONTO)
                      VALUES (v_codigoPago,v_codigoMatricula,v_codTipoBoleta,1,p_pago);
                        --COMMIT;
                        p_codigoEstado:=0;
                       p_msjEstado:='EL PAGO FUE EXITOSO, GRACIAS !!';
                   ELSE
                       p_codigoEstado:=2;
                       p_msjEstado:='LA MATRICULA SE ENCUENTRA PAGADA, NO SE PUEDE REALIZAR EL PAGO';
                   END IF;

    END IF;
    
    exception
    when others then
    v_msg := sqlerrm; 
    rollback; 
    raise_application_error(-20001,v_msg);

 END;
 ------------------------------------------------------------------------------------------------------------------------------------

FUNCTION  FN_TIPO_COMPROBANTE(
  p_pago in number
) return varchar
is
  v_codigoTipoComprobante varchar(10);
begin

      IF p_pago<500 THEN

      v_codigoTipoComprobante :='00003';

      ELSIF p_pago>=500 AND p_pago<1000 THEN

        v_codigoTipoComprobante :='00002';

      ELSE
           v_codigoTipoComprobante :='00001';

      END IF;

  return v_codigoTipoComprobante;
end;

 ------------------------------------------------------------------------------------------------------------------------------------

FUNCTION FN_CODIGO_PAGO
return VARCHAR
is
  v_codigoPago varchar(10);
  v_codigoPagoText varchar(10);
begin

  SELECT MAX(TO_NUMBER(PAGOCODIGO))+1 INTO v_codigoPago  FROM sysmatriculas.pago;


   v_codigoPagoText:= SUBSTR('00000'||TO_CHAR(v_codigoPago),-5);


  return v_codigoPagoText;
end;


END PKG_MATRICULA;
