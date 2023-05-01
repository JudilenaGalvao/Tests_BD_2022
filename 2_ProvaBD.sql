CREATE TABLE paciente(
id SERIAL PRIMARY KEY,
nome TEXT,
data_nascimento DATE,
endereco TEXT,
cpf CHAR(14)
);

CREATE TABLE pontuario(
id SERIAL PRIMARY KEY,
data_internacao DATE,
duracao_internacao INT2 DEFAULT 0,
motivo_internacao TEXT,
fk_paciente INT2,
status TEXT DEFAULT 'ativo',
FOREIGN KEY(fk_paciente) REFERENCES paciente(id)
);

CREATE TABLE medico(
id SERIAL PRIMARY KEY,
nome TEXT,
especialidade TEXT,
crm CHAR(13)
);

CREATE TABLE anotacaoProntuario(
id SERIAL PRIMARY KEY,
data DATE,
informacoes TEXT,
fk_medico INT2,
fk_prontuario INT2,
FOREIGN KEY(fk_medico) REFERENCES medico(id),
FOREIGN KEY(fk_prontuario) REFERENCES pontuario(id)
);


SELECT * FROM paciente;
SELECT * FROM pontuario;
SELECT * FROM medico;
SELECT * FROM anotacaoProntuario;

----------------------------Tabela paciente----------------------------

INSERT INTO paciente(nome, data_nascimento, endereco, cpf) VALUES('Carla Fernandes', '1995/09/13', 'Rua X. Nº200', '111.111.111.11');
INSERT INTO paciente(nome, data_nascimento, endereco, cpf) VALUES('Camila Castro', '1990/03/04', 'Rua Y. Nº7', '222.222.222.22');
INSERT INTO paciente(nome, data_nascimento, endereco, cpf) VALUES('Julia Anacleto', '1999/11/24', 'Rua Z. Nº193', '333.333.333.33');
INSERT INTO paciente(nome, data_nascimento, endereco, cpf) VALUES('Ana Cecilia Nascimento', '1989/08/30', 'Rua Q. Nº700', '444.444.444.44');
INSERT INTO paciente(nome, data_nascimento, endereco, cpf) VALUES('Juliana Pedrosa', '2003/01/18', 'Rua J. Nº12', '555.555.555.55');


-----------------------------tabela pontuario----------------------------

INSERT INTO pontuario(data_internacao, duracao_internacao, motivo_internacao, fk_paciente) VALUES('2020/07/30', 862, 'Aneurisma cerebral', 1);
INSERT INTO pontuario(data_internacao, duracao_internacao, motivo_internacao, fk_paciente) VALUES('2020/07/30', 862, 'Aneurisma cerebral', 1);
INSERT INTO pontuario(data_internacao, duracao_internacao, motivo_internacao, fk_paciente) VALUES('2020/07/30', 862, 'Aneurisma cerebral', 1);
INSERT INTO pontuario(data_internacao, duracao_internacao, motivo_internacao, fk_paciente) VALUES('2020/07/30', 862, 'Aneurisma cerebral', 1);
INSERT INTO pontuario(data_internacao, duracao_internacao, motivo_internacao, fk_paciente) VALUES('2020/07/30', 862, 'Aneurisma cerebral', 1);
INSERT INTO pontuario(data_internacao, duracao_internacao, motivo_internacao, fk_paciente) VALUES('2021/01/20', 688, 'AVC', 2);
INSERT INTO pontuario(data_internacao, duracao_internacao, motivo_internacao, fk_paciente) VALUES('2022/10/28', 42, 'Covid', 4);


---------------------------tabela medico-----------------------------------

INSERT INTO medico(nome, especialidade, crm) VALUES('Danilo', 'Cirugiao Vascular e Endovascular', '00010100-0/BR');
INSERT INTO medico(nome, especialidade, crm) VALUES('Taísia', 'Neurologista', '00020090-0/BR');
INSERT INTO medico(nome, especialidade, crm) VALUES('Marta', 'Infectologista', '06400000-0/BR');
INSERT INTO medico(nome, especialidade, crm) VALUES('Daniele', 'Pneumologista', '10070000-0/BR');
INSERT INTO medico(nome, especialidade, crm) VALUES('Pedro', 'Cardiologista', '04000800-0/BR');


---------------------------tabela anotacaoProntuario------------------------

INSERT INTO anotacaoProntuario(data, informacoes, fk_medico, fk_prontuario) VALUES('2020/10/05', 'Paciente instavel', 1, 1);
INSERT INTO anotacaoProntuario(data, informacoes, fk_medico, fk_prontuario) VALUES('2020/10/05', 'Paciente de risco', 3, 7);
INSERT INTO anotacaoProntuario(data, informacoes, fk_medico, fk_prontuario) VALUES('2020/10/05', 'Paciente de risco', 4, 7);
INSERT INTO anotacaoProntuario(data, informacoes, fk_medico, fk_prontuario) VALUES('2020/10/08', 'Paciente instavel', 3, 7);
INSERT INTO anotacaoProntuario(data, informacoes, fk_medico, fk_prontuario) VALUES('2020/10/13', 'Paciente instavel', 3, 7);
INSERT INTO anotacaoProntuario(data, informacoes, fk_medico, fk_prontuario) VALUES('2020/10/14', 'Paciente instavel', 4, 7);
INSERT INTO anotacaoProntuario(data, informacoes, fk_medico, fk_prontuario) VALUES('2020/10/05', 'Paciente instavel', 2, 6);


