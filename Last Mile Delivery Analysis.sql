CREATE DATABASE last_mile_delivery;

SHOW DATABASES;

USE last_mile_delivery;

CREATE TABLE customers (
    customer_id VARCHAR(20) PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    delivery_zone_id VARCHAR(10),
    preferred_time_slot VARCHAR(30),
    customer_type VARCHAR(20),
    account_since DATE
);

CREATE TABLE drivers (
    driver_id VARCHAR(10) PRIMARY KEY,
    driver_name VARCHAR(100),
    hire_date DATE,
    rating DECIMAL(3,2),
    employment_type VARCHAR(20),
    is_active VARCHAR(3)
);

CREATE TABLE vehicles (
    vehicle_id VARCHAR(10) PRIMARY KEY,
    vehicle_type VARCHAR(20),
    fuel_type VARCHAR(20),
    max_payload_kg DECIMAL(7,2),
    depot VARCHAR(10),
    last_service_date DATE,
    is_active VARCHAR(3)
);

CREATE TABLE orders (
    order_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20),
    order_date DATE,
    delivery_zone_id VARCHAR(10),
    package_weight_kg DECIMAL(5,2),
    service_type VARCHAR(20),
    priority VARCHAR(10),
    total_value DECIMAL(10,2),

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

CREATE TABLE deliveries (
    delivery_id VARCHAR(20) PRIMARY KEY,
    order_id VARCHAR(20),
    driver_id VARCHAR(10),
    vehicle_id VARCHAR(10),
    assigned_date DATE,
    actual_delivery_date DATE,
    status VARCHAR(20),
    delivery_attempt TINYINT,
    distance_km DECIMAL(6,2),
    delivery_duration_min INT,

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    FOREIGN KEY (driver_id)
        REFERENCES drivers(driver_id),

    FOREIGN KEY (vehicle_id)
        REFERENCES vehicles(vehicle_id)
);

select * from  customers;
select * from  deliveries;
select * from  drivers;
select * from  orders;
select * from  vehicles;



### Check rows and columns of each table ###

SELECT 
    'customers' AS table_name,
    (SELECT COUNT(*) FROM customers) AS total_rows,
    (SELECT COUNT(*)
     FROM information_schema.columns
     WHERE table_schema = DATABASE()
       AND table_name = 'customers') AS total_columns;


SELECT 
    'drivers' AS table_name,
    (SELECT COUNT(*) FROM drivers) AS total_rows,
    (SELECT COUNT(*)
     FROM information_schema.columns
     WHERE table_schema = DATABASE()
       AND table_name = 'drivers') AS total_columns;
       
SELECT 
    'vehicles' AS table_name,
    (SELECT COUNT(*) FROM vehicles) AS total_rows,
    (SELECT COUNT(*)
     FROM information_schema.columns
     WHERE table_schema = DATABASE()
       AND table_name = 'vehicles') AS total_columns;
       
SELECT 
    'orders' AS table_name,
    (SELECT COUNT(*) FROM orders) AS total_rows,
    (SELECT COUNT(*)
     FROM information_schema.columns
     WHERE table_schema = DATABASE()
       AND table_name = 'orders') AS total_columns;

SELECT 
    'deliveries' AS table_name,
    (SELECT COUNT(*) FROM deliveries) AS total_rows,
    (SELECT COUNT(*)
     FROM information_schema.columns
     WHERE table_schema = DATABASE()
       AND table_name = 'deliveries') AS total_columns;
       
       
       
#### Basic Analysis of overall table  ####

# 1) What is the total number of customers?

select count(distinct customer_id) as total_num_of_customers from customers;

# 2) What is the total number of orders?

select  count(*) as total_Num_of_orders from orders;

# 3) What is the total number of deliveries?

select count(*) as total_Num_of_deliveries from deliveries;

# 4) What are the different service types available?

select Distinct service_type as diff_service_types from orders;

# 5) How many drivers are currently active?

SELECT COUNT(*) AS active_drivers FROM drivers WHERE is_active = 'Yes';

# 6) What are the different vehicle types?

select count('vehicle_type')  from vehicles;

# 7) What is the total order value?

select  sum( total_value) as total_order_value from orders;

# 8) What is the average package weight?

select avg(package_weight_kg) as avg_package_weight from  orders;




#### Objective Wise Analysis ####

## A) Delivery Demand

# 1) Which delivery zones generate the highest order volume and order value?
select delivery_zone_id,
 count(*) as Highest_zone_order_volume ,
 sum(total_value) as Highest_zone_order_value
 from orders
 group by delivery_zone_id order by Highest_zone_order_value desc limit 1;


# 2) Which service types are most frequently used?
select 
   service_type, count(*) as frequency  
from orders 
     group by service_type order by frequency desc limit 1;


