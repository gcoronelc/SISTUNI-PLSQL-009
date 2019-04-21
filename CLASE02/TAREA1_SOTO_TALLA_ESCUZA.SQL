
create or replace function EUREKA.F_FACTORIAL_ESP (facto number) return number
is

   factorial number:=1;
   contador number := facto;

begin

  loop
    factorial:=factorial*contador;
    contador:=contador-1;
    exit when(contador=0);
  end loop;

  return factorial;
end;



SELECT EUREKA.F_FACTORIAL_ESP(5) FACTORIAL FROM DUAL;

