with

orders as (

    select * from {{ ref('stg_orders') }}

),

payments as (

    select * from {{ ref('stg_payments') }}
    where status != 'fail'

),

joined as (

    select
    
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        sum(payments.amount) as order_total
        
    from orders
    left join payments on orders.order_id = payments.order_id
    group by 1,2,3

)

select * from joined

