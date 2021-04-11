Step to install
* docker stack deploy --compose-file docker-compose-local.yaml barman_test
* Create user in pg: createuser --user postgres --interactive -P barman
* Create streaming user in pg: createuser --user postgres -P --replication streaming_barman
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
  
* barman switch-xlog --force --archive streaming

# Step to recover
* Shutdown postgres
* Switch wal: barman switch-wal streaming
* Set permission for barman to pg data folder
* Start recover: barman recover <db> <backup-id> --target-time "xxx"
* Start postgres, in case there is any error like "recovery ended before configured recovery target was reached": manually delete file recovery.signal
