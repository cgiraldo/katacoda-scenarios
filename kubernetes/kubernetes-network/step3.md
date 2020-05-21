## Ingress

Los objetos Ingress proporcionan información a un Ingress Controller sobre el servicio que está asociado a las diferentes peticiones de entrada.
Para ello es necesario disponer de un Ingress Controller en nuestro cluster de kubernetes, por ejemplo nginx, traefik o ambassador.
k3s instala por defecto traefik, por lo que ya podemos hacer uso de recursos ingress!

Vamos a crear ahora un ingress para acceder externamente :

abrimos la definición `manifests/web-ingress.yaml`{{open}}

La aplicamos:
`kubectl apply -f manifests/web-ingress.yaml`{{execute}}

para probar el funcionamiento del ingress vamos a hacer que el nombre hello-world.info resuelva a la IP donde el ingress controller está escuchando.
Lo hacemos manualmente en el fichero /etc/hosts:

`echo "127.0.0.1 hello-world.info" |sudo tee -a /etc/hosts`{{execute}}

Ahora podemos acceder peticiones al pod a través del ingress controller:
`curl http://hello-world.info`{{execute}}


Consulta todos los detalles sobre Ingress en la [documentación oficial de kubernetes](https://kubernetes.io/docs/concepts/configuration/configmap/).

Estos pasos son similares a los incluidos [aquí](https://kubernetes.io/docs/tasks/access-application-cluster/ingress-minikube/).