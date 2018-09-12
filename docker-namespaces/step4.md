We are going to check filesystem isolation among containers through Mount Namespaces.

- We create _kitten2.txt_ file in t2 container -> `touch /kitten2.txt`{{execute T2}}

- We create _kitten3.txt_ file in t3 container -> `touch /kitten3.txt`{{execute T3}}

- We list files of t2 container -> `ls`{{execute T2}} and files of t3 container -> `ls`{{execute T3}}

- We search for kitten files at host machine -> `find / -name kitten\*.txt`{{execute T1}}


***
Files created at the R/W layer of a container disappear when container is removed.

- Let's remove t2 and t3 containers -> `docker rm -f t2 t3`{{execute T1}}

- We search for kitten files at host machine -> `find / -name kitten\*.txt`{{execute T1}}

To remove files from container life cycle and let thhem survive a container removal, we must use _Docker Volumes_ or _Bind Mounts_.

## Volumes

Volumes  are stored in a part of the host filesystem which is managed by Docker (_/var/lib/docker/volumes/_ on Linux). 
Non-Docker processes should not modify this part of the filesystem. Volumes are the best way to persist data in Docker.

A docker volume can be explicitly created with `docker volume create`.

`docker volume create datavol`{{execute T1}}

`docker volume ls`{{execute T1}}

To attach a volume to a container you must do it at deploy time with the `-v` flag. 
If container does not exist, docker automatically creates one. 
Volumes can be shared between containers running at the same host. 

Let's deploy container t2 and container t3 with the shared volume _data_vol_.

`docker run -ti --rm --name t2 -v datavol:/data alpine`{{execute T2}}

`docker run -ti --rm --name t3 -v datavol:/data alpine`{{execute T3}}

If we create a file at t2 container -> `touch /data/another_kitten.txt`{{execute T2}}

We can see it at t3 container -> `ls /data/`{{execute T3}}

If we remove the containers, the volume must persist:

- `docker rm -f t2 t3`{{execute T1}}

- `docker volume ls`{{execute T1}}

We can execute a new t4 container with the previous volume. 
_another_kitten.txt_ file should be accessible at t4 container.

- `docker run -ti --rm --name t4 -v datavol:/data alpine`{{execute T4}}

- We list t4 /data contents -> `ls /data/`{{execute T4}}

## Bind Mounts

Bind mounts have limited functionality compared to volumes. 
When you use a bind mount, a file or directory on the host machine is mounted into a container. 
The file or directory is referenced by its full path on the host machine. 
The file or directory does not need to exist on the Docker host already. 
It is created on demand if it does not yet exist.

Let's mount the _/mnt/shared_DATA_ host machine path into the _/data_ mount point of t2 and t3 containers. 


-`docker run -ti --rm --name t2 -v /mnt/shared_DATA:/data alpine`{{execute T2}}

-`docker run -ti --rm --name t3 -v /mnt/shared_DATA:/data alpine`{{execute T3}}

If we create a file at t2 container -> `touch /data/puppy.txt`{{execute T2}}

We can see it at t3 container -> `ls /data/`{{execute T3}}

f we remove the containers, the content of the host path _/mnt/shared_DATA persists:

- `docker rm -f t2 t3`{{execute T1}}

- `ls /mnt/shared_DATA`{{execute T1}}

***
The same way as folders, docker can mount individual host files to containers:

Let's create a configuration file at the host machine -> `echo "important config value" > /tmp/config.txt`{{execute T1}}

We deploy t2 container and we bind mount the previous file.

-`docker run -ti --rm --name t2 -v /tmp/config.txt:/data/config.txt alpine`{{execute T2}}

Let's check the content of _data/config.txt_ file of t2 container `cat /data/config.txt`{{execute T2}}
