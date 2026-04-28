{{ config(materialized='table') }}

select
    date_trunc('month', transaction_date) as transaction_month,
    customer_country_code,
    region,
    zone,
    cust_number,
    cust_name,
    cust_location,
    product_id,
    product_name,
    product_category,
    sum(total_quantity) as total_quantity,
    sum(total_value) as total_value,
    sum(total_margin) as total_margin,
    sum(total_order) as total_order
from {{ ref('day_invoice') }}
group by
    transaction_month,
    customer_country_code,
    region,
    zone,
    cust_number,
    cust_name,
    cust_location,
    product_id,
    product_name,
    product_category