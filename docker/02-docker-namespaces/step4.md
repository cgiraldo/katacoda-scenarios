We are going to check filesystem isolation among containers through Mount Namespaces.

Create _kitten2.txt_ file in t2 container:

- Run in Tab2: `touch /kitten2.txt`{{execute}}

We create _kitten3.txt_ file in t3 container:

- Run in Tab3: `touch /kitten3.txt`{{execute}}

We list files of t2 and t3 containers:

- Run in Tab2 and Tab3: `ls`{{execute}} 

We search for kitten files at host machine:

- Run in Tab1: `find / -name kitten\*.txt`{{execute}}


***
Files created at the R/W layer of a container disappear when container is removed.

Let's remove t2 and t3 containers:

- Run in Tab1: -> `docker rm -f t2 t3`{{execute}}

We search for kitten files at host machine:

- Run in Tab1 -> `find / -name kitten\*.txt`{{execute}}

To remove files from container life cycle and let thhem survive a container removal, we must use _Docker Volumes_ or _Bind Mounts_.

## Volumes

Volumes  are stored in a part of the host filesystem which is managed by Docker (_/var/lib/docker/volumes/_ on Linux). 
Non-Docker processes should not modify this part of the filesystem. Volumes are the best way to persist data in Docker.

A docker volume can be explicitly created with `docker volume create`.

- Run in Tab1: `docker volume create datavol`{{execute}}

- Run in Tab1: `docker volume ls`{{execute}}

To attach a volume to a container you must do it at deploy time with the `-v` flag. 
If container does not exist, docker automatically creates one. 
Volumes can be shared between containers running at the same host. 

Let's deploy container t2 and container t3 with the shared volume _data_vol_.

- Run in Tab2: `docker run -ti --rm --name t2 -v datavol:/data alpine`{{execute}}

- Run in Tab3: `docker run -ti --rm --name t3 -v datavol:/data alpine`{{execute}}

Let's create a file at t2 container:

- Run in Tab2: `touch /data/another_kitten.txt`{{execute}}

We can see it at t3 container:

- Run in Tab3: `ls /data/`{{execute}}

If we remove the containers, the volume must persist:

- Run in Tab1: `docker rm -f t2 t3`{{execute}}

- Run in Tab1: `docker volume ls`{{execute}}

We can execute a new t4 container with the previous volume. 
_another_kitten.txt_ file should be accessible at t4 container:

- Run in Tab4: `docker run -ti --rm --name t4 -v datavol:/data alpine`{{execute}}

We list t4 /data contents:

- Run in Tab4: `ls /data/`{{execute}}

## Bind Mounts

Bind mounts have limited functionality compared to volumes. 
When you use a bind mount, a file or directory on the host machine is mounted into a container. 
The file or directory is referenced by its full path on the host machine. 
The file or directory does not need to exist on the Docker host already. 
It is created on demand if it does not yet exist.

Let's mount the _/mnt/shared_DATA_ host machine path into the _/data_ mount point of t2 and t3 containers:

- Run in Tab2: `docker run -ti --rm --name t2 -v /mnt/shared_DATA:/data alpine`{{execute}}

- Run in Tab3: `docker run -ti --rm --name t3 -v /mnt/shared_DATA:/data alpine`{{execute}}

Let's create a file at t2 container:

- Run in Tab2: `touch /data/puppy.txt`{{execute}}

We can see it at t3 container:

- Run in Tab3: `ls /data/`{{execute}}

f we remove the containers, the content of the host path _/mnt/shared_DATA persists:

- Run in Tab1: `docker rm -f t2 t3`{{execute}}

- Run in Tab1: `ls /mnt/shared_DATA`{{execute}}

***
The same way as folders, docker can mount individual host files to containers:

Let's create a configuration file at the host machine:

- Run ini Tab1: `echo "important config value" > /tmp/config.txt`{{execute}}

We deploy t2 container and we bind mount the previous file:

- Run in Tab2: `docker run -ti --rm --name t2 -v /tmp/config.txt:/data/config.txt alpine`{{execute}}

Let's check the content of _data/config.txt_ file of t2 container:

- Run in Tab2: `cat /data/config.txt`{{execute}}
