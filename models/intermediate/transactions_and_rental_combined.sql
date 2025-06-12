-- Step 1: Create a base table by joining transactions and rental data
-- using movie_id, month, and location.
-- This join may result in some NULLs in total_rental when no rental data exists for that month/location/movie.
WITH base AS (
    SELECT
        t.movie_id,
        t.month,
        t.location,
        t.ticket_amount,
        t.transaction_total,
        r.total_rental,

        -- Use LAG() to get the rental cost for the same movie and location
        -- from the previous month (based on chronological ordering of months).
        -- This will help us fill in missing rental values.
        LAG(r.total_rental) OVER (
            PARTITION BY t.movie_id, t.location
            ORDER BY t.month
        ) AS prev_month_rental

    FROM {{ ref('transactions_all') }} AS t

    -- LEFT JOIN ensures we keep all transactions, even if rental info is missing
    LEFT JOIN {{ ref('rental_all') }} AS r
        ON t.movie_id = r.movie_id
        AND t.month = r.month
        AND t.location = r.location
)

-- Step 2: In the final SELECT, use COALESCE to fill NULLs in total_rental
-- with the rental value from the previous month (if available).
SELECT
    movie_id,
    month,
    location,
    ticket_amount,
    transaction_total,

    -- If total_rental is missing (NULL), use the previous month's value instead.
    COALESCE(total_rental, prev_month_rental) AS total_rental_filled

FROM base