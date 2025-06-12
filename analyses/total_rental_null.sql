select t.movie_id, t.month, t.location, t.ticket_amount, t.transaction_total,r.total_rental
from {{ ref ('transactions_all') }} as t
left join
    {{ ref ('rental_all') }} as r
    on t.movie_id = r.movie_id
    and t.month = r.month
    and t.location = r.location
where total_rental is null
