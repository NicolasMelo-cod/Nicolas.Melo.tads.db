SELECT
    c.nome AS Cliente,
    c.cidade
FROM
    CLIENTES c
    LEFT JOIN VENDAS v ON c.id_cliente = v.id_cliente
WHERE
    v.id IS null;
INSERT INTO CLIENTES (nome, cidade, estado) VALUES
('Daniel', 'Belo Horizonte', 'MG'); -- cliente sem vendas