with bronze_sales as (
    select 
        sales_id,
        product_sk,
        customer_sk,
        {{ multiply('unit_price', 'quantity') }} as calculated_gross_amount,
        gross_amount,
        payment_method
    from {{ ref('bronze_sales') }}
),
bronze_products as (
    select 
        product_sk,
        category
    from {{ ref('bronze_product') }}
),
bronze_customer as (
    select
        customer_sk,
        first_name,
        last_name,
        email,
        gender
    from {{ ref('bronze_customer') }}
),joined_query as(
select 
    bs.sales_id,
    bs.product_sk,
    bs.customer_sk,
    bs.gross_amount,
    bs.payment_method,
    bp.category,
    bc.first_name,
    bc.last_name,
    bc.email,
    bc.gender
from bronze_sales bs
left join bronze_products bp on bs.product_sk = bp.product_sk
left join bronze_customer bc on bs.customer_sk = bc.customer_sk
)
select 
category,
gender,
sum(gross_amount) as total_sales
from joined_query
group by category, gender
order by total_sales desc
