curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.28.2/minikube-linux-amd64 && chmod +x minikube
sudo mv minikube /usr/local/bin/
minikube start --vm-driver=none


cat <<EOF | kubectl create -f -
apiVersion: v1
kind: Service
metadata:
  name: dashboard
spec:
  selector:
    app: kubernetes-dashboard
  type: NodePort
  ports:
  - nodePort: 30000
    port: 80
    protocol: TCP
    targetPort: 9090
EOF