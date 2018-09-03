##Creación del entorno de pruebas

El terminal T1 nos da acceso al Host donde se lanzan los contenedores, y lo utilizaremos principalmente para gestionar los contenedores mediante el CLI de docker. Los terminal T2 y T3 dan acceso a dos contenedores independientes que lanzaremos en el host.

Lanzamiendo de los contenedores en modo terminal interactivo:

- `docker run -ti --rm --name t2 alpine`{{execute T2}}

- `docker run -ti --rm --name t3 alpine`{{execute T3}}

Lista de contenedores corriendo en el Host:
 - `docker ps`{{execute T1}}



