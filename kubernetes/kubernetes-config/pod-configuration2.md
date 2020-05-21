## Configmaps

Acabamos de ver como configurar variables de entorno en la especificación del Pod.

Sin embargo, esto no es muy portable. Lo ideal es desacoplar la configuración de la especificación del Pod. ¿Cómo?

A través de ConfigMaps

Definición de ConfigMap:

> A ConfigMap is an API object used to store non-confidential data in key-value pairs. Pods can consume ConfigMaps as environment variables, command-line arguments, or as configuration files in a volume.


Vamos a definir varias variables en un configmap:

Abrimos el archivo `manifests/configmap-multikeys.yaml`{{open}}

Observa que el configmap define dos claves: SPECIAL_MEVEL y SPECIAL_TYPE 


El manifiesto `manifests/pod-configmap-envFrom.yaml{open}} muestra como configurar las variables de entorno del Pod a partir del configmap:

Aplicamos el manifiesto:

`kubectl apply -f manifests/pod-configmap-envFrom.yaml`{{exec}}


Vamos a inspeccionar el log del pod para ver que variables de entorno tenía definidas:

`kubectl logs dapi-test-pod`{{execute}}


Consulta el concepto de ConfigMap en la [documentación oficial de kubernetes](https://kubernetes.io/docs/concepts/configuration/configmap/).

Existen otras opciones para crear configmaps (a partir del contenido de un fichero, de un directorio, literales, etc.)
Consulta los detalles [aquí](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/.)