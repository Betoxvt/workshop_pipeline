from datetime import datetime
from typing import Tuple
from pydantic import BaseModel, EmailStr, validate_call, PositiveFloat, PositiveInt
from enum import Enum

class ProdutoEnum(str, Enum):
    produto1 = 'ZapFlow com Gemini'
    produto2 = 'ZapFlow com ChatGPT'
    produto3 = 'ZapFlow com Llama3.0'

class Vendas(BaseModel):
    """
    Modelo de dados para as vendas.

    Args:
        email (EmailStr): email do vendedor
        data (datetime): data da venda
        valor (PositiveFloat): valor da venda
        quantidade (PositiveInt): quantidade de produtos
        produto (ProdutoEnum): categoria do produto
    """
    email: EmailStr
    data: datetime
    valor: PositiveFloat
    quantidade: PositiveInt
    produto: ProdutoEnum
