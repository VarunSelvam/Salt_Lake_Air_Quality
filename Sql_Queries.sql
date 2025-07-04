-- Average Air Quality for each Season by Year Queries --

    -- 2003 --
select extract(year from recorded_date) as
recorded_year,
case
when extract(month from recorded_date) in
(12,1,2,3) then 'WINTER'
when extract(month from recorded_date) in
(4,5) then 'SPRING'
when extract(month from recorded_date) in
(6,7,8) then 'SUMMER'
when extract(month from recorded_date) in
(9,10,11) then 'FALL'
end as SEASON,
AVG(AQI)
from "2003_aqi_data"
group by recorded_year, SEASON

    -- 2013 --
select extract(year from recorded_date) as
recorded_year,
case
when extract(month from recorded_date) in
(12,1,2,3) then 'WINTER'
when extract(month from recorded_date) in
(4,5) then 'SPRING'
when extract(month from recorded_date) in
(6,7,8) then 'SUMMER'
when extract(month from recorded_date) in
(9,10,11) then 'FALL'
end as SEASON,
AVG(AQI)
from "2013_aqi_data"
group by recorded_year, SEASON

    -- 2023 -- 
select extract(year from recorded_date) as
recorded_year,
case
when extract(month from recorded_date) in
(12,1,2,3) then 'WINTER'
when extract(month from recorded_date) in
(4,5) then 'SPRING'
when extract(month from recorded_date) in
(6,7,8) then 'SUMMER'
when extract(month from recorded_date) in
(9,10,11) then 'FALL'
end as SEASON,
AVG(AQI)
from "2023_AQI_Data"
group by recorded_year, SEASON

-- Top 10 locations with worst AQI in each year --

    -- 2003 --
select recorded_year, state_name, county_name,
category, aqi from
(select extract(year from recorded_date) as
recorded_year, state_name, county_name,
category, aqi
from "2003_aqi_data"
order by aqi desc) worst_aqi
limit 10

    -- 2013 --
select recorded_year, state_name,
county_name, category, aqi from
(select extract(year from recorded_date) as
recorded_year, state_name, county_name,
category, aqi
from "2013_aqi_data"
order by aqi desc) worst_aqi
limit 10

    -- 2023 -- 
select recorded_year, state_name, county_name,
category, aqi from
(select extract(year from recorded_date) as
recorded_year, state_name, county_name,
category, aqi
from "2023_AQI_Data"
order by aqi desc) worst_aqi
limit 10

/*Top 10 locations with the best improvement over 20 years, 
from the first year to the most recent year */

select state_name, county_name, "2023_aqi",
"2003_aqi",diff_in_aqi from
(select state_name, county_name,
sum(max_aqi) "2023_aqi", sum(min_aqi)
"2003_aqi",
(sum(max_aqi) - sum(min_aqi)) as
diff_in_aqi
from
(
select extract(year from recorded_date) as
rec_year,
state_name, county_name, max(aqi) max_aqi,
as min_aqi
from "2023_AQI_Data"
group by rec_year, state_name, county_name,min_aqi
union
select extract(year from recorded_date)
rec_year, state_name, county_name, 0 as
max_aqi, min(aqi) min_aqi
from "2003_aqi_data"
group by rec_year, state_name, county_name,
max_aqi
) combined_aqi
group by state_name, county_name
order by diff_in_aqi asc
) final_aqi
limit 10

-- Top 10 locations with the worst decline over 20 years? --

select state_name, county_name, "2023_aqi",
"2003_aqi",diff_in_aqi from
(select state_name, county_name,
sum(max_aqi) "2023_aqi", sum(min_aqi)
"2003_aqi",
(sum(max_aqi) - sum(min_aqi)) as
diff_in_aqi
from
(
select extract(year from recorded_date) as
rec_year,
state_name, county_name, max(aqi) max_aqi,
0 as min_aqi
from "2023_AQI_Data"
group by rec_year, state_name, county_name,
min_aqi
union
select extract(year from recorded_date)
rec_year, state_name, county_name, 0 as
max_aqi, min(aqi) min_aqi
from "2003_aqi_data"
group by rec_year, state_name, county_name,
max_aqi
) combined_aqi
group by state_name, county_name
order by diff_in_aqi desc
) final_aqi
limit 10

-- Number of Unhealthy days for counties in Utah. Can be used to see if air quality is improving. --

    -- 2003 --
select extract(year from recorded_date),
state_name, county_name, count(category)
from "2003_aqi_data"
where state_name = 'Utah'
and county_name = 'Utah'
and category like 'Unhealthy%'
group by extract(year from recorded_date),
state_name, county_name

    -- 2013 --
select extract(year from recorded_date),
state_name, county_name, count(category)
from "2013_aqi_data"
where state_name = 'Utah'
and county_name = 'Utah'
and category like 'Unhealthy%'
group by extract(year from recorded_date),
state_name, county_name

    -- 2023 -- 
select extract(year from recorded_date),
state_name, county_name, count(category)
from "2023_AQI_Data"
where state_name = 'Utah'
and county_name = 'Utah'
and category like 'Unhealthy%'
group by extract(year from recorded_date),
state_name, county_name

-- How many months had the most unhealthy days in Salt Lake County over the past 20 years. -- 

    -- 2003 --
select extract(year from recorded_date)
rec_year,
extract(month from recorded_date) rec_month,
state_name, county_name, count(category)
from "2003_aqi_data"
where state_name = 'Utah'
and county_name = 'Salt Lake'
and category like 'Unhealthy%'
group by extract(year from recorded_date),
extract(month from recorded_date), state_name,
county_name

    -- 2013 -- 
select extract(year from recorded_date)
rec_year,
extract(month from recorded_date) rec_month,
state_name, county_name, count(category)
from "2013_aqi_data"
where state_name = 'Utah'
and county_name = 'Salt Lake'
and category like 'Unhealthy%'
group by extract(year from recorded_date),
extract(month from recorded_date), state_name,
county_name

    -- 2023 -- 
select extract(year from recorded_date)
rec_year,
extract(month from recorded_date) rec_month,
state_name, county_name, count(category)
from "2023_AQI_Data"
where state_name = 'Utah'
and county_name = 'Salt Lake'
and category like 'Unhealthy%'
group by extract(year from recorded_date),
extract(month from recorded_date), state_name,
county_name

