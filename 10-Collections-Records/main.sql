

--==========================================================================================
-- Varray 
-------------------------------------------------------------------------------------------------

SET SERVEROUTPUT ON;
DECLARE 

-- Criamos o tipo de dados DIA_SEMANA que ir� 
-- ser associado a vari�vel V_DIA_SEMANA.
TYPE DIA_SEMANA IS VARRAY(7) OF VARCHAR2(15);
V_DIA_SEMANA_EXTENSO DIA_SEMANA;
 
BEGIN

    V_DIA_SEMANA_EXTENSO  := DIA_SEMANA('Domingo','Segunda-feira','Terca-feira','Quarta-Feira','Quinta-Feira','Sexta-Feira','Sabado');

FOR X IN 1..7
LOOP
   	DBMS_OUTPUT.PUT_LINE( V_DIA_SEMANA_EXTENSO(X) );
END LOOP;

-- Sempre que possuir um valor entre 1 e 7 � poss�vel ter acesso ao dia da semana por extenso.
-- No exemplo abaixo pedimos para exibir o 5a dia da semana
DBMS_OUTPUT.PUT_LINE( 'Acesso ao dia da semana 5a feira: ' || V_DIA_SEMANA_EXTENSO(1) );
    
END;



--===========================================================================================
--  Tabelas Indexadas
-------------------------------------------------------------------------------------------------


SET SERVEROUTPUT ON
DECLARE

   TYPE rec_vendas_diaria_loja IS RECORD (
      nr_loja               NUMBER(5),
      nome_loja             VARCHAR2(100),
      data_venda            DATE,
      valor_total_vendas    NUMBER(8,2)
   );

  -- Tabela indexada baseada no RECORD
   TYPE atab_vendas_diaria_por_loja IS TABLE OF rec_vendas_diaria_loja INDEX BY PLS_INTEGER;
   array_vendas_diaria_loja atab_vendas_diaria_por_loja;

   -- vari�vel que ir� armazenar a linha atual
   v_linha_atual_array NUMBER;

BEGIN

   -- Populando dados fixos em uma estrutura PL/SQL Tables
   -- Loja n�mero 1 
   array_vendas_diaria_loja(1).nr_loja 		:= 1;
   array_vendas_diaria_loja(1).nome_loja	:= 'Loja DeLuxe DBurger Centro S�o Paulo';
   array_vendas_diaria_loja(1).data_venda 	:= SYSDATE; -- Armazena a data atual do sistema.
   array_vendas_diaria_loja(1).valor_total_vendas := 47654.32;

   -- Populando dados fixos em uma estrutura PL/SQL Tables
   -- Loja n�mero 11 
   array_vendas_diaria_loja(11).nr_loja 	:= 11;
   array_vendas_diaria_loja(11).nome_loja	:= 'Loja Premium DBurger Suzano';
   array_vendas_diaria_loja(11).data_venda 	:= SYSDATE; -- Armazena a data atual do sistema.
   array_vendas_diaria_loja(11).valor_total_vendas := 45301;   


   -- Populando dados fixos em uma estrutura PL/SQL Tables
   -- Loja n�mero 5 
   array_vendas_diaria_loja(5).nr_loja 		:= 5;
   array_vendas_diaria_loja(5).nome_loja	:= 'Loja Premium DBurger Florian�polis';
   array_vendas_diaria_loja(5).data_venda 	:= SYSDATE; -- Armazena a data atual do sistema.
   array_vendas_diaria_loja(5).valor_total_vendas := 32908;

   -- Vamos exibir os dados da loja de n�mero 11, que se encontra dentro
   -- estrutura PL/SQL Tables
   v_linha_atual_array := 11;
    
   -- Se a loja 11 estiver na PL/SQL Table vai entrar dentro do IF
   IF array_vendas_diaria_loja.EXISTS(11) THEN
	 
      DBMS_OUTPUT.PUT_LINE('Loja (' || array_vendas_diaria_loja(v_linha_atual_array).nr_loja 
      || '): ' || array_vendas_diaria_loja(v_linha_atual_array).nome_loja 
      || ', Data: ' || TO_CHAR(array_vendas_diaria_loja(v_linha_atual_array).data_venda, 'DD/MM')
      || ', Total Vendas: ' || array_vendas_diaria_loja(v_linha_atual_array).valor_total_vendas);
   ELSE
         DBMS_OUTPUT.PUT_LINE('A loja de n�mero 11 n�o est� cadastrada na PL/SQL Tables');
   END IF;

