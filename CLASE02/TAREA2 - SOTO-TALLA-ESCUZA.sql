
DECLARE
	-- Definimos los tipo de datos
	TYPE TABLA_MOVIMIENTO IS TABLE OF EUREKA.MOVIMIENTO%ROWTYPE;--RECURSOS.EMPLEADO%ROWTYPE;
	-- Definiendo las variables
	V_MOVIMIENTO TABLA_MOVIMIENTO;
BEGIN

  -- LLENA LA TABLA ANIDADA
	V_MOVIMIENTO := TABLA_MOVIMIENTO();
	DBMS_OUTPUT.PUT_LINE('TAMAÑO INICIAL: ' || V_MOVIMIENTO.COUNT);
	FOR REC IN (SELECT * FROM  EUREKA.MOVIMIENTO) LOOP
		V_MOVIMIENTO.EXTEND;
		V_MOVIMIENTO(V_MOVIMIENTO.LAST) := REC;
	END LOOP;
  
  -- MUESTRA LA TABALA
	DBMS_OUTPUT.PUT_LINE('TAMAÑO FINAL: ' || V_MOVIMIENTO.COUNT);
	FOR I IN V_MOVIMIENTO.FIRST..V_MOVIMIENTO.LAST LOOP
		DBMS_OUTPUT.PUT_LINE( I || '.- ' || V_MOVIMIENTO(I).CHR_CUENCODIGO
      || ' ' || V_MOVIMIENTO(I).DTT_MOVIFECHA || ' ' ||V_MOVIMIENTO(I).DEC_MOVIIMPORTE);
	END LOOP;

END;