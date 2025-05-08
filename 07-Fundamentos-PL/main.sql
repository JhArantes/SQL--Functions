'''
DECLARE

BEGIN


END;
'''

--
-- habilita 10.000 caracteres para serem exibidos como saída de dados
--
set serveroutput on size 10000;

declare
v_nr_nota_satisfacao number(2);
    	V_NM_CLIENTE VARCHAR2(30);
begin
	V_NR_NOTA_SATISFACAO := 9;
    	v_nm_cliente := 'Oivlas Sakspildap';
	
dbms_output.put_line('O cliente ' || v_NM_CLIENTE || 
    	' recomendou a seguinte nota de satisfacao de entrega: ' || V_NR_nota_satisfacao);
end;
/


SET SERVEROUTPUT ON;
declare
	/* Nesse início de processamento vamos 
	criar uma variável que irá receber a data e hora do sistema
	*/
	v_data date; /* A variável v_data será do tipo date */
begin
	select sysdate into v_data from dual; 
    	dbms_output.put_line('O conteúdo da variável v_data é:'  || v_data);
end;
/


DECLARE
    cursor cfechamento is SELECT * FROM DB_PEDIDO WHERE NR_PEDIDO = 0;
    rec_fechamento cfechamento%rowtype;
BEGIN

OPEN cfechamento;
/* O cursor abaixo tem como objetivo receber e processar
   os dados do pedido número 0 do projeto DBurger.
   Por questão de debug deixamos de realizar o processamento devido aos    
   comentários de multiplas linhas.
    	LOOP
        FETCH cfechamento INTO rec_fechamento;
        EXIT WHEN cfechamento%NOTFOUND;
    	END LOOP;
*/
    CLOSE cfechamento;
END;
/



-- Declarações

DECLARE
	v_tipo_sanguineo varchar2(3) := 'AB+';
BEGIN
	dbms_output.put_line('O tipo sanguíneo atual é: ' || v_tipo_sanguineo);
END;
/

-- NOT NULL
DECLARE
	v_nr_nota POSITIVEN NOT NULL := 5; -- declara variável com conteúdo obrigatório.
BEGIN
	dbms_output.put_line('A nota atual do aluno é: ' || v_nr_nota);
END;
/

-- NOT NULL

DECLARE
	v_nr_nota POSITIVEN NOT NULL := 5; -- declara variável com conteúdo obrigatório.
BEGIN
	dbms_output.put_line('A nota atual do aluno é: ' || v_nr_nota);
END;
/




-- %Type
-- O %Type criar erança de tipos de dados entre variáveis e colunas de tabelas.

DECLARE
	v_vl_credito REAL(7);
	v_vl_debito  v_vl_credito%type;
	v_qt_estrelas db_cliente.qt_estrelas%type;
BEGIN
	v_qt_estrelas := 5;
END;
/

-- cria uma tabela de exemplo
create table t_dim_tempo
( dt_evento date primary key,
  nr_dia_semana number(1),
  nm_dia_semana varchar2(20),
  nm_mes_extenso varchar2(20)
  );
-- insere uma linha de exemplo
insert into t_dim_tempo(dt_evento, nr_dia_semana, nm_dia_semana, nm_mes_extenso) values (sysdate, to_char(sysdate,'d'), to_char(sysdate,'day'), to_char(sysdate,',month'));

SET SERVEROUTPUT ON;
-- Agora vamos acessar dados da tabela criada.
DECLARE
	v_dt_evento t_dim_tempo.dt_evento%TYPE;
BEGIN
	SELECT 	dt_evento
	INTO	v_dt_evento
	FROM	t_dim_tempo
	where	trunc(dt_evento) = trunc(sysdate);
	
	dbms_output.put_line('A data do evento: ' || v_dt_evento);
END;
/


-- %Rowtype
-- O %Rowtype cria uma variável que herda o tipo de dados de uma linha inteira de uma tabela.

SET SERVEROUTPUT ON;
-- Caso a tabela t_dim_tempo não esteja criada, utilize o codigo fonte 16 para realizar essa tarefa
-- Inclui uma nova linha na tabela t_dim_tempo
insert into t_dim_tempo(dt_evento, nr_dia_semana, nm_dia_semana, nm_mes_extenso) values (sysdate+1, to_char(sysdate+1,'d'), to_char(sysdate+1,'day'), to_char(sysdate+1,',month'));
commit;

