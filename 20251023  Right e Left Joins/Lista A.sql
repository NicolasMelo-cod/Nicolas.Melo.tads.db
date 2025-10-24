SELECT 
    c.id_cliente,
    c.nome AS nome_cliente,
    v.produto,
    v.categoria,
    v.valor,
    v.data_venda
FROM 
    CLIENTES c
    LEFT JOIN VENDAS v ON c.id_cliente = v.id_cliente
ORDER BY 
    c.id_cliente, v.data_venda;