# ESTÁGIO 1: Build (Onde a mágica do patch acontece)
FROM node:22 AS builder

WORKDIR /usr/src/app

# 1. Copia arquivos de definição de dependências
COPY package.json package-lock.json* ./

# 2. Instala dependências (incluindo o compilador TypeScript)
RUN npm install

# 3. Copia TODO o código fonte
# É aqui que entra o seu arquivo 'src/lib/transform.ts' já editado
COPY . .

# 4. Compila o projeto (Gera a pasta /dist com o código corrigido)
RUN npm run build


# ESTÁGIO 2: Runtime (Imagem leve para rodar no Coolify)
FROM node:22-slim

WORKDIR /usr/src/app

# Instala bibliotecas de sistema para manipulação de arquivos legados (DBF/DBC)
RUN apt-get update && apt-get install -y --no-install-recommends \
    libsqlite3-0 \
    && rm -rf /var/lib/apt/lists/*

# Copia apenas o necessário do estágio de build (economiza muita RAM)
COPY --from=builder /usr/src/app/dist ./dist
COPY --from=builder /usr/src/app/package.json ./
COPY --from=builder /usr/src/app/node_modules ./node_modules

# O n8n vai disparar esse container, então definimos o ponto de entrada
ENTRYPOINT ["node", "dist/index.js"]
