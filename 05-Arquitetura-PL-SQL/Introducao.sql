
--==================================================================
-- PL/SQL - Producial Language SQL
-- Its a programing language that is used to write code that runs on the Oracle database.
--====================================================================

-- Os codigos ficam em Blocos, que são delimitados por BEGIN e END.
-- Os blocos podem conter variáveis, loops, condicionais e exceções.
-- Os blocos podem ser aninhados, ou seja, um bloco pode conter outro bloco dentro dele.

SET SERVEROUTPUT ON;
DECLARE -- Declaração de variáveis
    v_mensagem varchar(20); -- Declara a variável

BEGIN -- Inicio do Bloco
    v_mensagem := 'Olá, mundo!'; -- Insere o valor
    DBMS_OUTPUT.PUT_LINE(v_mensagem); -- Exibe na saida
END; -- Final do Bloco
--==================================================================

-- Versão IF
SET SERVEROUTPUT ON;

DECLARE
    v_sexo_feminino boolean;
    v_mensagem varchar2(70);
BEGIN
    v_sexo_feminino := TRUE;

    -- IF CONDIÇÕES
    IF v_sexo_feminino THEN
        v_mensagem := 'Olá, mulher!';
    ELSE
        v_mensagem := 'Olá, homem!';
    END IF;

END;




BEGIN 
    -- PL/SQL é uma linguagem procedural que está embutida dentro do SQL
    -- A linguagem PL/SQL não é um banco de dados, é uma linguagem de programação
    -- O SQL é um padrão ANSI e ISO, enquanto o PL/SQL é um padrão Oracle

    -- O PL/SQL é um superconjunto do SQL, ou seja, ele tem todas as funcionalidades do SQL e mais algumas

    -- 1. Variáveis
    -- ==================================================================
    -- 1. PL/SQL é uma linguagem de programação procedural que se integra ao SQL.
    -- 2. PL/SQL é utilizado para criar blocos de código que podem ser executados no banco de dados.
    -- 3. PL/SQL é uma linguagem de programação estruturada que permite a criação de variáveis, loops e condicionais.

    -- ==================================================================
    -- 4. Definindo um bloco PL/SQL simples:

    DECLARE
        v_nome VARCHAR2(50) := 'João'; -- Declaração de variável
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Olá, ' || v_nome); -- Exibe mensagem na saída padrão
    END;

    -- ==================================================================
    -- 5. Definindo um bloco PL/SQL com tratamento de exceções
    SELECT 
        F.NM_FUNCIONARIO,
        TRIM(F.NM_FUNCIONARIO) AS "TRIM",
        LTRIM(F.NM_FUNCIONARIO) AS "LTRIM",
        RTRIM(F.NM_FUNCIONARIO) AS "RTRIM"
    FROM
        DUAL;
END;
