FROM postgres:13

RUN apt update
RUN apt install -y vim barman

ENTRYPOINT ["sleep", "infinity"]
