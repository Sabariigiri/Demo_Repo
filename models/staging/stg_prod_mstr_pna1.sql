select
    product_id,
    product_name,
    product_pricing,
    product_margin,
    category_code,
    date
from {{ source('stage', 'prod_mstr_pna1') }}