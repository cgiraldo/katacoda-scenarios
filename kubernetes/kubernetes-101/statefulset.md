
Definición de Statefulset:

> Un StatefulSet es el objeto de la API workload que se usa para gestionar aplicaciones con estado.

> Al igual que un Deployment, un StatefulSet gestiona Pods que se basan en una especificación idéntica de contenedor. A diferencia de un Deployment, un StatefulSet mantiene una identidad asociada a sus Pods. Estos pods se crean a partir de la misma especificación, pero no pueden intercambiarse; cada uno tiene su propio identificador persistente que mantiene a lo largo de cualquier re-programación.


Vamos a desplegar nuestro primer Statefulset

Abrimos la declaración del Statefulset:

`manifests/simple-statefulset.yaml`{{open}}

Y aplica esta declaración en el cluster de kubernetes:

`kubectl apply -f manifests/simple-statefulset.yaml`{{execute}}

Observa el statefulset desplegado:

`kubectl get statefulsets`{{execute}}

Y los pods asociados:

`kubectl get pods -l app=simple-stateful`{{execute}}

Utilizamos -l para filtar los pods por etiqueta (label).

Observa el cambio en el nombre de los pod respecto al deployment.

Los pods de un statefulset mantienen un orden y utilizan un número incremental para cada pod. 

Podemos escalar el statefulset para que mantenga 2 instancias con:

`kubectl scale --replicas=2 Statefulset simple-statefulset`{{execute}}

En este caso vemos que elimina el pod `simple-statefulset-2`.



Consulta todos los detalles sobre Statefulsets en la [documentación oficial de kubernetes](https://kubernetes.io/docs/concepts/workloads/controllers/Statefulset/).
