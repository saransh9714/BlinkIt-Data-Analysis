create database blinkit_data;
use blinkit_data;

select *
from blinkit;


show columns from blinkit;
 
#data cleaning 
SET SQL_SAFE_UPDATES = 0;
UPDATE blinkit 
set item_fat_content=
case 
when item_fat_content in ('LF' , 'low fat')then 'Low Fat'
when item_fat_content= 'reg' then 'Regular'
else item_fat_content
end
;
#to check if data is cleaned or not 
select distinct item_fat_content
from blinkit;
 
 ## KPI Requirements
 #total sales in millions 
select cast(sum(sales) /1000000 as decimal(11,2)) as Total_sales_Millions
from blinkit;
 
 #avg sales 
select cast(avg(sales) as decimal(10,1)) as avg_sales
from blinkit;
 
 #no of items  
select count(*) as no_of_items 
from blinkit;
 
 #avg rating 
select cast(avg(Rating) as decimal(10,2))as avg_rating
from blinkit;

 ##granular requirements
 
 #impact of fat content on KPIs
 select item_fat_content ,
 cast(sum(Sales)/1000000 as decimal(10,2)) as total_sales_millions ,
 cast(avg(Sales) as decimal(10,2)) as avg_sales,
 count(*) as no_of_items ,
 cast(avg(Rating) as decimal(10,2)) as avg_rating
 from blinkit
 group by item_fat_content
 order by total_sales_millions desc ;
 
#impact of item type on KPIs
 select Item_Type,
 cast(sum(Sales)/1000000 as decimal(10,2)) as total_sales_millions ,
 cast(avg(Sales) as decimal(10,2)) as avg_sales,
 count(*) as no_of_items ,
 cast(avg(Rating) as decimal(10,2)) as avg_rating
 from blinkit
 group by Item_Type
 order by total_sales_millions desc ;
 
 #impact of fat content by outlet on KPIs
 select item_fat_content , Outlet_Location_Type,
 cast(sum(Sales)/1000000 as decimal(10,2)) as total_sales_millions,
 Cast(avg(sales) as decimal(10,2)) as avg_sales,
 count(*) as no_of_items,
 cast(avg(Rating) as decimal(10,2))as avg_rating
 from blinkit
 group by item_fat_content , Outlet_Location_Type
 order by item_fat_content;
 
 
#impact of outlet establishment year on KPIs,
select Outlet_Establishment_Year,
cast(sum(Sales)/1000000 as decimal(10,2)) as total_sales_millions,
Cast(avg(sales) as decimal(10,2)) as avg_sales,
count(*) as no_of_items,
cast(avg(Rating) as decimal(10,2))as avg_rating
from blinkit
group by Outlet_Establishment_Year
order by total_sales_millions desc;

##charts requiremnts 
#impact of outlet size on sales in percent
select Outlet_Size,
cast(sum(Sales)/1000000 as decimal(10,2)) as total_sales_m,
cast((sum(Sales)*100/sum(sum(Sales)) over())as decimal(10,2)) as percent_of_sales
from blinkit
group by Outlet_Size;

#impact of outlet location type on sales in percent
select Outlet_Location_Type,
cast(sum(Sales)/1000000 as decimal(10,2)) as total_sales_m,
cast((sum(Sales)*100/sum(sum(Sales)) over())as decimal(10,2)) as percent_of_sales,
cast(avg(Sales) as decimal(10,2)) as avg_sales,
count(*) as no_of_items ,
cast(avg(Rating) as decimal(10,2)) as avg_rating
from blinkit 
group by Outlet_Location_Type
order by total_sales_m;

#impact of outlet type on sales in percent 
select Outlet_Type ,
cast(sum(Sales)/1000000 as decimal(10,2)) as total_sales_m,
cast((sum(Sales)*100/sum(sum(sales)) over()) as decimal(10,2)) as sales_in_percent,
cast(avg(Sales) as decimal(10,2)) as avg_sales,
count(*) as no_of_items ,
cast(avg(Rating) as decimal(10,2)) as avg_rating
from blinkit 
group by Outlet_Type
order by sales_in_percent desc;



