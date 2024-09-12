# Workshop Pipeline Gen AI
ETL com API e CRM de vendas do zero: Python, SQL, OpenAI, Langchain e Git

## Dia 01

### pgAdmin

DB > Schemas > Public  > Tables > right click > QUERY Tool
```
CREATE TABLE IF NOT EXISTS vendas (
			id SERIAL PRIMARY KEY,
			email VARCHAR(255) NOT NULL,
			data TIMESTAMP NOT NULL,
			valor NUMERIC NOT NULL,
			quantidade INTEGER NOT NULL,
			produto VARCHAR(50) NOT NULL
)
```

### Streamlit Deploy

1. push all to github (check repository name & branch on streamlit)
2. select main file
3. creat an URL
4. Click advanced settings and add the same .env variables with ""

### mkdocs

```
mkdocs new .  # Creates mkdocs.yml &  docs/index.md for configuration
mkdocs serve  # Builds documentation page and shows locally
mkdocs build  # Builds documentation to directory
mkdocs gh-deploy  # Push documentation to a GitHub new branch "gh-pages"
```

## Dia 02

### briefer

Needs docker `$ systemctl start docker`

On project `$ briefer`

### dbt

1. 
```
dbt init vendas_dbt
cd vendas_dbt
dbt debug
```
### aws
