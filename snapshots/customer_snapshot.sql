{% snapshot customer_snapshot%}
{{
    config(
        target_database='DBT_SANDBOX',
        target_schema='DBT_RKUMAR',
        unique_key='KUNNR',
        strategy='timestamp',
        updated_at='CREATED',
    )
}}
select * from {{source('cust','cust_sn')}}
{% endsnapshot%}