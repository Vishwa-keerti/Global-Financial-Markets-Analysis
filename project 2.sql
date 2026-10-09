--creating the table 

CREATE TABLE market_data (
    date DATE NOT NULL,
    market VARCHAR(30) NOT NULL,
    price NUMERIC(14, 4) NOT NULL,
    open NUMERIC(14, 4) NOT NULL,
    high NUMERIC(14, 4) NOT NULL,
    low NUMERIC(14, 4) NOT NULL,
    change_pct NUMERIC(10, 4) NOT NULL,

    PRIMARY KEY (date, market),

    CHECK (price > 0),
    CHECK (open > 0),
    CHECK (high > 0),
    CHECK (low > 0),
    CHECK (high >= low)
);

select count(*) as total_records from market_data ;

--understanding data 
select *  from market_data limit 10 ;

--number of records per market 
select market , count(*) as total_records from market_data group by market ;

--checking for invalid price
select * from market_data where price <=0 or open <= 0 or high <= 0 or low<= 0 or high < low ;

--Which market has experienced the greatest percentage increase over the period covered by the dataset?
with market_start as ( select distinct on (market) market , date as start_date , price as start_price 
from market_data order by market , date ),
     market_end as (select distinct on (market) market , date as end_date , price as end_price  
from market_data order by market , date desc)
select s.market , s.start_date , e.end_date , round(s.start_price ,2) as start_price , round(e.end_price,2) as end_price , 
round((e.end_price - s.start_price)/s.start_price*100 , 2) as total_change_pct from market_start s join market_end e 
on s.market = e.market order by total_change_pct ;
--Gold experienced the greatest percentage increase (194.42%) over the period covered by the dataset
--Brent oil shows least percentage change (9.77%)
--others Nifty 50 (69.57%) , Nikkei 225 (93.32) , S&P 500 (117.2%)

-- daily returns 
create or replace view market_returns as 
with daily_prices as (select market , date , price , lag(price) over (partition by market order by date ) as previous_price 
    from market_data )
	select market , date , price , previous_price , round((price-previous_price)/previous_price*100 ,2) as daily_return_pct from daily_prices ;
	
select * from market_returns where market = 'Gold' limit 10 ;

--market volatility 
select market , count(daily_return_pct) as observations , round(stddev_samp(daily_return_pct),4) as daily_volatility_pct , round(stddev_samp(daily_return_pct) * sqrt(252)::numeric,4)
as annualize_volatility_pct from market_returns group by market order by annualize_volatility_pct desc ;
--Brent oil was most volatile followed by Nikkei 225 while Nifty 50 was least volatile 


