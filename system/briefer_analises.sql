SELECT
    DISTINCT DATE(data) AS dia,
    COUNT(data) as qtd
FROM
    vendas
GROUP BY
    data
ORDER BY
    dia ASC



SELECT
    DISTINCT valor AS d_valor,
    COUNT(valor) AS qtd
FROM
    vendas
GROUP BY
    valor
ORDER BY
    d_valor ASC



SELECT
    DATE(data) AS dia,
    SUM(valor) AS total_vendas,
    COUNT(*) AS total_transacoes
FROM
    vendas
WHERE
    data >= CURRENT_DATE - INTERVAL '6 days'
    AND data < CURRENT_DATE + INTERVAL '1 day'
GROUP BY
    DATE(data)
ORDER BY
    dia DESC



WITH minha_cte_no_briefer AS (
    SELECT
        *
    FROM
        vendas
    WHERE
        valor BETWEEN 1000 AND 6000
        AND data >= CURRENT_DATE - INTERVAL '6 days'
        AND data < CURRENT_DATE + INTERVAL '1 day'
)

SELECT
    count(*)
FROM
    minha_cte_no_briefer



WITH vendas_filtradas AS (
    SELECT 
        email, 
        DATE(data) AS dia, 
        valor, 
        quantidade, 
        produto 
    FROM 
        vendas 
    WHERE 
        valor BETWEEN 1000 AND 6000
        AND data >= CURRENT_DATE - INTERVAL '6 days'
        AND data < CURRENT_DATE + INTERVAL '1 day'
),
vendas_agregadas AS (
    SELECT 
        dia, 
        produto, 
        SUM(valor) AS total_valor, 
        SUM(quantidade) AS total_quantidade,
        COUNT(*) AS total_vendas
    FROM 
        vendas_filtradas
    GROUP BY 
        dia, 
        produto
)
SELECT 
    dia, 
    produto, 
    total_valor, 
    total_quantidade, 
    total_vendas
FROM 
    vendas_agregadas
ORDER BY 
    dia ASC, produto ASC;



WITH vendas_por_vendedor AS (
    SELECT 
        email AS vendedor, 
        DATE(data) AS dia, 
        valor, 
        quantidade, 
        produto 
    FROM 
        vendas 
    WHERE 
        valor BETWEEN 1000 AND 6000
        AND data >= CURRENT_DATE - INTERVAL '6 days'
        AND data < CURRENT_DATE + INTERVAL '1 day'
),
vendas_aggregated_vendedor AS (
    SELECT 
        vendedor, 
        dia, 
        SUM(valor) AS total_valor, 
        SUM(quantidade) AS total_quantidade, 
        COUNT(*) AS total_vendas
    FROM 
        vendas_por_vendedor
    GROUP BY 
        vendedor, 
        dia
)
SELECT 
    vendedor, 
    dia, 
    total_valor, 
    total_quantidade, 
    total_vendas
FROM 
    vendas_aggregated_vendedor
ORDER BY 
    dia ASC, vendedor ASC;