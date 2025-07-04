select round(avg(aqi),2) AS avg_aqi, county_name
from "2003_aqi_data"
where state_name = 'Utah'
group by county_name
order by avg_aqi desc;


select round(avg(aqi),2) AS avg_aqi, county_name
from "2013_aqi_data"
where state_name = 'Utah'
group by county_name
order by avg_aqi desc;

select round(avg(aqi),2) AS avg_aqi, county_name
from "2023_AQI_Data"
where state_name = 'Utah'
group by county_name
order by avg_aqi desc;

select count(*) from "2003_aqi_data";

select count(*) from "2013_aqi_data";

select count(*) from "2023_AQI_Data";
