FROM ubuntu:xenial
RUN apt-get update && apt-get -y install \
  netcat-openbsd curl wget mtr-tiny iputils-ping bind9-host \
  iproute2 net-tools vim tmux ssh lsof screen dtach \
  lynx psmisc strace apt-transport-https postgresql-client \
  software-properties-common gnupg jq tcpdump httpie \
  python-setuptools python3-setuptools build-essentials \
  gcc g++ make

RUN easy_install pip==9.0.1 \
  && easy_install3 pip==9.0.1 \
  && pip install boto boto3 ipython \
  && pip3 install boto boto3 ipython

RUN add-apt-repository ppa:git-core/ppa \
  && apt-get update \
  && apt-get -y install git
