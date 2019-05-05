-- FUNCION QUE RETORNA CURSOR


-- =======================================================
-- DEFINICION DEL PAQUETE
-- =======================================================

CREATE OR REPLACE PACKAGE SCOTT.PKG_UTIL IS

  -- Tipo de dato CURSOR
  TYPE GEN_CURSOR IS REF CURSOR;

  -- Retorna los empleados de un departamento
  FUNCTION F_EMP_X_DEP( V_DEPTNO NUMBER ) RETURN GEN_CURSOR;

END PKG_UTIL;
/



-- =======================================================
-- IMPLEMENTACION DEL PAQUETE
-- =======================================================
CREATE OR REPLACE PACKAGE BODY SCOTT.PKG_UTIL AS

  FUNCTION F_EMP_X_DEP( V_DEPTNO NUMBER ) RETURN GEN_CURSOR
  IS
    V_RETURNCURSOR GEN_CURSOR;
    V_SELECT VARCHAR(500);
  BEGIN
    
    V_SELECT := 'SELECT * FROM SCOTT.EMP WHERE DEPTNO = ' || TO_CHAR(V_DEPTNO );
    
    OPEN V_RETURNCURSOR 
    FOR V_SELECT;
    
    RETURN V_RETURNCURSOR;
    
  END;

END PKG_UTIL;
/



declare
  v_cur SCOTT.PKG_UTIL.GEN_CURSOR;
  r     scott.emp%rowtype;
begin
  v_cur := SCOTT.PKG_UTIL.f_emp_x_dep(20);
  fetch v_cur into r;
  dbms_output.put_line( to_char(v_cur%rowcount) || ' ' || r.ename );
  close v_cur;
end;
/


DECLARE
  V_CUR SCOTT.PKG_UTIL.GEN_CURSOR;
  R     SCOTT.EMP%ROWTYPE;
BEGIN
  v_cur := scott.PKG_UTIL.f_emp_x_dep(10);
  FETCH v_cur INTO R;
  WHILE v_cur%found LOOP
    dbms_output.put_line( to_char(v_cur%rowcount) || ' ' || R.ename );
    FETCH v_cur INTO R;
  END LOOP;
  CLOSE v_cur;
END;
/



GRANT EXECUTE ON SCOTT.UTIL TO APPSCOTT;





