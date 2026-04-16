# ESTÁGIO 1: Build
FROM node:22 AS builder

WORKDIR /usr/src/app
COPY package.json package-lock.json* ./
RUN npm install
COPY . .

RUN npm run build


# ESTÁGIO 2: Runtime
FROM node:22-slim

WORKDIR /usr/src/app
RUN apt-get update && apt-get install -y --no-install-recommends libsqlite3-0 && rm -rf /var/lib/apt/lists/*

# Copia apenas o necessário do estágio de build (economiza muita RAM)
COPY --from=builder /usr/src/app/dist ./dist
COPY --from=builder /usr/src/app/package.json ./
COPY --from=builder /usr/src/app/node_modules ./node_modules

ENTRYPOINT ["node", "dist/cli.js"]
