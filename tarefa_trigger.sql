-- Criando tabelas
CREATE TABLE pessoa ( 
 id_pessoa SERIAL PRIMARY KEY,  
 nome VARCHAR(15) NOT NULL,  
 sobrenome VARCHAR(15) NOT NULL,  
 telefone VARCHAR(20) NOT NULL,  
 email VARCHAR(30) UNIQUE,  
 data_nascimento DATE NOT NULL  
);

CREATE TABLE endereco 
( 
 id_endereco SERIAL PRIMARY KEY,  
 cep INT NOT NULL,  
 lograduro VARCHAR(50) NOT NULL,  
 nro INT NOT NULL,  
 bairro VARCHAR(30) NOT NULL,  
 cidade VARCHAR(30) NOT NULL,  
 estado VARCHAR(20) NOT NULL,
 fk_id_pessoa INT NOT NULL,
 CONSTRAINT fk_pessoa FOREIGN KEY (fk_id_pessoa) REFERENCES pessoa (id_pessoa)
); 

INSERT INTO pessoa (nome, sobrenome, telefone, email, data_nascimento) VALUES
 ('Roberto', 'Alves', '41996402533', 'robertoalves@gmail.com', '1991-07-13'),
 ('Dario', 'Garcia', '65985632559', 'dariogarcia@hotmail.com', '1985-05-24'),
 ('Renata', 'Gomes', '71952364215', 'renatagomes@yahoo.com', '1993-01-29'),
 ('Tiago', 'Lopes', '95965217824', 'tiago_lopes@gmail.com', '1981-04-18'),
 ('Julia', 'Garcia', '22961458236', 'jgarcia@outlook.com', '1995-02-28'),
 ('Rebeca', 'Camargo', '47952149652', 'camargo_rebeca@gmail.com', '2001-09-25');
 
 Insert INTO endereco (cep, lograduro, nro, bairro, cidade, estado, fk_id_pessoa) VALUES
	(81330480, 'Rua Leonardo Javorski', 105, 'Fazendinha', 'Curitiba', 'PR', 1),
    (80330340, 'Rua Maris de Barros', 210, 'Portao', 'Curitiba', 'PR', 1),
    (78013580, 'Rua das Acacias', 456, 'Jardim das Flores', 'Cuiabá', 'MT', 2),
    (46900025, 'Avenida Jardim', 100, 'Costa Azul', 'Salvador', 'BA', 3),
    (69300258, 'Rua das Palmeiras', 65, 'Boa Vista', 'Boa Vista', 'RR', 4),
    (26530602, 'Rua dos Girassóis', 1252, 'Copacabana', 'Rio de Janeiro', 'RJ', 5),
    (26024012, 'Avenida das Roseiras', 867, 'Ipanema', 'Rio de Janeiro', 'RJ', 5),
    (88065100, 'Rua das Violetas', 456, 'Flor de Vale', 'Florianópilis', 'SC', 6);
    
-- Consultas juntando tabelas
SELECT nome, sobrenome, lograduro, nro, bairro, cidade, estado from pessoa
INNER JOIN endereco
ON fk_id_pessoa = id_pessoa;

CREATE TABLE lembrete (
    lembreteId serial PRIMARY KEY,
    pessoaId INT,
    mensagem TEXT
);

CREATE TRIGGER inserir_dados
AFTER INSERT
ON pessoa FOR EACH ROW
BEGIN
	IF new.data_nascimento IS NULL THEN
	INSERT INTO lembrete (pessoaId, mensagem)
	VALUES (new.id_pessoa, CONCAT('Oi ', new.nome, ', atualize sua data de nascimento.'));
	END IF;
END;
