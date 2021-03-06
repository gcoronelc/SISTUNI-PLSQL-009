CREATE OR REPLACE PROCEDURE LOGISTICA.SP_ACTSTK(
P_ID_TIENDA        IN LOGISTICA.STOCK_TIENDA.ID_TIENDA%TYPE,
P_ID_PRODUCTO        IN LOGISTICA.STOCK_TIENDA.ID_PRODUCTO%TYPE,
P_CANTIDAD        NUMBER
)AS
V_CONT NUMBER;
v_excep1 Exception;
BEGIN

SELECT ID_TIENDA
INTO V_CONT
FROM LOGISTICA.STOCK_TIENDA
WHERE ID_TIENDA   = P_ID_TIENDA
AND   ID_PRODUCTO = P_ID_PRODUCTO 
FOR UPDATE;

UPDATE LOGISTICA.STOCK_TIENDA
SET STOCKCANT = STOCKCANT + P_CANTIDAD
WHERE ID_TIENDA   = P_ID_TIENDA
AND   ID_PRODUCTO = P_ID_PRODUCTO ;

COMMIT;

--IF SQL%NOTFOUND THEN
--RAISE v_excep1;
--END IF;

EXCEPTION
WHEN NO_DATA_FOUND THEN
ROLLBACK; -- cancelar transacción
    raise_application_error(-20001,'TIENDA / PRODUCTO NO ENCONTRADO');

END;
/

