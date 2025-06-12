select
    m.movie_id,
    m.movie_title,
    m.genre,
    m.studio,
    t.month,
    t.location,
    t.total_rental_filled as rental_cost,
    t.ticket_amount as tickets_sold,
    t.transaction_total as revenue

from {{ref ('stg_clean_movie_catalogue')}}   as m
left join {{ref ('transactions_and_rental_combined')}} as t
on m.movie_id = t.movie_id