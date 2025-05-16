
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


--=====================================================================================
-- CUrsor

-- Script que acesso o banco de dados Oracle
-- e armazena no cursor  C_VALOR_TOTAL_MEDIA_VENDAS_CLIENTE
-- o valor médio de vendas durante o ano corrente
-- para todos os clientes da DBurger
SET SERVEROUTPUT ON;

DECLARE
CURSOR C_VALOR_TOTAL_MEDIA_VENDAS_CLIENTE IS
    	SELECT NR_CLIENTE, ROUND(AVG(VL_TOT_PEDIDO),2)
    	FROM 	DB_PEDIDO
    	WHERE EXTRACT(YEAR FROM DT_PEDIDO) = EXTRACT(YEAR FROM SYSDATE)
	GROUP BY NR_CLIENTE;

BEGIN
	NULL; -- Comando utilizado para validar a sintaxe do bloco begin
END;

-- Script que acessa o banco de dados Oracle
-- e armazena no cursor  C_VALOR_TOTAL_MEDIA_VENDAS_CLIENTE
-- o valor médio de vendas durante o ano corrente
-- para todos os clientes da DBurger, depois disso
-- abrimos e fechamos o cursor.
SET SERVEROUTPUT ON;

DECLARE


	CURSOR C_VALOR_TOTAL_MEDIA_VENDAS_CLIENTE IS
    SELECT NR_CLIENTE, ROUND(AVG(VL_TOT_PEDIDO),2)
    FROM  DB_PEDIDO
    WHERE EXTRACT(YEAR FROM DT_PEDIDO) = EXTRACT(YEAR FROM SYSDATE)
	GROUP BY NR_CLIENTE;

BEGIN
	OPEN C_VALOR_TOTAL_MEDIA_VENDAS_CLIENTE;
	-- Em breve vamos inserir as regras de negócio para realizar
	-- o processamento

	-- Fechamos o cursor para não deixa-lo aberto na memória do SGBD,
	-- evitando assim existir áreas de memórias inconsistentes.
	CLOSE C_VALOR_TOTAL_MEDIA_VENDAS_CLIENTE;

END;





-- Script que trabalha com o conceito do atributo de cursor %FOUND
--
SET SERVEROUTPUT ON;

DECLARE
    CURSOR C_VALOR_TOTAL_MEDIA_VENDAS_CLIENTE IS
        SELECT NR_CLIENTE, ROUND(AVG(VL_TOT_PEDIDO), 2) VL_MEDIO_VENDAS
        FROM DB_PEDIDO
        WHERE EXTRACT(YEAR FROM DT_PEDIDO) = EXTRACT(YEAR FROM SYSDATE)
        GROUP BY NR_CLIENTE;

    -- Variável que será usada para armazenar os dados recuperados pelo cursor
    VC_VALOR_TOTAL_VENDAS_CLIENTE C_VALOR_TOTAL_MEDIA_VENDAS_CLIENTE%ROWTYPE;

    -- Variável que irá controlar quantas linhas foram manipuladas
    V_CONTADOR_CURSOR NUMBER := 0;

BEGIN
    OPEN C_VALOR_TOTAL_MEDIA_VENDAS_CLIENTE;

    -- Inicia o loop de processamento
    LOOP
        FETCH C_VALOR_TOTAL_MEDIA_VENDAS_CLIENTE INTO VC_VALOR_TOTAL_VENDAS_CLIENTE;

        -- Verifica se o cursor trouxe um registro (usando %FOUND)
        IF C_VALOR_TOTAL_MEDIA_VENDAS_CLIENTE%FOUND THEN
            -- Para cada cliente selecionado, atualizamos o seu respectivo valor médio de vendas
            UPDATE DB_CLIENTE
            SET VL_MEDIO_COMPRA = VC_VALOR_TOTAL_VENDAS_CLIENTE.VL_MEDIO_VENDAS
            WHERE NR_CLIENTE = VC_VALOR_TOTAL_VENDAS_CLIENTE.NR_CLIENTE;

            -- A cada linha processada, acumulamos o valor na variável V_CONTADOR_CURSOR
            V_CONTADOR_CURSOR := V_CONTADOR_CURSOR + 1;
        ELSE
            -- Caso não tenha registros, sai do loop
            EXIT;
        END IF;
    END LOOP;

    -- Fechamos o cursor para liberar a memória
    CLOSE C_VALOR_TOTAL_MEDIA_VENDAS_CLIENTE;

    -- Atualizamos todas as transações pendentes
    COMMIT;

    -- Exibe o número de linhas processadas
    DBMS_OUTPUT.PUT_LINE('A quantidade de linhas processadas foram: ' || V_CONTADOR_CURSOR);

