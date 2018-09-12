##Containers

`docker run -ti alpine`{{execute}}

`docker run -d httpd:alpine`{{execute}}

`docker ps`{{execute}}

`docker ps -a`{{execute}}

`docker run -d --name http1 httpd:alpine`{{execute}}

`docker ps`{{execute}}

`docker exec -ti http1 /bin/sh`{{execute}}

`docker stop http1`{{execute}}

`docker ps`{{execute}}

`docker start http1`{{execute}}

`docker ps`{{execute}}

`docker stop http1 && docker rm http1`{{execute}}

`docker ps -aq`{{execute}}

`docker rm -f $(docker ps -aq)`{{execute}}

### Networking

`docker network ls`{{execute}}
`docker network inspect bridge`{{execute}}

`docker run -d --name http1 httpd:alpine`{{execute}}

`docker exec http1 wget -qO- localhost:80`{{execute}}

`docker inspect http1`{{execute}}

`docker exec http1 ifconfig`{{execute}}

#### From other container

(they should be in the same docker network. Default is bridge)

`docker run -ti alpine wget -qO- 172.18.0.3:80`{{execute}}

`docker run -ti --link http1 alpine wget -qO- http1:80`{{execute}}

`docker run -ti --link http1:server alpine wget -qO- server:80`{{execute}}

#### From host

`wget -qO- 172.18.0.3:80`{{execute}}


#### External access

- Port mapping

`docker run -d --name http2 -p 8000:80 httpd:alpine`{{execute}}
`wget -qO- localhost:8000`{{execute}}

- Host network

`docker run -d --name http3 -net:host httpd:alpine`{{execute}}

`wget -qO- localhost:80`{{execute}}

`docker rm -f $(docker ps -aq)`{{execute}}

-------------------------

### Volumes

docker volume mount

`docker run -d --name http1 -p 8000:80 -v vol1:/usr/local/apache2/htdocs/ httpd:alpine`{{execute}}

`wget -qO- localhost:8000`{{execute}}

`docker run -it --rm -v vol1:/vol alpine sh -c 'echo "modified content" >/vol/index.html'`{{execute}}

`docker run -it --rm -v vol1:/vol alpine ls -l /vol`{{execute}}

`wget -qO- localhost:8000`{{execute}}

`docker rm -f http1`{{execute}}

`docker run -d --name http1 -p 8000:80 -v vol1:/usr/local/apache2/htdocs/ httpd:alpine`{{execute}}

`wget -qO- localhost:8000`{{execute}}

host bind mount

`docker run -d --name http_spider -p 8001:80 -v $PWD/vol_spider:/usr/local/apache2/htdocs/ httpd:alpine`{{execute}}

`wget -qO- localhost:8001`{{execute}}

`docker run -d --name http_bat -p 8002:80 -v $PWD/vol_bat:/usr/local/apache2/htdocs/ httpd:alpine`{{execute}}

`wget -qO- localhost:8002`{{execute}}
