
CREATE DATABASE IDP;
USE IDP;

CREATE TABLE professores (
    id_professor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(15),
    departamento VARCHAR(50),
    data_contratacao DATE NOT NULL,
    status ENUM('ativo', 'inativo', 'afastado') DEFAULT 'ativo'
);

CREATE TABLE veiculos (
    id_veiculo INT PRIMARY KEY AUTO_INCREMENT,
    id_professor INT NOT NULL,
    placa VARCHAR(10) UNIQUE NOT NULL,
    marca VARCHAR(30) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    cor VARCHAR(30) NOT NULL,
    ano INT,
    FOREIGN KEY (id_professor) REFERENCES professores(id_professor) ON DELETE CASCADE
);


CREATE TABLE reservas (
    id_reserva INT PRIMARY KEY AUTO_INCREMENT,
    id_professor INT NOT NULL,
    id_veiculo INT NOT NULL,
    data_reserva DATE NOT NULL,
    periodo ENUM('manhã', 'tarde', 'noite', 'integral') NOT NULL,
    status ENUM('confirmada', 'cancelada', 'utilizada') DEFAULT 'confirmada',
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_professor) REFERENCES professores(id_professor),
    FOREIGN KEY (id_veiculo) REFERENCES veiculos(id_veiculo)
);

CREATE TABLE tag_estacionamento (
    id_tag INT PRIMARY KEY AUTO_INCREMENT,
    id_professor INT NOT NULL,
    id_veiculo INT NOT NULL,
    codigo_tag VARCHAR(20) UNIQUE NOT NULL,
    data_emissao DATE NOT NULL,
    data_ativacao DATE,
    status ENUM('ativo', 'inativo', 'pendente', 'bloqueado', 'problema') DEFAULT 'pendente',
    problema_reportado TEXT,
    FOREIGN KEY (id_professor) REFERENCES professores(id_professor),
    FOREIGN KEY (id_veiculo) REFERENCES veiculos(id_veiculo)
);

CREATE TABLE pagamentos (
    id_pagamento INT PRIMARY KEY AUTO_INCREMENT,
    id_professor INT NOT NULL,
    forma_pagamento ENUM('Visa', 'Mastercard', 'Amex', 'Débito', 'Boleto', 'Pix') NOT NULL,
    valor_mensal DECIMAL(10,2) NOT NULL,
    data_inicio DATE NOT NULL,
    data_vencimento DATE NOT NULL,
    meses_gratis INT DEFAULT 0,
    data_inicio_gratuidade DATE,
    status ENUM('pago', 'pendente', 'atrasado', 'isento') DEFAULT 'pendente',
    FOREIGN KEY (id_professor) REFERENCES professores(id_professor)
);

CREATE TABLE acessos_estacionamento (
    id_acesso INT PRIMARY KEY AUTO_INCREMENT,
    id_tag INT,
    id_veiculo INT,
    data_hora_entrada DATETIME NOT NULL,
    data_hora_saida DATETIME,
    metodo_acesso ENUM('tag', 'manual', 'reserva') NOT NULL,
    observacoes TEXT,
    FOREIGN KEY (id_tag) REFERENCES tag_estacionamento(id_tag),
    FOREIGN KEY (id_veiculo) REFERENCES veiculos(id_veiculo)
);

CREATE TABLE problemas_tags (
    id_problema INT PRIMARY KEY AUTO_INCREMENT,
    id_tag INT NOT NULL,
    id_professor INT NOT NULL,
    data_reportagem DATE NOT NULL,
    tipo_problema ENUM('não funciona', 'não reconhecida', 'danificada', 'outro') NOT NULL,
    descricao TEXT NOT NULL,
    status ENUM('aberto', 'em análise', 'resolvido', 'fechado') DEFAULT 'aberto',
    FOREIGN KEY (id_tag) REFERENCES tag_estacionamento(id_tag),
    FOREIGN KEY (id_professor) REFERENCES professores(id_professor)
);

-- No final, será realizado um “DROP TABLE reservas;” quando o novo sistema for implementado