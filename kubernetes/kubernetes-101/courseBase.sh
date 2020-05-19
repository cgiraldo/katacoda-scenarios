#!/bin/bash

mkdir /root/manifests

curl -sfL https://get.k3s.io | sh -

source <(kubectl completion bash)
echo "source <(kubectl completion bash)" >> ~/.bashrc
