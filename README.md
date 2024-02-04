# Proton

CDC  with Debezium/Redpanda/Proton


## Local Environment Setup

 
## First Time Setup

Unpack `localhost.direct.zip`.

> HINT: password: `localhost`

```shell
unzip -P localhost infra/traefik/certs/localhost.direct.zip -d infra/traefik/certs/
```


## Start

```shell
docker-compose up

open https://traefik.localhost.direct/dashboard/#/
open https://console.localhost.direct/
open https://connect.localhost.direct/
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
curl -X POST -H "Content-Type: application/json" --data @connector.json https://connect.localhost.direct/connectors | jq
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

### Connnect to Proton via DBeaver or DataGrip

https://github.com/timeplus-io/proton/tree/develop/examples/jdbc

## References

- [Development Environment](https://github.com/getlago/lago/wiki/Development-Environment)
- [CDC with Debezium/Redpanda/Proton](https://github.com/timeplus-io/proton/tree/develop/examples/cdc)