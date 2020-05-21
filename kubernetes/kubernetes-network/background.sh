#!/bin/bash

# Create the local directory
mkdir -p game-config-files
mkdir -p manifests

# Download the sample files into `configure-pod-container/configmap/` directory
wget https://kubernetes.io/examples/configmap/game.properties -O game-config-files/game.properties
wget https://kubernetes.io/examples/configmap/ui.properties -O game-config-files/ui.properties

wget https://kubernetes.io/examples/pods/pod-configmap-envFrom.yaml -O manifests/pod-configmap-envFrom.yaml
wget https://kubernetes.io/examples/configmap/configmap-multikeys.yaml -O manifests/configmap-multikeys.yaml

