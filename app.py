import streamlit as st
from contrato import Vendas
from database import salvar_no_postgres
from datetime import datetime, time
from pydantic import ValidationError

def main():
    st.title('Sistema de CRM e Vendas da ZapFlow - Frontend Simples')
    email = st.text_input('Email do vendedor')
    data = st.date_input('Data da venda', datetime.now())
    hora = st.time_input('Hora da venda', value=time(9,0))
    valor = st.number_input('Valor da venda', min_value=0.0, format='%.2f')
    quantidade = st.number_input('Quantidade de produtos')
    produto = st.selectbox('Produto', options=['ZapFlow com Gemini', 'ZapFlow com ChatGPT', 'ZapFlow com Llama3.0'])

    if st.button('Salvar'):
        try:
            data_hora = datetime.combine(data, hora)
            venda = Vendas(
                email = email.lower(),
                data = data_hora,
                valor = valor,
                quantidade = quantidade,
                produto = produto
            )
            salvar_no_postgres(venda)
        except ValidationError as e:
            st.error(f'Erro: {e}')


if __name__ == '__main__':
    main()
