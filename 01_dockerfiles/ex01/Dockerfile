FROM debian

WORKDIR /home/teamspeak
RUN mkdir -p /home/teamspeak && \
	apt-get update && \
	apt-get install wget -y && \
	wget http://dl.4players.de/ts/releases/3.0.11.1/teamspeak3-server_linux-amd64-3.0.11.1.tar.gz && \
	tar -xzvf *.tar.gz && \
	rm *.tar.gz

ADD ./teamspeak.sh  /home/teamspeak.sh 

RUN chmod +x /home/teamspeak.sh 

EXPOSE 9987/UDP
EXPOSE 30033
EXPOSE 10011

ENTRYPOINT ["sh", "/home/teamspeak.sh", "start"]

