
declare 
  v_nuevo_sueldo number;
begin
  
  update scott.emp
  set sal = sal * 1.10
  where empno = 7369
  RETURNING sal into v_nuevo_sueldo;
  
  dbms_output.put_line( 'Nuevo Sueldo: ' || v_nuevo_sueldo );

end;


  

select * from scott.emp;


