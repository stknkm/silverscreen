select
    'NJ_003' as location,
    {{get_month('timestamp')}} as month,
    details as movie_id,
    sum(amount) as ticket_amount,
    sum(total_value) as transaction_total
from {{ source("silverscreen", "transactions_3") }}
where product_type = 'ticket'
group by location, month, movie_id
order by month
