
-- Tipos de Dados
SET SERVEROUTPUT ON;
DECLARE
    v_nr_nota_satisfacao NUMBER(2);
    v_nr_loja db_loja.nr_loja%type;
BEGIN
    V_NR_NOTA_SATISFACAO := 09;
    V_NR_LOJA := 37;

    dbms_output.put_line('A loja ' || v_nr_loja ||
    ' recomendou a seguinte nota de satisfacao de entrega: ' || v_nr_nota_satisfacao);
END;
/


-- O script abaixo crie 2 variáveis e atribui valores a essas variáveis.
-- Após isso, os respectivos conteúdos são exibidos
SET SERVEROUTPUT ON;
DECLARE
    v_nr_idade_media_cliente NUMBER(3) := 57;
    v_nr_loja db_loja.nr_loja%type := 00;
BEGIN
    dbms_output.put_line('A idade média do cliente da loja(' 
    || v_nr_loja || ')' || ' é: ' || v_nr_idade_media_cliente);
END;
/


