FROM python:3.13.5-alpine3.22

# Etapa 2: Definir o diretório de trabalho dentro do contêiner
WORKDIR /app

# Etapa 3: Copiar o arquivo de dependências
# Copiamos primeiro para aproveitar o cache do Docker. Se este arquivo não mudar,
# o passo de instalação das dependências não será executado novamente.
COPY requirements.txt .

# Etapa 4: Instalar as dependências
# O --no-cache-dir ajuda a manter a imagem menor.
RUN pip install --no-cache-dir -r requirements.txt

# Etapa 5: Copiar o código da aplicação
COPY . .

EXPOSE 8000

# Etapa 6: Comando para iniciar a aplicação
# Expõe a porta 8000 e inicia o servidor Uvicorn.
# O host 0.0.0.0 torna a aplicação acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
