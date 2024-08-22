# Estudo DIO sobre Índices e Procedures

## Índices Criados na DB Company
1. **Índice em employee(Dno):** Criado para otimizar a consulta que busca o departamento com o maior número de empregados.
2. **Índice em dept_location(Dnumber):** Criado para otimizar a junção entre as tabelas `departament` e `dept_location`.
3. **Índice em employee(Dno, Lname, Fname):** Criado para otimizar a consulta que lista os funcionários por departamento, ordenados por sobrenome e nome.

## Procedure criada para a Manipulação de Dados
Uma procedure `ManipulaEmployee` foi criada para permitir operações de inserção, atualização e remoção na tabela `employee`. Essa operação foi escolhida com base em um parâmetro de controle (`p_acao`), que pode ser 1 (inserir), 2 (atualizar) ou 3 (remover), conforme requerido nas instruções do desafio.

## Como Executar?
1. Clone o repositório.
2. Execute o script SQL para criar o banco de dados e as tabelas.
3. Utilize as consultas e a procedure conforme necessário para manipular os dados e checar seus resultados.

## Estudo de Views
Adicionado o estudo de Views e a criação de usuários com suas permissões estabelecidas. 
