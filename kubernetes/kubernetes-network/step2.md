##  NodePort Services

Bien, ya hemos comunicado diferentes Pods entre ellos.
Pero como podemos acceder a ellos? ¿Cómo exponemos nuestra aplicación de Kubernetes?

Hay tres formas generales de exponer una aplicación:

- Mediante un servicio de tipo NodePort.
- A través de LoadBalncer.
- A través de un recurso Ingress.

En este paso vamos a crear un nodePort para acceder a la aplicación web previa.

Abre `manifests/web-nodeport-svc.yaml`{{open}}

Ahora aplicamos este manifiesto:
`kubectl apply manfiest/web-nodeport-svc.yaml`{{execute}}

`kubectl describe web-nodeport`{{execute}}

El nodePort service permite acceder al puerto del port a través de un puerto en los nodos del cluster (nodePort).
Vamos a comprobarlo:

`curl localhost:30300`


Consulta todos los detalles sobre servicios en la documentación oficial de kubernetes [aquí](https://kubernetes.io/docs/concepts/services-networking/service/).

