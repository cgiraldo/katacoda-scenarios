
## Deployment

Definición de Deployment:

> A Deployment provides declarative updates for Pods and ReplicaSets.

> You describe a desired state in a Deployment, and the Deployment Controller changes the actual state to the desired state at a controlled rate. You can define Deployments to create new ReplicaSets, or to remove existing Deployments and adopt all their resources with new Deployments.

¿Por qué no usar directamente ReplicaSets?

> A ReplicaSet ensures that a specified number of pod replicas are running at any given time. However, a Deployment is a higher-level concept that manages ReplicaSets and provides declarative updates to Pods along with a lot of other useful features. Therefore, we recommend using Deployments instead of directly using ReplicaSets, unless you require custom update orchestration or don’t require updates at all.


Vamos a desplegar nuestro primer deployment

Abrimos la declaración del deployment:
`manifests/simple-deployment.yaml`{{open}}

para aplicar esta declaración en nuestro cluster de kubernetes:

`kubectl apply -f manifests/simple-deployment.yaml`{{execute}}

`kubectl get deployments`{{execute}}

`kubectl get pods`{{execute}}

Podemos escalar el despliegue para que mantenga 2 instancias con:

`kubectl scale --replicas=2 deployment simple-deployment`{{execute}}

También podemos modificar el manifiesto y aplicarlo de nuevo.
Edita el fichero para incluir 4 replicas y aplicalo con:

`kubectl apply -f manifests/simple-deployment.yaml`{{execute}} 


Consulta todos los detalles sobre deployments en la [documentación oficial de kubernetes](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/).
