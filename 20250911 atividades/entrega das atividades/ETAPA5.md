
-- Etapa 5: Tabela de Relatório Mensal (Desnormalizada)
-- Objetivo: consultas rápidas para BI, sem JOINs
-- Violação intencional da 2FN/3FN para otimização

CREATE TABLE relatorio_mensal (
    id_relatorio INT PRIMARY KEY,            -- Identificador único do relatório
    nome_cliente VARCHAR(100),               -- Nome do cliente (redundante)
    nome_tipo_concreto VARCHAR(50),          -- Tipo de concreto (redundante)
    valor_unitario DECIMAL(10,2),           -- Valor unitário do concreto
    quantidade DECIMAL(10,2),               -- Quantidade vendida
    valor_total DECIMAL(10,2),              -- Valor total (valor_unitario * quantidade)
    data_pedido DATE                         -- Data do pedido
);

-- Inserção de dados de exemplo (desnormalizados)

INSERT INTO relatorio_mensal (id_relatorio, nome_cliente, nome_tipo_concreto, valor_unitario, quantidade, valor_total, data_pedido)
VALUES 
(1, 'Construtora ABC', 'Concreto Grau 30', 120.50, 10, 1205.00, '2025-09-01'),
(2, 'Construtora ABC', 'Concreto Grau 40', 150.75, 8, 1206.00, '2025-09-01'),
(3, 'Construtora XYZ', 'Concreto Grau 30', 120.50, 15, 1807.50, '2025-09-02'),
(4, 'Construtora XYZ', 'Concreto Grau 35', 130.00, 12, 1560.00, '2025-09-02'),
(5, 'Construtora LMN', 'Concreto Grau 40', 150.75, 5, 753.75, '2025-09-03'),
(6, 'Construtora LMN', 'Concreto Grau 30', 120.50, 20, 2410.00, '2025-09-03');

-- Exemplo de consulta rápida (sem JOINs)

-- Total vendido por cliente no mês
SELECT nome_cliente, SUM(valor_total) AS total_mes
FROM relatorio_mensal
GROUP BY nome_cliente;

-- Total vendido por tipo de concreto
SELECT nome_tipo_concreto, SUM(valor_total) AS total_tipo
FROM relatorio_mensal
GROUP BY nome_tipo_concreto;

-- Pedidos de uma data específica
SELECT
FROM relatorio_mensal
WHERE data_pedido = '2025-09-01';