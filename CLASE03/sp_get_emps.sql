
-- consultar los empleados de un departamento

create or replace procedure scott.sp_get_emps
( p_deptno  in number, p_cursor out nocopy SYS_REFCURSOR)
is
begin
  open p_cursor for
  select * from scott.emp where deptno = p_deptno;
end;
/


declare 
  v_cursor SYS_REFCURSOR;
  v_rec    scott.emp%rowtype;
begin
  scott.sp_get_emps( 20, v_cursor );
  loop
    fetch v_cursor into v_rec;
    exit when (v_cursor%NotFound);
    dbms_output.put_line(v_rec.ename);
  end loop;
  close v_cursor;
end;
/


  
  