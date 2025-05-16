
--
-- Script que acesso o banco de dados Oracle
-- e retorna o valor total de vendas durante o ano corrente
--
SET SERVEROUTPUT ON;
DECLARE
    V_VL_TOTAL_VENDAS 		NUMBER;

	-- Estabelecemos uma meta de R$ 10M por ano de vendas
	V_VL_META_ESTABELECIDA 	NUMBER := 10000000;
BEGIN
    -- CONSULTA SQL DIRETAMENTE NO PL/SQL
    SELECT SUM(VL_TOT_PEDIDO)
    INTO V_VL_TOTAL_VENDAS
    FROM  DB_PEDIDO
    WHERE EXTRACT(YEAR FROM DT_PEDIDO) = EXTRACT(YEAR FROM SYSDATE);

    -- CRIANDO UM DESVIO DE FLUXO CASO O VALOR TOTAL DE VENDAS
	-- ULTRAPASSE OU NÃO O VALOR DA META ESTABELECIDA.
    IF V_VL_TOTAL_VENDAS > V_VL_META_ESTABELECIDA THEN
        DBMS_OUTPUT.PUT_LINE('VENDAS ACIMA DO ESPERADO PARA O ANO: ' || EXTRACT(YEAR FROM SYSDATE) );
    ELSE
        DBMS_OUTPUT.PUT_LINE('VENDAS ABAIXO DO ESPERADO PARA O ANO: ' || EXTRACT(YEAR FROM SYSDATE) );
    END IF;
END;


--==================================================================================================================

-- Script que acesso o banco de dados Oracle
-- e retorna o valor médio de vendas durante o ano corrente
-- PARA DETERMINADO CLIENTE
SET SERVEROUTPUT ON;
DECLARE
	V_NR_CLIENTE DB_CLIENTE.NR_CLIENTE%TYPE;

    V_VL_TOTAL_MEDIA_VENDAS 		NUMBER;

BEGIN

	V_NR_CLIENTE := &Informe_o_codigo_do_cliente;

    -- CONSULTA SQL DIRETAMENTE NO PL/SQL
	-- A média será arredondada para 2 casas decimais.
	--
    SELECT ROUND(AVG(VL_TOT_PEDIDO),2)
    INTO V_VL_TOTAL_MEDIA_VENDAS
    FROM  DB_PEDIDO
    WHERE EXTRACT(YEAR FROM DT_PEDIDO) = EXTRACT(YEAR FROM SYSDATE)
	AND	NR_CLIENTE = V_NR_CLIENTE;

	UPDATE DB_CLIENTE SET VL_MEDIO_COMPRA = V_VL_TOTAL_MEDIA_VENDAS
	WHERE NR_CLIENTE = V_NR_CLIENTE;

	-- Confirma a transação
	COMMIT;

    DBMS_OUTPUT.PUT_LINE('VALOR MEDIO DE COMPRAS DO CLIENTE(' || V_NR_CLIENTE || ') PARA O ANO: ' || EXTRACT(YEAR FROM SYSDATE) || ' FOI DE R$' || V_VL_TOTAL_MEDIA_VENDAS );

END;

--============================================================================
--
-- Script que evidencia o conceito de ROLLBACK
-- e preserva os dados anteriores.
-- PARA DETERMINADO CLIENTE
--
SET SERVEROUTPUT ON;
DECLARE
	V_NR_CLIENTE DB_CLIENTE.NR_CLIENTE%TYPE;

BEGIN

	V_NR_CLIENTE := &Informe_o_codigo_do_cliente;

	UPDATE DB_CLIENTE SET VL_MEDIO_COMPRA = 999999
	WHERE NR_CLIENTE = V_NR_CLIENTE;

	-- NÃO Confirma a transação
	ROLLBACK;

    DBMS_OUTPUT.PUT_LINE('Transação não confirmada!');

END;
/


SELECT * FROM DB_CLIENTE WHERE NR_CLIENTE = 10;















