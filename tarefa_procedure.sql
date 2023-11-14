CREATE TABLE compras (
    id SERIAL PRIMARY KEY,
    id_produto INT,
    data_da_compra DATE
);

CREATE TABLE produtos (
    id_produto SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    preco DECIMAL(10, 2)
);

CALL calcularQuantidadeProdutosPorDia();
SELECT * FROM temp_quantidade_produtos_por_dia;

-- Criação da Procedure
CREATE OR REPLACE PROCEDURE calcularQuantidadeProdutosPorDia()
AS $$
BEGIN
    CREATE TEMP TABLE temp_quantidade_produtos_por_dia AS
        SELECT data_da_compra::date AS dia, COUNT(*) AS quantidade_total
        FROM compras
        WHERE data_da_compra >= CURRENT_DATE - interval '1' day
        GROUP BY data_da_compra::date;
END;
