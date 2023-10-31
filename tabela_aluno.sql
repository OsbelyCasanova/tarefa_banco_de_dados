-- Criando tabela
CREATE TABLE aluno ( 
	ID SERIAL PRIMARY KEY,  
 	nome VARCHAR(15) NOT NULL,    
 	email VARCHAR(30) UNIQUE, 
  	endereco VARCHAR(80) NOT NULL
);
