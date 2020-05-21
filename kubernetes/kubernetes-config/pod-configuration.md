
## Configuración de Pods

Para proporcionar variables de configuración a pods tenemos varias opciones:

### Configuración  a través de variables de entorno

Abre el manifiesto del simple-deployment:

`manifests/simple-deployment.yaml`{{open}}

Observa que hemos incluido ahora el parametro `env` en la especificación del contenedor para añadirle la variable de entorno LISTEN_PORT.

Esta variable de entorno se utiliza después en el comando `nc` ejecutado por el contenedor.

Desplegamos el manifiesto en el cluster:

`kubectl apply -f manifests/simple-deployment.yaml`{{execute}}

Vamos a inspeccionar el log del pod para ver en que puerto está escuchando:

`kubectl logs deployment/simple-deployment`{{execute}}


Observa como el pod está escuchando en el puerto 2222.
