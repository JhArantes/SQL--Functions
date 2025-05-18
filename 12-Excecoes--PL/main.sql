
--========================================================================
-- Exceções

--
-- Script que aplica o conceito das exceções
-- ZERO_DIVIDE e OTHERS
SET SERVEROUTPUT ON;
DECLARE
	-- Variável que irá controlar quantas linhas foram manipuladas.
	V_CONTADOR_CURSOR NUMBER := 00;
BEGIN
	-- Perceba que estamos usando o FOR LOOP diretamente
	-- com um subconsulta, eliminando assim a necessidade
	-- de escrita comando CURSOR.
	FOR i IN (
		SELECT 	NR_CLIENTE,
			ROUND(AVG(VL_TOT_PEDIDO),2) VL_MEDIO_VENDAS
		FROM  	DB_PEDIDO
		WHERE 	EXTRACT(YEAR FROM DT_PEDIDO) = EXTRACT(YEAR FROM SYSDATE)
		GROUP 	BY NR_CLIENTE
			)
	LOOP
	 	-- Para cada cliente selecionado, atualizamos o seu respectivo
		-- valor médio de vendas, utilizando sua chave PK (primary key).
		UPDATE DB_CLIENTE SET VL_MEDIO_COMPRA = i.VL_MEDIO_VENDAS
		WHERE NR_CLIENTE = i.NR_CLIENTE;

		-- Para cada linha processada, acumulamos a quantidade de transações realizadas.
		V_CONTADOR_CURSOR := V_CONTADOR_CURSOR + SQL%ROWCOUNT;

		BEGIN
		   IF V_CONTADOR_CURSOR = 10 THEN
			-- Forçamos uma divisão por zero, correspondendo a um cálculo inválido,
			-- porém não ocorre erro pois temos um tratamento de exceção para isso.
			i.VL_MEDIO_VENDAS := i.VL_MEDIO_VENDAS / 0;
		   END IF;
		EXCEPTION
			-- Veja q exceção pré-definida ZERO_DIVIDE que trata da divisão por zero
            WHEN ZERO_DIVIDE THEN
                 DBMS_OUTPUT.PUT_LINE('Perceba que a exceção foi acionada para o cliente (' || i.NR_CLIENTE || ') e podemos tratar ' || CHR(10) || 'da maneira que quisermos, sem parar o processamento!');
			-- Veja a exceção OTHERS que trata de qualquer outra exceção que ainda não foi definida
			WHEN OTHERS THEN
		         DBMS_OUTPUT.PUT_LINE('Exceção crítica para o cliente (' || i.NR_CLIENTE || ') ' || SQLERRM);
		END;
	END LOOP;
	-- Atualizamos todas as transações pendentes.
	COMMIT;
	DBMS_OUTPUT.PUT_LINE('A quantidade de linhas processadas foram: ' || V_CONTADOR_CURSOR);
END;




-- Script que aplica o conceito da exceção
-- v_exception_status_cliente definida para o negócio.
SET SERVEROUTPUT ON;
DECLARE
	-- Essa variável irá receber o status do cliente
	V_ST_CLIENTE DB_CLIENTE.ST_CLIENTE%TYPE;

	v_exception_status_cliente EXCEPTION;
    PRAGMA EXCEPTION_INIT(v_exception_status_cliente, -20222);

BEGIN
	-- Perceba que estamos usando o FOR LOOP diretamente
	-- com um subconsulta, eliminando assim a necessidade
	-- de escrita comando CURSOR.
	FOR i IN (
				SELECT 	NR_CLIENTE,
						ROUND(AVG(VL_TOT_PEDIDO),2) VL_MEDIO_VENDAS
				FROM  	DB_PEDIDO
				WHERE 	EXTRACT(YEAR FROM DT_PEDIDO) = EXTRACT(YEAR FROM SYSDATE)
				GROUP 	BY NR_CLIENTE
				)
	LOOP

		BEGIN
			-- Para cada cliente selecionado, verificamos se o cliente está INATIVO
			-- em caso positivo, exibimos uma mensagem de aviso.
			SELECT ST_CLIENTE
			INTO	V_ST_CLIENTE
			FROM	DB_CLIENTE
			WHERE	NR_CLIENTE = i.NR_CLIENTE;

			IF V_ST_CLIENTE = 'I' or V_ST_CLIENTE IS NULL THEN
				  RAISE v_exception_status_cliente;

			END IF;
		EXCEPTION
			-- Exceção pré-definida pelo desenvolvedor
			-- para atender a uma regra de negócio.
			WHEN v_exception_status_cliente THEN
			 DBMS_OUTPUT.PUT_LINE('A exceção de negócio foi acionada para o cliente (' || i.NR_CLIENTE || ') e podemos tratar da maneira que quisermos, sem parar o processmaento!');
			-- Veja a exceção OTHERS que trata de qualquer outra exceção que ainda não foi definida
			WHEN OTHERS THEN
		         DBMS_OUTPUT.PUT_LINE('Exceção crítica para o cliente (' || i.NR_CLIENTE || ') ' || SQLERRM);
		END;

	END LOOP;

