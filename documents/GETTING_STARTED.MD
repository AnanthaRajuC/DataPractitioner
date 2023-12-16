## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. 

```shell
dbt init dbt_data_practitioner 
```

<img src="images\1_dbt_init.png"/>

```shell
cd dbt_data_practitioner
```

```shell
touch profiles.yml
```

```yml
sakila_db:
  target: dev
  outputs:
    dev:
      type: clickhouse
      schema: sakila_db
      host: localhost
      port: 8123
      user: default
      password: root
      secure: False
```

```shell
dbt debug
```

<img src="images\2_dbt_debug.png"/>

```shell
dbt docs generate
```

<img src="images\3_dbt_docs_generate.png"/>

```shell
dbt docs serve  
```

To access from your browser, navigate to: http://localhost:8080  

Press Ctrl+C to exit.  

<img src="images\4_dbt_docs_serve.png"/>


```shell
cd models  
mkdir sakila_db  
cd sakila_db  
```

```shell
touch actor_film_actor_join.sql
touch point_of_interest_1.sql
```

```shell
dbt build
```

Lineage Graph

<img src="images\5_lineage_graph.png"/>

```shell
cd dbt_data_practitioner
dagster-dbt project scaffold --project-name dagster_data_practitioner
```

<img src="images\6_dagster_data_practitioner.png"/>

```shell
cd dagster_data_practitioner
DAGSTER_DBT_PARSE_PROJECT_ON_LOAD=1 dagster dev
```

<img src="images\7_dagster_launch.png"/>

To access from your browser, navigate to: http://127.0.0.1:3000  

<img src="images\8_dagster_asset_group_materialized.png"/>

<img src="images\9_dagger_runs.png"/>

<img src="images\10_dagger_run_details.png"/>