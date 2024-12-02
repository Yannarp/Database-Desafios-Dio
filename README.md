# Projeto de Banco de Dados para E-commerce

## Descrição
Este projeto apresenta a modelagem conceitual, lógica e física de um banco de dados para um sistema de e-commerce. Ele foi projetado para atender às principais funcionalidades de um negócio digital, como gerenciamento de clientes (Pessoa Física e Jurídica), produtos, fornecedores, estoque, pedidos, pagamentos e entregas.

O sistema é robusto o suficiente para gerenciar múltiplos status de entrega, várias formas de pagamento, controle de estoque com limites definidos e rastreio de encomendas, atendendo às necessidades operacionais de um e-commerce moderno.

---

## Modelo Conceitual
### Contexto do Esquema
O modelo conceitual foi desenvolvido com base nas seguintes premissas:
1. **Cliente**:
   - Um cliente pode ser **Pessoa Física (PF)** ou **Pessoa Jurídica (PJ)**, mas não ambos.
   - Contém informações essenciais como CPF (para PF) ou CNPJ (para PJ), endereço e formas de contato.
   
2. **Produto e Estoque**:
   - Os produtos estão vinculados ao estoque, que possui um controle de **quantidade atual**, **mínima** e **máxima**.
   - Cada produto tem um ou mais fornecedores associados.

3. **Pedidos e Pagamentos**:
   - Os pedidos estão ligados a um cliente e podem incluir múltiplos produtos.
   - Cada pedido suporta várias formas de pagamento registradas, com histórico de valores pagos.

4. **Entrega**:
   - Gerenciada por status (em processamento, enviado, entregue, etc.) e código de rastreio único para cada pedido.

5. **Fornecedor**:
   - Responsável por fornecer produtos ao estoque e tem seus dados devidamente registrados.

---

### Entidades e Relacionamentos
1. **Cliente**: Relaciona-se com **Pedido**.
2. **Produto**: Relaciona-se com **Fornecedor** e **Estoque**.
3. **Pedido**: Relaciona-se com **Cliente**, **Produto**, **Pagamento** e **Entrega**.
4. **Entrega**: É vinculada diretamente ao pedido com seu status e rastreio.

O esquema busca evitar redundâncias e garantir integridade referencial, utilizando técnicas de normalização e boas práticas de design de banco de dados.

---

## Estrutura do Projeto
- **`schema.sql`**: Script SQL para criar as tabelas, chaves primárias, estrangeiras e constraints.
- **`insert_data.sql`**: Script SQL com dados fictícios para testes.
- **`queries.sql`**: Conjunto de consultas SQL para explorar e analisar os dados.

---

## Funcionalidades Principais
- Suporte a clientes PF e PJ com validações específicas.
- Registro de múltiplas formas de pagamento.
- Controle de estoque com alertas para limites mínimos.
- Rastreio detalhado de entregas com status.
- Relacionamento dinâmico entre fornecedores e produtos.

---

## Consultas Exemplares
1. **Quantidade de pedidos por cliente:**
    ```sql
    SELECT Cliente.Nome, COUNT(Pedido.ID_Pedido) AS Total_Pedidos
    FROM Cliente
    JOIN Pedido ON Cliente.ID_Cliente = Pedido.ID_Cliente
    GROUP BY Cliente.Nome;
    ```

2. **Produtos com estoque abaixo do mínimo:**
    ```sql
    SELECT Produto.Nome, Estoque.Quantidade, Estoque.Estoque_Minimo
    FROM Estoque
    JOIN Produto ON Estoque.ID_Produto = Produto.ID_Produto
    WHERE Estoque.Quantidade < Estoque.Estoque_Minimo;
    ```

3. **Pedidos e status de entrega:**
    ```sql
    SELECT Pedido.ID_Pedido, Entrega.Status, Entrega.Codigo_Rastreamento
    FROM Pedido
    JOIN Entrega ON Pedido.ID_Pedido = Entrega.ID_Pedido
    WHERE Entrega.Status != 'Entregue';
    ```

4. **Produtos e fornecedores:**
    ```sql
    SELECT Produto.Nome AS Produto, Fornecedor.Nome AS Fornecedor
    FROM Produto
    JOIN Fornece ON Produto.ID_Produto = Fornece.ID_Produto
    JOIN Fornecedor ON Fornece.ID_Fornecedor = Fornecedor.ID_Fornecedor;
    ```

---

## Como Usar
1. Clone este repositório:
   ```bash
   git clone https://github.com/SEU_USUARIO/ecommerce-banco-de-dados.git

