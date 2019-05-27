FROM ubuntu:bionic
RUN apt-get update && apt-get -y install \
    netcat-openbsd curl wget mtr-tiny iputils-ping bind9-host \
    iproute2 net-tools vim tmux ssh lsof screen dtach dnsutils \
    lynx psmisc strace apt-transport-https postgresql-client \
    software-properties-common gnupg jq tcpdump httpie \
    python-pip python3-pip build-essential \
    gcc g++ make locales traceroute groff \
  && apt-get clean \
  && ln -sf /bin/bash /bin/sh

RUN add-apt-repository ppa:git-core/ppa \
  && apt-get update \
  && apt-get -y install git \
  && apt-get clean

RUN pip install $PYTHON_PACKAGES \
  && pip3 install $PYTHON_PACKAGES \
  && pip3 install awscli

CMD ["bash", "-xec", "exec sleep infinity"]