DECLARE
	rec_dim_tempo t_dim_tempo%ROWTYPE;
	CURSOR c1 IS SELECT * FROM t_dim_tempo;
BEGIN
	OPEN c1;
	LOOP
	   FETCH c1 into rec_dim_tempo;
	   EXIT WHEN c1%NOTFOUND;
        dbms_output.put_line('A data do evento: ' || rec_dim_tempo.dt_evento);
	END LOOP;
	CLOSE c1;
END;	
/


-- Escopo e Visibilidade de Variáveis
-- O escopo de uma variável é o local onde ela pode ser acessada.
-- A visibilidade de uma variável é o local onde ela pode ser vista.
-- O escopo e a visibilidade de uma variável são definidos pelo bloco onde ela é declarada.




-- Cria as variáveis para serem utilizadas no algoritmo.
DECLARE
	v_dt_evento t_dim_tempo.dt_evento%TYPE;
	v_nr_dia_semana t_dim_tempo.nr_dia_semana%TYPE;
	v_ds_dia_semana varchar2(20);
BEGIN
	-- Carrega as variáveis data do evento e número do dia da semana
-- a partir dos dados existentes na tabela T_DIM_TEMPO
	SELECT 	dt_evento, nr_dia_semana
	INTO	v_dt_evento, v_nr_dia_semana
	FROM	t_dim_tempo
	where	trunc(dt_evento) = trunc(sysdate);
	
	v_ds_dia_semana :=
		CASE WHEN nr_dia_semana = 1 THEN 'Domingo'
			 WHEN nr_dia_semana = 2 THEN 'Segunda-feira'
			 WHEN nr_dia_semana = 3 THEN 'Terça-feira'
			 WHEN nr_dia_semana = 4 THEN 'Quarta-feira'
			 WHEN nr_dia_semana = 5 THEN 'Quinta-feira'
			 WHEN nr_dia_semana = 6 THEN 'Sexta-feira'
			 WHEN nr_dia_semana = 7 THEN 'Sábado'
		ELSE 'Dia da semana inválido'
		END;
		
	dbms_output.put_line('A data do evento: ' || v_dt_evento  || 
	' e o dia da semana é: ' || v_ds_dia_semana );
END;
/



-- Exibe a forma de pagamento mais utilizada do cliente a partir de seu código
select  fp.ds_forma_pagto, count(*) qtd_utilizadas
from    db_forma_pagamento fp inner join db_pedido p
on (fp.cd_forma_pagto = p.cd_forma_pagto)
where   p.nr_cliente = &informe_numero_cliente
group by fp.ds_forma_pagto
order by 2 desc
fetch  first 1 rows only;
/


SET SERVEROUTPUT ON;
SET SERVEROUTPUT ON;
DECLARE
	v_nr_cliente db_pedido.nr_cliente%type;
	v_ds_forma_pagto db_forma_pagamento.ds_forma_pagto%type;
	v_qt_vezes_utilizada INTEGER := 00;
BEGIN
    v_nr_cliente := '&informe_numero_cliente';
	/* 	Vamos aproveitar a instrução SQL anterior e adaptá-la para uso no PL/SQL.
		Perceba que a claúsula INTO foi criada para receber o conteúdo da instrução SQL.
	*/
	-- Exibe a forma de pagamento mais utilizada do cliente a partir de seu código
	select  fp.ds_forma_pagto, count(*) qtd_utilizadas
	into	v_ds_forma_pagto, v_qt_vezes_utilizada
	from    db_forma_pagamento fp inner join db_pedido p
	on (fp.cd_forma_pagto = p.cd_forma_pagto)
	where   p.nr_cliente = v_nr_cliente
	group by fp.ds_forma_pagto
	order by 2 desc
	fetch  first 1 rows only;
	-- Vamos exibir o resultado dos dados calculados.
	dbms_output.put_line('O cliente ' || v_nr_cliente || ' utilizou a forma de pagamento ' 
	|| v_ds_forma_pagto  || ' por ' || v_qt_vezes_utilizada ||  ' vezes.');
 END;
/




