FROM debian:latest

MAINTAINER Minh-Quan TRAN "xwiron@aliyun.com"

RUN apt-get update && \
    apt-get install -y vim && \
	apt-get install -y openssh-server && \
	rm -rf /var/lib/apt/lists/* && \
	apt-get clean

RUN echo 'root:root' |chpasswd

RUN groupadd iron && \
	useradd -g iron iron  && \
	cp -r /etc/skel /home/iron  && \
	chown -R iron:iron /home/iron

RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
	sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN mkdir -p /var/run/sshd
	
EXPOSE 22

CMD    ["/usr/sbin/sshd", "-D"]
