# Use a imagem base do n8n
FROM n8nio/n8n

# Instalar o módulo redis
RUN npm install redis

# Instalar bibliotecas adicionais de automação web
RUN npm install puppeteer cheerio axios

# Instalar biblioteca para PostgreSQL
RUN npm install pg

# Definir variáveis de ambiente
ENV NODE_FUNCTION_ALLOW_EXTERNAL=redis,puppeteer,cheerio,axios,pg

# Comandos adicionais para configurar o n8n (exemplo)
# Copiar arquivos de configuração, se necessário
# COPY ./config.json /home/node/.n8n/

# Exemplo de comando para iniciar o n8n (não obrigatório, pois a imagem base já cuida disso)
# CMD ["n8n"]

# Expor a porta padrão do n8n
EXPOSE 5678

# Adicionar comando de execução
CMD ["sh", "-c", "docker run -it --rm \
  --name n8n \
  -p 5678:5678 \
  -e DB_TYPE=postgresdb \
  -e DB_POSTGRESDB_DATABASE=${POSTGRES_DATABASE} \
  -e DB_POSTGRESDB_HOST=${POSTGRES_HOST} \
  -e DB_POSTGRESDB_PORT=${POSTGRES_PORT} \
  -e DB_POSTGRESDB_USER=${POSTGRES_USER} \
  -e DB_POSTGRESDB_SCHEMA=${POSTGRES_SCHEMA} \
  -e DB_POSTGRESDB_PASSWORD=${POSTGRES_PASSWORD} \
  -v ~/.n8n:/home/node/.n8n \
  docker.n8n.io/n8nio/n8n \
  n8n start"]
