
create or replace function scott.fn_suma(
  p_n1 in number,
  p_n2 in number
) return number
is
  v_suma number;
begin
  -- Proceso
  v_suma := p_n1 + p_n2;
  -- Reporte
  return v_suma;
end;
/

select scott.fn_suma(5,6) from dual;


create or replace function scott.fn_doble(
  p_n1 in number
) return number
is
  v_doble number;
begin
  -- Proceso
  v_doble := p_n1 + p_n1;
  -- Reporte
  return v_doble;
end;
/


select scott.fn_doble(5) from dual;


CREATE OR REPLACE FUNCTION eureka.FN_descemp(
  p_scodigo in varchar2,
  p_estado  out number
)return varchar2
is
  v_apenom varchar2(300);
begin
  -- Estado por defecto
  p_estado := 1;
  
  --proceso
  select vch_cliepaterno||' '||vch_cliematerno||' '||vch_clienombre 
  into v_apenom 
  from  eureka.cliente 
  where chr_cliecodigo = p_scodigo;
  
  --Reporte
  return v_apenom;

exception
  when others then
    p_estado := -1;
    return 'NO EXISTE';
end;
/
 

declare
  v_estado number;
  v_nombre VARCHAR2(500);
begin
  -- proceso
  v_nombre := eureka.FN_descemp('0000331', v_estado);
  -- Reporte
  dbms_output.put_line( 'Estado: ' || v_estado );
  dbms_output.put_line( 'nombre: ' || v_nombre );
end;
/



