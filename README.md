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

### Briefer for SQL and Dashboards

Needs docker `$ systemctl start docker`

On project `$ briefer`

### Create Bronze, Silver and Gold architecture using dbt

1. 
```
dbt init vendas_dbt
cd vendas_dbt
dbt debug
```
2. 
CREATE sources.yml inside models directory and configure.

CREATE folders for bronze, silver and gold inside models directory.

First, try the querys on a client like Briefer or pgAdmin, if its OK pass them to dbt, a few adjusts are necessary on the code. For example:
```
{{ config(materialized='view') }}
...
    FROM 
        {{ ref('bronze_vendas') }}
```

The SQL query scripts.
bronze uses source(raw)
silver uses bronze
gold uses silver

`dbt run`

Now you can use bronze, silver and gold models inside briefer.

schema.yml is a model documentation (inside gold folder)

`dbt docs generate` for a documentation page (catalog.json), a fantastic auto-generated one.

`dbt docs serve --port 8081`

[!CAUTION]
Do NOT use same table name for the new tables, or you will lose your data.

### Migrate DataBase and Refactor project  to AWS

AWS blocks everything and everyone by default. Needs more configuration but it is more secure from start. Security Group (firewall) Port and IP; Network (public or private); IAM (user access)

AWS > Select Zone > RDS > Create DataBase > PostgreSQL > select Model (free tier) > and many configurations > aditional config. dbname (use the .env one)

Download .csv (all db).

dbt seed folder: sends any file.csv to a DataBase.

~/.dbt/profiles.yml sotres all of your profiles. And inside your project dbt_project.yml configures what profile is used.

So you need to create a new profile for aws host, etc.

Now edit rules in AWS EC2 > Security Groups (like a firewall) to allow access (IP, PORT). Check your IP at AWS. Or a Bastion Host (use a private subnet with VPC endpoint using SSH).

`dbt seed` Inserts .csv to AWS DataBase

now you can open at briefer using the new host from aws. `dbt run` again to access gold and all.