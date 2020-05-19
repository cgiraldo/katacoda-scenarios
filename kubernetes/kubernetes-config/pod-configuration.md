
## Configuración de Pods

Para proporcionar variables de configuración a pods tenemos varias opciones:

### Configuración  a través de variables de entorno

Podemos incluir el parametro `env` en la especificación del POD para configurar el valor de variables de entorno.

Vamos a utilizar una variable de entorno para configurar el puerto en el que escucha netcat en el siguiente deployment:

Abrimos la declaración:

`manifests/deployment.yaml`{{open}}

para aplicar esta declaración en nuestro cluster de kubernetes:

`kubectl logs apply -f manifests/deployment.yaml`{{execute}}

Vamos a inspeccionar el log del pod para ver en que puerto está escuchando:

`kubectl logs deployment/simple-deployment`{{execute}}


Observa como el pod está escuchando en el puerto 2222.