END;




--========================================================================================================
-- Gerado por Oracle SQL Developer Data Modeler 22.2.0.165.1149
-- Elimina a tabela caso já exista cadastrada
DROP TABLE db_loja_resumo_venda_ano_mes CASCADE CONSTRAINTS;

-- Cria a tabela caso ainda não exista
CREATE TABLE db_loja_resumo_venda_ano_mes (
    nr_loja              NUMBER(5) NOT NULL,
    nr_ano               NUMBER(4) NOT NULL,
    nr_mes               NUMBER(2) NOT NULL,
    nm_loja              VARCHAR2(100) NOT NULL,
    vl_total_venda       NUMBER(10, 2) NOT NULL,
    vl_maior_venda_feita NUMBER(8, 2) NOT NULL,
    vl_menor_venda_feita NUMBER(8, 2) NOT NULL,
    vl_medio_venda       NUMBER(8, 2)
);

-- Cria a chave PK para essa tabela
ALTER TABLE db_loja_resumo_venda_ano_mes
    ADD CONSTRAINT db_sk_loja_res_venda_ano_mes PRIMARY KEY ( nr_loja,
                                                              nr_ano,
                                                              nr_mes );

-- Antes de realizar o processamento, limpamos todos os dados da tabela.
TRUNCATE TABLE DB_LOJA_RESUMO_VENDA_ANO_MES;
SELECT * FROM DB_LOJA_RESUMO_VENDA_ANO_MES;

-- Script que faz a carga das vendas das lojas
-- agrupada por ano e mês.
--
SET SERVEROUTPUT ON;
DECLARE
	-- Cria variável que irá acumular a quantidade de linhas processadas.
	V_QT_LINHAS_PROCESSADAS NUMBER := 00;
BEGIN
FOR X IN (SELECT  L.NR_LOJA,
			L.NM_LOJA,
			EXTRACT( YEAR FROM P.DT_PEDIDO) ANO_VENDA,
			EXTRACT( MONTH FROM P.DT_PEDIDO) MES_VENDA,
			SUM(P.VL_TOT_PEDIDO) VL_TOTAL_VENDA
		FROM    DB_LOJA L INNER JOIN DB_PEDIDO P
		ON      (L.NR_LOJA = P.NR_lOJA)
		GROUP BY    L.NR_LOJA,
					L.NM_LOJA,
					EXTRACT( YEAR FROM P.DT_PEDIDO),
					EXTRACT( MONTH FROM P.DT_PEDIDO)
			)
LOOP
	BEGIN
	   INSERT INTO DB_LOJA_RESUMO_VENDA_ANO_MES (
	   NR_LOJA,NR_ANO, NR_MES,	NM_LOJA, VL_TOTAL_VENDA,
	   VL_MAIOR_VENDA_FEITA, VL_MENOR_VENDA_FEITA,	VL_MEDIO_VENDA
         )
	   VALUES (
	   X.NR_LOJA, X.ANO_VENDA, X.MES_VENDA,X.NM_LOJA, X.VL_TOTAL_VENDA,
	   0, 0, 0
	   );

	   -- Armazena a quantidade todal de transações pendentes,
	   -- Usando o atributo do cursor implícito SQL%ROWCOUNT
	   V_QT_LINHAS_PROCESSADAS := V_QT_LINHAS_PROCESSADAS + SQL%ROWCOUNT;

	EXCEPTION
		WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erro encontrado: ' || SQLErrM);
            ROLLBACK;
	END;
END LOOP;

	DBMS_OUTPUT.PUT_LINE('Quantidade de linhas processadas: ' || V_QT_LINHAS_PROCESSADAS);
	-- Após o final do processamento, se tudo ocorreu bem,
	-- confirmar as transações pendentes.
	COMMIT;
END;
/

















