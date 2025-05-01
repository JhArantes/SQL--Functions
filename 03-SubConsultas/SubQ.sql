
SELECT * FROM T_SIP_FUNCIONARIO;

SELECT * FROM T_SIP_FUNCIONARIO WHERE ID_FUNCIONARIO = 1;



--=======================================================================
-- Consultas de única linha

-- Operadores 
-- =, <>, >, >=, <, <=

-- EXEMPLO – SUBCONSULTA DE UMA ÚNICA LINHA
-- Comparando o Salario do Id 12348 e retornando os salários maiores que o dele.
 SELECT NM_FUNCIONARIO,
        VL_SALARIO_MENSAL
   FROM T_SIP_FUNCIONARIO 
  WHERE VL_SALARIO_MENSAL > (
                         SELECT VL_SALARIO_MENSAL
                           FROM T_SIP_FUNCIONARIO 
                          WHERE NR_MATRICULA = 12348
                  );

--=======================================================================
-- EXEMPLO – SUBCONSULTA DE UMA ÚNICA LINHA
-- Retornando os funcionários com salário maior que a média salarial de todos os funcionários.
SELECT NM_FUNCIONARIO,
        VL_SALARIO_MENSAL
FROM T_SIP_FUNCIONARIO
WHERE VL_SALARIO_MENSAL > (SELECT AVG(VL_SALARIO_MENSAL) FROM T_SIP_FUNCIONARIO);


--=======================================================================
-- EXEMPLO – SUBCONSULTA DE UMA ÚNICA LINHA,
 -- COM AGRUPAMENTO, FUNÇÕES DE GRUPO E HAVING
   SELECT CD_DEPTO,
          MIN(VL_SALARIO_MENSAL)
     FROM T_SIP_FUNCIONARIO 
 GROUP BY CD_DEPTO
   HAVING MIN(VL_SALARIO_MENSAL) > (
                                 SELECT MIN(VL_SALARIO_MENSAL)
                                   FROM T_SIP_FUNCIONARIO 
                                  WHERE CD_DEPTO = 3 
                        );

--=======================================================================
-- EXEMPLO – SUBCONSULTA DE UMA ÚNICA LINHA,
 -- COM CLÁUSULA FROM
   SELECT F.NR_MATRICULA ,
          F.NM_FUNCIONARIO , 
          F.DT_ADMISSAO  , 
          RESFUNC.QTDEALOCACAO
   FROM   T_SIP_FUNCIONARIO F , 
                         (
                          SELECT  NR_MATRICULA , 
                                    COUNT(NR_MATRICULA) QTDEALOCACAO
                              FROM  T_SIP_IMPLANTACAO  
                          GROUP BY  NR_MATRICULA                                  
                          ) RESFUNC
                               
  WHERE F.NR_MATRICULA = RESFUNC.NR_MATRICULA ;

--=======================================================================
--=======================================================================
-- Criando Tabelas a partir de subconsultas

-- EXEMPLO – SUBCONSULTA PARA CRIAR TABELAS
CREATE TABLE T_TESTE_AULA_ON AS 
              SELECT * FROM T_SIP_IMPLANTACAO;

--=======================================================================
--=======================================================================
-- Sub Consultas de múltiplas linhas
-- operadores de comparação são:
-- IN | ANY | ALL | NOT IN

-- EXEMPLO – SUBCONSULTA COM VÁRIAS LINHAS,
 -- COM OPERADOR IN
 SELECT CD_IMPLANTACAO ,
        CD_PROJETO     , 
  NR_MATRICULA "FUNCIONARIO"
   FROM T_SIP_IMPLANTACAO 
  WHERE CD_PROJETO IN
           (
             SELECT CD_PROJETO
               FROM T_SIP_PROJETO 
                    WHERE TO_CHAR(DT_INICIO,'MM/YYYY') IN('04/2012','10/2013')
                  );

-- Operador ANY
 SELECT NR_MATRICULA   , 
        NM_FUNCIONARIO , 
        VL_SALARIO_MENSAL
   FROM T_SIP_FUNCIONARIO 
  WHERE VL_SALARIO_MENSAL < ANY 
                          (
                               SELECT AVG(VL_SALARIO_MENSAL)
                                 FROM T_SIP_FUNCIONARIO 
                             GROUP BY CD_DEPTO
                           );


-- Operador ALL

SELECT NR_MATRICULA   , 
      NM_FUNCIONARIO , 
      VL_SALARIO_MENSAL
  FROM T_SIP_FUNCIONARIO 
WHERE VL_SALARIO_MENSAL > ALL 
                        (
                              SELECT AVG(VL_SALARIO_MENSAL)
                                FROM T_SIP_FUNCIONARIO 
                            GROUP BY CD_DEPTO
                         );

--=======================================================================
-- Subconsultas Correlacionadas
-- São subconsultas que dependem da consulta externa para serem executadas.

-- EXEMPLO – SUBCONSULTA CORRELACIONADA
-- COM EXISTS
 SELECT F.NR_MATRICULA,
     F.NM_FUNCIONARIO
  FROM T_SIP_FUNCIONARIO F
 WHERE EXISTS
            (
              SELECT I.NR_MATRICULA
                FROM T_SIP_IMPLANTACAO I
               WHERE F.NR_MATRICULA=I.NR_MATRICULA
            );

-- EXEMPLO – SUBCONSULTA CORRELACIONADA
-- COM NOT EXISTS
SELECT F.NR_MATRICULA,
    F.NM_FUNCIONARIO
  FROM T_SIP_FUNCIONARIO F
 WHERE NOT EXISTS
         (
          SELECT I.NR_MATRICULA
            FROM T_SIP_IMPLANTACAO I
           WHERE F.NR_MATRICULA=I.NR_MATRICULA
         );


