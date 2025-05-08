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
    	dbms_output.put_line(‘O conteúdo da variável v_data é: ‘ || v_data);
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






