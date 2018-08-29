FROM mongo:3.2
RUN apt-get update && \
	apt-get install -y iputils-ping

COPY setup.sh /setup.sh
ENTRYPOINT [ "/setup.sh" ]
