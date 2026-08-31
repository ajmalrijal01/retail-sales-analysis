-- table creation
CREATE TABLE retail_sales 
( 
	order_id VARCHAR(20), 
	order_date DATE, 
	region VARCHAR(20), 
	customer_segment VARCHAR(30), 
	category VARCHAR(30), 
	sub_category VARCHAR(30), 
	ship_mode VARCHAR(20), 
	quantity INTEGER, 
	unit_price NUMERIC(10,2), 
	discount NUMERIC(4,2), 
	sales NUMERIC(10,2), 
	profit NUMERIC(10,2) 
);
-- count confirmation
select count(*) from retail_sales
-- full data viewing
select * from retail_sales
-- checking for duplicates
select order_id, count(*) from retail_sales group by order_id having count(*)>1
-- remove duplicates
begin
delete from retail_sales where ctid not in (select min(ctid) from retail_sales group by order_id)
rollback
commit
-- Fix inconsistent casing in region
select distinct region from retail_sales
-- You'll notice lowercase 'north', 'east' etc mixed in with 'North', 'East'
begin
update retail_sales set region =
case 
	when lower(region) = 'north' then 'North' 
	when lower(region) = 'east' then 'East'
	when lower(region) = 'west' then 'West'
	when lower(region) = 'south' then 'South'
end
rollback
commit
-- re-run distinct query to confirm the update
-- Check missing values
select count(*) from retail_sales where ship_mode is null
-- Fill missing ship_mode with 'Unknown' (a reasonable, documented choice)
begin
update retail_sales set ship_mode = 'Unknown' where ship_mode is null
rollback
commit
-- query to confirm the update, also confirm the count
select ship_mode from retail_sales where ship_mode = 'Unknown'
-- Which region generates the most total sales?
select region, sum(sales) as Total_Sales from retail_sales group by region order by Total_Sales desc
-- OR
select region, sum(sales) as Total_Sales from retail_sales group by region 
having sum(sales) = (select max(total_sales) from (select sum(sales) as total_sales from retail_sales group by region))
-- Which product category is most profitable (not just highest sales)?
select category, sum(profit) as total_profit, sum(profit)*100/sum(sales) as profit_margin from retail_sales group by category order by total_profit desc 
-- OR
select category, sum(profit) as total_profit, sum(profit)*100/sum(sales) as profit_margin from retail_sales group by category 
having sum(profit) = (select max(total_profit) from (select sum(profit) as total_profit from retail_sales group by category))
-- Which customer segment gives the most discounts, and does it hurt profit?
select customer_segment, avg(discount) avg_discount, avg(profit) as avg_profit from retail_sales group by customer_segment order by avg_discount desc
-- OR
select customer_segment, avg(discount) as avg_discount, avg(profit) as avg_profit from retail_sales group by customer_segment 
having avg(discount) = (select max(avg_discount) from (select avg(discount) as avg_discount from retail_sales group by customer_segment))
-- Monthly sales trend — is the business growing?
select to_char(order_date, 'YYYY-MM') as month, sum(sales) as total_sales from retail_sales group by month order by month asc
-- (Window function practice) Rank sub-categories by profit within each category
select category, sub_category, sum(profit) as total_profit, 
rank() over (partition by category order by sum(profit) desc) as rank_in_category from retail_sales
group by category, sub_category