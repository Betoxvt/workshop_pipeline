{{ config(materialized='view') }}

WITH vendas_7_dias_produto AS (
    SELECT 
        produto,
        SUM(valor) AS total_valor, 
        SUM(quantidade) AS total_quantidade, 
        COUNT(*) AS total_vendas
    FROM 
        {{ ref('silver_vendas') }}
    WHERE 
        data >= CURRENT_DATE - INTERVAL '6 days'
    GROUP BY 
        produto
)

SELECT 
    produto, 
    total_valor, 
    total_quantidade, 
    total_vendas
FROM 
    vendas_7_dias_produto
ORDER BY
    produto ASC