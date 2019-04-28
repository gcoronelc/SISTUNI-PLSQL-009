
begin

  update scott.emp
  set sal = sal * 1.10
  where empno = 67897;
  
  if sql%Notfound then
    dbms_output.put_line('NO existe');
  else
    dbms_output.put_line('SI existe');
  end if;

end;
/


select * from scott.emp;