----------------------------buscas no banco-----------------------------------

--1. Altere o status de dois prontuários para inativo

UPDATE pontuario SET status = 'inativo' WHERE id = 7;

--2. Altere o CPF do paciente Carla para 01323344599

UPDATE paciente SET cpf = '013.233.445-99' WHERE nome = 'Carla Fernandes';
SELECT * FROM paciente ORDER BY id;

--3. Delete o médico com nome Pedro

DELETE FROM medico WHERE nome = 'Pedro';

--4. Buscar todos os alunos que tenham c no seu nome (maiúsculo ou minúsculo)

SELECT nome FROM paciente WHERE nome LIKE UPPER ('%c%');

--5. Selecione o nome de todos os pacientes que estão internados, ou seja, que tem um prontuário ativo

SELECT nome FROM paciente pa JOIN pontuario po ON po.fk_paciente = pa.id WHERE status = 'ativo';

--6. Selecione o valor médio de duração das internações

SELECT AVG(duracao_internacao) FROM pontuario;

--7. Selecione o valor médio de duração das internações finalizadas, ou seja, inativas

SELECT AVG(duracao_internacao) FROM pontuario WHERE status = 'inativo';

--8. Selecione as internações com maior e menor duração

SELECT MIN(duracao_internacao), MAX(duracao_internacao) FROM pontuario;

--9. Selecione a quantidade de internações por paciente

SELECT pa.nome, COUNT(*)
FROM (paciente pa JOIN pontuario pr ON pr.fk_paciente = pa.id)
WHERE pr.status = 'ativo'
GROUP BY pa.id
HAVING COUNT(*) >= 1;

--10. Selecione a quantidade de Anotações em Prontuário por médico

SELECT m.nome, COUNT(*)
FROM (medico m JOIN anotacaoProntuario apr ON apr.fk_medico = m.id)
GROUP BY m.id
HAVING COUNT(*) >= 1;

--11. Selecione a quantidade de Anotações em Prontuário por médico, por prontuário

SELECT po.id, COUNT(*)
FROM (pontuario po JOIN anotacaoProntuario apr ON apr.fk_prontuario = po.id)JOIN medico m ON apr.fk_medico = m.id
GROUP BY po.id
HAVING COUNT(*) >= 1;


--12. Selecione os médicos que não fizeram anotação em nenhum prontuário

SELECT m.nome
FROM (pontuario po JOIN anotacaoProntuario apr ON apr.fk_prontuario = po.id)JOIN medico m ON apr.fk_medico = m.id
WHERE po.status = 'inativo'
GROUP BY m.nome;


--13. Selecione os médicos que visitaram a paciente Carla e a paciente Júlia

SELECT m.nome
FROM ((anotacaoProntuario apr JOIN medico m ON apr.fk_medico = m.id) JOIN pontuario po ON apr.fk_prontuario = po.id)
JOIN paciente pa ON po.fk_paciente = pa.id
WHERE pa.nome = 'Carla Fernandes' AND pa.nome = 'Julia Anacleto';


--14. Selecione os médicos que visitaram a paciente Carla e não visitaram a paciente Júlia

SELECT m.nome
FROM ((anotacaoProntuario apr JOIN medico m ON apr.fk_medico = m.id) JOIN pontuario po ON apr.fk_prontuario = po.id)
JOIN paciente pa ON po.fk_paciente = pa.id
WHERE pa.nome = 'Carla Fernandes' AND NOT pa.nome = 'Julia Anacleto';

--15. Selecione os pacientes ordenados por ordem alfabética

SELECT nome FROM paciente ORDER BY nome

--16. Selecione os médicos que visitaram dois ou mais pacientes no dia 05/10/2022

SELECT m.nome
FROM ((anotacaoProntuario apr JOIN medico m ON apr.fk_medico = m.id) JOIN pontuario po ON apr.fk_prontuario = po.id)
JOIN paciente pa ON po.fk_paciente = pa.id
WHERE apr.data = '2020/10/05';

--17. Selecione os pacientes (nome) que foram visitados por pelo menos 2 médicos
--durante sua estadia, já tendo sido liberados, ou seja, o status do prontuário já está
--inativo

SELECT pa.nome, COUNT(*), m.nome
FROM ((anotacaoProntuario apr JOIN medico m ON apr.fk_medico = m.id) JOIN pontuario po ON apr.fk_prontuario = po.id)
JOIN paciente pa ON po.fk_paciente = pa.id
WHERE po.status = 'inativo'
GROUP BY pa.nome, m.nome
HAVING COUNT(*) >= 2;