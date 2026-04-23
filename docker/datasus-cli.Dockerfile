# ESTÁGIO 1: Build
FROM node:22 AS builder

WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y --no-install-recommends gcc make && rm -rf /var/lib/apt/lists/*

COPY deps/blast-dbf ./deps/blast-dbf
RUN make -C deps/blast-dbf

COPY package.json package-lock.json* ./
RUN npm install
COPY . .

RUN npm run build


# ESTÁGIO 2: Runtime
FROM node:22-slim

WORKDIR /usr/src/app
RUN apt-get update && apt-get install -y --no-install-recommends libsqlite3-0 && rm -rf /var/lib/apt/lists/*

COPY --from=builder /usr/src/app/deps/blast-dbf/blast-dbf ./deps/blast-dbf/blast-dbf

COPY --from=builder /usr/src/app/dist ./dist
COPY --from=builder /usr/src/app/package.json ./
COPY --from=builder /usr/src/app/node_modules ./node_modules
ENTRYPOINT ["node", "dist/cli.js"]
