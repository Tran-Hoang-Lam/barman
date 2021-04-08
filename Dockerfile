FROM debian:stable-slim

RUN apt update
RUN apt install -y vim barman

ENTRYPOINT ["sleep", "infinity"]
