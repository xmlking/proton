# Proton

CDC  with Debezium/Redpanda/Proton


## Local Environment Setup

Install [mkcert](https://github.com/FiloSottile/mkcert) and generate some certs for TLS usage

```shell
# install mkcert
brew install mkcert
mkcert -install

# You can find the root CA path by running the command below.
mkcert -CAROOT
ls -1 ~/Library/Application\ Support/mkcert 

```

### Create Certs

```shell
cd  infra/traefik
mkdir certs && cd certs

mkcert -cert-file k8s.local-cert.pem -key-file k8s.local-key.pem \
"*.k8s.local" localhost 127.0.0.1 ::1
```

> Reminder: X.509 wildcards only go one level deep, so this won't match a.b.k8s.local


### Tell your PC where to go
```shell
vi /etc/hosts
# then this line at the end
127.0.0.1 k8s.local
```

## Start

```shell
docker-compose up

open https://traefik.k8s.local/dashboard/#/
open http://traefik.k8s.local/dashboard/#/

open https://console.k8s.local/
open https://connect.k8s.local/
```


## PostgreSQL

```shell
docker exec -i postgres psql -U postgres -d postgres
```

Create the data table
```sql
CREATE table characters (
        id INT PRIMARY KEY,
        first_name VARCHAR(50),
        last_name VARCHAR(50)
        );
INSERT INTO characters VALUES (1, 'luke', 'skywalker');
INSERT INTO characters VALUES (2, 'anakin', 'skywalker');
INSERT INTO characters VALUES (3, 'padmé', 'amidala');
SELECT * FROM characters;
```
Create Signal Table (still required)

```sql
CREATE TABLE debezium_signal (id VARCHAR(100) PRIMARY KEY, type VARCHAR(100) NOT NULL, data VARCHAR(2048) NULL);
```

## Create the CDC job

Perform the following command in your host server, since port 8083 is exposed from Debezium Connect.


```
```shell
curl -X POST -H "Content-Type: application/json" --data @connector.json https://connect.k8s.local/connectors | jq
```

### Trigger the Snapshot

```sql
INSERT INTO debezium_signal (id, type, data) VALUES ('ad-hoc', 'execute-snapshot', '{"data-collections": ["public.characters"],"type":"incremental"}');
```

## Produce into signal Kafka topic (the new event-driven way)
   
```
## Run Proton SQL


Create the data table
You can use `docker exec -it proton proton-client -m -n` to run the SQL client in Proton container. 

```shell
select * from customers
```


## References

- [Development Environment](https://github.com/getlago/lago/wiki/Development-Environment)
- [CDC with Debezium/Redpanda/Proton](https://github.com/timeplus-io/proton/tree/develop/examples/cdc)