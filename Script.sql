--CREATE
-- Tabela: Usuario
CREATE TABLE Usuario (
    id_usuario SERIAL PRIMARY KEY,
    tipo_usuario VARCHAR(20) NOT NULL, --pode ser varchar7
    nome VARCHAR(50) NOT NULL,
	idade INT CHECK (idade >= 18),
    email VARCHAR(50) UNIQUE NOT NULL,
	CPF VARCHAR(11),
    senha VARCHAR(50) NOT NULL,
    telefone VARCHAR(20)
);

-- Tabela: Pet
CREATE TABLE Pet (
    id_pet SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    nome VARCHAR(20),
    idade INT CHECK (idade >= 0),
	animal TEXT,
    raca VARCHAR(50),
    porte VARCHAR(20),
    descricao TEXT,
    status VARCHAR(30),
    data_resgate DATE,
    CONSTRAINT fk_pet_usuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario) ON DELETE CASCADE
);

-- Tabela: Adocao
CREATE TABLE Adocao (
    id_adocao SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_pet INT NOT NULL UNIQUE,
    data_adocao DATE NOT NULL,
    formulario TEXT,
    CONSTRAINT fk_adocao_usuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario) ON DELETE CASCADE,
    CONSTRAINT fk_adocao_pet FOREIGN KEY (id_pet) REFERENCES Pet(id_pet) ON DELETE CASCADE
);

--DROP TABLE IF EXISTS Adocao, Pet, Usuario CASCADE;


--INSERT
-- Inserir usuários (protetores e adotantes)
INSERT INTO Usuario (tipo_usuario, nome, idade, email, CPF, senha, telefone) VALUES
('ONG', 'Nicolly', 20, 'nic@protetores.org', 11111111111, 'senha123', '(11) 98888-1111'),
('Cidadao', 'Jasmin', 21, 'jasmin@gmail.com', 22222222222, 'senha1', '(11) 98888-1111');

-- Inserir pets (id_usuario = protetores: 1 e 3)
INSERT INTO Pet (id_usuario, nome, idade, animal, raca, porte, descricao, status, data_resgate) VALUES
(1, 'Luna', 2,'gato' ,'Vira-lata', 'Médio', 'Cadelinha resgatada em ótimo estado.', 'Disponível', '2024-12-01');

-- Inserir adoções (id_usuario = adotantes: 2 e 4)
-- Lembrando que só 1 adoção por pet (id_pet UNIQUE)
INSERT INTO Adocao (id_usuario, id_pet, data_adocao, formulario) VALUES
(1, 1, '2025-01-10', 'Tenho experiência com gatos, moro em apartamento.');

--QUERY
select * from Adocao;
select * from pet;
select * from usuario;