-- IF

-- Ejercicio 01
-- Encontrar el mayor de 5 numeros

create or replace function scott.fn_mayor
(
  p_n1 number, p_n2 number, p_n3 number, 
  p_n4 number, p_n5 number 
)
return number
is
  v_mayor number;
begin
  -- Punto de partida
  v_mayor := p_n1;
  -- Proceso
  if v_mayor < p_n2 then
    v_mayor := p_n2;
  end if;
  if v_mayor < p_n3 then
    v_mayor := p_n3;
  end if;
  if v_mayor < p_n4 then
    v_mayor := p_n4;
  end if;
  if v_mayor < p_n5 then
    v_mayor := p_n5;
  end if;
  -- Reporte
  return v_mayor;
end;
/

-- Prueba

select scott.fn_mayor(120,45,32,67,43) mayor from dual;


