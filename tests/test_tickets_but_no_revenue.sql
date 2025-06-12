SELECT *
FROM {{ ref('mart_movies') }}
WHERE tickets_sold > 0 AND revenue = 0