END;
/

















-- Script que aplica o conceito do procedimento
-- RAISE_APPLICATION_ERROR
SET SERVEROUTPUT ON;
DECLARE
	-- Essa variável irá receber o status do cliente
	V_ST_CLIENTE DB_CLIENTE.ST_CLIENTE%TYPE;

BEGIN
	-- Perceba que estamos usando o FOR LOOP diretamente
	-- com um subconsulta, eliminando assim a necessidade
	-- de escrita comando CURSOR.
	FOR i IN (
		SELECT 	NR_CLIENTE,
				ROUND(AVG(VL_TOT_PEDIDO),2) VL_MEDIO_VENDAS
		FROM  		DB_PEDIDO
		WHERE 		EXTRACT(YEAR FROM DT_PEDIDO) = EXTRACT(YEAR FROM SYSDATE)
		GROUP 		BY NR_CLIENTE
				)
	LOOP

		BEGIN
		   -- Para cada cliente selecionado, verificamos se o cliente está INATIVO
		   -- em caso positivo, exibimos uma mensagem de aviso.
		   SELECT ST_CLIENTE
		   INTO	V_ST_CLIENTE
		   FROM	DB_CLIENTE
		   WHERE	NR_CLIENTE = i.NR_CLIENTE;

		   IF V_ST_CLIENTE = 'I' or V_ST_CLIENTE IS NULL THEN
			  RAISE_APPLICATION_ERROR( -20157, 'Erro crítico pois existe o cliente (' || i.NR_CLIENTE || ') está com o status ( ' || V_ST_CLIENTE || ') =>' || SQLERRM);
		   END IF;

		END;

	END LOOP;

END;
/










-- Script que aplica o conceito das funções
-- SQLCODE e SQLERRM
SET SERVEROUTPUT ON;
DECLARE
	-- Variável que irá controlar quantas linhas foram manipuladas.
	V_CONTADOR_CURSOR NUMBER := 00;
	V_SQL_CODIGO_ERRO   NUMBER;
	V_SQL_MENSAGEM_ERRO VARCHAR2(4000);
BEGIN
	-- Perceba que estamos usando o FOR LOOP diretamente
	-- com um subconsulta, eliminando assim a necessidade
	-- de escrita comando CURSOR.
	FOR i IN (
		SELECT 	NR_CLIENTE,
				ROUND(AVG(VL_TOT_PEDIDO),2) VL_MEDIO_VENDAS
		FROM  	DB_PEDIDO
		WHERE 	EXTRACT(YEAR FROM DT_PEDIDO) = EXTRACT(YEAR FROM SYSDATE)
		GROUP 	BY NR_CLIENTE
		)
	LOOP
	 	-- Para cada cliente selecionado, atualizamos o seu respectivo
		-- valor médio de vendas, utilizando como chave o número do cliente.
		UPDATE DB_CLIENTE SET VL_MEDIO_COMPRA = i.VL_MEDIO_VENDAS
		WHERE NR_CLIENTE = i.NR_CLIENTE;

		-- A cada linha processada, acumulamos o valor na variavel v_contador_cursor.
		V_CONTADOR_CURSOR := V_CONTADOR_CURSOR + SQL%ROWCOUNT;

		BEGIN

            i.VL_MEDIO_VENDAS := i.VL_MEDIO_VENDAS ** 999999999999999999999999999999999999999999999999999;
            DBMS_OUTPUT.PUT_LINE ( I.VL_MEDIO_VENDAS);

		EXCEPTION
			-- Veja q exceção pré-definida ZERO_DIVIDE que trata da divisão por zero
            WHEN ZERO_DIVIDE THEN
                 DBMS_OUTPUT.PUT_LINE('Perceba que a exceção foi acionada para o cliente (' || i.NR_CLIENTE || ') e podemos tratar da maneira que quisermos, sem parar o processamento!');
			-- Veja a exceção OTHERS que trata de qualquer outra exceção que ainda não foi definida
			WHEN OTHERS THEN
				V_SQL_CODIGO_ERRO := SQLCODE;
				V_SQL_MENSAGEM_ERRO := SQLERRM;
		         DBMS_OUTPUT.PUT_LINE(	'Exceção crítica para o cliente (' || i.NR_CLIENTE || ') ' ||
										V_SQL_CODIGO_ERRO || ' * ' || V_SQL_MENSAGEM_ERRO);
		END;
	END LOOP;

END;
/