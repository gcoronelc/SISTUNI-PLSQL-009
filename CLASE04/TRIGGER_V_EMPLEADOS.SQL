CREATE OR REPLACE VIEW SCOTT.V_EMPLEADOS AS
SELECT E.EMPNO, E.ENAME, D.DEPTNO, D.DNAME
FROM SCOTT.EMP E JOIN SCOTT.DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT * FROM SCOTT.V_EMPLEADOS;

INSERT INTO SCOTT.V_EMPLEADOS
VALUES( 9999, 'PEDRO', 40, 'ASUNTOS IMPORTANTES' );



CREATE OR REPLACE TRIGGER SCOTT.TR_VIEW_V_EMPLEADOS
INSTEAD OF INSERT OR DELETE ON SCOTT.V_EMPLEADOS
FOR EACH ROW
DECLARE
  V_CONTA NUMBER(5);
BEGIN
  IF INSERTING THEN
  
     select count(1) into v_conta
     from scott.dept where deptno = :new.deptno; 
  
     if v_conta = 0 then
        insert into scott.dept( deptno, dname )
        values( :new.deptno, :new.dname );
     end if;
     
     select count(1) into v_conta
     from scott.emp where empno = :new.empno;   
  
     if v_conta = 0 then
        insert into scott.emp( empno, ename, deptno )
        values( :new.empno, :new.ename, :new.deptno );
     end if;
     
  ELSIF DELETING THEN
  
     delete from scott.emp 
     where empno = :old.empno;
  
  END IF;
  
END;
/

SELECT * FROM SCOTT.DEPT;

SELECT * FROM SCOTT.EMP;

SELECT * FROM SCOTT.V_EMPLEADOS;

INSERT INTO SCOTT.V_EMPLEADOS
VALUES( 8888, 'MANUEL', 60, 'ASUNTOS' );




