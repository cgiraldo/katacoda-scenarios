
## Pod Networking

##  Services

Tenemos nuestros Pods ejecutandose. A través de kubectl podemos acceder a la salida standard del pod `kubectl logs`, o incluso podemos ejecutar comandos con `kubectl exec`.

Pero, ¿Como pueden comunicarse entre ellos?

La respuesta está en los servicios.

Definición de Service:

> A Service is an abstract way to expose an application running on a set of Pods as a network service.

Kubernetes les da a los Pods su propia dirección IP y un nombre DNS para un cojunto de Pods, pudiendo realizar un balance de carga entre ellos.

Vamos a crear un deployment con una aplicación web:

`kubectl create deployment web --image=gcr.io/google-samples/hello-app:1.0`{{execute}}

Escalamos para tener tres replicas:

`kubectl scale --replicas=3 deployment web`{{execute}}

Podemos inspeccionar la IP de los pods del deployment con:

`kubectl get pods --selector app=web -o wide`{{execute}}

Podemos comprobar si el pod responde a una petición http con:

`curl IP_DEL_POD:8080`

Pero los Pods son efímeros por naturaleza, están diseñados para escalarse y ser creados y destruidos de forma dinámica.

Vamos a eliminar los Pod:

`kubectl delete pods --selector app=web`{{execute}}

Como es un Deployment, el ReplicaSet se encargará de levantar de nuevo Pods para cumplir con el número de réplicas configurado:

Compruebalo con:

`kubectl get pods --selector app=web -o wide`{{execute}}

Pero los nuevos Pods tienen IPs diferentes!

La solución a esta naturaleza dinámica de los Pods es crear un servicio.

Vamos a crear un servicio para la aplicación web anterior:

Abre `manifests/web-clusterip-svc.yaml`{{open}}

Fijate en los selectores y tipo de servicio.
Lo aplicamos con:

`kubectl apply -f manifests/web-clusterip-svc.yaml`{{execute}}

Vamos a extraer la IP del servicio (CLUSTER-IP) y llamarla. Esta IP se mantendrá fija para el servicio web-service, y 
kubernetes se encargará de llevar la petición a un Pod que cumpla con el selector configurado. Si hay múltiples Pods, 
realizará un balanceo de las peticiones entre los pods.

`kubectl get service web-service -o wide`{{execute}}


Compruebalo realizando múltiples peticiones al Cluster-IP.

`curl CLUSTER_IP:80`

Además kubernetes proporciona un servicio de DNS que permite a los PODs acceder a los servicios a través de nombres.
Cuando se añade un recurso service, kubernetes añade una entrada con el nombre del recurso (en nuestro caso web-service) en el
DNS del cluster.
Vamos a comprobar esto a través de otro pod:

`kubectl apply -f manifests/dnsutils.yaml`{{execute}}

Ahora realizamos una resolución de nombre en este pod:

`kubectl exec -ti dnsutils -- nslookup web-service`{{execute}}

Vale, pero he visto servicios headless. ¿Qué quiere decir esto?
Por defecto un service ClusterIP crea una "IP" virtual (ClusterIP) como punto de entrada para las consultas e internamente redirige la consulta
a la IP de alguno de los pods detrás del servicio.
Un servicio headless configura el ClusterIP a None, con lo que no se crea esta IP virtual. El servidor DNS de kubernetes proporcionará la lista de IPs de los pods detrás del servicio, en lugar de la IP virtual.

`kubectl apply -f manifests/web-headless-svc.yaml`{{execute}}

`kubectl exec -ti dnsutils -- nslookup web-headless`{{execute}}

Consulta todos los detalles sobre servicios en la documentación oficial de kubernetes [aquí](https://kubernetes.io/docs/concepts/services-networking/service/).

