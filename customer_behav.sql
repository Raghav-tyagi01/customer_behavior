SELECT * FROM cus_segment;

-- 1 How many customers are repeat buyers?
SELECT COUNT(*) AS repeat_customers FROM (SELECT customer_id FROM cus_segment GROUP BY customer_id HAVING COUNT(*) > 1) AS t;


-- 2 show name and total order by each person
select customer_name,count(customer_id) from cus_segment group by Customer_Name having count(Customer_ID)>1 order by count(Customer_ID) desc;


-- 3 Who are the top 10 customers generating highest revenue?
select customer_name,sum(Amount_of_Product) from cus_segment group by Customer_Name having sum(Amount_of_Product)>1 
order by count(Amount_of_Product) desc limit 10;


-- 4 Which cities generate the highest number of orders?
select city,count(Order_Date) from cus_segment group by city order by count(Order_Date) desc;


-- 5 Which states contribute the least revenue?
select state,sum(Amount_of_Product) from cus_segment group by state order by sum(Amount_of_Product) asc;


-- 6 Which product_categories and product_name have poor review?
SELECT product_category,product_name, COUNT(*) AS total_reviews,ROUND(AVG(rating), 2) AS avg_rating FROM cus_segment
GROUP BY product_category, product_name
HAVING AVG(rating) < 3
ORDER BY avg_rating ASC;


-- 7 Find the top 3 customers in each city based on total number of orders.
SELECT * FROM (SELECT customer_id, customer_name, city, COUNT(*) AS total_orders,
RANK() OVER (PARTITION BY city ORDER BY COUNT(*) DESC) AS rnk
FROM cus_segment
GROUP BY customer_id, customer_name, city) t
WHERE rnk <= 3;


-- 8 Find the most sold product in each category.
SELECT * FROM (SELECT product_category, product_name, COUNT(*) AS total_sold,
RANK() OVER(PARTITION BY product_category  ORDER BY COUNT(*) DESC) AS rnk
FROM cus_segment
GROUP BY product_category, product_name) t
WHERE rnk = 1;

