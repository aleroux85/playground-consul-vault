FROM ubuntu:18.04

RUN apt-get update && apt-get install -y wget ca-certificates unzip

ENV CONSUL_VERSION 1.5.2
RUN mkdir /consul
RUN wget --quiet --output-document=/tmp/consul.zip https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip && \
    unzip /tmp/consul.zip -d /consul && \
    rm -f /tmp/consul.zip && \
    chmod +x /consul/consul
ENV PATH="/consul:${PATH}"
RUN mkdir /consul/data

RUN mkdir /app
WORKDIR /app