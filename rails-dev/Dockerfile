FROM rails
MAINTAINER Daniel D <djx339@gmail.com>

# Install deps
RUN apt-get update && apt-get install -y \
        build-essential \
        cmake \
        vim \
        openssh-server \
        python-dev \
        supervisor \
    --no-install-recommends && rm -rf /var/lib/apt/lists/*

# Setup ssh server
RUN mkdir /var/run/sshd \
    && echo 'root:password' | chpasswd \
    && sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Setup supervisord
RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Setup dev env
RUN git clone https://github.com/djx339/dotfiles.git ~/dotfiles

EXPOSE 22 3000

CMD ["/usr/bin/supervisord"]
