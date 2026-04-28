select *
from {{ ref('day_invoice') }}
where total_value < 0