Terminal T1 is a shell at the Host Machine that run the containers,
T1 shell is mainly used to manage containers through the docker CLI


Terminals T2 and T3 give us access to two independent containers (t1 and t2) that we will run at the host.

Let's deploy the t1 and t2 containers in interactive mode (`-ti`):

- `docker run -ti --rm --name t2 alpine`{{execute T2}}

- `docker run -ti --rm --name t3 alpine`{{execute T3}}

The next CLI command gives us the list of running containers:

 - `docker ps`{{execute T1}}



