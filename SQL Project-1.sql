--SQL Retail Sales Analysis - P1
Create Database Sql_project_r


-- Create Table
DROP TABLE IF EXISTS retail_sales;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(15),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);

-- Data Cleaning
Select*
From retail_sales

Select*
From retail_sales
Where Transactions_id IS Null

Select*
From retail_sales
Where 
	Transactions_id IS Null
	OR
	sale_time IS Null
	OR
	Sale_date is Null
	OR
	customer_id is Null
	Or
	Gender is Null
	Or
	age IS NULL
	Or
	Category is Null
	OR
	Quantity is NULL
	OR
	price_per_unit is Null
	OR
	Cogs is Null
	OR
	total_sale is NULL

---
Delete From retail_sales
Where 
	Transactions_id IS Null
	OR
	sale_time IS Null
	OR
	Sale_date is Null
	OR
	customer_id is Null
	Or
	age IS NULL
	Or
	Category is Null
	OR
	Quantity is NULL
	OR
	price_per_unit is Null
	OR
	Cogs is Null
	OR
	total_sale is NULL;

-- Data Exploration

-- How many sales we have?
Select Count (*) as total_sale FROM retail_sales

--How many unique customers we have
Select Count (Distinct Customer_id) as total_sale from retail_sales

-- How many unique Categories we have 
Select Distinct category  from retail_sales

-- Data Analysis & Business Key Problems and Answers

--Q1. Write a SQL Query to retreive all columns for sales made on '2022-11-05'

Select *
From retail_sales
Where sale_date = '2022-11-05';

/* Q2. Write a SQL Query to retreive all transactions where the category is 'Clothing' and the quantity sold is 
more than 4 in the month of Nov-2022*/

Select *
From retail_sales
Where Category = 'Clothing'
	AND
	TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
	AND
	quantity >=4

-- Q3.Write SQL Query to calculate the total sales (total_sales) for each category.

Select 
	category,
	SUM(total_sale) as net_sale
From retail_sales
Group By 1

-- Q4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category

Select 
	Round(AVG (age),2) AS avg_age
From retail_sales
Where category = 'Beauty'


--Q5. Write a SQL query to find all transactions where the total_sale is greater than 1000

Select *
From retail_sales
Where total_sale > 1000

--Q6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category

Select
	category,
	gender,
	Count(*) as total_trans
From retail_sales
Group by
	category,
	gender
Order by 1


-- Q7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.

Select 
	year,
	month,
	avg_sale
From
(
	Select 
		EXTRACT(YEAR FROM sale_date) AS year,
		EXTRACT(MONTH FROM sale_date) AS month,
		AVG(total_sale) AS avg_sale,
		RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
	FROM retail_sales
	GROUP BY 1,2
) as T1
Where rank = 1
--ORDER BY 1,2


--Q8. Write a SQL query to find the top 5 customer based on the highest total sales

Select 
	customer_id,
	Sum(total_sale) as total_sales
From retail_sales
Group BY 1
Order By 2 Desc
Limit 5

--Q9. Write a SQL query to find the number of unique customers who purchased items for each category

Select
	category,
	Count(Distinct customer_id) as cnt_unique_cs
From retail_sales
Group By category


--Q10. Write a SQL query to create each shift and number of orders (Example Morning < 12, Afternoon Between 12 and 17, Evening >17)

WITH hourly_sale
AS
(
Select *,
	Case
		WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
		WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END AS shift
From retail_sales
)
Select
	shift,
	count(*) as total_orders
From hourly_sale
Group by shift

--End of Project









