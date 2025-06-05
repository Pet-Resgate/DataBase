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
    sexo VARCHAR(10) CHECK (sexo IN ('macho', 'fêmea')),
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

CREATE TABLE IF NOT EXISTS public.pet
(
    id_pet integer NOT NULL DEFAULT nextval('pet_id_pet_seq'::regclass),
    id_usuario integer NOT NULL,
    nome character varying(20) COLLATE pg_catalog."default",
    idade integer,
    animal text COLLATE pg_catalog."default",
    raca character varying(50) COLLATE pg_catalog."default",
    porte character varying(20) COLLATE pg_catalog."default",
    descricao text COLLATE pg_catalog."default",
    status character varying(30) COLLATE pg_catalog."default",
    data_resgate date,
    brinca integer,
    carinhoso integer,
    sociavel integer,
    sexo character varying(10) COLLATE pg_catalog."default",
    CONSTRAINT pet_pkey PRIMARY KEY (id_pet),
    CONSTRAINT fk_pet_usuario FOREIGN KEY (id_usuario)
        REFERENCES public.usuario (id_usuario) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT pet_idade_check CHECK (idade >= 0),
    CONSTRAINT pet_brinca_check CHECK (brinca >= 1 AND brinca <= 3),
    CONSTRAINT pet_carinhoso_check CHECK (carinhoso >= 1 AND carinhoso <= 3),
    CONSTRAINT pet_sociavel_check CHECK (sociavel >= 1 AND sociavel <= 3),
    CONSTRAINT pet_sexo_check CHECK (sexo::text = ANY (ARRAY['macho'::character varying, 'fêmea'::character varying]::text[]))
)


TABLESPACE pg_default;


ALTER TABLE IF EXISTS public.pet
    OWNER to postgres;


CREATE TABLE IF NOT EXISTS public.adocao
(
    id_adocao integer NOT NULL DEFAULT nextval('adocao_id_adocao_seq'::regclass),
    id_usuario integer NOT NULL,
    id_pet integer NOT NULL,
    data_adocao date NOT NULL,
    formulario text COLLATE pg_catalog."default",
    CONSTRAINT adocao_pkey PRIMARY KEY (id_adocao),
    CONSTRAINT adocao_id_pet_key UNIQUE (id_pet),
    CONSTRAINT fk_adocao_pet FOREIGN KEY (id_pet)
        REFERENCES public.pet (id_pet) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_adocao_usuario FOREIGN KEY (id_usuario)
        REFERENCES public.usuario (id_usuario) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
)


TABLESPACE pg_default;


ALTER TABLE IF EXISTS public.adocao
    OWNER to postgres;


CREATE TABLE IF NOT EXISTS public.usuario
(
    id_usuario integer NOT NULL DEFAULT nextval('usuario_id_usuario_seq'::regclass),
    tipo_usuario character varying(20) COLLATE pg_catalog."default" NOT NULL,
    nome character varying(50) COLLATE pg_catalog."default" NOT NULL,
    idade integer,
    email character varying(50) COLLATE pg_catalog."default" NOT NULL,
    cpf character varying(11) COLLATE pg_catalog."default",
    senha character varying(50) COLLATE pg_catalog."default" NOT NULL,
    telefone character varying(20) COLLATE pg_catalog."default",
    cnpj character varying(20) COLLATE pg_catalog."default",
    CONSTRAINT usuario_pkey PRIMARY KEY (id_usuario),
    CONSTRAINT usuario_email_key UNIQUE (email),
    CONSTRAINT usuario_idade_check CHECK (idade >= 18)
)


TABLESPACE pg_default;


ALTER TABLE IF EXISTS public.usuario
    OWNER to postgres;


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
