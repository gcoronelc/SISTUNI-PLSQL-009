
drop table scott.sal_history purge;

create table scott.sal_history(
   EmpNo     number(4) not null,
   SalOld    Number(7,2) null,
   SalNew    Number(7,2) null,
   StartDate Date not null,
   SetUserDB Varchar2(30) not null,
   SetUserSO Varchar2(30) null,   
   setIP     Varchar2(100) null,  
   setPC     Varchar2(100) null
);


create or replace trigger scott.tr_sal_history
after insert or update on scott.emp
for each row
begin
    
  insert into scott.sal_history( EmpNo, SalOld, SalNew, StartDate, SetUserDB)
  values( :new.EmpNo, :Old.Sal, :New.Sal, SYSDATE, USER );

end;


INSERT INTO SCOTT.EMP(EMPNO, ENAME, SAL ) VALUES( 7557, 'GUSTAVO', 7777 );

update SCOTT.EMP
set sal = 99999
where empno = 7557;

select * from scott.emp;

select * from scott.sal_history;


update SCOTT.EMP
set ename = 'ANGEL'
where empno = 7557;


-- TAREA
-- Desarrollar los cambios necesarios en el trigger scott.tr_sal_history
-- para que solo modifique losa cambios en el salario.
-- Tambien debe actualizar las columnas que faltan: SetUserSO, setIP, setPC


 
