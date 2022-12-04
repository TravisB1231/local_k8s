#! /bin/bash

export OS=$(uname -a)
case $OS in
    *"Ubuntu"*)
    apt-get upgrade
    apt-get update
# docker
    sudo apt-get install -y docker.io
# k8s
    sudo apt-get install -y ca-certificates curl

    sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
    echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
    sudo apt-get update
    sudo apt-get install -y kubectl
# minikube
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
    sudo dpkg -i minikube_latest_amd64.deb
    minikube start --force
# k9s
    curl -LO https://github.com/derailed/k9s/releases/download/v0.26.7/k9s_Linux_x86_64.tar.gz
    tar -xzf k9s_Linux_x86_64.tar.gz
# python
    sudo apt-get install -y python3.10
    sudo apt-get install -y python3-pip
    sudo apt-get install python3.10-venv
# mysql
    sudo apt-get install -y mysql-server
    sudo apt-get update
    sudo apt-get install -y default-libmysqlclient-dev libssl-dev
    #  mysql -u root -p

# Auth service setup
    mkdir system_design
    mkdir system_design/python
    mkdir system_design/python/src
    mkdir system_design/python/src/auth
    python3 -m venv .venv
    source .venv/bin/activate
    pip install pylint jedi jwt pyjwt flask flask_mysqldb
    ;;
esac