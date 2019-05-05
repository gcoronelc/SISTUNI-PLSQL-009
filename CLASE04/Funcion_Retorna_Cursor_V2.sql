-- FUNCION QUE RETORNA CURSOR - VERSION 2

-- =======================================================
-- DEFINICION DEL PAQUETE
-- =======================================================

CREATE OR REPLACE PACKAGE SCOTT.PKG_UTIL2 IS

  TYPE GEN_CURSOR IS REF CURSOR;

  FUNCTION F_EMP_X_DEP( P_DEPTNO NUMBER ) RETURN GEN_CURSOR;

END PKG_UTIL2;
/

-- =======================================================
-- IMPLEMENTACION DEL PAQUETE
-- =======================================================
CREATE OR REPLACE PACKAGE BODY SCOTT.PKG_UTIL2 AS

  FUNCTION F_EMP_X_DEP( P_DEPTNO NUMBER ) RETURN GEN_CURSOR
  IS
    V_RETURN_CURSOR GEN_CURSOR;
    V_SELECT VARCHAR(500);
  BEGIN
    
    V_SELECT := 'SELECT * FROM SCOTT.EMP WHERE DEPTNO = :CODIGO';
    
    OPEN  V_RETURN_CURSOR 
    FOR   V_SELECT
    USING P_DEPTNO;
    
    RETURN V_RETURN_CURSOR;
    
  END;

END PKG_UTIL2;
/



declare
  v_cur scott.PKG_UTIL2.gen_cursor;
  r     scott.emp%rowtype;
begin
  v_cur := scott.PKG_UTIL2.f_emp_x_dep(30);
  fetch v_cur into r;
  dbms_output.put_line( to_char(v_cur%rowcount) || ' ' || r.ename );
  close v_cur;
end;
/


declare
  v_cur scott.PKG_UTIL2.gen_cursor;
  r     scott.emp%rowtype;
begin
  v_cur := scott.PKG_UTIL2.f_emp_x_dep(30);
  fetch v_cur into r;
  while v_cur%found loop
    dbms_output.put_line( to_char(v_cur%rowcount) || ' ' || r.ename );
    fetch v_cur into r;
  end loop;
  close v_cur;
end;
/



GRANT EXECUTE ON SCOTT.PKG_UTIL2 TO APPSCOTT;






