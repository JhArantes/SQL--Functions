
-- EXEMPLO – GROUP BY 
SELECT NR_MATRICULA, 
       COUNT(CD_DEPENDENTE) "QTDE. DEPENDENTES"
  FROM T_SIP_DEPENDENTE
    GROUP BY NR_MATRICULA;

/*A cláusula GROUP BY permite que criemos um grupo de dados. 
Podemos aplicar a função de grupo para extrair informações relacionadas 
ao agrupamento criado, e ainda consultar duas ou mais tabelas, de acordo com a necessidade de 
negócio apresentada.
*/
-- EXEMPLO – GROUP BY COM FUNÇÃO DE GRUPO
  SELECT CD_DEPTO,
   COUNT(NR_MATRICULA) "QTDE. FUNCIONARIOS NO DEPTO",
   SUM(VL_SALARIO_MENSAL) "TOTAL SALARIO POR DEPTO",
   ROUND(AVG(VL_SALARIO_MENSAL),2) "MEDIA SALARIAL POR DEPTO"
    FROM T_SIP_FUNCIONARIO
GROUP BY CD_DEPTO
ORDER BY CD_DEPTO;

--===============================================================================================
-- JOINS ++++ Group By
-- EXEMPLO – GROUP BY COM VÁRIAS TABELAS
SELECT F.NM_FUNCIONARIO       "FUNCIONARIO" ,
       D.NR_MATRICULA         "MATRICULA"   , 
       COUNT(D.NR_MATRICULA)  "QTDE. DEPENDENTES"
  FROM T_SIP_FUNCIONARIO F INNER JOIN T_SIP_DEPENDENTE D
       ON (F.NR_MATRICULA = D.NR_MATRICULA)
    GROUP BY F.NM_FUNCIONARIO, D.NR_MATRICULA;
    
--===============================================================================================
-- Having
/*
    Podemos utilizar a cláusula HAVING para aplicar uma condição de seleção sobre as linhas agrupadas. 
A cláusula Having  é utilizada para realizar restrições ao agrupamento com a cláusula Group By.
Nessa cláusula, podemos usar funções de agrupamento: AVG, COUNT, MIN, MAX, SUM, por exemplo.
*/
-- EXEMPLO – GROUP BY COM HAVING
  SELECT CD_DEPTO,
   COUNT(NR_MATRICULA) "QTDE. FUNCIONARIO NO DEPTO",
   SUM(VL_SALARIO_MENSAL) "TOTAL SALARIO POR DEPTO",
   ROUND(AVG(VL_SALARIO_MENSAL),2) "MEDIA SALARIAL POR DEPTO"
    FROM T_SIP_FUNCIONARIO
GROUP BY CD_DEPTO
HAVING   SUM(VL_SALARIO_MENSAL) > 10000;

--===============================================================================
/*
    Podemos criar desvios condicionais, através da estrutura “CASE”, 
    utilizando PL/SQL 
(Procedural Language / Structured Query Language), 
linguagem de programação para o SGBDR Oracle, que é uma extensão da linguagem SQL.
*/

CASE 
     WHEN <CONDIÇÃO 1> THEN <VALOR 1>
     WHEN <CONDIÇÃO 2> THEN <VALOR 2>
     WHEN <CONDIÇÃO 3> THEN <VALOR 3>
     .
     .
     .
     ELSE <VALOR 4>
END

/*
    No exemplo abaixo serão recuperados o status dos projetos “EM ANDAMENTO” ou “FINALIZADO”, 
baseado na validação da “DT_TERMINO”, ou seja, caso a 
“DT_TERMINO IS NULL” (data término nula) 
indica que o projeto está em andamento, caso contrário, data término preenchida,
 indica que o projeto está finalizado.
*/
-- EXEMPLO – INSTRUÇÃO CASE
SELECT
        NM_PROJETO,
        DT_TERMINO,
CASE
  WHEN DT_TERMINO IS NULL THEN 'EM ANDAMENTO'
  ELSE 'FINALIZADO'
END STATUS_PROJETO
  FROM T_SIP_PROJETO
ORDER BY NM_PROJETO;



