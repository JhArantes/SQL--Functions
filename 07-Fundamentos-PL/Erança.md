# PL/SQL: Entendendo `%TYPE` e `%ROWTYPE`

Ao desenvolver em PL/SQL, é comum precisarmos declarar variáveis que representam colunas ou registros inteiros de uma tabela. Para isso, o Oracle nos oferece dois atributos muito úteis: `%TYPE` e `%ROWTYPE`. Eles ajudam a tornar o código mais robusto, reutilizável e resistente a alterações no esquema do banco de dados.

## ✅ `%TYPE`

O atributo `%TYPE` permite que uma variável herde **automaticamente o tipo de dado** de uma coluna de uma tabela ou de outra variável.

### 🔹 Vantagens
- Evita erros de tipo de dado.
- Facilita manutenção do código (ex.: se o tipo da coluna mudar, não é preciso alterar o código PL/SQL).
- Melhora a legibilidade e reutilização.

### 🔹 Exemplo

No trecho abaixo, estamos dizendo que a variável `v_nr_cliente` terá o **mesmo tipo de dado** da coluna `nr_cliente` da tabela `db_pedido`:

```plsql
v_nr_cliente db_pedido.nr_cliente%TYPE;
```

Isso significa que se nr_cliente for um NUMBER(6), por exemplo, v_nr_cliente será do mesmo tipo.

🧠 Outro exemplo prático
plsql
Copy
Edit
DECLARE
    v_nome_cliente clientes.nome%TYPE;
BEGIN
    SELECT nome INTO v_nome_cliente FROM clientes WHERE id = 1;
    DBMS_OUTPUT.PUT_LINE('Cliente: ' || v_nome_cliente);
END;
✅ %ROWTYPE
Já o %ROWTYPE serve para declarar uma variável que representa uma linha inteira de uma tabela ou resultado de SELECT.

🔹 Vantagens
Permite acessar todos os campos de uma linha com uma única variável.

Ideal para operações que lidam com registros completos.

🔹 Exemplo
plsql
Copy
Edit
DECLARE
    v_cliente clientes%ROWTYPE;
BEGIN
    SELECT * INTO v_cliente FROM clientes WHERE id = 1;
    DBMS_OUTPUT.PUT_LINE('Cliente: ' || v_cliente.nome || ', Email: ' || v_cliente.email);
END;
Neste exemplo, v_cliente tem todos os campos da tabela clientes, como nome, email, data_nascimento, etc.

💡 Resumo
Atributo	Uso Principal	Exemplo
%TYPE	Declarar variável com tipo de coluna	v_id cliente.id%TYPE
%ROWTYPE	Declarar variável com estrutura de linha inteira	v_cliente cliente%ROWTYPE

🛠 Dica prática
Use %TYPE para colunas específicas e %ROWTYPE quando for necessário manipular registros completos. Ambos ajudam a proteger seu código contra alterações no banco de dados, tornando-o mais flexível e manutenível.

mathematica
Copy
Edit
