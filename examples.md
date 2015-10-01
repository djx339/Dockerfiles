FROM ubuntu:14.04
MAINTAINER Daniel D <djx339@gmail.com>

# Ubuntu/Debain install deps
RUN apt-get update && apt-get install -y \
        vim \
    --no-install-recommends && rm -rf /var/lib/apt/lists/*

# Install java7
RUN apt-get update && apt-get install -y software-properties-common --no-install-recommends \
    && add-apt-repository -y ppa:webupd8team/java \
    && echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections \
    && apt-get update && apt-get install -y oracle-java7-installer --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Install ssh server
RUN apt-get update && apt-get install -y \
        openssh-server \
    --no-install-recommends && rm -rf /var/lib/apt/lists/* \

RUN mkdir -p /var/run/sshd \
    && echo 'root:password' | chpasswd \
    && sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config


# Install Supervisor
RUN apt-get update && apt-get install -y \
        supervisor \
    --no-install-recommends && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/log/supervisor

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord"]

# supervisord.conf
```
[supervisord]
nodaemon=true

[program:sshd]
command=/usr/sbin/sshd -D
```
