-- Criação do banco de dados
DROP DATABASE IF EXISTS InterBank;
CREATE DATABASE InterBank;
USE InterBank;

-- Tabela de Clientes
CREATE TABLE Cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    data_nascimento DATE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    endereco VARCHAR(200) NOT NULL,
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Tabela de Contas
CREATE TABLE Conta (
    id_conta INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    tipo ENUM('POUPANCA', 'CORRENTE') NOT NULL,
    agencia VARCHAR(10) NOT NULL,
    numero VARCHAR(15) UNIQUE NOT NULL,
    saldo DECIMAL(15,2) DEFAULT 0.00,
    data_abertura DATETIME DEFAULT CURRENT_TIMESTAMP,
    ativa BOOLEAN DEFAULT TRUE,
    limite_credito DECIMAL(15,2) DEFAULT 0.00,
    taxa_rendimento DECIMAL(5,2) DEFAULT 0.5 COMMENT 'Apenas para poupança',
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
) ENGINE=InnoDB;

-- Tabela de Transferências
CREATE TABLE Transferencia (
    id_transferencia INT AUTO_INCREMENT PRIMARY KEY,
    id_conta_origem INT NOT NULL,
    id_conta_destino INT NOT NULL,
    valor DECIMAL(15,2) NOT NULL,
    data_transferencia DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('PENDENTE', 'CONCLUIDA', 'CANCELADA') DEFAULT 'CONCLUIDA',
    tipo ENUM('TED', 'DOC', 'PIX', 'INTERNA') NOT NULL,
    FOREIGN KEY (id_conta_origem) REFERENCES Conta(id_conta),
    FOREIGN KEY (id_conta_destino) REFERENCES Conta(id_conta)
) ENGINE=InnoDB;

-- Tabela de Saques
CREATE TABLE Saque (
    id_saque INT AUTO_INCREMENT PRIMARY KEY,
    id_conta INT NOT NULL,
    valor DECIMAL(15,2) NOT NULL,
    data_saque DATETIME DEFAULT CURRENT_TIMESTAMP,
    local VARCHAR(100) NOT NULL COMMENT 'Agência ou ATM',
    FOREIGN KEY (id_conta) REFERENCES Conta(id_conta)
) ENGINE=InnoDB;

-- Tabela de Depósitos
CREATE TABLE Deposito (
    id_deposito INT AUTO_INCREMENT PRIMARY KEY,
    id_conta INT NOT NULL,
    valor DECIMAL(15,2) NOT NULL,
    data_deposito DATETIME DEFAULT CURRENT_TIMESTAMP,
    origem VARCHAR(100) NOT NULL COMMENT 'Dinheiro, cheque, transferência',
    FOREIGN KEY (id_conta) REFERENCES Conta(id_conta)
) ENGINE=InnoDB;

-- Tabela de Extrato
CREATE TABLE Extrato (
    id_extrato INT AUTO_INCREMENT PRIMARY KEY,
    id_conta INT NOT NULL,
    tipo_operacao ENUM('DEPOSITO', 'SAQUE', 'TRANSFERENCIA', 'RENDIMENTO') NOT NULL,
    valor DECIMAL(15,2) NOT NULL,
    data_operacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    descricao VARCHAR(200),
    id_operacao INT COMMENT 'ID da operação relacionada',
    FOREIGN KEY (id_conta) REFERENCES Conta(id_conta)
) ENGINE=InnoDB;

-- Índices para melhorar performance
CREATE INDEX idx_cliente_cpf ON Cliente(cpf);
CREATE INDEX idx_conta_numero ON Conta(numero);
CREATE INDEX idx_transferencia_datas ON Transferencia(data_transferencia);
CREATE INDEX idx_extrato_conta_data ON Extrato(id_conta, data_operacao);