FROM ubuntu:focal

ENV KUBECTL_VERSION=v1.23.3 \
    KUBECTL_SHA256=d7da739e4977657a3b3c84962df49493e36b09cc66381a5e36029206dd1e01d0 \
    TZ=America/Los_Angeles \
    DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get -y install \
    netcat-openbsd curl wget mtr-tiny iputils-ping bind9-host \
    iproute2 net-tools vim tmux ssh lsof screen dtach dnsutils \
    lynx psmisc strace apt-transport-https postgresql-client \
    software-properties-common gnupg jq tcpdump httpie \
    python3-pip build-essential \
    gcc g++ make locales traceroute groff \
  && apt-get clean \
  && ln -sf /bin/bash /bin/sh

RUN add-apt-repository ppa:git-core/ppa \
  && apt-get update \
  && apt-get -y install git \
  && apt-get clean \
  && export KUBECTL_URL=https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
  && wget -O /usr/local/bin/kubectl ${KUBECTL_URL} \
  && echo "${KUBECTL_SHA256} /usr/local/bin/kubectl" | sha256sum --check \
  && chmod +x /usr/local/bin/kubectl

ENV PYTHON_PACKAGES="boto boto3 ipython redis awscli"

RUN pip3 install $PYTHON_PACKAGES

ADD ["https://hey-release.s3.us-east-2.amazonaws.com/hey_linux_amd64", "/usr/local/bin/hey"]
RUN chmod +x /usr/local/bin/hey

CMD ["bash", "-xec", "exec sleep infinity"]
