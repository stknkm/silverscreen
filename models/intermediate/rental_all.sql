select movie_id, month, location_id as location, sum(total_invoice_sum) as total_rental
from {{ source("silverscreen", "invoices_raw") }}
group by movie_id, month, location
order by month
