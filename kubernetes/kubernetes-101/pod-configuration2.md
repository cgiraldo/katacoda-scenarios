## Configmaps

Acabamos de ver como configurar variables de entorno en la especificación del Pod.

Sin embargo, esto no es muy portable. Lo ideal es desacoplar la configuración de la especificación del Pod. ¿Cómo?

A través de ConfigMaps

Definición de ConfigMap:

> A ConfigMap is an API object used to store non-confidential data in key-value pairs. Pods can consume ConfigMaps as environment variables, command-line arguments, or as configuration files in a volume.


Vamos a definir varias variables de entorno en un configmap para utilizar en el deployment anterior:

Abrimos el archivo `manifests/env-configmap.yaml`{{open}}

Observa que hemos definido dos claves: LISTEN_PORT y OTHER_VARIABLE 

Ahora modificamos el manifiesto simple-deployment para configurar las variables de entorno del Pod a partir del configmap:

El nuevo manifiesto es `manifests/configmap-deployment.yaml`{{open}}

Vamos a inspeccionar el log del pod para ver en que puerto está escuchando:

`kubectl logs deployment/simple-deployment`{{execute}}

Observa como ahora el pod está escuchando en el puerto 5555, definido en el configmap.


Existen otras opciones para crear configmaps (a partir del contenido de un fichero, de un directorio, literales, etc.)
Consulta todos los detalles sobre configmaps en la documentación oficial de kubernetes, por ejemplo [aquí](https://kubernetes.io/docs/concepts/configuration/configmap/) y [aquí](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/.)