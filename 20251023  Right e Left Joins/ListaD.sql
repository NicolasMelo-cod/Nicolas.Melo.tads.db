SELECT 
    c.cidade,
    COALESCE(SUM(v.valor), 0) AS total_vendas
FROM 
    CLIENTES c
LEFT JOIN 
    VENDAS v
ON 
    c.id_cliente = v.id_cliente
GROUP BY 
    c.cidade
ORDER BY
    c.cidade;