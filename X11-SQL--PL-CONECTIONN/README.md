
# 📌 A Importância do PL/SQL no Contexto de Banco de Dados Oracle

PL/SQL é a linguagem procedural da Oracle que estende o SQL com recursos de programação estruturada. Quando combinado com SQL puro, oferece uma solução poderosa para manipulação de dados, controle de transações e lógica de negócio diretamente no banco de dados.

## ✅ Por que usar PL/SQL com SQL?

Ao integrar SQL com PL/SQL, você aproveita o melhor dos dois mundos:

- 🔄 SQL: linguagem declarativa para manipulação e consulta de dados.
- 🧠 PL/SQL: adiciona estruturas de controle (IF, LOOP, CASE...), tratamento de erros, cursores e transações.

Essa combinação é executada no próprio Oracle Database, sem precisar de comunicação com camadas externas da aplicação — o que gera desempenho incomparável ⚡.

### 🚀 Vantagens da Integração SQL + PL/SQL

- 🧠 Eliminação de context switch  
  Tudo é processado no servidor, evitando troca constante entre aplicação e banco.

- 🧩 Otimização de memória  
  A Library Cache permite reutilização de código PL/SQL e instruções SQL já compiladas.

- 📚 Uso inteligente de cursores  
  Gerencia resultados complexos com atributos úteis como %ROWCOUNT e %FOUND.

- 🔒 Controle transacional nativo  
  Comandos como COMMIT, ROLLBACK e SAVEPOINT são tratados diretamente no PL/SQL.

## 📂 Manipulação de Dados

Comandos básicos de DML no Oracle:

- INSERT ➕: adiciona linhas
- UPDATE 🛠️: modifica linhas existentes
- DELETE 🗑️: remove linhas
- SELECT 🔍: consulta dados
- LOCK TABLE 🔐: controla acesso simultâneo

## 🔄 Controle de Transações

O Oracle é orientado a transações, garantindo consistência e integridade nos dados.

| Comando        | Função                                                                 |
|----------------|------------------------------------------------------------------------|
| COMMIT         | Torna permanentes as alterações realizadas                             |
| ROLLBACK       | Desfaz alterações realizadas desde o início da transação               |
| SAVEPOINT      | Marca um ponto parcial na transação para possível rollback específico  |
| SET TRANSACTION| Define propriedades da transação, como isolamento e controle de acesso |

## 🎯 Cursores no PL/SQL

### Tipos:

- 🔹 Cursores Implícitos  
  Criados automaticamente pelo Oracle para operações DML simples. Ex: cursor “SQL”.

- 🔸 Cursores Explícitos  
  Declarados manualmente para processar múltiplas linhas de resultado com controle detalhado.

## 🔍 Exemplo 1 – Cursor Declarado

```sql
SET SERVEROUTPUT ON;

DECLARE
  CURSOR C_VALOR_TOTAL_MEDIA_VENDAS_CLIENTE IS
    SELECT NR_CLIENTE, ROUND(AVG(VL_TOT_PEDIDO), 2)
    FROM DB_PEDIDO
    WHERE EXTRACT(YEAR FROM DT_PEDIDO) = EXTRACT(YEAR FROM SYSDATE)
    GROUP BY NR_CLIENTE;
BEGIN
  NULL; -- Bloco BEGIN válido, mas sem ação (apenas estrutura)
END;
```

📝 Esse exemplo declara um cursor explícito que calcula a média de vendas por cliente no ano atual, mas não executa nenhuma lógica ainda.

## 🛠️ Exemplo 2 – Uso com Variáveis e LOOP

```sql
SET SERVEROUTPUT ON;

DECLARE
  CURSOR C_VALOR_TOTAL_MEDIA_VENDAS_CLIENTE IS
    SELECT NR_CLIENTE, ROUND(AVG(VL_TOT_PEDIDO), 2) VL_MEDIO_VENDAS
    FROM DB_PEDIDO
    WHERE EXTRACT(YEAR FROM DT_PEDIDO) = EXTRACT(YEAR FROM SYSDATE)
    GROUP BY NR_CLIENTE;

  VC_VALOR_TOTAL_VENDAS_CLIENTE C_VALOR_TOTAL_MEDIA_VENDAS_CLIENTE%ROWTYPE;
  V_CONTADOR_CURSOR NUMBER := 0;

BEGIN
  OPEN C_VALOR_TOTAL_MEDIA_VENDAS_CLIENTE;

  LOOP
    FETCH C_VALOR_TOTAL_MEDIA_VENDAS_CLIENTE INTO VC_VALOR_TOTAL_VENDAS_CLIENTE;

    IF C_VALOR_TOTAL_MEDIA_VENDAS_CLIENTE%FOUND THEN
      UPDATE DB_CLIENTE
      SET VL_MEDIO_COMPRA = VC_VALOR_TOTAL_VENDAS_CLIENTE.VL_MEDIO_VENDAS
      WHERE NR_CLIENTE = VC_VALOR_TOTAL_VENDAS_CLIENTE.NR_CLIENTE;

      V_CONTADOR_CURSOR := V_CONTADOR_CURSOR + 1;
    ELSE
      EXIT;
    END IF;
  END LOOP;

  CLOSE C_VALOR_TOTAL_MEDIA_VENDAS_CLIENTE;
  COMMIT;

  DBMS_OUTPUT.PUT_LINE('A quantidade de linhas processadas foram: ' || V_CONTADOR_CURSOR);
END;
```

🔍 Esse cursor percorre todos os clientes, calcula sua média de vendas e atualiza a tabela DB_CLIENTE. Ao final, mostra quantas linhas foram processadas.

## 🧷 Atributos Úteis de Cursores

| Atributo           | Descrição                                               |
|--------------------|---------------------------------------------------------|
| %FOUND             | Retorna TRUE se o FETCH recuperou uma linha             |
| %NOTFOUND          | Retorna TRUE se não houve dados no último FETCH         |
| %ROWCOUNT          | Número de linhas retornadas pelo cursor                 |
| %ISOPEN            | Verifica se o cursor ainda está aberto                  |

## 🧱 Criando Tabelas com Oracle SQL

```sql
DROP TABLE db_loja_resumo_venda_ano_mes CASCADE CONSTRAINTS;

CREATE TABLE db_loja_resumo_venda_ano_mes (
    nr_loja              NUMBER(5) NOT NULL,
    nr_ano               NUMBER(4) NOT NULL,
    nr_mes               NUMBER(2) NOT NULL,
    nm_loja              VARCHAR2(100) NOT NULL,
    vl_total_venda       NUMBER(10, 2) NOT NULL,
    vl_maior_venda_feita NUMBER(8, 2) NOT NULL,
    vl_menor_venda_feita NUMBER(8, 2) NOT NULL,
    vl_medio_venda       NUMBER(8, 2)
);

ALTER TABLE db_loja_resumo_venda_ano_mes
  ADD CONSTRAINT db_sk_loja_res_venda_ano_mes 
  PRIMARY KEY (nr_loja, nr_ano, nr_mes);
```

🧾 Essa tabela armazena um resumo mensal e anual das vendas por loja, com indicadores como maior, menor e média de vendas.

## ✅ Conclusão

PL/SQL é essencial para quem trabalha com Oracle Database. Ele permite:

- Lógica complexa diretamente no banco 🧩
- Melhor performance ao evitar comunicação externa 🚀
- Controle fino de transações e cursores 🔄

💡 Dica: dominar PL/SQL te torna um profissional mais completo em ambientes Oracle.
