
SELECT * FROM DB_LOJA;
SELECT * FROM DB_CATEGORIA_PROD;
SELECT * FROM DB_PRODUTO;



SELECT 	CP.CD_CATEGORIA_PROD, 
	CP.DS_CATEGORIA_PROD, 
	SC.CD_SUB_CATEGORIA_PROD, 
	SC.DS_SUB_CATEGORIA_PROD,
	PR.DS_PRODUTO, 
	PR.VL_UNITARIO, 
	PR.TP_EMBALAGEM, 
	PR.ST_PRODUTO, 
	PR.VL_PERC_LUCRO
FROM	DB_CATEGORIA_PROD CP INNER JOIN DB_SUB_CATEGORIA_PROD SC
ON (CP.CD_CATEGORIA_PROD = SC.CD_CATEGORIA_PROD) INNER JOIN DB_PRODUTO PR
ON (SC.CD_SUB_CATEGORIA_PROD = PR.CD_SUB_CATEGORIA_PROD)
WHERE CP.CD_CATEGORIA_PROD = 2
ORDER BY CP.CD_CATEGORIA_PROD, SC.CD_SUB_CATEGORIA_PROD, PR.DS_PRODUTO;

SELECT
    c.NR_CLIENTE,
    C.NM_CLIENTE,
    C.QT_ESTRELAS,
    CF.DT_NASCIMENTO,
    CF.FL_SEXO_BIOLOGICO,
    CF.NR_CPF
FROM DB_CLIENTE C INNER JOIN DB_CLI_FISICA CF
ON (C.NR_CLIENTE = CF.NR_CLIENTE)
WHERE C.QT_ESTRELAS >= 4 AND CF.FL_SEXO_BIOLOGICO = 'F'


SELECT  E.SG_ESTADO,
        E.NM_ESTADO,
        C.NM_CIDADE,
        B.NM_BAIRRO,
        L.NM_LOGRADOURO,
        L.NR_CEP
FROM    DB_ESTADO E INNER JOIN DB_CIDADE C
ON      (E.SG_ESTADO = C.SG_ESTADO) INNER JOIN DB_BAIRRO B
ON      (C.CD_CIDADE = B.CD_CIDADE) INNER JOIN DB_LOGRADOURO L
ON      (B.CD_BAIRRO = L.CD_BAIRRO)
WHERE   E.SG_ESTADO = 'MG'
ORDER BY E.SG_ESTADO;


SELECT  L.NR_LOJA,
        L.NM_LOJA,
        FL.NR_MATRICULA_FUNC_LOJA MATRICULA_FUNC,
        F.NM_FUNCIONARIO,
        D.NM_DEPTO,
        C.DS_CARGO CARGO_FUNCIONARIO,
        FG.NM_FUNCIONARIO NOME_FUNCIONARIO_GESTOR
FROM    DB_LOJA L INNER JOIN DB_FUNC_LOJA FL
ON      (L.NR_LOJA = FL.NR_LOJA) INNER JOIN DB_FUNCIONARIO F
ON      (FL.NR_MATRICULA_FUNC = F.NR_MATRICULA_FUNC) INNER JOIN DB_DEPTO D
ON      (FL.CD_DEPTO = D.CD_DEPTO) INNER JOIN DB_CARGO C
ON      (FL.CD_CARGO = C.CD_CARGO) LEFT JOIN DB_FUNCIONARIO FG
ON      (FG.NR_MATRICULA_FUNC = FL.NR_MATRICULA_FUNC_GESTOR)
WHERE   L.NR_LOJA = 94
ORDER BY L.NR_LOJA;

# PL/SQL
'''
Poderosa estenção da lingaugem SQL
e com ela é possivel criar inumeras 
logicas de programação, como:
- Estruturas de repetição (loop, for, while)
- Estruturas de decisão (if, case)
- Variaveis (inteiro, string, data, booleano)
- Estruturas de controle (Try, exception)
- Funções e procedimentos (criação de funções e procedimentos)

Ela é uma linguagem procedural, ou seja,
ela é executada passo a passo, linha a linha.

'''

SET SERVEROUTPUT ON;
DECLARE
    v_mensagem VARCHAR2(60);
    v_tipo_cliente VARCHAR2(30);
BEGIN 
    v_tipo_cliente := '3 Estrelas';

    if v_tipo_cliente = 'VIP' then
        v_mensagem := 'Olá, Cliente VIP!';
    else
        v_mensagem := 'Olá, Cliente Comum!';
    end if;


    DBMS_OUTPUT.PUT_LINE(v_mensagem);
END;


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