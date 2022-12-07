CREATE SCHEMA Superstoremarket_fact

#####Understanding the Data#######

#1.Describe the data in hand in your own words.
#The superstore database consist of 5 tables in it which altogther will help us 
#to gain information about the superstore likes which product are sold ,which product
#makes the highest sales,types of customer,profit made,margin on the product,mode
#of shipping used by supestore.
#1.The first table is cust_dimen which gives the information about the customer like name of customer,
#province,region in which customer stays,type of the customer buying the product for eg.consumer,corporate,
#Home office,small business etc and lasty the unique id of customer

#2.The second table is market_fact which gives general information of the superstore market like Quantity of product 
#ordered by each coustmer ,discount on the product, sales done from the sold product,profit made on sales, margin 
#on the product,shipping cost &lastly  IDs like Customer id,Order id ,product id and shipping id

#3.The third table is orders_dimen  which tell us  which  product was ordered w.r.t unique order id 
#& the priority of the product if it is low ,high,not specified or medium 

#4.The fourth table is prod_dimension which tells about the category to which product belong .
#Category mentioned in the prod_dimen table are Technology,Furniture,Office supply.
#The table also gives the sub category of product and it unique product id

#5.The fifth table is shipping_dimen which helps us to know on which date the product was shipped,
#mode of shipping like regular air,delivery truck  or express air and lastly the order id ,
#shipping id of product

#2.Identify and list the Primary Keys and Foreign Keys for this dataset provided to 
#you(In case you don’t find either primary or foreign key, then specially mention 
#this in your answer)

#1.cust_dimen-
#Primary Key- Cust_id
#Foreign Key- Cust_id

#2. market_fact
#Primary Key: NA
#Foreign Key: Ord_id, Prod_id, Ship_id, Cust_id
	
 # 3. orders_dimen
#Primary Key: Ord_id
 # Foreign Key: Ord_id
	
#4.prod_dimen
#Primary Key: Prod_id
#Foreign Key: Prod_id

#5. shipping_dimen
#Primary Key: Ship_id
#Foreign Key: Ship_id
              

######Basic & Advanced Analysis####

#1.Write a query to display the Customer_Name and Customer Segment using alias 
#name “Customer Name", "Customer Segment" from table Cust_dimen.
SELECT		Customer_Name AS "Customer Name",Customer_segment AS "Customer Segment"
FROM		cust_dimen;

#2. Write a query to find all the details of the customer from the table cust_dimen 
order by desc.
SELECT		*
FROM		cust_dimen
ORDER BY	customer_name DESC;

#3.Write a query to get the Order ID, Order date from table orders_dimen where 
#‘Order Priority’ is high.
SELECT		order_id,order_date,order_priority
FROM		orders_dimen
WHERE		order_priority= "High";

#4.Find the total and the average sales (display total_sales and avg_sales) 
SELECT		SUM(Sales) AS Total_sales,AVG(Sales) AS avg_sales
FROM		market_fact;

#5.Write a query to get the maximum and minimum sales from maket_fact table.
SELECT		MAX(Sales),MIN(Sales)
FROM		market_fact;

#6.Display the number of customers in each region in decreasing order of 
#no_of_customers. The result should contain columns Region, no_of_customers.
SELECT		COUNT(distinct customer_name) AS no_of_customers,Region
FROM		cust_dimen
GROUP BY	Region
ORDER BY	No_of_customers DESC;

#7.Find the region having maximum customers (display the region name and max(no_of_customers)
SELECT 		COUNT(cust_id), region
FROM 		cust_dimen
GROUP BY 	region
ORDER BY	COUNT(cust_id)DESC
LIMIT 		1;

SELECT region