# 3) How are orders distributed across different priority levels?
SELECT priority, COUNT(*) AS order_count
FROM orders
GROUP BY priority;

# 4) How does order demand change over time?
SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY order_year, order_month;


# 5) Which delivery zones generate the highest total order value?
select delivery_zone_id ,sum(total_value) as Hghest_Tot_ord_Value from orders group by delivery_zone_id order by sum(total_value) desc limit 5;


# 6) Which service types have the highest average order value?
select service_type, avg(total_value) as avg_order_value from orders group by service_type order by avg(total_value) desc;

# 7) Which delivery zones have the highest average order value per order?
select order_id, delivery_zone_id,avg(total_value) as Highest_Avg_ord_value from orders group by delivery_zone_id,order_id order by avg(total_value) desc;

# 8)Which service type and priority combination generates the highest order demand?
select service_type , priority, count(order_id) from orders group by service_type,priority order by count(order_id) desc;


select distinct service_type from orders;
select * from orders; 




## B) Customer Order Behaviour

# 1) Which customers place the highest number of orders?
SELECT c.customer_id,
       c.customer_name,
       COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_orders DESC limit 1;


-- select customer_id , count(*) from orders group by customer_id order by count(*) desc ;

# 2) Which customers generate the highest total order value?
select c.customer_id,c.customer_name, sum(o.total_value) from customers as c join orders as o on c.customer_id = o.customer_id group by c.customer_name,  c.customer_id order by sum(o.total_value) desc limit 5;

# 3) How does ordering behaviour differ between Business and Individual customers?
SELECT
    YEAR(o.order_date) AS order_year,
    MONTH(o.order_date) AS order_month,
    c.customer_type, count(o.order_id) as count_of_order_id,
    sum(o.total_value) as sum_of_total_value 
from customers c inner join orders o 
	on c.customer_id = o.customer_id 
    group by order_year, order_month,c.customer_type;


# 4) Which delivery zones have the highest customer/order activity?
select delivery_zone_id , count(customer_id) as total_customer from customers group by delivery_zone_id order by total_customer desc limit 1;


# 5) What percentage of customers are repeat customers?
SELECT
    (COUNT(*) / (SELECT COUNT(*) FROM customers)) * 100.0
    AS repeat_customer_percentage
FROM (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING COUNT(order_id) > 1
) AS repeat_customers;


# 6) How does average order value differ by customer type?

SELECT 
    c.customer_type,
    AVG(o.total_value) AS avg_order_value
FROM orders o
JOIN customers c 
    ON o.customer_id = c.customer_id
GROUP BY c.customer_type;


# 7) Which customers have placed orders across multiple delivery zones?
select customer_id , count(delivery_zone_id) as count_del_zone_id from orders group by customer_id order by count_del_zone_id;


## C) Delivery Performance

# 1) What is the distribution of deliveries across different delivery statuses?
select status,count(delivery_id) as total_deliveries 
from deliveries 
group by status order by status;

# 2) Which delivery zones have the highest number of multiple-attempt deliveries?
SELECT
    o.delivery_zone_id,
    COUNT(d.delivery_id) AS total_deliveries
FROM deliveries d
JOIN orders o
    ON d.order_id = o.order_id
GROUP BY o.delivery_zone_id
ORDER BY total_deliveries DESC limit 1;

# 3) Which zones have the highest average delivery duration?
select o.delivery_zone_id, 
     avg(d.delivery_duration_min) as avg_duration 
from orders o join deliveries d
     on o.order_id = d.order_id 
group by o.delivery_zone_id 
order by avg_duration desc limit 1;

# 4) How does delivery outcome vary by order priority?
select o.priority, count(d.delivery_id) as count_of_delivery_id from orders o left join deliveries d on d.order_id = o.order_id group by o.priority order by count_of_delivery_id desc;

# 5) How does delivery distance relate to delivery duration?
-- select distance_km,avg(delivery_duration_min) as avg_del_duration from deliveries group by distance_km order by avg_del_duration asc;

SELECT
    CASE
        WHEN distance_km < 5 THEN '0-5 km'
        WHEN distance_km < 10 THEN '5-10 km'
        WHEN distance_km < 20 THEN '10-20 km'
        WHEN distance_km < 50 THEN '20-50 km'
        ELSE '50+ km'
    END AS distance_group,
    COUNT(delivery_id) AS total_deliveries,
    AVG(delivery_duration_min) AS average_duration
FROM deliveries
GROUP BY distance_group
ORDER BY average_duration;

# 6) Which delivery zones have the highest average delivery distance?
select o.delivery_zone_id ,avg(d.distance_km) as avg_ditance_of_delivery from deliveries d join orders o on d.order_id = o.order_id group by o.delivery_zone_id order by avg_ditance_of_delivery desc limit 1; 

