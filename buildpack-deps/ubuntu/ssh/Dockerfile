FROM djx339/buildpack-deps:ubuntu-14.04
MAINTAINER Daniel D <djx339@gmail.com>

RUN apt-get update && apt-get install -y --no-install-recommends \
        openssh-server \
        supervisor \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/sshd /var/log/supervisor \
    && sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config

# supervisor configuration
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

COPY run /app/run
RUN chmod a+x /app/run

EXPOSE 22

CMD ["/app/run"]
