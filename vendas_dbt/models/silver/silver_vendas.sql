{{ config(materialized='view') }}

WITH cleaned_data AS (
    SELECT 
        email, 
        DATE(data) AS data,
        ROUND(cast(valor AS DECIMAL(10,2)),2) AS valor, 
        quantidade, 
        produto
    FROM 
        {{ ref('bronze_vendas') }}
    WHERE 
        valor BETWEEN 1000 AND 6000
        AND data <= CURRENT_DATE
)

SELECT * FROM cleaned_data