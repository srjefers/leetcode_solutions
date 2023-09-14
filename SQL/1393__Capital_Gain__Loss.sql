/* Write your PL/SQL query statement below */
with stocks_buy as (
    select 
        stock_name,
        sum(price) as t_price
    from Stocks
    where operation = 'Buy'
    group by stock_name
),
stocks_sell as (
    select 
        stock_name,
        sum(price) as t_price
    from Stocks
    where operation = 'Sell'
    group by stock_name
),
final as (
    select 
        sb.stock_name,
        ss.t_price - sb.t_price as capital_gain_loss
    from stocks_buy sb
    left join stocks_sell ss 
        on sb.stock_name = ss.stock_name
)
select * from final