END;



--===========================================================================================
--   Nested Tables
-------------------------------------------------------------------------------------------------

-- O script abaixo apresenta como trabalhar com arrays 
-- PL/SQL Nested Tables
--
SET SERVEROUTPUT ON;

DECLARE
   -- Definindo um tipo para a Nested Table
   TYPE dados_vendas IS TABLE OF VARCHAR2(50);
   TYPE valores_vendas IS TABLE OF NUMBER;

   -- Declarando variáveis baseadas no tipo
   itens_vendidos dados_vendas;
   total_vendas valores_vendas;
BEGIN
   -- Inicializando as Nested Tables
   itens_vendidos := dados_vendas();
   total_vendas := valores_vendas();

   -- Populando dados
   itens_vendidos.EXTEND(3);
   total_vendas.EXTEND(3);

   itens_vendidos(1) := 'Cheeseburger';
   itens_vendidos(2) := 'Batata Frita';
   itens_vendidos(3) := 'Suco Laranja';

   total_vendas(1) := 500;
   total_vendas(2) := 300;
   total_vendas(3) := 700;

   -- Iterando pelos dados e exibindo-os
   FOR i IN 1..itens_vendidos.COUNT LOOP
      DBMS_OUTPUT.PUT_LINE('Item: ' || itens_vendidos(i) || 
                           ', Total de Vendas R$: ' || total_vendas(i));
   END LOOP;
END;



--===========================================================================================
--   Bulk Collect
-------------------------------------------------------------------------------------------------

SET SERVEROUTPUT ON;
DECLARE

	type rec_venda_forma_pagto is record
	( cd_forma_pagto 	 		db_forma_pagamento.cd_forma_pagto%type,
	  vl_ticket_medio_venda     db_forma_pagamento.vl_ticket_medio_vendas%type
	);

   -- Definindo uma Nested Table baseada no RECORD
   TYPE tof_forma_pagto IS TABLE OF rec_venda_forma_pagto;

   -- Variável do tipo array(a) para armazenar os dados coletados
	arec_venda_forma_pagto tof_forma_pagto;
	
BEGIN

   -- Coletando os valores médios de vendas agrupados por forma de pagamento
   SELECT CD_FORMA_PAGTO, 
          ROUND( AVG(VL_TOT_PEDIDO) ,2) vl_ticket_medio_vendas
   BULK COLLECT INTO arec_venda_forma_pagto
   FROM DB_PEDIDO
   GROUP BY CD_FORMA_PAGTO;

   -- Atualizando a tabela DB_FORMA_PAGAMENTO com os valores médios
   FORALL i IN 1..arec_venda_forma_pagto.COUNT

      UPDATE DB_FORMA_PAGAMENTO  
      SET 	vl_ticket_medio_vendas = arec_venda_forma_pagto(i).vl_ticket_medio_venda
	  WHERE CD_FORMA_PAGTO = arec_venda_forma_pagto(i).cd_forma_pagto;

   -- Exibindo mensagens para verificar a execução
   DBMS_OUTPUT.PUT_LINE('Atualizações concluídas com sucesso.');
   DBMS_OUTPUT.PUT_LINE('Formas de pagamento atualizadas: ' || arec_venda_forma_pagto.COUNT);

END;
/