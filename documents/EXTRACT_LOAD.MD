## Extract and Load

```shell
clickhouse-client --password
```

```shell
create database sakila_db
```

```sql
CREATE TABLE `actor` (
  `actor_id` Int64,
  `first_name` Nullable(String),
  `last_name` Nullable(String),
  `last_update` Nullable(DateTime64)
) ENGINE = MergeTree ORDER BY actor_id;
```

```shell
clickhouse-mysql \
    --src-host=localhost \
    --src-user=admin \
    --src-password=password \
    --migrate-table \
    --src-tables=sakila.actor \
    --dst-host=127.0.0.1 \
    --dst-password=root \
    --dst-schema sakila_db \
    --dst-table actor  
```    

```sql
CREATE TABLE `film_actor` (
  `actor_id` Int64,
  `film_id` Int64,
  `last_update` Nullable(DateTime64)
) ENGINE = MergeTree ORDER BY (actor_id,film_id);
``` 

```shell
clickhouse-mysql \
    --src-host=localhost \
    --src-user=admin \
    --src-password=password \
    --migrate-table \
    --src-tables=sakila.film_actor \
    --dst-host=127.0.0.1 \
    --dst-password=root \
    --dst-schema sakila_db \
    --dst-table film_actor  
```