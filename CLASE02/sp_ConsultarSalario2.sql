
create or replace procedure scott.sp_ConsultarSalario2
( 
  p_codigo  in number,
  p_salario out nocopy number
)
is
begin
  -- Proceso
  select sal into p_salario
  from scott.emp 
  where empno = p_codigo;
exception
  when no_data_found then
    RAISE_APPLICATION_ERROR(-20000, 'Código no exite');
  when others then
    RAISE_APPLICATION_ERROR(-20001, SQLERRM);
end;
/


declare
  v_codigo  number;
  v_salario number;
begin
  -- Datos
  v_codigo := 1234; --7369;
  -- Proceso
  scott.sp_ConsultarSalario2( v_codigo, v_salario );
  -- Reporte
  dbms_output.put_line( 'Salario: ' || v_salario );
exception
  when others then
    dbms_output.put_line( sqlerrm );
end;
/


select * from scott.emp;




