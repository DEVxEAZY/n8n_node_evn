ADD file ... in /
CMD ["/bin/sh"]
ENV NODE_VERSION=20.15.0
RUN /bin/sh -c addgroup -g
ENV YARN_VERSION=1.22.22
RUN /bin/sh -c apk add
COPY docker-entrypoint.sh /usr/local/bin/ # buildkit
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["node"]
COPY / / # buildkit
RUN /bin/sh -c rm -rf
WORKDIR /home/node
ENV NODE_ICU_DATA=/usr/local/lib/node_modules/full-icu
EXPOSE map[5678/tcp:{}]
ARG N8N_VERSION=1.52.2
RUN |1 N8N_VERSION=1.52.2 /bin/sh -c
LABEL org.opencontainers.image.title=n8n
LABEL org.opencontainers.image.description=Workflow Automation Tool
LABEL org.opencontainers.image.source=https://github.com/n8n-io/n8n
LABEL org.opencontainers.image.url=https://n8n.io
LABEL org.opencontainers.image.version=1.52.2
ENV N8N_VERSION=1.52.2
ENV NODE_ENV=production
ENV N8N_RELEASE_TYPE=stable

# Adicionando comandos solicitados
RUN npm install redis
RUN npm install puppeteer cheerio axios
RUN npm install pg
ENV NODE_FUNCTION_ALLOW_EXTERNAL=redis,puppeteer,cheerio,axios,pg

COPY docker-entrypoint.sh / # buildkit
RUN |1 N8N_VERSION=1.52.2 /bin/sh -c
ENV SHELL=/bin/sh
USER node
ENTRYPOINT ["tini" "--" "/docker-entrypoint.sh"]
