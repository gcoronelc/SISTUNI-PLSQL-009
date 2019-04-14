CREATE OR REPLACE FUNCTION eureka.FN_descemp(
  p_scodigo in varchar2
)return varchar2
is
v_apenom varchar2(300);
 begin
 --proceso
 select vch_cliepaterno||' '||vch_cliematerno||' '||vch_clienombre 
 into v_apenom from  eureka.cliente 
 where chr_cliecodigo = p_scodigo;
  
 --Reporte
 return v_apenom;
 end;
 /
 
 
 SELECT eureka.FN_descemp('00001') FROM DUAL;
 
 