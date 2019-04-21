-- CASE

-- Ejercicio
-- Consultar la condición de un alumno en el esque EDUCA
-- con restecto a un curso.
-- APROBADO, ASISTENTE, DESAPROBADO

create or replace function educa.fn_estado
(
  p_alumno in number, 
  p_curso in number
)
return varchar2
is
  v_estado varchar2(50);
  v_conta  number(5);
  v_nota   number;
begin
  -- Punto de partida
  v_estado := 'NO EXISTE';
  
  -- Verificar si la matricula existe
  select count(1) into v_conta
  from educa.matricula
  where alu_id = p_alumno
  and   cur_id = p_curso;
  
  if v_conta = 0 then
    return v_estado;
  end if;
  
  -- Proceso
  select mat_nota into v_nota
  from educa.matricula
  where alu_id = p_alumno
  and   cur_id = p_curso;
  
  case 
    when (v_nota >= 14) then
      v_estado := 'APROBADO';
    when (v_nota <= 10) then
      v_estado := 'DESAPROBADO';
    else
      v_estado := 'ASISTENTE';
  end case;
  
  -- Reporte final
  return v_estado;
end;
/



SELECT educa.fn_estado(5,1) ESTADO FROM DUAL;







