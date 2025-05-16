
# A importancia do PL/SQL no Contexto de Data Base


Um dos grandes benefícios de combinar SQL e PL/SQL no Oracle Database é a flexibilidade de executar instruções SQL diretamente no bloco PL/SQL, aproveitando os poderosos recursos dos bancos de dados relacionais.
      

O SQL (Structured Query Language) é uma linguagem declarativa e o PL/SQL (Procedural Language/SQL) é uma extensão procedural do SQL, criada pela Oracle, que permite adicionar lógica de programação estruturada, como loops, condicionais, tratamento de erros e controle de fluxo.
      


A integração ocorre diretamente dentro do núcleo do Oracle Database, permitindo que instruções SQL sejam executadas nativamente dentro de blocos PL/SQL, sem necessidade de comunicação externa com a aplicação, criando assim uma poderosa combinação que resulta em códigos-fontes com incomparável desempenho em relação a outras linguagens existentes, muitas das quais necessitam criar conexões externas e adicionar mais uma camada de consumo de tempo de acesso, tornando seu desempenho inferior em comparação ao PL/SQL. A integração entre SQL e PL/SQL reduz a sobrecarga de comunicação entre a aplicação cliente e o banco de dados.
      

# Por que a integração é eficiente

<b>Eliminação do context switch: </b>
quando uma aplicação externa executa SQL e lógica de negócios separadamente, ocorre um "context switch" entre o cliente e o servidor, gerando sobrecarga de comunicação. No PL/SQL, tanto a lógica quanto as instruções SQL são processadas no servidor, eliminando essa troca de contexto;
        
<b>Otimização do código na memória: </b>
a integração permite que blocos de código-fonte PL/SQL e SQL compartilhem recursos da Library Cache, evitando recompilações desnecessárias, sendo que o Oracle otimiza o reuso de instruções SQL já compiladas, reduzindo o tempo de execução;
        

<b>Uso eficiente de cursores: </b>
o Oracle permite o uso de cursores explícitos e implícitos dentro do PL/SQL para gerenciar múltiplos resultados SQL, sendo que a execução de cursores é altamente otimizada dentro do ambiente integrado, com suporte a atributos (%ROWCOUNT, %FOUND) e estruturas de controle (FOR LOOP);
        
<b>Controle transacional e segurança: </b>
o controle transacional, como COMMIT, ROLLBACK e SAVEPOINT, é tratado diretamente pelo PL/SQL sem a necessidade de intervenção externa, permitindo confirmar as transações pendentes executadas dentro de códigos-fontes PL/SQL.
        


# Manipulando Dados


Para manipular dados no banco dados Oracle, utilizamos os comandos INSERT, UPDATE, DELETE, SELECT e LOCK TABLE, sendo que o comando INSERT adiciona novas linhas de dados às tabelas do banco de dados; o UPDATE modifica linhas existentes; o DELETE remove linhas indesejadas; o SELECT recupera linhas que atendem aos critérios de busca especificados; e o LOCK TABLE limita temporariamente o acesso a uma tabela.
      

# Controle de Transação


O SGBD Oracle é orientado a transações, ou seja, utiliza transações para garantir a integridade dos dados. Mas vamos nos aprofundar um pouco mais nesse conceito. Uma transação consiste em uma ou diversas instruções de manipulação de dados (DML) que realizam uma unidade lógica de trabalho. Por exemplo, duas instruções UPDATE podem, juntas, creditar uma conta bancária e debitar outra.
      

<ul class="on-list">
          <li>
            <b>COMMIT:</b> torna permanentes as alterações realizadas no banco de dados durante a transação atual;
          </li>
          <li>
            <b>ROLLBACK:</b> encerra a transação atual e desfaz todas as alterações realizadas desde o início da transação;
          </li>
          <li>
            <b>SAVEPOINT:</b> marca um ponto no processamento da transação, permitindo que, combinado com o ROLLBACK, seja possível desfazer parte de uma transação;
          </li>
          <li>
            <b>SET TRANSACTION:</b> configura propriedades da transação, como o nível de isolamento e o acesso de leitura/gravação.
          </li>
        </ul>



<ul class="on-list">
          <li>
            <b>Cursores Implícitos:</b> gerados automaticamente pelo PL/SQL para instruções SQL que manipulam dados, como INSERT, UPDATE, DELETE e SELECT, que retornam apenas uma linha. Esses cursores simplificam a programação ao abstrair o gerenciamento do contexto de execução, mas são limitados a cenários de baixo volume de dados. O nome do cursor implícito padrão no Oracle é “<b>SQL”</b>;
          </li>
          <li>
            <b>Cursores Explícitos:</b> devem ser declarados explicitamente pelo desenvolvedor para consultas que retornam uma ou múltiplas linhas. Os cursores explícitos oferecem controle detalhado sobre o processamento do conjunto de resultados, permitindo iteração linha a linha para resolver as mais variadas necessidades de negócio.
          </li>
        </ul>














