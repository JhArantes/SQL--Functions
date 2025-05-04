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
SELECT 
    F.NM_FUNCIONARIO,
    TRIM(F.NM_FUNCIONARIO) AS "TRIM",
    LTRIM(F.NM_FUNCIONARIO) AS "LTRIM",
    RTRIM(F.NM_FUNCIONARIO) AS "RTRIM"
FROM 
    T_SIP_FUNCIONARIO F;

-- EXEMPLO – FUNÇÕES LPAD() e RPAD()
SELECT 
    F.NM_FUNCIONARIO,
    LPAD(F.NM_FUNCIONARIO, 20, '0') AS "LPAD",
    RPAD(F.NM_FUNCIONARIO, 20, '0') AS "RPAD"
FROM 
    T_SIP_FUNCIONARIO F;

-- EXEMPLO – FUNÇÃO NVL()
SELECT 
    F.NM_FUNCIONARIO,
    NVL(F.NR_CPF, 'NÃO INFORMADO') AS "NR_CPF"
FROM 
    T_SIP_FUNCIONARIO F;

-- EXEMPLO – FUNÇÃO REPLACE()
SELECT 
    F.NM_FUNCIONARIO,
    REPLACE(F.NM_FUNCIONARIO, 'A', 'X') AS "REPLACE"
FROM 
    T_SIP_FUNCIONARIO F;

-- EXEMPLO – FUNÇÃO SUBSTR()
SELECT 
    F.NM_FUNCIONARIO,
    SUBSTR(F.NM_FUNCIONARIO, 1, 3) AS "SUBSTR"
FROM 
    T_SIP_FUNCIONARIO F;

--===================================================================
-- Funções Numéricas
--===================================================================

-- EXEMPLO – FUNÇÃO TRUNC()
SELECT 
    TRUNC(123.456, 2) AS "TRUNCADO PARA 2 CASAS DECIMAIS",
    TRUNC(123.456) AS "TRUNCADO PARA INTEIRO"
FROM 
    DUAL;

-- EXEMPLO – FUNÇÃO MOD()
SELECT 
    MOD(10, 3) AS "RESTO DA DIVISÃO 10/3"
FROM 
    DUAL;

-- EXEMPLO – FUNÇÃO SQRT()
SELECT 
    SQRT(16) AS "RAIZ QUADRADA DE 16"
FROM 
    DUAL;

-- EXEMPLO – FUNÇÃO ABS()
SELECT 
    ABS(-10) AS "VALOR ABSOLUTO DE -10"
FROM 
    DUAL;


