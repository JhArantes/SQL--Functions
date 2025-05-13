
-- Estruturas de Controle


-- IF THEN ELSE

-- A instru��o SQL abaixo exibe os dados da loja, valor do sal�rio bruto 
-- e valor atual do percentual de comiss�o do funcion�rio 101.
select  nr_matricula_func_loja,
        nr_loja,
        vl_salario_bruto,
        vl_perc_comissao
from    db_func_loja 
where   nr_matricula_func_loja = 101;


-- O script abaixo calcula o valor do ticket m�dio de venda de um 
-- determinado funcion�rio e se o valor for maior do que R$ 330, 
-- adiciona 5% a mais no percentual atual. 
DECLARE
    v_nr_matricula_func_atd     db_pedido.nr_matricula_func_atd%type;
    v_vl_ticket_medio           db_pedido.vl_tot_pedido%type;
BEGIN
    v_nr_matricula_func_atd := &informe_nr_funcionario_loja;
    SELECT  ROUND( AVG(vl_tot_pedido),2)
    INTO    v_vl_ticket_medio
    FROM    db_pedido
    where   to_char(dt_pedido, 'yyyy') = to_char(sysdate, 'yyyy')
    and     nr_matricula_func_atd = v_nr_matricula_func_atd;
    -- Se o valor do ticket m�dio de venda feito pelo funcionario
    -- for maior do que R$ 330, adicionamos um b�nus de 5% a mais na comiss�o atual do funcion�rio.
    IF v_vl_ticket_medio > 330 then
        update db_func_loja set vl_perc_comissao = vl_perc_comissao + 5
        where nr_matricula_func_loja = v_nr_matricula_func_atd;
        commit;
    END IF;
END;
/


-- O script abaixo calcula o valor do ticket m�dio de venda de um 
-- determinado funcion�rio e se o valor for maior do que R$ 550, 
-- adiciona 5% a mais no percentual atual. Em caso negativo, diminui 2%

DECLARE
    v_nr_matricula_func_atd     db_pedido.nr_matricula_func_atd%type;
    v_vl_ticket_medio           db_pedido.vl_tot_pedido%type;
	v_vl_perc_comissao			number(1);
BEGIN
    v_nr_matricula_func_atd := &informe_nr_funcionario_loja;
    SELECT  ROUND( AVG(vl_tot_pedido),2)
    INTO    v_vl_ticket_medio
    FROM    db_pedido
    where   to_char(dt_pedido, 'yyyy') = to_char(sysdate, 'yyyy')
    and     nr_matricula_func_atd = v_nr_matricula_func_atd;
    -- Se o valor do ticket m�dio de venda feito pelo funcionario
    -- for maior do que R$ 550, adicionamos um b�nus de 5% a mais na comiss�o atual do funcion�rio.
	-- Caso contrario diminu�mos 2%
    IF v_vl_ticket_medio > 550 then
		v_vl_perc_comissao := 5;
	ELSE
		v_vl_perc_comissao := -2;
	END IF;
	-- comando que adiciona ou diminui o % do valor da comiss�o do funcion�rio.
    update db_func_loja set vl_perc_comissao = vl_perc_comissao + v_vl_perc_comissao
    where nr_matricula_func_loja = v_nr_matricula_func_atd;
    commit;    
END; 
/



-- O script abaixo calcula o valor do ticket médio de venda de um 
-- determinado funcionário e se o valor for maior do que R$ 350, 
-- adiciona 5% a mais no percentual atual. Em caso negativo, o novo 
-- valor de comissão será gerado de acordo com o ticket médio de venda.
DECLARE
    v_nr_matricula_func_atd     db_pedido.nr_matricula_func_atd%type;
    v_vl_ticket_medio           db_pedido.vl_tot_pedido%type;
	v_vl_perc_comissao			number(1);
BEGIN
    v_nr_matricula_func_atd := &informe_nr_funcionario_loja;
    SELECT  ROUND( AVG(vl_tot_pedido),2)
    INTO    v_vl_ticket_medio
    FROM    db_pedido
    where   to_char(dt_pedido, 'yyyy') = to_char(sysdate, 'yyyy')
    and     nr_matricula_func_atd = v_nr_matricula_func_atd;
    -- Se o valor do ticket médio de venda feito pelo funcionario
    -- for maior do que R$ 350, adicionamos um bônus de 5% a mais na comissão atual do funcionário.
	-- Caso contrario vamos diminuindo o % de comissão conforme o ticket médio vai caindo.
    IF v_vl_ticket_medio > 350 THEN
		v_vl_perc_comissao := 5;
	ELSIF v_vl_ticket_medio > 320 THEN
		v_vl_perc_comissao := 3;
	ELSIF v_vl_ticket_medio > 315 THEN
		v_vl_perc_comissao := 1;
	ELSE
		v_vl_perc_comissao := -2;
    END IF;
	-- comando que adiciona ou diminui o % do valor da comissão do funcionário.
    update db_func_loja set vl_perc_comissao = vl_perc_comissao + v_vl_perc_comissao
    where nr_matricula_func_loja = v_nr_matricula_func_atd;
    commit;
    
END;
/

-- Case

SET SERVEROUTPUT ON;
DECLARE
	V_NOTA_FINAL CHAR(1) := 'B';
BEGIN
	CASE V_NOTA_FINAL
		WHEN 'A' THEN DBMS_OUTPUT.PUT_LINE('EXCELENTE');
		WHEN 'B' THEN DBMS_OUTPUT.PUT_LINE('MUITO BOM...');
		WHEN 'C' THEN DBMS_OUTPUT.PUT_LINE('BOM');
		WHEN 'D' THEN DBMS_OUTPUT.PUT_LINE('INSUFICIENTE');
		WHEN 'F' THEN DBMS_OUTPUT.PUT_LINE('REPROVADO');
	ELSE 
		DBMS_OUTPUT.PUT_LINE('FORA DA FAIXA...!');
	END CASE;
END;
/

--=======================================================================
-- Loops
---------------------------------------------------------------------------------

-- A instrução SQL abaixo trata do tema LOOP simples em Oracle PL/SQL.
SET SERVEROUTPUT ON;
DECLARE
	V_CONTADOR NUMBER(1) := 00;
BEGIN
	LOOP
		V_CONTADOR := V_CONTADOR + 1;
		DBMS_OUTPUT.PUT_LINE('CONTADOR NÚMERO(' || V_CONTADOR || ')' );
		-- SE O VALOR DO CONTADOR ULTRAPASSAR O NÚMERO 6, O PROCESSAMENTO SE ENCERRA.
		IF V_CONTADOR > 6 THEN
			EXIT;
		END IF;
	END LOOP;
	DBMS_OUTPUT.PUT_LINE('SAÍMOS DO LOOP => CONTADOR NÚMERO(' || V_CONTADOR || ')' );
END;
/

-- O script abaixo trabalha com a instrução WHILE LOOP
SET SERVEROUTPUT ON;
DECLARE
    V_CONTADOR PLS_INTEGER := 10;  -- INICIA O CONTADOR
BEGIN
    -- Enquanto o contador for menor ou igual a 10
    WHILE V_CONTADOR > 0 LOOP
		-- EXIBE O CONTEÚDO DO CONTADOR
        DBMS_OUTPUT.PUT_LINE('SEQUÊNCIA (' || V_CONTADOR || ')' );  
        V_CONTADOR := V_CONTADOR - 1;  -- REDUZINDO O VALOR DO CONTADOR
    END LOOP;
END;
/

