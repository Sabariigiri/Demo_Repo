{{ config(
    materialized='incremental',
    incremental_strategy='merge',
    unique_key=[
        'transaction_date',
        'cust_number',
        'product_id'
    ]
) }}

select
    cast(i.transaction_timestamp as date) as transaction_date,
    c.cust_country_code as customer_country_code,
    i.region,
    i.zone,
    c.cust_number,
    c.cust_name,
    c.cust_location,
    p.product_id,
    p.product_name,
    p.product_category,
    sum(i.quantity) as total_quantity,
    sum(i.quantity * p.product_pricing) as total_value,
    sum((i.quantity * p.product_pricing) * p.product_margin / 100) as total_margin,
    count(*) as total_order
from {{ ref('stg_invoice_raw') }} i
join {{ ref('customer_master') }} c
  on i.cust_number = c.cust_number
join {{ ref('product_master') }} p
  on i.product_id = p.product_id

{% if is_incremental() %}
where i.transaction_timestamp >
      (select max(transaction_date) from {{ this }})
{% endif %}

group by
    transaction_date,
    customer_country_code,
    i.region,
    i.zone,
    c.cust_number,
    c.cust_name,
    c.cust_location,
    p.product_id,
    p.product_name,
    p.product_category
