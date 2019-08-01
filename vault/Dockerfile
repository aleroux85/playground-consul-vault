FROM ubuntu:18.04

RUN apt-get update && apt-get install -y wget ca-certificates unzip curl jq

ENV VAULT_VERSION 1.1.3
RUN mkdir /vault
RUN wget --quiet --output-document=/tmp/vault.zip https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip && \
    unzip /tmp/vault.zip -d /vault && \
    rm -f /tmp/vault.zip && \
    chmod +x /vault
ENV PATH="/vault:${PATH}"

RUN mkdir /app
WORKDIR /app

RUN mkdir /app/consul
RUN mkdir /app/consul/config
RUN mkdir /app/consul/data