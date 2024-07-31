# Use a base image apropriada
FROM node:20.15.0-alpine

# Definindo variáveis de ambiente
ENV NODE_VERSION=20.15.0
ENV YARN_VERSION=1.22.22
ENV N8N_VERSION=1.52.2
ENV NODE_ICU_DATA=/usr/local/lib/node_modules/full-icu
ENV NODE_ENV=production
ENV N8N_RELEASE_TYPE=stable
ENV NODE_FUNCTION_ALLOW_EXTERNAL=redis,puppeteer,cheerio,axios,pg
ENV SHELL=/bin/sh

# Instalando dependências do sistema
RUN apk add --no-cache \
    bash \
    tini \
    su-exec \
    redis

# Definindo diretório de trabalho
WORKDIR /home/node

# Copiando arquivos necessários
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
COPY . .

# Instalando pacotes npm
RUN npm install --global yarn && \
    yarn install --production --frozen-lockfile && \
    npm install redis puppeteer cheerio axios pg

# Expondo porta necessária
EXPOSE 5678

# Definindo metadados da imagem
LABEL org.opencontainers.image.title="n8n"
LABEL org.opencontainers.image.description="Workflow Automation Tool"
LABEL org.opencontainers.image.source="https://github.com/n8n-io/n8n"
LABEL org.opencontainers.image.url="https://n8n.io"
LABEL org.opencontainers.image.version="1.52.2"

# Configurando usuário para execução
USER node

# Definindo ponto de entrada e comando padrão
ENTRYPOINT ["tini", "--", "/usr/local/bin/docker-entrypoint.sh"]
CMD ["node"]
