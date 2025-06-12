SELECT *
FROM {{ ref('mart_movies') }}
WHERE revenue > 0 AND tickets_sold = 0
