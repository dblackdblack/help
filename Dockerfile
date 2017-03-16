FROM ubuntu:xenial
RUN apt-get update && apt-get -y install netcat-openbsd curl wget mtr iputils-ping

