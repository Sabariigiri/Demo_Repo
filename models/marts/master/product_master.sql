{{ config(materialized='view') }}

select
    product_id,
    product_name,
    product_pricing,
    product_margin,
    date,
    case
      when category_code = 1 then 'Snacks'
      when category_code = 2 then 'Cereal'
      else 'Other'
    end as product_category
from {{ ref('stg_prod_mstr_pna1') }}


