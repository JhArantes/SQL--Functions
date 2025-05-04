--===================================================================
-- Funções - SQL Oracle
--===================================================================

-- Divididas em 4 partes:
-- 1. Funções de Data
-- 2. Funções de String
-- 3. Funções Numéricas
-- 4. Funções de Conversão

--===================================================================
-- Funções de String
--===================================================================

-- Funções de String são utilizadas para manipular e formatar strings de texto.

-- EXEMPLO – FUNÇÕES LOWER(), UPPER() e INITCAP()
SELECT 
    F.NM_FUNCIONARIO AS "COMO ESTÁ GRAVADO",
    LOWER(F.NM_FUNCIONARIO) AS "MINÚSCULAS (LOWER)",
    UPPER(F.NM_FUNCIONARIO) AS "MAIÚSCULAS (UPPER)",
    INITCAP(F.NM_FUNCIONARIO) AS "MAIÚSCULA/MINÚSCULA (INITCAP)"
FROM 
    T_SIP_FUNCIONARIO F;

-- EXEMPLO – FUNÇÕES ASCII() e CHR()
SELECT 
    ASCII('R') AS "ASCII DE 'R'",
    CHR(82) AS "CARACTERE DE ASCII 82"
FROM 
    DUAL;

-- EXEMPLO – FUNÇÃO CONCAT()
SELECT 
    CONCAT('A', 'B') AS "CONCATENAR"
FROM 
    DUAL;

-- EXEMPLO – FUNÇÃO INSTR()
SELECT 
    F.NM_FUNCIONARIO,
    INSTR(F.NM_FUNCIONARIO, 'A') AS "POSIÇÃO DE 'A'",
    INSTR(F.NM_FUNCIONARIO, 'JOS') AS "POSIÇÃO DE 'JOS'",
    INSTR(F.NM_FUNCIONARIO, 'A', 3) AS "POSIÇÃO DE 'A' A PARTIR DA 3ª POSIÇÃO",
    INSTR(F.NM_FUNCIONARIO, 'A', 3, 2) AS "2ª OCORRÊNCIA DE 'A' A PARTIR DA 3ª POSIÇÃO"
FROM 
    T_SIP_FUNCIONARIO F;

-- EXEMPLO – FUNÇÃO LENGTH()
SELECT 
    F.NM_FUNCIONARIO,
    LENGTH(F.NM_FUNCIONARIO) AS "TAMANHO"
FROM 
    T_SIP_FUNCIONARIO F;

-- EXEMPLO – FUNÇÕES TRIM(), LTRIM() e RTRIM()
-- TRIM() remove espaços em branco à esquerda e à direita
SELECT 
    F.NM_FUNCIONARIO,
    TRIM(F.NM_FUNCIONARIO) AS "TRIM",
    LTRIM(F.NM_FUNCIONARIO) AS "LTRIM",
    RTRIM(F.NM_FUNCIONARIO) AS "RTRIM"
FROM 
    T_SIP_FUNCIONARIO F;

-- EXEMPLO – FUNÇÕES LPAD() e RPAD()
-- LPAD() adiciona espaços à esquerda e RPAD() adiciona espaços à direita
SELECT 
    F.NM_FUNCIONARIO,
    LPAD(F.NM_FUNCIONARIO, 20, '0') AS "LPAD",
    RPAD(F.NM_FUNCIONARIO, 20, '0') AS "RPAD"
FROM 
    T_SIP_FUNCIONARIO F;

-- EXEMPLO – FUNÇÃO NVL()
-- NVL() substitui valores nulos por um valor padrão
SELECT 
    F.NM_FUNCIONARIO,
    NVL(F.NR_CPF, 'NÃO INFORMADO') AS "NR_CPF"
FROM 
    T_SIP_FUNCIONARIO F;

-- EXEMPLO – FUNÇÃO REPLACE()
-- REPLACE() substitui uma parte da string por outra
SELECT 
    F.NM_FUNCIONARIO,
    REPLACE(F.NM_FUNCIONARIO, 'A', 'X') AS "REPLACE"
FROM 
    T_SIP_FUNCIONARIO F;

