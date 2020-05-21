## Configmaps

Acabamos de ver como configurar variables de entorno en los contenedores de nuestros Pods.

Sin embargo, esto no es muy portable. Lo ideal es desacoplar la configuración de la especificación del Pod. ¿Cómo?

A través de **ConfigMaps**.

Definición de ConfigMap:

> A ConfigMap is an API object used to store non-confidential data in key-value pairs. Pods can consume ConfigMaps as environment variables, command-line arguments, or as configuration files in a volume.

Abre el manifiesto `manifests/configmap-multikeys.yaml`{{open}}

Puedes ver que hemos definido dos elementos en los datos del configmap con claves: `SPECIAL_LEVEL` y `SPECIAL_TYPE`.

Despliega el manifiesto del configmap:
`kubectl apply -f manifests/configmap-multikeys.yaml`{{execute}}

Ahora abre el manifiesto `manifests/pod-configmap-envFrom.yaml`{{open}}

En este caso hemos utilizamos `envFrom` en lugar de `env`, e indicamos que utilice el configmap anterior como fuente de las variables de entorno.

Despliega el manifiesto del pod:
`kubectl apply -f manifests/pod-configmap-envFrom.yaml`{{execute}}


Inspecciona la salida del pod anterior, ya que el `command` configurado muestra las variables de entorno del contenedor:

`kubectl logs dapi-test-pod |grep SPECIAL`{{execute}}


Consulta el concepto de ConfigMap en la [documentación oficial de kubernetes](https://kubernetes.io/docs/concepts/configuration/configmap/).

Existen otras opciones para crear configmaps (a partir del contenido de un fichero, de un directorio, literales, etc.)
Consulta los detalles [aquí](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/.)