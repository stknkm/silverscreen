select
    'NJ_001' as location,
    {{get_month('timestamp')}} as month,
    movie_id,
    sum(ticket_amount) as ticket_amount,
    sum(transaction_total) as transaction_total
from {{ source("silverscreen", "transactions_1") }}
group by location, month, movie_id
order by month
