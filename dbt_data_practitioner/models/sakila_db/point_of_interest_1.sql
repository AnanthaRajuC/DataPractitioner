{{ config(materialized='view') }}

with transformed as (
    select
    CONCAT(first_name, ' ', last_name) as name
    from  {{ ref('actor_film_actor_join') }}
)

select * from transformed