En este paso comprobamos que por defecto existe un aislamiento en el sistema de ficheros de cada contenedor.

- Creamos el fichero _gatito2.txt_ en el contenedor T2 `touch /gatito2.txt`{{execute T2}}

- Creamos el fichero _gatito3.txt_ en el contenedor T3 `touch /gatito3.txt`{{execute T3}}

- Comprobamos los ficheros de T2 `ls`{{execute T2}} y de T3 `ls`{{execute T3}}

- Buscamos estos ficheros en el HOST `find / -name gatito\*.txt`{{execute T1}}


***
Los ficheros creados en un contenedor desaparecen cuando el contenedor se elimina del HOST.

- Eliminamos los contenedores T2 y T3 `docker rm -f t2 t3`{{execute T1}}

- Buscamos estos ficheros en el HOST `find / -name gatito\*.txt`{{execute T1}}

Para que los ficheros sobrevivan a los contenedores pueden utilizarse _Docker Volumes_ o _Bind Mounts_

## Volumes

Los volumenes se almacenan en una parte del sistema de ficheros del host que gestiona docker (/var/lib/docker/volumes).
Pueden crearse de manera explícita o ser creados por docker al crear un contenedor.

`docker run -ti --rm --name t2 -v datavol:/data alpine`{{execute T2}}

`docker run -ti --rm --name t3 -v datavol:/data alpine`{{execute T3}}

Creamos un fichero en el contenedor T2 `touch /data/t2_other.txt`{{execute T2}}

Listamos los ficheros de /data en el contenedor T3 `ls /data/`{{execute T3}}

Eliminamos los contenedores, el volumen debe persistir:

- `docker rm -f t2 t3`{{execute T1}}

- `docker volume ls`{{execute T1}}

Podemos ejecutar un nuevo contenedor T4 y montar el volumen anterior:

- `docker run -ti --rm --name t4 -v datavol:/data alpine`{{execute T4}}

Listamos los ficheros de /data en el contenedor T4 `ls /data/`{{execute T4}}

## Bind Mounts

Los _Bind Mounts_ tienen una funcionalidad limitada en comparación con los _Docker Volumes_. 
Este tipo de montajes utilizan archivos o directorios del HOST montados en el contenedor.
Vamos a crear la carpeta /mnt/shared_DATA en el host y la montaremos en la ruta /data del contenedor T2 y T3.

Lanzamos los contenedores t2 y t3 compartiendo la carpeta del host /mnt/shared_DATA

-`docker run -ti --rm --name t2 -v /mnt/shared_DATA:/data alpine`{{execute T2}}

-`docker run -ti --rm --name t3 -v /mnt/shared_DATA:/data alpine`{{execute T3}}

Creamos un fichero en el contenedor T2 `touch /data/t2_file.txt`{{execute T2}}

Listamos los ficheros de /data en el contenedor T3 `ls /data/`{{execute T3}}

Al eliminar los contenedores, el contenido de la carpeta del host /mnt/shared_DATA se mantiene:

- `docker rm -f t2 t3`{{execute T1}}

- `ls /mnt/shared_DATA`{{execute T1}}

***
Al igual que las carpetas, docker puede montar ficheros individuales del host de la misma manera:

Creamos un fichero en el host `echo "important config value" > /tmp/config.txt`{{execute T1}}

Lanzamos el contenedor t2 compartiendo el fichero del host /tmp/config.txt

-`docker run -ti --rm --name t2 -v /tmp/config.txt:/data/config.txt alpine`{{execute T2}}

Comprobamos el fichero montado en el contenedor T2 `cat /data/config.txt`{{execute T2}}
