import os
import polars as pl
import streamlit as st
from datetime import datetime
from dotenv import load_dotenv
from groq import Groq

load_dotenv()

# Configura o cliente Groq usando a chave da API do ambiente
client = Groq(api_key=os.getenv("GROQ_API_KEY"))


# Função para ler o json
def carregar_dados():
    return pl.read_json('gold_vendas_7_dias.json')


# Função para gerar resposta do Groq com base no agente selecionado
def responder_pergunta(pergunta, dados, agente_tipo):
    data_atual = datetime.now().strftime('%d%m%Y')

    # Definindo o contexto de acordo com o tipo de agente selecionado
    if agente_tipo == 'Robô Comercial para Dados':
        contexto = (
            f'Hoje é {data_atual}. Você é um robô comercial especializado em análise de dados de vendas.'
            f'Os dados de vendas dos últimos 7 dias são: {dados.to_dicts()}.'
            f'Sua função é responder perguntas sobre esses dados de forma direta e objetiva, sem especulações.'
            f'Nunca responda algo que não esteja nos dados ou fora do contexto fornecido.'
        )
    elif agente_tipo == "Análise Comercial Avançada":
        contexto = (
            f"Hoje é {data_atual}. Você é um analista comercial avançado especializado em estratégias de vendas. "
            f"Os dados de vendas dos últimos 7 dias são: {dados.to_dicts()}. "
            f"Sua função é sugerir estratégias de vendas baseadas nos dados, respondendo perguntas e oferecendo insights. "
            f"Nunca responda algo que não tenha nos dados ou seja fora do contexto fornecido."
        )
    
    chat_completion = client.chat.completions.create(
        messages=[
            {
                'role': 'user',
                'content': f'{contexto}\n\nPergunta: {pergunta}'
            }
        ],
        model='llama3-8b-8192'
    )
    return chat_completion.choices[0].message.content.strip()


# Interface do Streamlit
st.title('Agente de Atendimento - Escolha seu Analista')

# Escolha do tipo de agente
agente_tipo = st.selectbox(
    'Escolha o tipo de agente para suas análises: ',
    ['Robô Comercial para Dados', 'Análise Comercial Avançada']
)

# Carregar e exibir dados
dados =  carregar_dados()

# Caixa de entrada para perguntas
pergunta = st.text_input('Digite sua pergunta ou peça uma estratégia: ')

# Quando uma pergunta é feita
if pergunta:
    resposta = responder_pergunta(pergunta, dados, agente_tipo)
    st.write(f'Resposta do {agente_tipo}: {resposta}')
