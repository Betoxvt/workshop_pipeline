{{ config(materialized='view') }}

WITH vendas_7_dias_vendedor AS (
    SELECT 
        email AS vendedor, 
        SUM(valor) AS total_valor, 
        SUM(quantidade) AS total_quantidade, 
        COUNT(*) AS total_vendas
    FROM 
        {{ ref('silver_vendas') }}
    WHERE 
        data >= CURRENT_DATE - INTERVAL '6 days'
    GROUP BY 
        email
)

SELECT 
    vendedor, 
    total_valor, 
    total_quantidade, 
    total_vendas
FROM 
    vendas_7_dias_vendedor
ORDER BY 
    vendedor ASC