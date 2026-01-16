-- Data exploration 
show tables from retails_sales_analytics;

select * from customer_profiles;
show columns from customer_profiles;
-- Changing inconsistent formated column name to Organised manner
alter table customer_profiles 
change column ï»¿CustomerID  Customer_Id int ;

select * from product_inventory;
show columns from product_inventory;
-- Changing inconsistent formated column name to Organised manner
alter table product_inventory 
change column ï»¿ProductID  Product_Id int ;

select * from sales_transaction;
show columns from sales_transaction;
-- Changing inconsistent formated column name to Organised manner
alter table sales_transaction 
change column Product_Id  Transaction_id int;
select * from sales_transaction;
-- Checking for Null values:
SELECT COUNT(*) FROM customer_profiles;
SELECT COUNT(DISTINCT customer_id) FROM customer_profiles ;
SELECT DISTINCT Gender FROM customer_profiles;
SELECT DISTINCT Location FROM customer_profiles;
select * from customer_profiles;

SELECT COUNT(DISTINCT Product_Id) FROM product_inventory ;
SELECT DISTINCT Category FROM product_inventory;
SELECT DISTINCT ProductName FROM product_inventory;
select * from product_inventory;

select * from sales_transaction;
SELECT COUNT(*) FROM sales_transaction;
SELECT COUNT(DISTINCT TransactionDate) FROM sales_transaction ;

show tables from retails_sales_analytics;
