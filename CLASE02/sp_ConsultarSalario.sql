
create or replace procedure scott.sp_ConsultarSalario
( 
  p_codigo  in number,
  p_mensaje out nocopy varchar2,
  p_salario out nocopy number
)
is
begin
  -- Inicio
  p_mensaje := 'OK';
  -- Proceso
  select sal into p_salario
  from scott.emp 
  where empno = p_codigo;
exception
  when no_data_found then
    p_mensaje := 'Código no existe.';
    p_salario := 0;
  when others then
    p_mensaje := SQLERRM;
    p_salario := 0;
end;
/


declare
  v_codigo  number;
  v_mensaje varchar2(1000);
  v_salario number;
begin
  -- Datos
  v_codigo := 1234; --7369;
  -- Proceso
  scott.sp_ConsultarSalario( v_codigo, v_mensaje, v_salario );
  -- Reporte
  dbms_output.put_line( 'Mensaje: ' || v_mensaje );
  dbms_output.put_line( 'Salario: ' || v_salario );
end;
/


select * from scott.emp;




