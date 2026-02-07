SELECT * FROM walmart;


SELECT COUNT(*) FROM walmart;

SELECT
    DISTINCT payment_method,
    COUNT(*)

FROM walmart
GROUP BY payment_method


SELECT COUNT(DISTINCT Branch):
FROM walmart;

SELECT MAX(quantity) FROM walmart;

#Q1: Find different payment method and number of transactions, number of qty sold

SELECT
    payment_method,
    count(*) as no_payments,
    sum(quantity) as no_qty_sold
FROM walmart
GROUP BY payment_method


#Q2: Identify the highest-rated category in each branch, displaying the branch,catgory
SELECT
    branch,
    category,
    avg_rating
FROM (
    SELECT
        branch,
        category,
        AVG(rating) AS avg_rating,
        RANK() OVER (
            PARTITION BY branch
            ORDER BY AVG(rating) DESC
        ) AS rnk
    FROM walmart
    GROUP BY branch, category
) ranked
WHERE rnk = 1;


#Q3: identify the busiest day for each branch based on the number of transactions

SELECT
    branch,
    DAYNAME(STR_TO_DATE(date, '%d/%m/%y')) AS day_name,
    COUNT(*) AS no_transactions
FROM walmart
GROUP BY branch, day_name;


#Q4: Calculate the total quantity of items sold per payment method. List payment method and total quantity.
SELECT 
    payment_method,
    SUM(quantity) as no_qty_sold
FROM walmart
GROUP BY payment_method


#Q5:
#Determine the average, minimum, and maximum rating of products for each city. 
#List the city, average_rating, min_rating and max_rating.

SELECT
    city,
    category,
    MIN(rating) as min_rating,
    MAX(rating) as max_rating,
    AVG(rating) as avg_rating
FROM walmart
GROUP BY 1,2


#Q6: Calculate the total profit for each category by considering total_profit as 
#(unit_price* quantity* profit_margin). List category and total profit, ordered from highest to lowest profit.

SELECT 
    category,
    SUM(total) as total_revenue,
    SUM(total * profit_margin) as profit
FROM walmart
GROUP BY 1


#Q7: Determine the most common payment method for each Branch. Display Branch and the preferred_payment_method.
-- Q7: Most common payment method for each branch


WITH cte AS (
    SELECT
        branch,
        payment_method,
        total_trans,
        RANK() OVER (
            PARTITION BY branch
            ORDER BY total_trans DESC
        ) AS payment_rank
    FROM (
        SELECT
            branch,
            payment_method,
            COUNT(*) AS total_trans
        FROM walmart
        GROUP BY branch, payment_method
    ) t
)
SELECT *
FROM cte
WHERE payment_rank = 1;



#Q8: Categorize sales into group MORNING,  AFTERNOON, EVENING. Find out which of the shift and number of invoices.
SELECT * from walmart


SELECT
    CASE
        WHEN HOUR(time) < 12 THEN 'Morning'
        WHEN HOUR(time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS day_time,
    COUNT(*) AS total_transactions
FROM walmart
GROUP BY day_time;

