#!/usr/bin/env bash

set -ex

export PS1="# "
export http_proxy
export https_proxy

# install base deps
apt-get update 
apt-get install -y --no-install-recommends \
    git \
    libopencv-dev \
    software-properties-common \
    python-software-properties

# install torch
git config --global http.sslVerify false
git clone https://github.com/torch/distro.git ~/torch --recursive --depth 1
cd ~/torch
bash install-deps
./install.sh -b

rm -rf /var/lib/apt/lists/*

source ~/.bashrc

# install 3rd packages
luarocks install luasocket
luarocks install cutorch
luarocks install cunn
luarocks install cunnx
luarocks install rnn
luarocks install dp
luarocks install qtlua
luarocks install qttorch