-- EXEMPLO – FUNÇÃO SUBSTR()
-- SUBSTR() extrai uma parte da string
SELECT 
    F.NM_FUNCIONARIO,
    SUBSTR(F.NM_FUNCIONARIO, 1, 3) AS "SUBSTR"
FROM 
    T_SIP_FUNCIONARIO F;

--===================================================================
-- Funções Numéricas
--===================================================================

-- EXEMPLO – FUNÇÃO TRUNC()
-- TRUNC() remove a parte decimal de um número
SELECT 
    TRUNC(123.456, 2) AS "TRUNCADO PARA 2 CASAS DECIMAIS",
    TRUNC(123.456) AS "TRUNCADO PARA INTEIRO"
FROM 
    DUAL;

-- EXEMPLO – FUNÇÃO MOD()
-- MOD() retorna o resto da divisão de dois números
SELECT 
    MOD(10, 3) AS "RESTO DA DIVISÃO 10/3"
FROM 
    DUAL;

-- EXEMPLO – FUNÇÃO SQRT()
-- SQRT() retorna a raiz quadrada de um número
SELECT 
    SQRT(16) AS "RAIZ QUADRADA DE 16"
FROM 
    DUAL;

-- EXEMPLO – FUNÇÃO ABS()
-- ABS () retorna o valor absoluto de um número
-- O valor absoluto é o valor numérico sem o sinal negativo.
SELECT 
    ABS(-10) AS "VALOR ABSOLUTO DE -10"
FROM 
    DUAL;


-- ===================================================================
-- == Funções de Conversão
-- Funções de Conversão são utilizadas para converter dados de um tipo para outro.
----------------------------------------------------------------------

---------------------------------------------------------------------------------------
-- função TO_CHAR() - converte um número ou data para string
SELECT 
    TO_CHAR(123.456) AS "TO_CHAR",
    TO_CHAR(SYSDATE, 'DD/MM/YYYY') AS "TO_CHAR DATA"
FROM 
    DUAL;
---------------------------------------------------------------------------------------
-- EXEMPLO – FUNÇÕES DE CONVERSÃO – TO_CHAR()
SELECT F.VL_SALARIO ,
       TO_CHAR(F.VL_SALARIO, 'L9999999.99') "SIMBOLO MOEDA LOCAL" ,
       TO_CHAR(F.VL_SALARIO, 'C99,999.99') "SIMBOLO MOEDA ISO" ,
       TO_CHAR(F.VL_SALARIO, '99,999.99')  ,
       F.NR_MATRICULA ,
       TO_CHAR(F.NR_MATRICULA, '0099999')       
  FROM T_SIP_FUNCIONARIO F;

---------------------------------------------------------------------------------------
-- função TO_NUMBER() - converte uma string para número
SELECT 
    TO_NUMBER('123.456') AS "TO_NUMBER",
    TO_NUMBER('123,456', '999G999D99') AS "TO_NUMBER COM FORMATO"
FROM 
    DUAL;

---------------------------------------------------------------------------------------
-- função TO_DATE() - converte uma string para data
SELECT 
    TO_DATE('2023-10-01', 'YYYY-MM-DD') AS "TO_DATE"
FROM
    DUAL;

---------------------------------------------------------------------------------------
-- Função Cast() - converte um tipo de dado para outro
-- EXEMPLO – FUNÇÕES DE CONVERSÃO – CAST()
SELECT 
        CAST( 12345.67 AS VARCHAR2(10) ) ,        
        CAST( '29/09/2013' AS DATE )     ,
        CAST( 12345.678 AS NUMBER(10,2)) 
  FROM DUAL;

-- CONVERTER VALORES DE COLUNA DE UM TIPO PARA OUTRO
SELECT 
       CAST ( F.VL_SALARIO AS VARCHAR2(10) ) ,
       CAST ( F.VL_SALARIO + 1000 AS NUMBER (8,2) )
  FROM T_SIP_FUNCIONARIO F;

---------------------------------------------------------------------------------------
--====================================================================
-- Funções de Data
---------------------------------------------------------------------------------------




  

