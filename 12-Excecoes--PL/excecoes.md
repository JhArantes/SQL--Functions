
# Tratamento de Exceções PL/SQL

Exceções são inconsistecias no codigo de execução do programa
Existem varios tipos como sintax, value, infraestrutura ....

## Tratamento

Então imagine que ocorra um erro em tempo de execução, precisamos de algo para tratalo

ele é comparavel com um IF e else aonde o desenvolvedor escolhe o que acontece caso ocorra algum erro então o tratamento de exceções é o developer escolhendo o caminho em que o script deve ir após a falha/ Error

```sql

--
-- Script que aplica o conceito das exceções
-- ZERO_DIVIDE e OTHERS
SET SERVEROUTPUT ON;
DECLARE
	-- Variável que irá controlar quantas linhas foram manipuladas.
	V_CONTADOR_CURSOR NUMBER := 00;
BEGIN
	-- Perceba que estamos usando o FOR LOOP diretamente
	-- com um subconsulta, eliminando assim a necessidade
	-- de escrita comando CURSOR.
	FOR i IN (
		SELECT 	NR_CLIENTE,
			ROUND(AVG(VL_TOT_PEDIDO),2) VL_MEDIO_VENDAS
		FROM  	DB_PEDIDO
		WHERE 	EXTRACT(YEAR FROM DT_PEDIDO) = EXTRACT(YEAR FROM SYSDATE)
		GROUP 	BY NR_CLIENTE
			)
	LOOP
	 	-- Para cada cliente selecionado, atualizamos o seu respectivo
		-- valor médio de vendas, utilizando sua chave PK (primary key).
		UPDATE DB_CLIENTE SET VL_MEDIO_COMPRA = i.VL_MEDIO_VENDAS
		WHERE NR_CLIENTE = i.NR_CLIENTE;

		-- Para cada linha processada, acumulamos a quantidade de transações realizadas.
		V_CONTADOR_CURSOR := V_CONTADOR_CURSOR + SQL%ROWCOUNT;

		BEGIN
		   IF V_CONTADOR_CURSOR = 10 THEN
			-- Forçamos uma divisão por zero, correspondendo a um cálculo inválido,
			-- porém não ocorre erro pois temos um tratamento de exceção para isso.
			i.VL_MEDIO_VENDAS := i.VL_MEDIO_VENDAS / 0;
		   END IF;
		EXCEPTION
			-- Veja q exceção pré-definida ZERO_DIVIDE que trata da divisão por zero
            WHEN ZERO_DIVIDE THEN
                 DBMS_OUTPUT.PUT_LINE('Perceba que a exceção foi acionada para o cliente (' || i.NR_CLIENTE || ') e podemos tratar ' || CHR(10) || 'da maneira que quisermos, sem parar o processamento!');
			-- Veja a exceção OTHERS que trata de qualquer outra exceção que ainda não foi definida
			WHEN OTHERS THEN
		         DBMS_OUTPUT.PUT_LINE('Exceção crítica para o cliente (' || i.NR_CLIENTE || ') ' || SQLERRM);
		END;
	END LOOP;
	-- Atualizamos todas as transações pendentes.
	COMMIT;
	DBMS_OUTPUT.PUT_LINE('A quantidade de linhas processadas foram: ' || V_CONTADOR_CURSOR);
END;
```

Nesse caso o Error é dividir por zero um tipo de error (Divisor iqual a Zero)


## Tipos de Errors

