
create table scott.emp2 as
(select * from scott.emp);

update scott.emp2 set sal = 8888;


ALTER TABLE SCOTT.EMP2 
ADD PRIMARY KEY ( EMPNO );

UPDATE (SELECT t1.empno empno, 
               t1.ename ename,
               t1.sal   sal1,
               t2.sal   sal2
          FROM scott.emp  t1 
          JOIN scott.emp2 t2
            ON t1.empno = t2.empno)
   SET sal1 = sal2;
   
select * from scott.emp;

   
   
       
       
