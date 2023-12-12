{{config(materialized='table')}}
with cust_sn as(
    select KUNNR,CURRENT_TIMESTAMP() AS CREATED from {{source('Customer','KNA1')}}
)select * from customer_snapshot