
# Collections e Records

Muitas linguagens ultilizam tipos de coleções como arrays, listas e tabelas aninhadas (nested table)


aplicações em Banco de dados oferecem os tipos de dados TABLE e VARRAY  que permitem declarar tabelas indexadas (index-by-tables) tabelas aninhadas (nested tables) e arrays de tamanho variavel (variable size arrays)


# O Que É Uma Collection em PL/SQL?

As "collections" na linguagem PL/SQL são estruturas semelhantes a arrays ou listas, usadas para armazenar conjuntos de dados que se encontram na memória e ficam disponíveis para uso sempre que necessário.

Uma coleção pode ser considerada como um grupo ordenado de elementos, todos do mesmo tipo, onde cada elemento dentro de uma coleção possui um índice único que determina sua posição na coleção.

## Exemplo de Usos de Collections no Projeto DBURGER

Na hamburgueria DBurger, as "collections" podem ser úteis em situações que exista a necessidade de manipular múltiplos valores ou registros de forma eficiente, como por exemplo:

* Armazenar temporariamente os itens do pedido de um cliente antes de inseri-los nas tabelas do banco de dados.
* Guardar uma lista de ingredientes selecionados para um hambúrguer personalizado.
* Manter em memória os resultados de uma consulta para processamento posterior sem acessar repetidamente o banco de dados.
* Implementar estruturas de dados mais complexas, como listas de espera ou filas de atendimento.

## Tipos de Coleções

A linguagem de programação PL/SQL oferece os seguintes tipos de coleções:

### VARRAYS (Variable-Size Arrays)

Contêm um número fixo de elementos, embora esse número possa ser alterado em tempo de execução, e se utilizam de números sequenciais como índices que também podem ser definidos como tipos equivalentes em SQL.

### Tabelas Aninhadas (Nested Tables)

Contêm um número arbitrário de elementos e utilizam números sequenciais como índices. É possível definir tipos equivalentes em SQL, permitindo que tabelas aninhadas sejam armazenadas em tabelas do banco de dados e manipuladas por meio de SQL. Exemplo: representar os itens de um pedido de cliente, onde cada pedido pode ter uma lista variável de produtos.

### Tabelas Indexadas (Index-by Tables)

Também conhecidas como arrays associativos, permitem pesquisar elementos usando números arbitrários ou strings como índices. São similares às hash tables de outras linguagens de programação. Exemplo: armazenar e acessar rapidamente o número de pedidos por filial usando o código da filial como índice.

Para usar coleções em uma aplicação, você define um ou mais tipos PL/SQL e, em seguida, define variáveis desses tipos, sendo possível definir tipos de coleção utilizando a linguagem PL/SQL.

## Vantagens em Se Utilizar Collection

* **Redução de interações com o banco:** processa múltiplos registros na memória antes de aplicar alterações ao banco;
* **Performance:** é mais rápido para manipular grandes volumes de dados do que processá-los um a um;
* **Organização:** permite trabalhar com estruturas temporárias e intermediárias sem alterar diretamente as tabelas.







| **Método** | **Função executada** |
|------------|-----------------------|
| `EXISTS`   | Verificar a existência de um índice. |
| `COUNT`    | Retorna o número de elementos na tabela. |
| `FIRST`    | Retorna o menor índice válido. |
| `LAST`     | Retorna o maior índice válido. |
| `NEXT`     | Retorna o próximo índice válido. |
| `PRIOR`    | Retorna o número de índice que precede o índice informado em uma tabela PL/SQL. |






