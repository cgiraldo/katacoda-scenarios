Los ConfigMaps son un recurso interesante para almacenar variables y ficheros de configuración y definir varios contextos en nuestros despliegues de Kubernetes. Pero que pasa si esas variables son sensibles (i.e. contraseñas o claves ssh).

Para ello se han definido el recurso Secret.

Definición de Secret:

> Kubernetes Secrets let you store and manage sensitive information, such as passwords, OAuth tokens, and ssh keys. Storing confidential information in a Secret is safer and more flexible than putting it verbatim in a Pod definition or in a container imageStored instance of a container that holds a set of software needed to run an application.. 


Vamos a definir un secret con dos valores secretos: 
- username=my-app
- password=39528$vdg7Jb

Abre la definición del Secret `manifests/secret.yaml`{{open}}

¡Espera! ¡la información de username y password no se corresponde con los valores anteriores!

Eso es porque kubernetes almacena los secrets codificados como base-64.

Comprueba que los datos se corresponden:

Encode: `echo -n 'my-app' | base64`{{execute}}

Decode: `echo -n 'bXktYXBw' | base64 -d && echo`{{execute}}


Ahora despliega el secret en el cluster con:

`kubectl apply -f manifests/secret.yaml`{{execute}}

Puedes inspeccionar el secret con :

`kubectl get secret test-secret -o yaml`{{execute}}

## Secret como volumen de Pod

Vamos a crear un Pod que accede al secret a través de un volumen.

Abre el manifiesto `manifests/secret-pod.yaml`{{open}}

La definición de un volumen a partir de un Secret es muy similar a como hicimos con el ConfigMap.

Aplicamos el manifiesto:

`kubectl apply -f manifests/secret-pod.yaml`{{execute}}


Vamos a inspeccionar el log del pod ya que muestra sus variables de entorno:

`kubectl logs env-secret-pod`{{execute}}


Consulta el concepto de secret en la [documentación oficial de kubernetes](https://kubernetes.io/docs/concepts/configuration/secret/).

Existen otras opciones para crear y montar secrets, consulta detalles [aquí](https://kubernetes.io/docs/tasks/inject-data-application/distribute-credentials-secure/).
