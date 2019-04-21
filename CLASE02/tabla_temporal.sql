-- Ejercicio de Tabla Temporal
-- Se necesita el siguiente reporte del esquema EDUCA
/*

CUR_ID    CUR_NOMBRE   VACANTES  MATRICULADOS   IMP. PROYECTADO   COMPROMETIDO    RECAUDADO 
--------------------------------------------------------------------------------------------




---------------------------------------------------------------------------------------------


*/


CREATE GLOBAL TEMPORARY TABLE EDUCA.RESUMEN(
  ID           NUMBER,
  NOMBRE       VARCHAR2(100),
  VACANTES     NUMBER,
  MATRICULADOS NUMBER,
  PROYECTADO   NUMBER(12,2),
  COMPROMETIDO NUMBER(12,2),
  RECAUDADO    NUMBER(12,2) 
) ON COMMIT PRESERVE ROWS;


CREATE OR REPLACE PROCEDURE EDUCA.SP_GENERA_RESUMEN
IS
  v_comprometido number(12,2);
  v_recaudado    number(12,2);
BEGIN
  -- Limpiar tabla
  DELETE FROM EDUCA.RESUMEN;
  COMMIT;
  
  -- Cargar datos iniciales
  insert into EDUCA.RESUMEN( 
  id, nombre, vacantes, matriculados, proyectado, comprometido, recaudado)
  select cur_id, cur_nombre, cur_vacantes, cur_matriculados, cur_vacantes * cur_precio, 0, 0
  from educa.curso;

  -- Proceso
  for r in (select * from EDUCA.RESUMEN) loop
    
    -- Comprometido
    select nvl(sum(mat_precio),0) into v_comprometido
    from educa.matricula   where cur_id = r.id;
    
    -- Recaudado
    select nvl(sum(pag_importe),0) into v_recaudado
    from educa.pago         where cur_id = r.id;
    
    -- Actualizar tabla RESUMEN
    update EDUCA.RESUMEN
    set comprometido = v_comprometido,
        recaudado    = v_recaudado
    where id = r.id;
    
  end loop;

END;
/


call EDUCA.SP_GENERA_RESUMEN();



select * from EDUCA.RESUMEN;



CREATE OR REPLACE PROCEDURE EDUCA.SP_GENERA_RESUMEN
( p_cursor out nocopy SYS_REFCURSOR )
IS
  v_comprometido number(12,2);
  v_recaudado    number(12,2);
BEGIN
  -- Limpiar tabla
  DELETE FROM EDUCA.RESUMEN;
  COMMIT;
  
  -- Cargar datos iniciales
  insert into EDUCA.RESUMEN( 
  id, nombre, vacantes, matriculados, proyectado, comprometido, recaudado)
  select cur_id, cur_nombre, cur_vacantes, cur_matriculados, cur_vacantes * cur_precio, 0, 0
  from educa.curso;

  -- Proceso
  for r in (select * from EDUCA.RESUMEN) loop
    
    -- Comprometido
    select nvl(sum(mat_precio),0) into v_comprometido
    from educa.matricula   where cur_id = r.id;
    
    -- Recaudado
    select nvl(sum(pag_importe),0) into v_recaudado
    from educa.pago         where cur_id = r.id;
    
    -- Actualizar tabla RESUMEN
    update EDUCA.RESUMEN
    set comprometido = v_comprometido,
        recaudado    = v_recaudado
    where id = r.id;
    
  end loop;
  commit;
  
  -- Reporte
  open p_cursor for
  select id, nombre, vacantes, matriculados, proyectado, comprometido, recaudado
  from EDUCA.RESUMEN;

END;
/

declare
  v_cursor SYS_REFCURSOR;
  v_rec    EDUCA.RESUMEN%rowtype;
begin
  EDUCA.SP_GENERA_RESUMEN( v_cursor );
  loop
    fetch v_cursor into v_rec;
    exit when (v_cursor%notfound);
    dbms_output.put_line(v_rec.nombre);  
  end loop;
  close v_cursor;
end;

