
declare
  v_sql varchar2(2000);
begin

  v_sql := 'create table scott.algo( dato varchar2(100) )';
  execute immediate v_sql;

end;

-------------------------------------------------------------------

create or replace procedure scott.dml_execute( p_sql varchar2 )
is
begin
  execute immediate p_sql;
end;


declare
  v_sql varchar2(2000);
begin

  v_sql := 'create table scott.algo( dato varchar2(100) )';
  scott.dml_execute( v_sql );

end;