#8.Find all the customers from Atlantic region who have ever purchased ‘TABLES’ 
#and the number of tables purchased (display the customer name, no_of_tables 
#purchased)
SELECT 	c.Customer_Name,p.product_sub_category,SUM(m.Order_Quantity) AS no_of_tables,c.Region
FROM	market_fact m
LEFT JOIN 	cust_dimen c ON m.Cust_id=c.Cust_id
LEFT JOIN	prod_dimen p ON m.Prod_id=p.Prod_id
WHERE 		p.Product_Sub_Category="TABLES" AND c.region="ATLANTIC"
GROUP BY	c.customer_name
ORDER BY	no_of_tables DESC;


#9.Find all the customers from Ontario province who own Small Business. (display 
#the customer name, no of small business owners)
SELECT		DISTINCT customer_name,customer_segment
FROM		cust_dimen
WHERE		region="Ontario"AND customer_segment="Small Business";

#10.Find the number and id of products sold in decreasing order of products sold 
#(display product id, no_of_products sold) 
SELECT		prod_id,SUM(order_quantity) AS no_of_products_sold
FROM		market_fact
GROUP BY	prod_id
ORDER BY	SUM(order_quantity) DESC;


#11.Display product Id and product sub category whose produt category belongs to 
#Furniture and Technlogy. The result should contain columns product id, product 
#sub category.
SELECT		prod_id,product_sub_category
FROM		prod_dimen
WHERE		Product_Category IN ("furniture","Technology");


#12.Display the product categories in descending order of profits (display the product 
#category wise profits i.e. product_category, profits)?
SELECT		p.product_category,SUM(m.profit)AS profits
FROM		market_fact m
INNER JOIN	prod_dimen p ON m.prod_id=p.prod_id
GROUP BY	p.Product_Category
ORDER BY	profits DESC;

#13.Display the product category, product sub-category and the profit within each 
#subcategory in three columns.
SELECT		p.product_category,p.product_sub_category,SUM(m.profit) AS profit
FROM		market_fact m
INNER JOIN	prod_dimen p ON m.prod_id=p.Prod_id
GROUP BY	Product_Category,Product_Sub_Category
ORDER BY	Profit DESC;

#14.Display the order date, order quantity and the sales for the order.
SELECT		O.order_date,m.order_quantity,m.sales
FROM		market_fact m
INNER JOIN	orders_dimen o ON m.Ord_id=o.Ord_id;

#15.Display the names of the customers whose name contains the 
 #i) Second letter as ‘R’
 #ii) Fourth letter as ‘D’
 SELECT		customer_name 
 FROM		cust_dimen
 WHERE		Customer_Name LIKE "_R%" AND Customer_name LIKE "___D%";
 
 #16.Write a SQL query to to make a list with Cust_Id, Sales, Customer Name and 
#their region where sales are between 1000 and 5000.
SELECT		m.cust_id,c.customer_name,c.region,m.sales
FROM		market_fact m
INNER JOIN	cust_dimen c ON m.cust_id=c.cust_id
WHERE		m.sales BETWEEN 1000 AND 5000;

#17.Write a SQL query to find the 3rd highest sales.
SELECT		sales 
FROM		market_fact
ORDER BY 	sales DESC
LIMIT 		1 OFFSET 2;


#18. Where is the least profitable product subcategory shipped the most? For the least 
#profitable product sub-category, display the region-wise no_of_shipments and the
#profit made in each region in decreasing order of profits (i.e. region, 
#no_of_shipments, profit_in_each_region)
 #→ Note: You can hardcode the name of the least profitable product subcategory
SELECT		p.product_sub_category,
			c.region,
            ROUND(SUM(m.profit),2) as Total_Profit,
            COUNT(m.ship_id) as No_of_shipments
FROM		market_fact m
LEFT JOIN	cust_dimen c ON	m.Cust_id = c.Cust_id
LEFT JOIN	prod_dimen p ON	m.Prod_id = p.Prod_id
WHERE		p.product_sub_category = 'TABLES'
GROUP BY	p.product_sub_category, c.region
ORDER BY	Total_Profit DESC