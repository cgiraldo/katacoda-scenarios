
## Pods

Definición de Pod:

> A Pod is the basic execution unit of a Kubernetes application--the smallest and simplest unit in the Kubernetes object model that you create or deploy. A Pod represents processes running on your {{< glossary_tooltip term_id="cluster" text="cluster" >}}.

> A Pod encapsulates an application's container (or, in some cases, multiple containers), storage resources, a unique network identity (IP address), as well as options that govern how the container(s) should run. A Pod represents a unit of deployment: a single instance of an application in Kubernetes, which might consist of either a single {{< glossary_tooltip text="container" term_id="container" >}} or a small number of containers that are tightly coupled and that share resources.

vamos a desplegar nuestro primer pod:

Modo imperativo con kubectl:

`kubectl run myapp-container --image=busybox --command -- sh -c 'echo Hello Kubernetes! && sleep 60'`{{execute}}

`kubectl get pods`{{execute}}

Ver salida estandar del pod:

`kubectl logs myapp-container`{{execute}}

Eliminamos el pod:
`kubectl delete pod myapp-container`{{execute}}


Modo declarativo:
Vamos a ver como se desplegaría el pod que hemos desplegado anteriormente de manera declarativa.
La declaración de recursos se realiza a través de manifiestos, archivos en formato json o yaml:

Abrimos la declaración del pod:
`manifests/simple-pod.yaml`{{open}}

para aplicar esta declaración en nuestro cluster de kubernetes:

`kubernetes apply -f manifests/simple-pod.yaml`{{execute}}

`kubectl get pods`{{execute}}



Consulta todos los detalles sobre pods en la [documentación oficial de kubernetes](https://kubernetes.io/docs/concepts/workloads/pods/pod/).
