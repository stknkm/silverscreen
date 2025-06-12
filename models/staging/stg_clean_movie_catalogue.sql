select
    movie_id,
    movie_title,
    release_date,
    COALESCE(genre,'Unknown') as genre,
    country,
    studio,
    budget,
    director,
    COALESCE(rating,'Unknown') as rating,
    
from {{ source("silverscreen", "movie_catalogue") }}
