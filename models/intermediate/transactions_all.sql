select *
from {{ ref("stg_transactions_1") }}
union all
select *
from {{ ref("stg_transactions_2") }}
union all
select *
from {{ ref("stg_transactions_3") }}
