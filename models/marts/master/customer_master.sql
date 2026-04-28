{{ config(materialized='view') }}

with base as (
    select
        cust_number,
        first_name || ' ' || last_name as cust_name,
        cust_location,
        cust_country,
        validity_start,
        validity_end
    from {{ ref('stg_cust_mstr_kna1') }}
),


latest_customer as (
    select *
    from base
    qualify row_number() over (
        partition by cust_number
        order by validity_end desc
    ) = 1
),


filtered_customer as (
    select *
    from latest_customer
    where cust_country not in ('+7', '+92')
)

select
    c.cust_number,
    c.cust_name,
    c.cust_location,
    c.cust_country,
    r.country_code as cust_country_code
from filtered_customer c
left join {{ ref('country_code') }} r
  on c.cust_country = r.country


