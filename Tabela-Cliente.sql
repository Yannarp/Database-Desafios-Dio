-- Tabela Cliente
CREATE TABLE Cliente (
    ID_Cliente INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Tipo ENUM('PF', 'PJ') NOT NULL,
    CPF CHAR(11),
    CNPJ CHAR(14),
    Telefone VARCHAR(15),
    Email VARCHAR(100),
    Endereco TEXT,
    CHECK (
        (Tipo = 'PF' AND CPF IS NOT NULL AND CNPJ IS NULL) OR 
        (Tipo = 'PJ' AND CNPJ IS NOT NULL AND CPF IS NULL)
    )
    
);

-- Tabela Fornecedor
CREATE TABLE Fornecedor (
    ID_Fornecedor INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    CNPJ CHAR(14) NOT NULL UNIQUE,
    Contato VARCHAR(100),
    Endereco TEXT
);

-- Tabela Produto
CREATE TABLE Produto (
    ID_Produto INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Descricao TEXT,
    Preco DECIMAL(10, 2) NOT NULL,
    Categoria VARCHAR(50),
    Peso DECIMAL(5, 2),
    Dimensoes VARCHAR(50),
    ID_Fornecedor INT NOT NULL,
    FOREIGN KEY (ID_Fornecedor) REFERENCES Fornecedor(ID_Fornecedor)
);

-- Tabela Estoque
CREATE TABLE Estoque (
    ID_Estoque INT AUTO_INCREMENT PRIMARY KEY,
    ID_Produto INT NOT NULL UNIQUE,
    Quantidade INT NOT NULL,
    Localizacao VARCHAR(100),
    FOREIGN KEY (ID_Produto) REFERENCES Produto(ID_Produto)
);

-- Tabela Pedido
CREATE TABLE Pedido (
    ID_Pedido INT AUTO_INCREMENT PRIMARY KEY,
    ID_Cliente INT NOT NULL,
    Data DATETIME NOT NULL,
    Total DECIMAL(10, 2) NOT NULL,
    Status ENUM('Aberto', 'Pago', 'Cancelado') DEFAULT 'Aberto',
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente)
);

-- Tabela Pagamento
CREATE TABLE Pagamento (
    ID_Pagamento INT AUTO_INCREMENT PRIMARY KEY,
    ID_Pedido INT NOT NULL,
    Tipo ENUM('Cartão', 'Boleto', 'Pix', 'Transferência') NOT NULL,
    Valor DECIMAL(10, 2) NOT NULL,
    Data DATETIME NOT NULL,
    FOREIGN KEY (ID_Pedido) REFERENCES Pedido(ID_Pedido)
);

-- Tabela Itens do Pedido
CREATE TABLE Itens_Pedido (
    ID_Item_Pedido INT AUTO_INCREMENT PRIMARY KEY,
    ID_Pedido INT NOT NULL,
    ID_Produto INT NOT NULL,
    Quantidade INT NOT NULL,
    Preco_Unitario DECIMAL(10, 2) NOT NULL,
    Total_Item DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (ID_Pedido) REFERENCES Pedido(ID_Pedido),
    FOREIGN KEY (ID_Produto) REFERENCES Produto(ID_Produto)
);

-- Tabela Entrega
CREATE TABLE Entrega (
    ID_Entrega INT AUTO_INCREMENT PRIMARY KEY,
    ID_Pedido INT NOT NULL,
    Codigo_Rastreio VARCHAR(50) NOT NULL,
    Status ENUM('Em preparação', 'Em transporte', 'Entregue', 'Cancelada') DEFAULT 'Em preparação',
    Data_Envio DATETIME,
    Data_Entrega DATETIME,
    FOREIGN KEY (ID_Pedido) REFERENCES Pedido(ID_Pedido)
);


