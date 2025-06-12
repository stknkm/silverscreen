SELECT movie_id, month, location, COUNT(*)
FROM {{ ref('mart_movies') }}
GROUP BY movie_id, month, location
HAVING COUNT(*) > 1