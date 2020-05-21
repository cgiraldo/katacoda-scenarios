## ConfigMaps

Acabamos de utilizar ConfigMaps para configurar variables de entorno en un contenedor.

Los ConfigMaps permiten también montar ficheros de configuración a un contenedor.

Esta vez, vamos a crear un configmap a partir de los ficheros de un directorio.

`kubectl create configmap game-config --from-file=game-config-files/`{{execute}}

Podemos ver el contenido del recurso configMap creado en nuestro cluster de kubernetes con:

`kubectl get configmaps game-config -o yaml`{{execute}}

Puedes ver en la sección data que se ha generado una entrada por cada fichero con su contenido.


Abre el manifiesto de Pod `manifests/pod-configmap-volume.yaml`{{open}}

En este manifiesto podemos ver que definimos un volumen config-volume` a partir del configmap anterior, y en la especificacion del contenedor montamos el volumen en '/etc/config'.

Despliega el manifiesto del Pod:

`kubectl apply -f manifests/pod-configmap-volume.yaml`{{execute}}

Si inspeccionas el log del contenedor, verás que los archivos del configmap se encuentran listados en `/etc/config`.

`kubectl logs game-pod`{{execute}}


Consulta todos los detalles sobre configmaps en la documentación oficial de kubernetes, por ejemplo [aquí](https://kubernetes.io/docs/concepts/configuration/configmap/) y [aquí](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/.)