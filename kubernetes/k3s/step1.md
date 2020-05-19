Kubernetes está formado por uno o más nodos, que serán los que desplieguen contenedores.
Para realizar este curso vamos a instalar kubernetes en una host ubuntu del cloud mediante k3s.

k3s está especialmente diseñado para ejecutar kubernetes en entornos con recursos reducidos, por lo que es ideal para desplegar un cluster de kubernetes en un único host local.


`curl -sfL https://get.k3s.io | sh -`{{execute}}

Ahora podemos comprobar el estado del cluster a traves de kubectl el CLI de kubernetes.

`kubectl get node`{{execute}}

Kubernetes define el nodo master sobre el que se despliegan componentes del sistema.
Por defecto k8s no permite desplegar pods en el nodo master.
k3s habilita el despliegue de pods en el nodo master de manera automática.

En caso de no ser así, se puede habilitar el despliegue de pods en master con:

`kubectl taint node host01 node-role.kubernetes.io/master:NoSchedule-`

Para facilitar el uso de kubectl vamos a activar el autocompletado mediante TAB:

`source <(kubectl completion bash)`{{execute}}

Es interesante añadirlo de forma permanente al fichero bashrc:

`echo "source <(kubectl completion bash)" >> ~/.bashrc`{{execute}}
