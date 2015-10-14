FROM djx339/buildpack-deps:ubuntu-14.04-sshd
MAINTAINER Daniel D <djx339@gmail.com>

ENV RUBY_MAJOR 2.2
ENV RUBY_VERSION 2.2.3
ENV RUBY_DOWNLOAD_SHA256 df795f2f99860745a416092a4004b016ccf77e8b82dec956b120f18bdc71edce
ENV RUBYGEMS_VERSION 2.4.8
ENV RAILS_VERSION 4.2.4

# skip installing gem documentation
RUN echo 'install: --no-document\nupdate: --no-document' >> "$HOME/.gemrc"

# Install deps
RUN apt-get update && apt-get install -y --no-install-recommends \
        bison \
        libgdbm-dev \
        mysql-client postgresql-client sqlite3 \
        nodejs \
        openssh-server \
        python \
        python-dev \
        ruby \
        supervisor \
        vim \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /usr/src/ruby \
    && curl -fSL -o ruby.tar.gz "http://cache.ruby-lang.org/pub/ruby/$RUBY_MAJOR/ruby-$RUBY_VERSION.tar.gz" \
    && echo "$RUBY_DOWNLOAD_SHA256 *ruby.tar.gz" | sha256sum -c - \
    && tar -xzf ruby.tar.gz -C /usr/src/ruby --strip-components=1 \
    && rm ruby.tar.gz \
    && cd /usr/src/ruby \
    && autoconf \
    && ./configure --disable-install-doc \
    && make -j"$(nproc)" \
    && make install \
    && apt-get purge -y --auto-remove bison libgdbm-dev ruby \
    && gem update --system $RUBYGEMS_VERSION \
    && rm -r /usr/src/ruby

ENV GEM_HOME /usr/local/bundle
ENV PATH $GEM_HOME/bin:$PATH
ENV BUNDLER_VERSION 1.10.6

RUN gem install bundler --version "$BUNDLER_VERSION" \
    && bundle config --global path "$GEM_HOME" \
    && bundle config --global bin "$GEM_HOME/bin"

RUN gem install rails --version "$RAILS_VERSION"

ONBUILD COPY id_rsa.pub /root/.ssh/authorized_keys
ONBUILD RUN chmod 700 /root/.ssh && chmod 600 /root/.ssh/authorized_keys

# Setup dev env
RUN git clone https://github.com/djx339/dotfiles.git ~/dotfiles \
    && /root/dotfiles/install.sh

EXPOSE 3000

