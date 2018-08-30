FROM mongo:3.2
ENTRYPOINT [ "/usr/bin/mongod", "--port", $MONGO_PORT, "--replSet", "rs", "--journal", "--smallfiles", "--rest" ]
