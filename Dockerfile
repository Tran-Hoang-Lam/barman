FROM postgres:13

RUN apt update
RUN apt install -y vim barman

RUN chown -R barman /var/lib/postgresql/data

COPY barman/barman.conf /etc/barman.conf
COPY barman/streaming.conf /etc/barman.d/streaming.conf

RUN echo "pg:5432:*:barman:secret" >> ~barman/.pgpass
RUN echo "pg:5432:*:streaming_barman:secret" >> ~barman/.pgpass

RUN chmod 0600 ~barman/.pgpass

USER barman

ENTRYPOINT ["sleep", "infinity"]
