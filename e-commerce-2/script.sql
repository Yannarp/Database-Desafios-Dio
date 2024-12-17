-- Script para criação do banco de dados do E-commerce

-- Criação do Banco de Dados
CREATE DATABASE Ecommerce;
USE Ecommerce;

-- Tabela Cliente
CREATE TABLE Cliente (
    ID_Cliente INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Telefone VARCHAR(15),
    Endereco TEXT NOT NULL,
    Tipo ENUM('PF', 'PJ') NOT NULL,
    CPF VARCHAR(11) UNIQUE,
    CNPJ VARCHAR(14) UNIQUE,
    CHECK (
        (Tipo = 'PF' AND CPF IS NOT NULL AND CNPJ IS NULL) OR
        (Tipo = 'PJ' AND CNPJ IS NOT NULL AND CPF IS NULL)
    )
);

-- Tabela Produto
CREATE TABLE Produto (
    ID_Produto INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Descricao TEXT,
    Preco DECIMAL(10, 2) NOT NULL,
    Categoria VARCHAR(50)
);

-- Tabela Estoque
CREATE TABLE Estoque (
    ID_Estoque INT AUTO_INCREMENT PRIMARY KEY,
    ID_Produto INT NOT NULL,
    Quantidade INT NOT NULL DEFAULT 0,
    Estoque_Minimo INT NOT NULL,
    Estoque_Maximo INT NOT NULL,
    FOREIGN KEY (ID_Produto) REFERENCES Produto(ID_Produto)
);

-- Tabela Fornecedor
CREATE TABLE Fornecedor (
    ID_Fornecedor INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Telefone VARCHAR(15),
    Endereco TEXT NOT NULL
);

-- Tabela Fornece (Relacionamento Produto-Fornecedor)
CREATE TABLE Fornece (
    ID_Produto INT NOT NULL,
    ID_Fornecedor INT NOT NULL,
    PRIMARY KEY (ID_Produto, ID_Fornecedor),
    FOREIGN KEY (ID_Produto) REFERENCES Produto(ID_Produto),
    FOREIGN KEY (ID_Fornecedor) REFERENCES Fornecedor(ID_Fornecedor)
);

-- Tabela Pedido
CREATE TABLE Pedido (
    ID_Pedido INT AUTO_INCREMENT PRIMARY KEY,
    ID_Cliente INT NOT NULL,
    Data_Pedido DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Valor_Total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente)
);

-- Tabela Pagamento
CREATE TABLE Pagamento (
    ID_Pagamento INT AUTO_INCREMENT PRIMARY KEY,
    ID_Pedido INT NOT NULL,
    Forma_Pagamento VARCHAR(50) NOT NULL,
    Valor_Pago DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (ID_Pedido) REFERENCES Pedido(ID_Pedido)
);

-- Tabela ItemPedido (Relacionamento Produto-Pedido)
CREATE TABLE ItemPedido (
    ID_Item INT AUTO_INCREMENT PRIMARY KEY,
    ID_Pedido INT NOT NULL,
    ID_Produto INT NOT NULL,
    Quantidade INT NOT NULL,
    Preco_Unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (ID_Pedido) REFERENCES Pedido(ID_Pedido),
    FOREIGN KEY (ID_Produto) REFERENCES Produto(ID_Produto)
);

-- Tabela Entrega
CREATE TABLE Entrega (
    ID_Entrega INT AUTO_INCREMENT PRIMARY KEY,
    ID_Pedido INT NOT NULL,
    Status VARCHAR(50) NOT NULL,
    Codigo_Rastreamento VARCHAR(100),
    Data_Entrega DATETIME,
    FOREIGN KEY (ID_Pedido) REFERENCES Pedido(ID_Pedido)
);

-- Inserção de Dados para Testes
-- Inserir alguns clientes
INSERT INTO Cliente (Nome, Email, Telefone, Endereco, Tipo, CPF) 
VALUES ('João Silva', 'joao@gmail.com', '11999999999', 'Rua A, 123', 'PF', '12345678901');

INSERT INTO Cliente (Nome, Email, Telefone, Endereco, Tipo, CNPJ) 
VALUES ('Empresa X', 'empresa@gmail.com', '1133334444', 'Av. B, 456', 'PJ', '98765432000112');

-- Inserir alguns produtos
INSERT INTO Produto (Nome, Descricao, Preco, Categoria) 
VALUES ('Notebook', 'Notebook Dell 16GB RAM', 5000.00, 'Eletrônicos');

INSERT INTO Produto (Nome, Descricao, Preco, Categoria) 
VALUES ('Smartphone', 'iPhone 14 Pro Max', 7000.00, 'Eletrônicos');

-- Inserir fornecedores
INSERT INTO Fornecedor (Nome, Email, Telefone, Endereco) 
VALUES ('Fornecedor A', 'fornecedora@gmail.com', '1144445555', 'Rua C, 789');

-- Vincular fornecedores aos produtos
INSERT INTO Fornece (ID_Produto, ID_Fornecedor) 
VALUES (1, 1);

-- Inserir pedidos e pagamentos
INSERT INTO Pedido (ID_Cliente, Valor_Total) 
VALUES (1, 1500.00);

INSERT INTO Pagamento (ID_Pedido, Forma_Pagamento, Valor_Pago) 
VALUES (1, 'Cartão de Crédito', 1500.00);

-- Consultas complexas
-- 1. Quantidade de pedidos por cliente
SELECT Cliente.Nome, COUNT(Pedido.ID_Pedido) AS Total_Pedidos
FROM Cliente
JOIN Pedido ON Cliente.ID_Cliente = Pedido.ID_Cliente
GROUP BY Cliente.Nome;

-- 2. Produtos com estoque abaixo do mínimo
SELECT Produto.Nome, Estoque.Quantidade, Estoque.Estoque_Minimo
FROM Estoque
JOIN Produto ON Estoque.ID_Produto = Produto.ID_Produto
WHERE Estoque.Quantidade < Estoque.Estoque_Minimo;

-- 3. Pedidos com status de entrega
SELECT Pedido.ID_Pedido, Entrega.Status, Entrega.Codigo_Rastreamento
FROM Pedido
JOIN Entrega ON Pedido.ID_Pedido = Entrega.ID_Pedido;

-- 4. Relação de produtos e fornecedores
SELECT Produto.Nome AS Produto, Fornecedor.Nome AS Fornecedor
FROM Produto
JOIN Fornece ON Produto.ID_Produto = Fornece.ID_Produto
JOIN Fornecedor ON Fornece.ID_Fornecedor = Fornecedor.ID_Fornecedor;
