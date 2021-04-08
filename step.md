Step to install
* docker stack deploy --compose-file docker-compose-local.yaml barman_test
* Create user in pg: createuser --interactive -P barman
* Create streaming user in pg: createuser -u postgres -P --replication streaming_barman
* Restart pg
* Change password in barman: passwd barman
* Switch exec user to barman
* Save password:
  ** echo "pg:5432:*:barman:password" >> ~/.pgpass
  ** echo "pg:5432:*:streaming_barman:password" >> ~/.pgpass
* Change permission: cd ~barman && chmod 0600 .pgpass  
* Test (if it not require password then OK): 
  ** psql -c 'SELECT version()' -U barman -h pg postgres
  ** psql -U streaming_barman -h pg   -c "IDENTIFY_SYSTEM"   replication=1

