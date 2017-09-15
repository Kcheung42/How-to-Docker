## How To Docker
##### 1. Create Machine:

	docker-machine create --driver virtualbox char

##### Get the environment commands for your new VM

	docker-machine env char

##### Connect shell to the new Machine

	eval "$(docker-machine env default)"

##### 2. Get the host IP address

	docker-machine ip char

##### 4. Get the hello-world container

	docker pull hello-world

##### 5. Launch the hello-world container

	docker run hello-world

##### 6. Launch nginx container

	docker run -d -p 5000:80 --name overlord --restart always nginx

##### 7. Get the internal IP address of the overloard container without starting its shell and in one command.

	docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' overlord

##### 8. Launch a shell from an alpine container and make sure that you can interact directly with the container via your terminal, and that the container deletes itself once the shell's execution is done

	docker run -it --rm alpine

# 9. From the shell of a debian container, install via the container's package manager everything you need to compile C source code and push it onto a git repo (of course, make sure before that the package manger and the packages already in the container are updated). For this excercies, you should only specify the commands to be run directly in the container

	apt-get update && apt-get upgrade
	apt-get install build-essential
	apt-get install gcc
	apt-get install git

# 10. Create a volume named hatchery
	
	docker volume create hatchery
	
# 11. List all the Docker volumes created on the machine. Remember. VOLUMES

	docker volume ls

# 12. Launch a mysql container as a background task. It should be able to restart on its own in case of error, and the root password of the database should be Kerrigan. You will also make sure that the databse is stored in the hatchery volume, that the container directly creates a database named zerglings, and that the container itself is named spawning-pool.

	docker run --name spawning-pool -v hatchery:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=Kerrigan -d

