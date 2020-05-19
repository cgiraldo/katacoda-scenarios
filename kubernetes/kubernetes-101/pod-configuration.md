
## Configuración de Pods

Para proporcionar variables de configuración a pods tenemos varias opciones:

### Configuración  a través de variables de entorno

Podemos incluir el parametro `env` en la especificación del POD para configurar el valor de variables de entorno.

Vamos a modificar el simple-deployment para utilizar una variable de entorno que nos indique el puerto a escuchar:

Abrimos la declaración del deployment modificada:

`manifests/config-env-deployment.yaml`{{open}}

para aplicar esta declaración en nuestro cluster de kubernetes:

`kubectl logs apply -f manifests/config-env-deployment.yaml`{{execute}}

Vamos a inspeccionar el log del pod para ver en que puerto está escuchando:

`kubectl logs deployment/simple-deployment`{{execute}}


Observa como ahora el pod está escuchando en el puerto 2222.
