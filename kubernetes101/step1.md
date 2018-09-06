## K8 namespaces  


<pre class="file" data-filename="namespace.yml" data-target="replace">apiVersion: v1
kind: Namespace
metadata:
  name: tutorial
</pre>

`kubectl get namespaces`{{execute}}

`kubectl apply -f namespace.yml`{{execute}}

## K8 pods


<pre class="file" data-filename="pod.yml" data-target="replace">apiVersion: v1
kind: Pod
metadata:
  name: sample-pod
  namespace: tutorial
  labels:
    name: echo-pod
spec:
  containers:
  - name: echo-container
    image: bash
    command: ["bash"]
    args: ["-c", "nc -l -k -p $LISTEN_PORT -v -e 'cat'"]
    env:
    - name: LISTEN_PORT
      value: "2000"
    ports:
    - containerPort: 2000
      hostPort: 2020
</pre>

`kubectl apply -f pod.yml`{{execute}}

`kubectl get pods -n tutorial`{{execute}}

`kubectl get pods --all-namespaces`{{execute}}