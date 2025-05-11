
# 🧠 Tipos de Dados em PL/SQL

## 📌 Introdução
PL/SQL oferece diversos tipos de dados para representar diferentes informações. Eles podem ser classificados em:

- 🔹 **Escalares**: armazenam valores únicos (ex: `NUMBER`, `VARCHAR2`, `BOOLEAN`);
- 🔸 **Compostos**: armazenam múltiplos valores (ex: `RECORD`, `TABLE`);
- 🧭 **Referência**: apontam para objetos (ex: `REF CURSOR`);
- 💾 **LOB (Large Objects)**: usados para grandes volumes de dados (ex: `CLOB`, `BLOB`).

---

## 🔢 Tipos Numéricos (`NUMBER`)

O tipo `NUMBER` é amplamente utilizado e tem baixo custo de armazenamento.

```sql
NUMBER(precisão, escala)
```

- `NUMBER`: ponto flutuante sem declarar escala;
- `NUMBER(p)`: precisão com escala implícita;
- `NUMBER(p,s)`: precisão e escala explícitas.

### 🔍 Subtipos Numéricos

- `BINARY_INTEGER` / `PLS_INTEGER`: inteiros (positivos ou negativos), mais eficientes em memória.
- `DEC`, `DECIMAL`, `NUMERIC`: ponto fixo, até 38 dígitos decimais.
- `FLOAT`, `DOUBLE PRECISION`: ponto flutuante com até 126 dígitos binários (~38 decimais).
- `REAL`: ponto flutuante com até 63 dígitos binários (~18 decimais).
- `INTEGER`, `INT`, `SMALLINT`: inteiros, até 38 dígitos decimais.

---

## 🧪 Exemplo Prático com `NUMBER`

```sql
SET SERVEROUTPUT ON;
DECLARE
    v_nr_idade_media_cliente NUMBER(3) := 57;
    v_nr_loja db_loja.nr_loja%TYPE := 00;
BEGIN
    dbms_output.put_line('A idade média do cliente da loja (' 
    || v_nr_loja || ') é: ' || v_nr_idade_media_cliente);
END;
/
```

---

## 🧾 Tipos para Caracteres (`CHAR`)

`CHAR[(tamanho [CHAR | BYTE])]` define uma string com tamanho fixo.

```sql
SET SERVEROUTPUT ON;
DECLARE
    v_flag_aprovado CHAR(3) := 'SIM';
    v_st_cliente db_cliente.st_cliente%TYPE := 'I';
BEGIN
    dbms_output.put_line('O status do cliente é (' || v_st_cliente 
    || ') e o status de aprovação é: ' || v_flag_aprovado);
END;
/
```

---

## 📦 LONG e LONG RAW

- `LONG`: armazena textos longos, até 32.760 bytes.
- `LONG RAW`: armazena dados binários, mesmo limite.

🔁 Oracle recomenda migrar `LONG` para `CLOB` e `LONG RAW` para `BLOB`.

```sql
SET SERVEROUTPUT ON;
DECLARE
    v_texto CHAR(17) := 'FIAP DATA SCIENCE';
    v_texto_binario LONG RAW; 
BEGIN
    v_texto_binario := UTL_RAW.CAST_TO_RAW(v_texto);
    dbms_output.put_line('Conteúdo binário armazenado: ' || RAWTOHEX(v_texto_binario)
    || CHR(13) || 'Conteúdo CHAR: ' || v_texto );
END;
/
```

---

## 📍 ROWID

Identificador exclusivo da linha em uma tabela. Útil para localizar ou manipular registros específicos.

```sql
SET SERVEROUTPUT ON;
DECLARE 
    v_rowid ROWID;
    v_nr_loja DB_PEDIDO.NR_LOJA%TYPE;
    v_nr_pedido DB_PEDIDO.NR_PEDIDO%TYPE;
    v_nr_cliente DB_PEDIDO.NR_CLIENTE%TYPE;
BEGIN
    SELECT ROWID, NR_LOJA, NR_PEDIDO, NR_CLIENTE
    INTO v_rowid, v_nr_loja, v_nr_pedido, v_nr_cliente
    FROM DB_PEDIDO
    WHERE NR_LOJA = 1 AND NR_PEDIDO = 10;

    dbms_output.put_line('O ROWID para o pedido número 10 da loja 1 é: ' || v_rowid);
END;
/
```

