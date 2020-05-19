¡Felicidades, ya tienes disponible tu primer cluster de kubernetes!

Vamos a explorar que es lo que tenemos.

## Namespaces

Primero vamos a listar los namespaces:

`kubectl get namespaces`{{execute}}

Los espacios de nombres están pensados para utilizarse en entornos con muchos usuarios distribuidos entre múltiples equipos, o proyectos. 

Los espacios de nombres son una forma de dividir los recursos del clúster entre múltiples usuarios, equipos o proyectos.

No es necesario usar múltiples espacios de nombres sólo para separar recursos ligeramente diferentes, como versiones diferentes de la misma aplicación: para ello utiliza etiquetas para distinguir tus recursos dentro del mismo espacio de nombres.

Podemos ver que inicialmente el cluster cuenta con los namespaces:
Kubernetes arranca con tres espacios de nombres inicialmente:

   * `default` El espacio de nombres por defecto para aquellos objetos que no especifican ningún espacio de nombres
   * `kube-system` El espacio de nombres para aquellos objetos creados por el sistema de Kubernetes
   * `kube-public` Este espacio de nombres se crea de forma automática y es legible por todos los usuarios (incluyendo aquellos no autenticados).
   Este espacio de nombres se reserva principalmente para uso interno del clúster, en caso de que algunos recursos necesiten ser visibles y legibles de forma pública para todo el clúster.
   * `kube-node-lease` Este espacio de nombres está reservado para facilitar la monitorización del cluster por parte de terceros.

Cuando consultamos recursos de con `kubectl` sin indicar un namespace, devuelve los recursos del namespace `default`.

`kubectl get all`{{execute}}

Vemos que el namespace `default` está inicialmente vacío.

### Crear un namespace

Vamos a crear un namespace de prueba:

`kubectl create namespace gradiant`{{execute}}

Y listamos de nuevo los namespaces:

`kubectl get namespaces`{{execute}}

### Establecer el namespace para una petición

Si queremos consultar los recursos de un namespace concreto debemos indicarlo con el flag `--namespace` o `-n`:

`kubectl get all --namespace gradiant`{{execute}}

Como vemos el namespace que acabamos de crear está vacío.
Kubernetes ejecuta sus componentes internos también como Pods del systema en el namespace kube-system.
Vamos a ver todos los recursos internos que kubernetes con:

`kubectl get all --namespace kube-system`{{execute}}

Incluso podemos obtener todos los recursos de todos los namespaces con el flag `--all-namespaces`:

`kubectl get all --all-namespaces`{{execute}}


### Establecer la preferencia de namespace

Podemos indicar de forma permanente el namespace para todas las llamadas futuras a comandos kubectl
en dicho contexto.

`kubectl config set-context --current --namespace=gradiant{{execute}}

La configuración actual de kubectl puede consultarse con:

```
kubectl config view | grep namespace:
```


Consulta todos los detalles sobre namespaces en la [documentación oficial de kubernetes](https://kubernetes.io/es/docs/concepts/overview/working-with-objects/namespaces/).
