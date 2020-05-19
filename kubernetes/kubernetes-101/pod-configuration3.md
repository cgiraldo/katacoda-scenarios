## ConfigMaps

Acabamos de utilizar ConfigMaps para configurar variables de entorno en un POD.
Los ConfigMaps permiten también pasar ficheros de configuración a un Pod.

Esta vez, vamos a crear un configmap a partir de los ficheros de un directorio.

`kubectl create configmap game-config --from-file=game-config-files/`

Podemos ver el contenido del recurso configMap creado en nuestro cluster de kubernetes con:

`kubectl describe configmaps game-config`{{execute}}

Ahora vamos a inspeccionar el manifiesto de un pod donde se monta el configmap anterior como un volumen:

Abre `manifests/pod-configmap-volume.yaml`{{open}}

para aplicar esta declaración en nuestro cluster de kubernetes:

`kubectl apply -f manifests/pod-configmap-volume.yaml`{{execute}}

Vamos a inspeccionar el log del pod para ver los ficheros listados en /etc/config:

`kubectl logs game-pod`{{execute}}


Consulta todos los detalles sobre configmaps en la documentación oficial de kubernetes, por ejemplo [aquí](https://kubernetes.io/docs/concepts/configuration/configmap/) y [aquí](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/.)