
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
after insert or update of Sal on scott.emp
for each row
begin    
  insert into scott.sal_history( EmpNo, SalOld, SalNew, StartDate, SetUserDB, SetUserSO, setIP, setPC)
  values( :new.EmpNo, :Old.Sal, :New.Sal, SYSDATE, USER, sys_context('userenv','os_user'), sys_context('userenv','ip_address'),sys_context('userenv','host'));
end;


INSERT INTO SCOTT.EMP(EMPNO, ENAME, SAL ) VALUES( 1500, 'GUSTAVO', 1200 );

update SCOTT.EMP set sal = 18000 where empno = 1500;

select * from scott.emp;
select * from scott.sal_history;

select sys_context('userenv','terminal') from dual;
select sys_context('userenv','os_user') from dual;
select sys_context('userenv','host') from dual;
select sys_context('userenv','server_host') from dual;
select sys_context('userenv','ip_address') from dual;
select utl_inaddr.get_host_address from dual;
select utl_inaddr.get_host_name('172.17.3.95') from dual;
--172.17.3.95

update SCOTT.EMP set ename = 'ALBERTO' where empno = 1500;


-- TAREA
-- Desarrollar los cambios necesarios en el trigger scott.tr_sal_history
-- para que solo modifique losa cambios en el salario.
-- Tambien debe actualizar las columnas que faltan: SetUserSO, setIP, setPC


 
