use swiggy;
select * from swiggy;

-- 1.) HOW MANY RESTAURANTS HAVE A RATING GREATER THAN 4.5?

select count(distinct restaurant_name) as 'High rated restaurants'
from swiggy
where rating > 4.5;

-- 2.) WHICH IS THE TOP 1 CITY WITH THE HIGHEST NUMBER OF RESTAURANTS?

select city, count(distinct restaurant_name) as restaurant_count
from swiggy
group by city
order by restaurant_count desc
limit 1;

-- 3.) HOW MANY RESTAURANTS HAVE THE WORD "PIZZA" IN THEIR NAME?
select distinct restaurant_name as 'restaurants'
from swiggy
where restaurant_name like '%pizza%';

-- 4.) WHAT IS THE MOST COMMON CUISINE AMONG THE RESTAURANTS IN THE DATASET

select cuisine, count(*) as highest_cuisine
from swiggy
group by cuisine
order by highest_cuisine desc
limit 1;

-- 5.) WHAT IS THE AVERAGE RATING OF RESTAURANTS IN EACH CITY
select city, avg(rating) as rating_count
from swiggy
group by city
order by rating_count desc;

-- 6.) WHAT IS THE HIGHEST PRICE OF ITEM UNDER THE 'RECOMMENDED' MENU CATEGORY FOR EACH RESTAURANT
select restaurant_name, menu_category, max(price) as max_price
from swiggy
where menu_category ='recommended'
group by restaurant_name, menu_category;

-- 7.) FIND THE TOP 5 MOST EXPENSIVE RESTAURANTS THAT OFFER CUISINE OTHER THAN INDIAN CUISINE
select distinct restaurant_name, cost_per_person
from swiggy 
where cuisine != 'indian'
order by cost_per_person desc
limit 5;

-- 8.) FIND THE RESTAURANTS THAT HAVE AN AVERAGE COST WHICH IS HIGHER THAN THE TOTAL AVERAGE COST OF ALL RESTAURANTS TOGETHER.

select distinct restaurant_name, cost_per_person
from swiggy 
where cost_per_person >(
select avg(avg_price) from (
select restaurant_name, avg(cost_per_person) as avg_price from swiggy
group by restaurant_name) dev_tab);

-- 9.) RETRIEVE THE DETAILS OF RESTAURANTS THAT HAVE THE SAME NAME BUT ARE LOCATED IN DIFFERENT CITIES.

select distinct s1.restaurant_name, s1. city, s2. city
from swiggy s1
join swiggy s2 
on s1. restaurant_name = s2.restaurant_name
and s1.city != s2.city;

-- 10.) WHICH RESTAURANT OFFERS THE MOST NUMBER OF ITEMS IN THE 'MAIN COURSE'CATEGORY?

select distinct restaurant_name, menu_category, count(item) as tot_items
from swiggy
where menu_category = 'main course'
group by restaurant_name, menu_category
order by tot_items desc
limit 1;

-- 11.) LIST THE NAMES OF RESTAURANTS THAT ARE 100% VEGEATARIAN IN ALPHABETICAL ORDER OF RESTAURANT NAME.
select distinct restaurant_name, veg_or_nonveg
from swiggy
where veg_or_nonveg = 'veg'
order by restaurant_name;

-- 12.) WHICH IS THE RESTAURANT PROVIDING THE LOWEST AVERAGE PRICE FOR ALL ITEMS?

select distinct restaurant_name, avg(price) as avg_price
from swiggy
group by restaurant_name
order by avg_price
limit 1;

-- 13.) WHICH TOP 5 RESTAURANT OFFERS HIGHEST NUMBER OF CATEGORIES?

select distinct restaurant_name, count(distinct menu_category) as number_of_category
from swiggy
group by restaurant_name
order by number_of_category desc
limit 5;

-- 14.) WHICH RESTAURANT PROVIDES THE HIGHEST PERCENTAGE OF NON-VEGEATARIAN FOOD?

select distinct restaurant_name,
count(case when veg_or_nonveg = 'non-veg' then 1 end) / count(*)*100 as non_veg_pct
from swiggy
group by restaurant_name
order by non_veg_pct desc
limit 1;
