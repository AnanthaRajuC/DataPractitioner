
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table') }}

with sakila_actor as (

    select 
        actor_id as actor_actor_id,
        first_name, 
        last_name, 
        last_update as actor_last_update
    from actor

),

sakila_film_actor as (
    select 
        actor_id as film_actor_actor_id,
        film_id,
        last_update as film_actor_last_update
    from film_actor        
),

combined as (
    select
        actor_actor_id,
        first_name, 
        last_name, 
        actor_last_update,

        film_actor_actor_id,
        film_id,
        film_actor_last_update
    from sakila_actor sa
    left join sakila_film_actor sfa on sfa.film_actor_actor_id = sa.actor_actor_id
    group by actor_actor_id,first_name, last_name, actor_last_update,film_actor_actor_id,film_id,film_actor_last_update

)


select *
from combined