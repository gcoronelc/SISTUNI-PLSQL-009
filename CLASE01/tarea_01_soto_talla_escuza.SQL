 create or replace function eureka.fn_nombre( 
  v_codigo  VARCHAR
)return varchar
is
v_nombre varchar(500);
begin 


select a.vch_emplnombre||' ' || a.vch_emplpaterno||' ' ||a.vch_emplmaterno 
into v_nombre 
from eureka.empleado a 
where a.chr_emplcodigo=v_codigo;
 
RETURN v_nombre;

end;
/


SELECT eureka.fn_nombre('0001' ) FROM DUAL;

