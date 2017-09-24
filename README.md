## How To Docker
##### 1. Create Machine.

	docker-machine create --driver virtualbox Char

##### Get the environment commands for your new VM.

	docker-machine env Char

##### Connect shell to the new Machine.

	eval "$(docker-machine env Char)"

##### 2. Get the host IP address.

	docker-machine ip char

##### 3. Define variables needed by your virtual machine Char in the general env of your terminal, so that you can run the docker ps command without errors. You have to fix all four environment variables with one command, and you are not allowed to use your shell's builtin to set these variables by hand

	DOCKER_TLS_VERIFY=1 DOCKER_HOST="tcp://192.168.99.102:2376" DOCKER_CERT_PATH="$HOME/.docker/machine/machines/Char" DOCKER_MACHINE_NAME="Char" docker ps

##### 4. Get the hello-world container.

	docker pull hello-world

##### 5. Launch the hello-world container.

	docker run hello-world

##### 6. Launch nginx container.

	docker run -d -p 5000:80 --name overlord --restart always nginx

##### 7. Get the internal IP address of the overloard container without starting its shell and in one command.

	docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' overlord

##### 8. Launch a shell from an alpine container and make sure that you can interact directly with the container via your terminal, and that the container deletes itself once the shell's execution is done.

	docker run -it --rm alpine

##### 9. From the shell of a debian container, install via the container's package manager everything you need to compile C source code and push it onto a git repo (of course, make sure before that the package manger and the packages already in the container are updated). For this excercies, you should only specify the commands to be run directly in the container.

	apt-get update && apt-get upgrade
	apt-get install build-essential
	apt-get install gcc
	apt-get install git

##### 10. Create a volume named hatchery.

	docker volume create hatchery

##### 11. List all the Docker volumes created on the machine. Remember. VOLUMES.

	docker volume ls

##### 12. Launch a mysql container as a background task. It should be able to restart on its own in case of error, and the root password of the database should be Kerrigan. You will also make sure that the databse is stored in the hatchery volume, that the container directly creates a database named zerglings, and that the container itself is named spawning-pool.

	docker run -d --name spawning-pool --restart always -v hatchery:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=Kerrigan mysql:latest

##### 13. Print the enviornment variables of the spawning-pool container in one command, to be sure that you have configured your container properly.

	docker exec spawning-pool env

##### 14. Launch a wordpress container as a background task, just for fun. The container should be named lair, its 80 port should be bound to 8080 port of the virtual machine and it should be able to use the spawning-pool container as a database service. You can try to access lair on your machine via a web browswer, with the IP address of the virtual machine as a URL.

	docker run -d -p 8080:80 --name lair --link spawning-pool:mysql wordpress

##### 15. Launch a phpmyadmin container as a background task. It should be named roach-warden, its 80 port should be bound to 8081 port of the virtual machine and it should be able to explore the database stored in the spawning-pool container.

	docker run -d -p 8081:80 --name roach-warden --link spawning-pool:mysql phpmyadmin/phpmyadmin

##### 16. Look up the spawning-pool container's logs in real time without running its shell

	docker logs spawn-pool

##### 17. Display all the currently active containers on the Char virtual machine.

	docker container ls

##### 18. Relaunch overlord container

	docker restart overlord

##### 19. Launch a container name Abathur. It will be a Python container, 2-slim version, its /root folder will be bound to a HOME folder on your host, and its 3000 port will be bound to the 3000 port of your virtual machine. You will personalize this container so that you can use the Flask micro-framework in its latest version. You will make sure that an html page displaying 'Hello World' with < h1 > tags can be served by Flask. You will tesst that your container is properly set up by accessing, via curl or a web browser, the IP address of your virtual machine on the 3000 port. You will also list all the neccessary commands in you repository

	docker run --name Abathur -v $HOME:/root -w /root -p 3000:3000 -dt python:2-slim
	docker exec Abathur pip install flask
	docker exec Abathur touch main.py
	docker exec Abathur bash -c "echo 'from flask import Flask' >> main.py"
	docker exec Abathur bash -c "echo 'app = Flask(__name__)' >> main.py"
	docker exec Abathur bash -c "echo \"@app.route('/')\" >> main.py"
	docker exec Abathur bash -c "echo \"def hello_world():\" >> main.py"
	docker exec Abathur bash -c "echo \"	return '<h1>Hello World</h1>'\" >> main.py"
	docker exec Abathur bash -c 'export FLASK_APP=/root/main.py && flask run -h 0.0.0.0 -p 3000'

##### 20. Create a local swarm, the Char virtual machine should be its manager
	docker-machine ssh Char
	docker swarm init --advertise-addr 192.168.99.102

##### 21. Create another virtual machine with docker-machine using the virtualbox driver, and name it Aiur

	docker-machine create --driver virtualbox Aiur

##### 22. Add Aiur as a worker of the local swarm in which Char is leader (the command to take control of Aiur is not requested)

	docker-machine ssh Aiur
	docker swarm join --token SWMTKN-1-2r7zxr98bw0p4bft5vtykz9o4sc0pe5tkm0p5axprn3wtwhpe4-7qcdg9ec273wh5do0z48q7lru 192.168.99.102:2377

##### 23. Create an overlay-type internal network that you will name overmind.

	docker network create -d overlay overmind

##### 24. Launch a rabbitmq SERVICE that will be named orbital-command. You should define a specific user and password for the RabbitMQ service, they can be whatever you want. This service will be on the overmind network

	docker service create --hostname orbital-command --name orbital-command  --network overmind -e RABITMQ_DEFAULT_USER=kenneth -e RABITMQ_DEFAULT_PASS=cheung rabbitq:3

##### 25. List all the services of the local swarm

	docker service ls

##### 26. Launch a 42school/engineering-bay service in two replicas and make sure that the service works properly (see the documentation provided at hub.docker.com). This service will be named engineering-bay and will be on the overmind network.

	docker service create --name engineering-bay --network overmind  --replicas 2 -e OC_USERNAME=kenneth -e OC_PASSWD=cheung  42school/engineering-bay

##### 27. Get the real-time logs of one of the taks of the engineering-bay service

	docker service logs -f $(docker service ps -q -f name=engineering-bay.1 -f desired-state=ready engineering-bay)

##### 28. Damn it, a group of zergs is attacking orbital-command, and shutting down the engineering-bay service won't help it at all... You must send a troup of Marines to eliminate the intruders. Launch a 42school/marine-squad in two replicas, and make sure that the service works properly (see documentation provided at hub.docker.com). This service will be named... marines and will be on the overmind network

	docker service create --name marines --replicas 2 --network overmind -e OC_USERNAME=kenneth -e OC_PASSWD=cheung 42school/marine-squad

##### 29. Display all the tasks of the marines service

	docker service ps marines

##### 30. Increase the number of copies of the marines service up to twenty, because there's never enough Marines to eliminate Zergs. (Remember to take a look at the tasks and logs of the service you'll see it's fun)

	docker service scale marines=20

##### 31. Force quit and delete all the services on the local swarm, in one command

	docker service rm $(docker service ls)

##### 32. Force quit and delete all the containers (whatever their status), in one command.

	docker rm -f $(docker ps -qa)

##### 33. Delete all the container images stored on the Char virtual machine, in one command as well

	docker-machine rm -f Char

##### 34. Delete Aiur virtual machine without using rm -f

	docker-machine kill Aiur
	docker-machine rm Aiur -y
