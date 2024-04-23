#!/bin/bash

echo "Installing k3s"
curl -sfL https://get.k3s.io | sh -
source /etc/bash_completion
source <(kubectl completion bash)
echo "source <(kubectl completion bash)" >> ~/.bashrc
