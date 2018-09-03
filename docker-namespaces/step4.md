En este paso comprobamos que por defecto existe un aislamiento en el sistema de ficheros de cada contenedor.

- Creamos el fichero _file2.txt_ en el contenedor T2 `touch /file2.txt`{{execute T2}}

- Creamos el fichero _file3.txt_ en el contenedor T3 `touch /file3.txt`{{execute T3}}

- Comprobamos los ficheros de T2 `ls`{{execute T2}} y de T3 `ls`{{execute T3}}

- Buscamos estos ficheros en el HOST `find / -name file\*.txt`{{execute T1}}


***
Los ficheros creados en un contenedor desaparecen cuando el contenedor se elimina del HOST.

- Eliminamos los contenedores T2 y T3 `docker rm -f t2 t3`{{execute T1}}

- Buscamos estos ficheros en el HOST `find / -name file\*.txt`{{execute T1}}

Para que los ficheros sobrevivan a los contenedores pueden utilizarse _Bind Mounts_ o _Docker Volumes_

## Bind Mounts

Los _Bind Mounts_ tienen una funcionalidad limitada en comparación con los _Docker Volumes_. 
Este tipo de montajes utilizan archivos o directorios del HOST montados en el contenedor.
Vamos a crear la carpeta /mnt/shared_DATA en el host y la montaremos en la ruta /data del contenedor T2 y T3.

Lanzamos los contenedores t2 y t3 compartiendo la carpeta del host /mnt/shared_DATA

-`docker run -ti --rm -name t2 -v /mnt/shared_DATA:/data alpine`{{execute T2}}

-`docker run -ti --rm -name t3 -v /mnt/shared_DATA:/data alpine`{{execute T3}}

Creamos un fichero en el contenedor T2 `touch /data/t2_file.txt`{{execute T2}}

Listamos los ficheros de /data en el contenedor T3 `ls /data/`{{execute T3}}

Al eliminar los contenedores, el contenido de la carpeta del host /mnt/shared_DATA se mantiene:

- `docker rm -f t2 t3`{{execute T1}}

- `ls /mnt/shared_DATA`{{execute T1}}


## Docker Volumes