---

## 🧵 VARCHAR vs VARCHAR2

O Oracle criou `VARCHAR2` para gerar compatibilidade com códigos antigos. Ele trata textos com codificação mais avançada e é o tipo principal de texto no Oracle. Evite `CHAR`, pois é usado basicamente para compatibilidade com códigos legados.

```sql
SET SERVEROUTPUT ON;

DECLARE
    v_primeiro_nome VARCHAR2(20) := 'Oivlas';
    v_sobrenome     VARCHAR2(20) := 'Sakspildap';
    v_nome_completo VARCHAR2(40);
BEGIN
    v_nome_completo := v_primeiro_nome || ' ' || v_sobrenome;
    dbms_output.put_line('Nome completo: ' || v_nome_completo);
END;
```

---

## 🌍 Tipos de Caracteres Nacionais

Para linguagens com milhares de caracteres como chinês e japonês, PL/SQL suporta:

- `NCHAR`: comprimento fixo;
- `NVARCHAR2`: comprimento variável, codificado em UTF-8/AL16UTF16.

---

## 💾 Tipos de Dados LOB (Large Objects)

Armazenam dados grandes e não estruturados como vídeos, imagens e documentos.

- `BFILE`: referência a arquivos armazenados fora do banco.
- `BLOB`: dados binários.
- `CLOB`: grandes volumes de texto.
- `NCLOB`: grandes volumes de texto com suporte a caracteres nacionais.

---

## ✅ Tipo de Dado BOOLEAN

```sql
SET SERVEROUTPUT ON;
DECLARE
    v_aprovado BOOLEAN := TRUE;
BEGIN
    IF v_aprovado THEN
        dbms_output.put_line('Aprovado.');
    ELSE
        dbms_output.put_line('Reprovado.');
    END IF;
END;
/
```

---

## ⏳ DateTime e Intervalos

Permite armazenar datas, horas e intervalos.

```sql
SET SERVEROUTPUT ON;
DECLARE
	v_data_nascimento db_cli_fisica.dt_nascimento%type;
	v_data_hoje date;
	v_nr_idade PLS_INTEGER;
BEGIN
	SELECT 	DT_NASCIMENTO, SYSDATE,
			TRUNC( MONTHS_BETWEEN ( SYSDATE, DT_NASCIMENTO ) / 12,0)
	INTO	v_data_nascimento, v_data_hoje, v_nr_idade
	FROM	DB_CLI_FISICA
	WHERE 	NR_CLIENTE = 1;
	
	dbms_output.put_line('O cliente número 1 nasceu em ' || v_data_nascimento 
						 || ' e atualmente tem ' || v_nr_idade || ' anos.');
END;
/
```

---

### ⏱️ TIMESTAMP

```sql
SET SERVEROUTPUT ON;
DECLARE
    v_inicio TIMESTAMP 	:= TIMESTAMP '2024-11-14 09:00:00.000';
    v_fim TIMESTAMP 	:= TIMESTAMP '2024-11-14 15:30:45.123';
    v_diferenca INTERVAL DAY TO SECOND;
BEGIN
    v_diferenca := v_fim - v_inicio;

    dbms_output.put_line('A diferença de tempo é: ' || 
                         EXTRACT(DAY FROM v_diferenca) || ' dias, ' ||
                         EXTRACT(HOUR FROM v_diferenca) || ' horas, ' ||
                         EXTRACT(MINUTE FROM v_diferenca) || ' minutos, ' ||
                         EXTRACT(SECOND FROM v_diferenca) || ' segundos.');
END;
/
```

---

## 🔄 Conversão de Tipos de Dados

Conversão Explícita:

```sql
SET SERVEROUTPUT ON;
DECLARE
     v_data_aniversario DATE;
     v_data_extenso VARCHAR2(150);
BEGIN
     v_data_aniversario := TO_DATE('18/05/1967','dd/mm/yyyy');
     v_data_extenso := TO_CHAR(v_data_aniversario, 'FMDay, DD "de" FMMonth "de" YYYY', 
                       'NLS_DATE_LANGUAGE=Portuguese');
     dbms_output.put_line('Data por extenso: ' || v_data_extenso);
END;
/
```

