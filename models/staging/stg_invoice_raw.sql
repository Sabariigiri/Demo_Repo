select
    transaction_timestamp,
    cust_number,
    product_id,
    quantity,
    region,
    zone
from {{ source('strage', 'invoice_raw') }}