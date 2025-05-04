# Funções Oracle SQL

# Divisoes

| Função           | Descrição                                                    |
| ----------------- | ------------------------------------------------------------ |
| **CARACTERE** | Manipulam strings de caractere.                             |
| **NÚMERICAS** | Efetuam cálculos.                                          |
| **CONVERSÃO** | Convertem um valor de um tipo de banco de dados para outro. |
| **DATA** | Processam datas e horas.                                    |
| **EXPRESSÃO REGULAR** | Utilizam expressões regulares para procurar dados, introduzidas no Oracle 10g e ampliadas no 11g. |




# 📘 Funções de Manipulação de Strings no Oracle SQL

Este documento apresenta um resumo das principais funções SQL para manipulação de caracteres e strings no Oracle. Cada função está acompanhada de uma breve explicação e exemplos práticos.

---


## Funções de Case: `LOWER()`, `UPPER()`, `INITCAP()`

* **`LOWER(string)`:** Converte todos os caracteres da string para minúsculas.
* **`UPPER(string)`:** Converte todos os caracteres da string para maiúsculas.
* **`INITCAP(string)`:** Converte a primeira letra de cada palavra na string para maiúscula e o restante para minúscula.

```sql
SELECT F.NM_FUNCIONARIO             "COMO ESTÁ GRAVADO" ,
       LOWER(F.NM_FUNCIONARIO)      "MINUSCULAS (LOWER)" ,
       UPPER(F.NM_FUNCIONARIO)      "MAIUSCULAS (UPPER)" ,
       INITCAP(F.NM_FUNCIONARIO)    "MAIUSCULA/MINUSCULA (INITCAP)"
FROM T_SIP_FUNCIONARIO F;
```


## 🔡 Códigos de Caracteres: `ASCII()` e `CHR()`

- **`ASCII(char)`**: Retorna o código ASCII do caractere fornecido.
- **`CHR(number)`**: Retorna o caractere correspondente ao código ASCII fornecido.

### 📌 Exemplo:
```sql
SELECT ASCII('R'),  -- Retorna 82
       CHR(82)      -- Retorna 'R'
FROM DUAL;
```

##  🔗 Função de Concatenação: CONCAT()
CONCAT(string1, string2): Concatena (une) duas strings.

### 📌 Exemplo:
```sql
Copy code
SELECT CONCAT('A', 'B') AS "CONCATENAR"
FROM DUAL;  -- Retorna 'AB'
```

## 🔍 Posição de Substring: INSTR() e INSTRB()
INSTR(string, substring [, start_position [, occurrence]]):
Retorna a posição da n-ésima ocorrência de uma substring na string.

INSTRB(): Igual ao INSTR(), mas trabalha com bytes, útil com caracteres multibyte.

### 📌 Exemplo:
```sql
Copy code
SELECT F.NM_FUNCIONARIO,
       INSTR(F.NM_FUNCIONARIO, 'A') AS "1ª A",
       INSTR(F.NM_FUNCIONARIO, 'JOS') AS "JOS",
       INSTR(F.NM_FUNCIONARIO, 'A', 3) AS "A a partir da 3ª pos.",
       INSTR(F.NM_FUNCIONARIO, 'A', 3, 2) AS "2ª A após pos. 3"
FROM T_SIP_FUNCIONARIO F;
🔢 Comprimento da String: LENGTH()
LENGTH(string): Retorna o número de caracteres na string.
```


# Length Quantidade Caracters
### 📌 Exemplo:
```sql
Copy code
SELECT F.NM_FUNCIONARIO,
       LENGTH(F.NM_FUNCIONARIO) AS "TAMANHO"
FROM T_SIP_FUNCIONARIO F;
✂️ Remoção de Espaços: TRIM(), LTRIM(), RTRIM()
TRIM([LEADING | TRAILING | BOTH] [caractere] FROM string):
Remove espaços (ou caractere específico) do início, fim ou ambos os lados da string.

LTRIM(string [, caracteres]): Remove caracteres do início da string.

RTRIM(string [, caracteres]): Remove caracteres do fim da string.
```

# Remoção espaços 
### 📌 Exemplo:
```sql
Copy code
SELECT F.NM_FUNCIONARIO,
       TRIM(F.NM_FUNCIONARIO) AS "TRIM",
       LTRIM(F.NM_FUNCIONARIO) AS "LTRIM",
       RTRIM(F.NM_FUNCIONARIO) AS "RTRIM"
FROM T_SIP_FUNCIONARIO F;
```