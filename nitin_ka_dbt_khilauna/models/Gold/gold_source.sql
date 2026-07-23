with deduplicated as (
select *,
row_number() over (partition by id order by updateDate desc) as deduplication_id
from
{{ source('source','items')}}
)
select 
    id,
    name,
    category,
    updateDate 

from deduplicated
where
    deduplication_id = 1
