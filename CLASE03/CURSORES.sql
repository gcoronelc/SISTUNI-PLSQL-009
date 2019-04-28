-- Cursor 01

declare
  cursor v_cursor is
    select * from scott.emp;
  v_rec scott.emp%rowtype;
begin
  
  open v_cursor;
  
  -- Primera fila
  fetch v_cursor into v_rec;
  dbms_output.put_line('Filas: ' || v_cursor%rowcount);
  dbms_output.put_line(v_rec.ename);
  
  -- Segunda fila
  fetch v_cursor into v_rec;
  dbms_output.put_line('Filas: ' || v_cursor%rowcount);
  dbms_output.put_line(v_rec.ename);  
  
  close v_cursor;
end;


-- Cursor 02

declare
  cursor v_cursor is
    select * from scott.emp@DBL01;
  v_rec scott.emp%rowtype;
begin
  
  open v_cursor;
  
  loop
  
    fetch v_cursor into v_rec;
    exit when (v_cursor%NotFound);
    
    dbms_output.put_line('Filas ' || v_cursor%rowcount || ': ' || v_rec.ename);
  
  end loop;
  
  close v_cursor;
end;


-- Cursor 03

declare
  cursor v_cursor is
    select * from scott.emp@DBL01;
  V_FILA NUMBER := 0;
begin
  
  FOR V_REC IN V_CURSOR loop
    
    V_FILA := V_FILA + 1;
    dbms_output.put_line('Filas ' || V_FILA || ': ' || v_rec.ename);
  
  end loop;

end;



-- Cursor 04

declare   
  V_FILA NUMBER := 0;
begin
  
  FOR V_REC IN (select * from scott.emp@DBL01) loop
    
    V_FILA := V_FILA + 1;
    dbms_output.put_line('Filas ' || V_FILA || ': ' || v_rec.ename);
  
  end loop;

end;







