------------------------------CRIAÇAO DE TABELAS---------------------------!>

CREATE TABLE carro(
    id SERIAL,
    ano INT2,
    modelo TEXT,
    marca TEXT,
    chassi CHAR(3) UNIQUE NOT NULL,
    novo BOOLEAN,
    quilometragem FLOAT4,
    PRIMARY KEY (id)
);

CREATE TABLE cliente(
    id SERIAL,
    nome TEXT NOT NULL,
    data_nascimento DATE,
    endereco TEXT,
    cpf char(14) UNIQUE NOT NULL,    
    PRIMARY KEY (id)
);

CREATE TABLE funcionario(
    id SERIAL,
    nome TEXT NOT NULL,
    data_nascimento DATE,
    endereco TEXT,
    cpf char(14) UNIQUE NOT NULL,   
    carteira_trabalho INT2 UNIQUE NOT NULL,
    tipo_contrato TEXT,
    email TEXT NOT NULL,
    login TEXT NOT NULL,
    senha TEXT NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE venda(
    numero_venda SERIAL,
    data DATE,
    preco FLOAT4,
    formas_de_pagamento TEXT,
    qnt_parcelas INT2,
    fk_carro INT2,
    fk_vendedor INT2,
    fk_cliente INT2,
    PRIMARY KEY (numero_venda),
    FOREIGN KEY (fk_carro) REFERENCES carro(id),
    FOREIGN KEY (fk_vendedor) REFERENCES funcionario(id),
    FOREIGN KEY (fk_cliente) REFERENCES cliente(id)
);

CREATE TABLE entradaCarro(
    fk_carro INT2,
    fk_venda INT2,
    valor FLOAT4,
    FOREIGN KEY (fk_carro) REFERENCES carro(id),
    FOREIGN KEY (fk_venda) REFERENCES venda(numero_venda)
);


CREATE TABLE parcela(
    id SERIAL,
    data_de_vencimento DATE,
    valor_parcela FLOAT4,
    fk_venda INT2,
    PRIMARY KEY (id),
    FOREIGN KEY (fk_venda) REFERENCES venda(numero_venda)
  
);


CREATE TABLE aluguel(
    id SERIAL,
    data_inicio DATE,
    data_fim DATE,
    preco FLOAT4 NOT NULL,
    forma_pagamento TEXT,
    fk_carro INT2,
    fk_cliente INT2,
    fk_vendedor INT2,
    PRIMARY KEY (id),
    FOREIGN KEY (fk_carro) REFERENCES carro(id),
    FOREIGN KEY (fk_vendedor) REFERENCES funcionario(id),
    FOREIGN KEY (fk_cliente) REFERENCES cliente(id)
);

CREATE TABLE motorista(
    id SERIAL,
    nome TEXT NOT NULL,
    data_de_nascimento DATE,
    endereco TEXT,
    cpf char(14) UNIQUE NOT NULL,   
    carteira_de_motorista INT2 UNIQUE NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE motoristaAluguel(
    fk_aluguel INT2,
    fk_motorista INT2,
    FOREIGN KEY (fk_aluguel) REFERENCES aluguel(id),
    FOREIGN KEY (fk_motorista) REFERENCES motorista(id)
);



SELECT * FROM carro; 

SELECT * FROM cliente; 

SELECT * FROM funcionario; 

SELECT * FROM venda;

SELECT * FROM entradaCarro;

SELECT * FROM parcela;

SELECT * FROM aluguel;

SELECT * FROM motorista;

SELECT * FROM motoristaAluguel;



---------------------------INSERIR DADOS NA TABELA CARRO-------------------------------------!>

INSERT INTO carro (ano,modelo,marca,chassi, novo, quilometragem) VALUES (2022, 'Compass', 'Jeep', 'RFQ', 'true', 0);
INSERT INTO carro (ano,modelo,marca,chassi, novo, quilometragem) VALUES (2022, 'Siena', 'Fiat', 'WFA', 'false', 20000);  
INSERT INTO carro (ano,modelo,marca,chassi, novo, quilometragem) VALUES (2022, 'Toro', 'Fiat', 'WWW', 'true', 0);  
INSERT INTO carro (ano,modelo,marca,chassi, novo, quilometragem) VALUES (2022, 'Argo', 'Fiat', 'XXX', 'false', 12000);  
INSERT INTO carro (ano,modelo,marca,chassi, novo, quilometragem) VALUES (2022, 'Renegate', 'Jeep', 'LLL', 'true', 0);


---------------------------INSERIR DADOS NA TABELA CLIENTE---------------------------------------!>



INSERT INTO cliente (nome,data_nascimento,endereco,cpf) VALUES ('Carla', '1990-08-12', 'Rua x', '298.984.097-12'); 
INSERT INTO cliente (nome,data_nascimento,endereco,cpf) VALUES ('Davi', '2004-04-17', 'Rua Y', '000.000.000-00');  
INSERT INTO cliente (nome,data_nascimento,endereco,cpf) VALUES ('Judi', '1990-12-22', 'Rua K', '111.111.111-11');  
INSERT INTO cliente (nome,data_nascimento,endereco,cpf) VALUES ('Julia', '1999-10-12', 'Rua l', '222.222.222-22');  
INSERT INTO cliente (nome,data_nascimento,endereco,cpf) VALUES ('Guidao', '2000-08-09', 'Rua W', '333.333.333-33');  


---------------------------INSERIR DADOS NA TABELA FUNCIONARIO---------------------------------------!>

INSERT INTO funcionario (nome,data_nascimento,endereco,cpf, carteira_trabalho, tipo_contrato, email, login, senha) VALUES ('Joao', '2004-08-05', 'Rua Manaus', '033.555.444-83',123,'CLT', 'joao@gmail.com', 'joao.0', 1111);  
INSERT INTO funcionario (nome,data_nascimento,endereco,cpf, carteira_trabalho, tipo_contrato, email, login, senha) VALUES ('Leninha', '1990-01-11', 'Rua Macaibana', '222.984.111-00',111,'CLT', 'leninha@gmail.com', 'leninha.2', 2222);


---------------------------2 VENDAS SEM ENTRADA E SEM PARCELAS---------------------------------------!>

INSERT INTO venda (data,preco,formas_de_pagamento,qnt_parcelas,fk_carro, fk_vendedor, fk_cliente) VALUES ('2020-5-13', 40.000, 'dinheiro', 0, 5, 1, 1);  
INSERT INTO venda (data,preco,formas_de_pagamento, qnt_parcelas ,fk_carro, fk_vendedor, fk_cliente) VALUES ('2021-08-22', 30.000, 'dinheiro', 0, 2, 2, 2);


---------------------------1 VENDA COM ENTRADA E 3 PARCELAS---------------------------------------!>

INSERT INTO venda (data,preco,formas_de_pagamento, qnt_parcelas ,fk_carro, fk_vendedor, fk_cliente) VALUES ('2021-2-01', 60.000, 'cartao', 3, 5, 1, 3);
INSERT INTO parcela(data_de_vencimento, valor_parcela, fk_venda) VALUES  ('2021-3-01', 20.000, 3);
INSERT INTO parcela(data_de_vencimento, valor_parcela, fk_venda) VALUES  ('2021-4-01', 20.000, 3);
INSERT INTO parcela(data_de_vencimento, valor_parcela, fk_venda) VALUES  ('2021-5-01', 20.000, 3);


---------------------------1 VENDA COM ENTRADA E 2 PARCELAS---------------------------------------!>


INSERT INTO venda (data,preco,formas_de_pagamento, qnt_parcelas ,fk_carro, fk_vendedor, fk_cliente) VALUES ('2021-7-23', 300.000, 'cartao', 2, 1, 1, 1);
INSERT INTO parcela(data_de_vencimento, valor_parcela, fk_venda) VALUES  ('2021-8-23', 60.000, 4);
INSERT INTO parcela(data_de_vencimento, valor_parcela, fk_venda) VALUES  ('2021-9-23', 60.000, 4);


--------------------------2 ENTRADAS DE CARROS---------------------------------------!>

INSERT INTO EntradaCarro (fk_carro, fk_venda, valor) VALUES  (5, 3, 5.000);
INSERT INTO EntradaCarro (fk_carro, fk_venda, valor) VALUES  (1, 4, 10.000);


--------------------------2 ALUGUEIS---------------------------------------!>

INSERT INTO aluguel(data_inicio,data_fim,preco,forma_pagamento,fk_carro,fk_cliente, fk_vendedor) VALUES ('2021-6-20', '2021-6-30',10.000, 'dinheiro', 1, 1, 1);
INSERT INTO aluguel(data_inicio,data_fim,preco,forma_pagamento,fk_carro,fk_cliente, fk_vendedor) VALUES ('2021-7-20', '2021-7-30', 20.000,'dinheiro', 2, 2, 2);


--------------------------4 MOTORISTAS---------------------------------------!>

INSERT INTO motorista(nome,data_de_nascimento,endereco,cpf,carteira_de_motorista) VALUES ('Danilo', '2000-7-30','rua z','000.888.999-44', 324);
INSERT INTO motorista(nome,data_de_nascimento,endereco,cpf,carteira_de_motorista) VALUES ('Daniel', '2000-7-10','rua k','000.333.999-41', 260);
INSERT INTO motorista(nome,data_de_nascimento,endereco,cpf,carteira_de_motorista) VALUES ('Patricia', '2000-7-03','rua o','000.222.777-74', 469);
INSERT INTO motorista(nome,data_de_nascimento,endereco,cpf,carteira_de_motorista) VALUES ('Amanda', '2000-7-8','rua l','000.000.555-24', 357);


-------------------------- ALUGUEL 1: 3 MOTORISTA---------------------------------------!>

INSERT INTO motoristaAluguel(fk_aluguel, fk_motorista) VALUES (1,1);
INSERT INTO motoristaAluguel(fk_aluguel, fk_motorista) VALUES (1,2);
INSERT INTO motoristaAluguel(fk_aluguel, fk_motorista) VALUES (1,3);



-------------------------- ALUGUEL 2: 2 MOTORISTA---------------------------------------!>

INSERT INTO motoristaAluguel(fk_aluguel, fk_motorista) VALUES (2,3);
INSERT INTO motoristaAluguel(fk_aluguel, fk_motorista) VALUES (2,4);



-------------------------- BUSCAS NO BANCO---------------------------------------!>


SELECT A.ano, A.modelo, A.chassi, V.data, V.preco
FROM carro A, venda V, cliente C
WHERE V.fk_carro = A.id AND
	  V.fk_cliente = C.id AND
      C.nome = 'Carla';
      
      
      
SELECT A.ano, A.modelo, A.chassi, AL.data_inicio, AL.data_fim
FROM carro A, aluguel AL, motorista M, motoristaAluguel ML
WHERE ML.fk_aluguel = AL.id AND
	  ML.fk_motorista = M.id AND
      AL.fk_carro = A.id AND
      M.nome = 'Danilo';
      
      
      
SELECT A.ano, A.modelo, A.chassi, V.data, C.nome
FROM carro A, venda V, cliente C, entradaCarro EC
WHERE V.fk_carro = A.id AND
	  EC.fk_carro = A.id AND
      EC.fk_venda = V.numero_venda AND
	  V.fk_cliente = C.id AND
      EC.fk_venda > 0;      
      


SELECT V.numero_venda, P.valor_parcela, P.data_de_vencimento
FROM carro A, venda V, parcela P
WHERE V.fk_carro = A.id AND
	  P.fk_venda = V.numero_venda AND
      A.modelo = 'Compass';
