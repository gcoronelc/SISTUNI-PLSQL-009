
select * from scott.emp;


BEGIN
  DBMS_OUTPUT.PUT_LINE('Bienvenidos al oscuro mundo de ORACLE.');
END;
/


DECLARE
  V_N1   NUMBER;
  V_N2   NUMBER;
  V_SUMA NUMBER;
BEGIN
  -- DATOS
  V_N1 := 10;
  V_N2 := 50;
  -- Proceso
  V_SUMA := V_N1 + V_N2;
  -- Reporte
  DBMS_OUTPUT.PUT_LINE( 'N1: ' || V_N1 );
  DBMS_OUTPUT.PUT_LINE( 'N2: ' || V_N2 );
  DBMS_OUTPUT.PUT_LINE( 'SUMA: ' || V_SUMA );
END;
/