## D) Driver & Vehicle Performance

# 1) How many deliveries are handled by each driver?
SELECT
    dr.driver_id,
    dr.driver_name,
    COUNT(d.delivery_id) AS total_deliveries
FROM drivers dr
LEFT JOIN deliveries d
    ON dr.driver_id = d.driver_id
GROUP BY dr.driver_id, dr.driver_name
ORDER BY total_deliveries DESC;


# 2) What is the delivery outcome distribution for each driver?
SELECT
    dr.driver_name,
    d.status,
    COUNT(d.delivery_id) AS total_deliveries
FROM drivers dr
JOIN deliveries d
    ON dr.driver_id = d.driver_id
GROUP BY
    dr.driver_name,
    d.status
ORDER BY dr.driver_name, total_deliveries DESC;

# 3) Which drivers have higher average delivery duration?
select dr.driver_name,avg(d.delivery_duration_min) as avg_del_duration from deliveries d join drivers dr on dr.driver_id = d.driver_id group by dr.driver_name order by avg_del_duration desc limit 1;

# 4) How are deliveries distributed across different vehicle types?
SELECT
    v.vehicle_type,
    COUNT(d.delivery_id) AS total_deliveries
FROM vehicles v
JOIN deliveries d
    ON v.vehicle_id = d.vehicle_id
GROUP BY v.vehicle_type
ORDER BY total_deliveries DESC;

# 5) How does average delivery duration vary by vehicle type?
SELECT
    v.vehicle_type,
    AVG(d.delivery_duration_min) AS average_delivery_duration
FROM vehicles v
JOIN deliveries d
    ON v.vehicle_id = d.vehicle_id
GROUP BY v.vehicle_type
ORDER BY average_delivery_duration DESC;

# 6) How does driver workload vary between active and inactive drivers?
SELECT
    dr.is_active,
    COUNT(DISTINCT dr.driver_id) AS total_drivers,
    COUNT(d.delivery_id) AS total_deliveries,
    ROUND(
        COUNT(d.delivery_id) * 1.0 /
        COUNT(DISTINCT dr.driver_id),2
    ) AS average_deliveries_per_driver
FROM drivers dr
LEFT JOIN deliveries d
    ON dr.driver_id = d.driver_id
GROUP BY dr.is_active
ORDER BY dr.is_active;

# 7) How do vehicle type and fuel type relate to delivery distance and duration?
SELECT
    v.vehicle_type,
    v.fuel_type,
    COUNT(d.delivery_id) AS total_deliveries,
    AVG(d.distance_km) AS average_distance_km,
    AVG(d.delivery_duration_min) AS average_duration_min
FROM vehicles v
JOIN deliveries d
    ON v.vehicle_id = d.vehicle_id
GROUP BY
    v.vehicle_type,
    v.fuel_type
ORDER BY average_distance_km DESC;

## E) Delivery Problems
# 1) How many deliveries require multiple attempts?
SELECT
    COUNT(DISTINCT order_id) AS multiple_attempt_orders
FROM deliveries
WHERE delivery_attempt > 1;


# 2) Which delivery zones have the highest number of multiple-attempt deliveries?

SELECT
    o.delivery_zone_id,
    COUNT(DISTINCT d.order_id) AS multiple_attempt_orders
FROM deliveries d
JOIN orders o
    ON d.order_id = o.order_id
WHERE d.delivery_attempt > 1
GROUP BY o.delivery_zone_id
ORDER BY multiple_attempt_orders DESC;

# 3) What is the relationship between delivery attempts and delivery outcome?
SELECT
    delivery_attempt,
    status,
    COUNT(delivery_id) AS total_deliveries
FROM deliveries
GROUP BY delivery_attempt, status
ORDER BY delivery_attempt, total_deliveries DESC; 

# 4) Do high-priority orders have different delivery outcomes compared with other priorities?
SELECT o.priority, d.status,
    COUNT(d.delivery_id) AS total_deliveries,
    ROUND(
        COUNT(d.delivery_id) * 100.0 /
        SUM(COUNT(d.delivery_id))
        OVER (PARTITION BY o.priority),2
    ) AS outcome_percentage
FROM orders o
JOIN deliveries d
    ON o.order_id = d.order_id
GROUP BY o.priority, d.status
ORDER BY o.priority, outcome_percentage DESC;

# 5) Which drivers handle the highest number of deliveries requiring multiple attempts?
SELECT
    dr.driver_id,
    dr.driver_name,
    COUNT(DISTINCT d.order_id) AS multiple_attempt_orders
FROM drivers dr
JOIN deliveries d
    ON dr.driver_id = d.driver_id 
WHERE d.delivery_attempt > 1
GROUP BY dr.driver_id, dr.driver_name
ORDER BY multiple_attempt_orders DESC;

