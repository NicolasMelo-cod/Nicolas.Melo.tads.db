SELECT
    v.id AS id_venda,
    v.produto,
    v.categoria,
    v.valor,
    v.data_venda,
    NVL(c.nome, 'Sem Cliente') AS nome_cliente
FROM
    VENDAS v
    LEFT JOIN CLIENTES c ON v.id_cliente = c.id_cliente
ORDER BY
    v.id;