

select 
pk_id_pricedate
, adjustedclose
, ticker
from tbl_pricedate 
order by 
    ticker asc 
    , date asc


select pk_id_pricedate, adjustedclose, ticker from tbl_pricedate order by ticker asc , date asc
select * from [STG].[ticker_price_date_trend_regime]

select 
    pgs.player_name
    , fouls = sum(pgs.personal_fouls)
    , minutes = sum(pgs.minutes)
    , fouls_per_minute = cast(sum(pgs.personal_fouls) as float)/ cast(sum(pgs.minutes) as float)
    , blocks = sum(pgs.blocks)
from clean.player_game_stats pgs 
group by    
    pgs.player_name
having sum(pgs.minutes) != 0 and sum(pgs.minutes) >= 1000
