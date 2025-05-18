
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