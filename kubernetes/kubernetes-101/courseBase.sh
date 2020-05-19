#!/bin/bash

curl -sfL https://get.k3s.io | sh -

source <(kubectl completion bash)
echo "source <(kubectl completion bash)" >> ~/.bashrc
