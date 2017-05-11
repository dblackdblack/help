FROM ubuntu:xenial
RUN apt-get update && apt-get -y install \
  netcat-openbsd curl wget mtr iputils-ping bind9-host \
  iproute2 net-tools vim tmux ssh lsof screen dtach \
  lynx psmisc strace apt-transport-https postgresql-client \
  software-properties-common gnupg

RUN add-apt-repository ppa:git-core/ppa \
  && apt-get update \
  && apt-get install git
