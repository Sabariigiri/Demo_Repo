select
    cust_number,
    first_name,
    last_name,
    cust_location,
    cust_country,
    validity_start,
    validity_end
from {{ source('stage', 'cust_mstr_kna1') }}