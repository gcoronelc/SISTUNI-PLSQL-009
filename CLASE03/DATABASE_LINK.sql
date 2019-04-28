
-- CASO 01: Descriptor simple
-- ----------------------------------------

CREATE PUBLIC DATABASE LINK DBL01 
CONNECT TO system IDENTIFIED BY oracle 
USING '172.17.0.97:1521/orcl';

insert into scott.emp@DBL01(empno, ename, sal)
values( 8889, 'GUSTAVO', 9999);

commit;


select * from scott.emp@DBL01;


-- CASO 01: Usando TNS Name
-- ----------------------------------------

CREATE PUBLIC DATABASE LINK DBL02 
CONNECT TO system IDENTIFIED BY oracle 
USING 'HARLEY';


select * from scott.emp@DBL02;



-- CASO 02: Usando un descriptor complejo
-- ----------------------------------------

CREATE PUBLIC DATABASE LINK DBL03
CONNECT TO system IDENTIFIED BY oracle 
USING '(DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = 172.17.0.97)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = orcl)
    )
  )';


select * from scott.emp@DBL03;


