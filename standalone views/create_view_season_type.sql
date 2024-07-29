SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[season_type] as

select season = 2023, [type] = 'Regular', start_date = '2023-10-24', end_date = '2024-04-14' union all
select season = 2023, [type] = 'Play-in', start_date = '2024-04-15', end_date = '2024-04-19' union all
select season = 2023, [type] = 'Playoffs', start_date = '2024-04-20', end_date = '2024-06-15' union all

select season = 2022, [type] = 'Regular', start_date = '2022-10-18', end_date = '2023-04-09' union all
select season = 2022, [type] = 'Play-in', start_date = '2023-04-10', end_date = '2023-04-14' union all
select season = 2022, [type] = 'Playoffs', start_date = '2023-04-15', end_date = '2023-06-12' union all

select season = 2021, [type] = 'Regular', start_date = '2021-10-19', end_date = '2022-04-10' union all
select season = 2021, [type] = 'Play-in', start_date = '2022-04-11', end_date = '2022-04-15' union all
select season = 2021, [type] = 'Playoffs', start_date = '2022-04-16', end_date = '2022-06-19' union all 

select season = 2020, [type] = 'Regular', start_date = '2020-12-21', end_date = '2021-05-16' union all
select season = 2020, [type] = 'Play-in', start_date = '2021-05-17', end_date = '2021-05-21' union all
select season = 2020, [type] = 'Playoffs', start_date = '2021-05-22', end_date = '2021-07-20' union all

select season = 2019, [type] = 'Regular', start_date = '2019-10-22', end_date = '2020-08-14' union all
select season = 2019, [type] = 'Play-in', start_date = '2020-08-15', end_date = '2020-08-16' union all
select season = 2019, [type] = 'Playoffs', start_date = '2020-08-17', end_date = '2020-10-11' union all

select season = 2018, [type] = 'Regular', start_date = '2018-10-06', end_date = '2019-04-10' union all
select season = 2018, [type] = 'Playoffs', start_date = '2019-04-13', end_date = '2019-06-13'union all

select season = 2017, [type] = 'Regular', start_date = '2017-10-17', end_date = '2018-04-11' union all
select season = 2017, [type] = 'Playoffs', start_date = '2018-04-14', end_date = '2018-06-17' union all

select season = 2016, [type] = 'Regular', start_date = '2016-10-25', end_date = '2017-04-12' union all
select season = 2016, [type] = 'Playoffs', start_date = '2017-04-15', end_date = '2017-06-12' union all

select season = 2015, [type] = 'Regular', start_date = '2015-10-27', end_date = '2016-04-14' union all
select season = 2015, [type] = 'Playoffs', start_date = '2016-04-16', end_date = '2016-06-19'
GO
