select
    'NJ_002' as location,
    {{get_month('date')}} as month,
    movie_id,
    sum(ticket_amount) as ticket_amount,
    sum(total_earned) as transaction_total
from {{ source("silverscreen", "transactions_2") }}
group by location, month, movie_id
order by month
