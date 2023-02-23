FROM golang
RUN go install github.com/rakyll/hey@latest \
	&& install $(go env GOPATH)/bin/hey /usr/local/bin -o root -g root -m 0755 \
	&& rm -rf $(go env GOPATH)

RUN apt-get update \
	&& apt-get -y install curl wget netcat python3-pip jq mtr-tiny bind9-host tmux lsof less \
		psmisc strace apt-transport-https dnsutils net-tools zip unzip gzip bzip2 xz-utils \
	&& python3 -m pip install boto3 ipython redis

RUN bash -c 'if [[ $(uname --machine) == "aarch64" ]] ; then \
		wget -O /usr/local/bin/kubectl https://s3.us-west-2.amazonaws.com/amazon-eks/1.25.6/2023-01-30/bin/linux/arm64/kubectl ;\
		wget -O /tmp/awscli.zip https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip ;\
	else \
		wget -O /usr/local/bin/kubectl https://s3.us-west-2.amazonaws.com/amazon-eks/1.25.6/2023-01-30/bin/linux/amd64/kubectl ;\
		wget -O /tmp/awscli.zip https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip ;\
	fi' \
	&& chmod +x /usr/local/bin/kubectl \
	&& cd /tmp \
	&& unzip awscli.zip \
	&& cd aws \
	&& ./install \
	&& cd \
	&& rm -rf /tmp/awscli.zip /tmp/aws
	
CMD ["/bin/sleep", "infinity"]
