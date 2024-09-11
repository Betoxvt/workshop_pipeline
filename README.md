# Workshop Pipeline Gen AI
ETL com API e CRM de vendas do zero: Python, SQL, OpenAI, Langchain e Git

## pgAdmin

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