<div class="on-table-responsive" id="on-table-1">
        <table class="on-table on-table-primary">
          <thead>
            <tr>
              <th>Nome da Exceção pré-definida</th>
              <th>Erro Oracle</th>
              <th>Valor do erro SQLCODE</th>
              <th>Momento do acionamento</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>
                ACCESS_INTO_NULL
              </td>
              <td>
                ORA-06530
              </td>
              <td>
                -6530
              </td>
              <td>
                Ocorre quando o programa tenta atribuir valores aos atributos de um objeto não inicializado, ou seja, que se encontra atomicamente nulo.
              </td>
            </tr>
            <tr>
              <td>
                CASE_NOT_FOUND
              </td>
              <td>
                ORA-06592
              </td>
              <td>
                -6592
              </td>
              <td>
                Ocorre quando nenhuma das opções nas cláusulas WHEN de uma instrução CASE é selecionada e não há uma cláusula ELSE.
              </td>
            </tr>
            <tr>
              <td>
                COLLECTION_IS_NULL
              </td>
              <td>
                ORA-06531
              </td>
              <td>
                -6531
              </td>
              <td>
                Ocorre ao usar métodos de coleção ou atribuir valores em tabelas aninhadas ou varrays não inicializados.
              </td>
            </tr>
            <tr>
              <td>
                CURSOR_ALREADY_OPEN
              </td>
              <td>
                ORA-06511
              </td>
              <td>
                -6511
              </td>
              <td>
                Ocorre quando o programa tenta abrir um cursor que já está aberto e um cursor deve ser fechado antes de ser reaberto. Um loop FOR de cursor abre automaticamente o cursor ao qual se refere, portanto, o programa não pode abrir esse cursor dentro do loop.
              </td>
            </tr>
            <tr>
              <td>
                DUP_VAL_ON_INDEX
              </td>
              <td>
                ORA-00001
              </td>
              <td>
                -1
              </td>
              <td>
                Ocorre quando o programa tenta armazenar valores duplicados em uma coluna do banco de dados que possui uma restrição de índice único
              </td>
            </tr>
            <tr>
              <td>
                INVALID_CURSOR
              </td>
              <td>
                ORA-01001
              </td>
              <td>
                -1001
              </td>
              <td>
                Ocorre quando o programa tenta realizar uma operação ilegal em um cursor, como fechar um cursor que não foi aberto.
              </td>
            </tr>
            <tr>
              <td>
                INVALID_NUMBER
              </td>
              <td>
                ORA-01722
              </td>
              <td>
                -1722
              </td>
              <td>
                Ocorre quando, em uma instrução SQL, a conversão de uma string de caracteres para um número falha porque a string não representa um número válido.
              </td>
            </tr>
            <tr>
              <td>
                LOGIN_DENIED
              </td>
              <td>
                ORA-01017
              </td>
              <td>
                -1017
              </td>
              <td>
                Ocorre quando o programa tenta fazer login no Oracle com um nome de usuário e/ou senha inválidos.
              </td>
            </tr>
            <tr>
              <td>
                NO_DATA_FOUND
              </td>
              <td>
                ORA-01403
              </td>
              <td>
                +100
              </td>
              <td>
                Normalmente ocorre quando uma instrução SELECT INTO não retorna nenhuma linha ou em situações onde o programa faz referência a um elemento excluído a um elemento não inicializado em uma tabela index-by.
              </td>
            </tr>
            <tr>
              <td>
                NOT_LOGGED_ON
              </td>
              <td>
                ORA-01012
              </td>
              <td>
                -1012
              </td>
              <td>
                Ocorre quando o programa emite uma chamada ao banco de dados sem estar conectado ao Oracle.
              </td>
            </tr>
            <tr>
              <td>
                PROGRAM_ERROR
              </td>
              <td>
                ORA-06501
              </td>
              <td>
                -6501
              </td>
              <td>
                Ocorre quando há um problema interno no PL/SQL.
              </td>
            </tr>
            <tr>
              <td>
                ROWTYPE_MISMATCH
              </td>
              <td>
                ORA-06504
              </td>
              <td>
                -6504
              </td>
              <td>
                Ocorre quando a variável de cursor do host e a variável de cursor PL/SQL envolvidas em uma atribuição possuem tipos de retorno incompatíveis. Por exemplo, quando uma variável de cursor do host aberta é passada para um subprograma armazenado, os tipos de retorno dos parâmetros reais e formais devem ser compatíveis.
              </td>
            </tr>
            <tr>
              <td>
                STORAGE_ERROR
              </td>
              <td>
                ORA-06500
              </td>
              <td>
                -6500
              </td>
              <td>
                Ocorre quando o PL/SQL fica sem memória ou quando a memória foi corrompida.
              </td>
            </tr>
            <tr>
              <td>
                SUBSCRIPT_BEYOND_COUNT
              </td>
              <td>
                ORA-06533
              </td>
              <td>
                -6533
              </td>
              <td>
                Ocorre quando o programa faz referência a um elemento de uma tabela aninhada ou varray usando um número de índice maior do que o número de elementos na coleção.
              </td>
            </tr>
            <tr>
              <td>
                SUBSCRIPT_OUTSIDE_LIMIT
              </td>
              <td>
                ORA-06532
              </td>
              <td>
                -6532
              </td>
              <td>
                Ocorre quando o programa faz referência a um elemento de uma tabela aninhada ou varray usando um número de índice (-1, por exemplo) que está fora do intervalo permitido.
              </td>
            </tr>
            <tr>
              <td>
                SYS_INVALID_ROWID
              </td>
              <td>
                ORA-01410
              </td>
              <td>
                -1410
              </td>
              <td>
                Ocorre quando a conversão de uma string de caracteres para um rowid universal falha, pois a string não representa um rowid válido.
              </td>
            </tr>
            <tr>
              <td>
                TIMEOUT_ON_RESOURCE
              </td>
              <td>
                ORA-00051
              </td>
              <td>
                -51
              </td>
              <td>
                Ocorre quando há um time-out enquanto o Oracle aguarda por um recurso.
              </td>
            </tr>
            <tr>
              <td>
                TOO_MANY_ROWS
              </td>
              <td>
                ORA-01422
              </td>
              <td>
                -1422
              </td>
              <td>
                Ocorre quando uma instrução SELECT INTO retorna mais de uma linha.
              </td>
            </tr>
            <tr>
              <td>
                VALUE_ERROR
              </td>
              <td>
                ORA-06502
              </td>
              <td>
                -6502
              </td>
              <td>
                Ocorre quando há um erro aritmético, de conversão, de truncamento ou de restrição de tamanho.
              </td>
            </tr>
            <tr>
              <td>
                ZERO_DIVIDE
              </td>
              <td>
                ORA-01476
              </td>
              <td>
                -1476
              </td>
              <td>
                Ocorre quando o programa tenta dividir um número por zero.
              </td>
            </tr>
          </tbody>
          <tfoot>
            <tr>
              <td colspan="4">
                Tabela que representa as principais exceções pré-definidas utilizadas na linguagem PL/SQL
              </td>
            </tr>
          </tfoot>
        </table>
      </div>


```sql
-- Script que trata do conceito de gerenciamento
-- da exceção DUP_VAL_ON_INDEX
SET SERVEROUTPUT ON;
BEGIN
    -- Já temos esse email cadastrado para outro cliente, ou seja,
    -- a exceção dup_val_on_index é acionada.
    INSERT INTO DB_CLIENTE(NR_CLIENTE, NM_CLIENTE, QT_ESTRELAS, VL_MEDIO_COMPRA,
    ST_CLIENTE, DS_EMAIL, NR_TELEFONE)
    VALUES (987654321, 'Claudia Monegatto', 0, 0, 'A', 'adriana1gmail.com.br', null);
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE( 'A EXCEÇÃO DUP_VAL_ON_INDEX FOI ACIONADA, POIS O EMAIL adriana1gmail.com.br JÁ ESTÁ CADASTRADA.' || SQLERRM);
END;
/

```






























