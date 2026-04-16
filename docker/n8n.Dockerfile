FROM n8nio/n8n:1.123.31

# Exige privilégio máximo para poder falar com o socket do host
USER root

# Baixa o binário estático do Docker
RUN wget https://download.docker.com/linux/static/stable/x86_64/docker-24.0.9.tgz -O docker.tgz && \
    tar -xzf docker.tgz && \
    mv docker/docker /usr/bin/docker && \
    rm -rf docker docker.tgz

