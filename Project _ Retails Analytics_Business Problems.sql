/* Q1-Write a query to identify the number of duplicates in "sales_transaction" table. 
Also, create a separate table containing the unique values and remove the the original table 
from the databases and replace the name of the new table with the original name. */

select Transaction_id , count(*) from Sales_transaction
group by Transaction_id
having count(*) >1;
create table Sales_transaction1 as
select distinct * from Sales_transaction;
drop table Sales_transaction;
ALTER TABLE Sales_transaction1 
RENAME TO Sales_transaction;
select * from Sales_transaction;

/* Q2-Write a query to identify the discrepancies in the price of the same product 
 in "sales_transaction" and "product_inventory" tables. Also, 
 update those discrepancies to match the price in both the tables. */
select * from Sales_transaction;
select* from product_inventory;
select st.Transaction_id, st.price as TransactionPrice, pi.price as InventoryPrice
from sales_transaction st 
join product_inventory pi on st.productID=pi.ProductName
where st.price<>pi.price;

update sales_transaction as st set
price=(select pi.price from product_inventory pi where pi.Product_Id=st.ProductID)
where st.productID in 
(select pi.Product_Id from product_inventory pi where st.Price<>pi.Price);

-- Q3 Write a SQL query to identify the null values in the dataset and replace those by “Unknown”.
select count(*) 
from customer_profiles 
where location is Null;

update customer_profiles 
set location='Unknown'
where location is null;

select * from customer_profiles ;   
    
--  Q4: Write a SQL query to summarize the total sales and quantities sold per product by the company.
select ProductID, sum(quantitypurchased) as TotalUnitsSold, sum(quantitypurchased*price) as TotalSales
from Sales_transaction
group by ProductID
order by 3 desc; 

-- Q5: Write a SQL query to count the number of transactions per customer to understand purchase frequency.

select customerID, count(Transaction_Id) as Number_Of_Transactions
from Sales_transaction
group by 1
order by 2 desc;

/* Q6: Write a SQL query to evaluate the performance of the product categories based on the total sales 
which help us understand the product categories which needs to be promoted in the marketing campaigns. */
Select Pi.Category, sum(st.quantitypurchased) as TotalUnitsSold, sum(st.Price*st.quantitypurchased) as TotalSales
from Sales_transaction st
join product_inventory PI on st.productID=Pi.ï»¿ProductID
group by PI.Category
order by TotalSales desc;

/* Q7: Write a SQL query to find the top 10 products with the total sales revenue 
	from the sales transactions. This will help the company to identify the High sales products 
	which needs to be focused to increase the revenue of the company. */

select ProductID, 
sum(price * QuantityPurchased) as TotalRevenue 
from Sales_transaction
group by ProductID
order by TotalRevenue desc
limit 10;

/* Q8: Write a SQL query to find the ten products with the least amount of units 
	sold from the sales transactions, provided that at least one unit was sold for those products. */

select ProductID, sum(QuantityPurchased) as TotalUnitsSold
from Sales_transaction
group by 1
having sum(QuantityPurchased)>1
order by 2 
limit 10;
select * from sales_transaction;
select * from customer_profiles;
show tables from retails_sales_analytics;

/* Q9: Write a SQL query to understand the month on month growth rate of sales of the company 
	   which will help understand the growth trend of the company. */
 WITH monthly_sales AS
(
   SELECT MONTH(TransactionDate) AS month,
	SUM(QuantityPurchased*Price) AS total_sales
	FROM sales_transaction
   GROUP BY
       1
)

SELECT
   month,
total_sales,
   LAG(total_sales) OVER (ORDER BY month) AS previous_month_sales,
   ((total_sales - LAG(total_sales) OVER (ORDER BY month)) / LAG(total_sales) OVER (ORDER BY month)) * 100 AS mom_growth_percentage
FROM
   monthly_sales
ORDER BY
   month;
   
/* Q10: Write a SQL query that describes the number of transaction along with the total amount spent by each customer 
which are on the higher side and will help us understand the customers who are the high frequency purchase customers in the company. */
select CustomerID, 
count(Transaction_Id) as Number_Of_Transactions, sum(Price*quantityPurchased) as Total_Spent
from sales_transaction
group by CustomerID
having count(Transaction_Id)>10 and sum(Price*quantityPurchased)>1000
order by Total_Spent desc;

 /* Q11: Write a SQL query that describes the number of transaction along with the total amount spent by each customer,
which will help us understand the customers who are occasional customers or have low purchase frequency in the company. */

select CustomerID, Count(Transaction_ID) as Number_Of_Transactions, 
sum(Price*Quantitypurchased) as Total_Spent
from Sales_transaction
group by CustomerID
having Count(Transaction_ID)<=2
order by 2, 3 desc;

