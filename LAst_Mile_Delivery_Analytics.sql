# Project Title:
-- Last Mile Delivery Operations Analytics

#SPRINT - 1

-- Understanding ER Diagram and Business Process
/*
Business Process:

Customers ---> Places Order --> Order Is Assigned For Delivery ----> Driver + Vehicle (Deliver The Order)

ER Diagram:

Database contains info about :
-- Customers
-- Orders
-- Deliveries
-- Drivers
-- Vehicles

Primary Keys: 
Customers  --> customer_id
Orders --> order_id
Deliveries --> delivery_id
Drivers --> driver_id
Vehicles --> vehicle_id

Foreign Keys:
Orders --> customer_id
deliveries --> order_id , driver_id, vehicle_id


Questions :

1. Management wants to find customers who have placed multiple orders. What information would you need to identify them?

-- Tables required: customers and orders
-- Columns needed:
	customers.customer_id
	customers.customer_name
	orders.customer_id
	orders.order_id
-- Relationship: 
customers.customer_id is related to orders.customer_id.
One customer can place multiple orders.
-- Logical flow:
	Connect customers with their orders using customer_id. And Grop the orders by customers
	Count the number of order_ids for each customer.
	Identify customers whose order count is greater than 1.
	Examine the customer name and number of orders to determine which customers are repeat customers.
    
2. The Operations team wants to identify orders that required more than one delivery attempt. Where would you find the information needed to investigate this?

-- Table required: deliveries
-- Columns needed:
	delivery_id
	order_id
	delivery_attempt
	status
-- Relationship: The deliveries table is related to the orders table through order_id.
-- Logical flow:
	Examine the delivery_attempt column in the deliveries table. ANd identify records where no of attempts Greater Than 1.
	Use order_id to identify the corresponding orders.
	Compare the number of attempts and delivery status to understand delivery issues.
    
3. The Customer team wants to compare Business and Individual customers based on their ordering activity. Which tables and columns would you need?

-- Tables required: customers and orders
-- Columns needed:
	customers.customer_id
	customers.customer_name
	customers.customer_type
	orders.order_id
	orders.customer_id
	orders.order_date
	orders.total_value
-- Relationship: customers.customer_id is related to orders.customer_id. One customer can have multiple orders.
-- Logical flow:
	Connect customers with their orders using customer_id. Use customer_type to seperate Business and Individual Customers
	Compare their ordering activity using metrics such as: (No of Orders, Total Order Value, Avg Order Value, Ordering Frequency)
	Examine the differences between the two customer groups to understand their ordering behaviour.

4. The Operations team wants to compare different service types based on how far deliveries travel and how long they take. Which tables would you need to connect?

-- Tables required: orders and deliveries
-- Columns needed:
	orders.order_id
	orders.service_type
	deliveries.order_id
	deliveries.distance_km
	deliveries.delivery_duration_min
-- Relationship: orders.order_id is related to deliveries.order_id. An order is associated with its delivery information.
-- Logical flow:
	Connect orders with deliveries using order_id. And 	Group the deliveries based on service_type.
	Compare the delivery distance and delivery duration for each service type.
	Examine which service types involve longer distances or delivery times.
    
5. The team wants to identify which drivers have handled deliveries and examine their recorded ratings. What information would you need?

-- Tables required: drivers and deliveries
-- Columns needed:
	drivers.driver_id
	drivers.driver_name
	drivers.rating
	deliveries.delivery_id
	deliveries.driver_id
	deliveries.status
-- Relationship: drivers.driver_id is related to deliveries.driver_id. One driver can handle multiple deliveries.
-- Logical flow:
	Connect drivers with deliveries using driver_id. And identify drivers who have delivery records.
	Examine their recorded rating. and comapre the drivers based on their ratings and delivery activity
    
6. Operations wants to understand whether different types of vehicles are being used for different deliveries. Which tables and columns would you need?

-- Tables required: vehicles and deliveries
-- Columns needed:
	vehicles.vehicle_id
	vehicles.vehicle_type
	vehicles.max_payload_kg
	deliveries.delivery_id
	deliveries.vehicle_id
	deliveries.order_id
	deliveries.distance_km
-- Relationship: vehicles.vehicle_id is related to deliveries.vehicle_id. One vehicle can be used for multiple deliveries.
-- Logical flow:
	Connect vehicles with deliveries using vehicle_id. And Identify the vehicle type used for each delivery
	Compare different vehicle types based on their delivery activity.
    
7. Management wants to compare delivery performance across different delivery zones. What information would you need from the database?

-- Tables required: orders and deliveries
-- Columns needed:
	orders.order_id
	orders.delivery_zone_id
	deliveries.delivery_id
	deliveries.order_id
	deliveries.status
	deliveries.delivery_attempt
	deliveries.distance_km
	deliveries.delivery_duration_min
	deliveries.assigned_date
	deliveries.actual_delivery_date
-- Relationship: orders.order_id is related to deliveries.order_id. The delivery zone is associated with the order through delivery_zone_id.
-- Logical flow:
	Connect orders with deliveries using order_id. Group the delivery records by delivery_zone_id.
	Compare zones using performance measures such as:( Number of deliveries,Delivery status, Avg delivery duration,Avg distance travelled.etc)
	Identify which zones have better or poorer delivery performance and investigate possible operational differences.
    
8. The Operations team wants to investigate whether heavier packages are associated with longer delivery durations. Which information would you need, and where would you find it?

-- Tables required: orders and deliveries
-- Columns needed:
	orders.order_id
	orders.package_weight_kg
	deliveries.order_id
	deliveries.delivery_duration_min
	Relationship: orders.order_id is related to deliveries.order_id.
-- Logical flow:
	Connect orders with deliveries using order_id. Examine the package_weight_kg for each order.
	Compare package weight with delivery_duration_min.(Group or categorize packages by weight if required.)
	Determine whether heavier packages tend to have longer delivery durations.
    
9. Management wants to understand whether delivery outcomes differ across service types. What tables and information would you bring together?

-- Tables required: orders and deliveries
-- Columns needed:
	orders.order_id
	orders.service_type
	deliveries.order_id
	deliveries.status
	deliveries.delivery_attempt
	deliveries.delivery_duration_min
	deliveries.distance_km
-- Relationship: orders.order_id is related to deliveries.order_id.
-- Logical flow:
	Connect orders with deliveries using order_id. and Separate deliveries based on service_type.
    Compare delivery outcomes using status.
	Examine additional performance measures such as delivery attempts, duration, and distance.
	Determine whether certain service types have better or worse delivery outcomes

10. The Operations team wants to understand which customers have placed orders and how their orders are being handled. What information would you need to connect a customer with their orders and deliveries?

-- Tables required: customers, orders, and deliveries
-- Columns needed:
	customers.customer_id,  customers.customer_name, customers.customer_type
	orders.order_id, orders.customer_id, orders.order_date, orders.service_type, orders.priority, orders.total_value
	deliveries.delivery_id, deliveries.order_id, deliveries.status, deliveries.delivery_attempt, deliveries.delivery_duration_min.
-- Relationships:
	customers.customer_id → orders.customer_id
	orders.order_id → deliveries.order_id
	The relationship can be visualized as: Customer → Order → Delivery
-- Logical flow:
	Connect customers with orders using customer_id. Connect orders with deliveries using order_id.
	Identify which orders belong to each customer.
	Examine how those orders were handled using delivery status, attempts, and duration.
*/

# SPRINT - 2
-- Database Setup

CREATE DATABASE QuickRoute_Analytics;

USE QuickRoute_Analytics;

-- 1. Customers

CREATE TABLE customers (
    customer_id VARCHAR(20) PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    delivery_zone_id VARCHAR(20) NOT NULL,
    preferred_time_slot VARCHAR(30),
    customer_type VARCHAR(20) NOT NULL,
    account_since DATE NOT NULL
);

-- 2. Drivers

CREATE TABLE drivers (
    driver_id VARCHAR(20) PRIMARY KEY,
    driver_name VARCHAR(100) NOT NULL,
    hire_date DATE NOT NULL,
    rating DECIMAL(3,2),
    employment_type VARCHAR(20) NOT NULL,
    is_active VARCHAR(3) NOT NULL DEFAULT 'Yes'
);


-- 3. Vehicles

CREATE TABLE vehicles (
    vehicle_id VARCHAR(20) PRIMARY KEY,
    vehicle_type VARCHAR(50) NOT NULL,
    fuel_type VARCHAR(30) NOT NULL,
    max_payload_kg DECIMAL(10,2),
    depot VARCHAR(20) NOT NULL,
    last_service_date DATE,
    is_active VARCHAR(3) NOT NULL DEFAULT 'Yes'
);


-- 4. Orders

CREATE TABLE orders (
    order_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL,
    order_date DATE NOT NULL,
    delivery_zone_id VARCHAR(20) NOT NULL,
    package_weight_kg DECIMAL(10,2),
    service_type VARCHAR(30) NOT NULL,
    priority VARCHAR(20) NOT NULL,
    total_value DECIMAL(12,2),

    CONSTRAINT fk_orders_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);


-- 5. Deliveries

CREATE TABLE deliveries (
    delivery_id VARCHAR(20) PRIMARY KEY,
    order_id VARCHAR(20) NOT NULL,
    driver_id VARCHAR(20) NOT NULL,
    vehicle_id VARCHAR(20) NOT NULL,
    assigned_date DATE NOT NULL,
    actual_delivery_date DATE DEFAULT NULL,
    status VARCHAR(20) NOT NULL,
    delivery_attempt INT NOT NULL,
    distance_km DECIMAL(10,2),
    delivery_duration_min INT,

    CONSTRAINT fk_deliveries_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    CONSTRAINT fk_deliveries_driver
        FOREIGN KEY (driver_id)
        REFERENCES drivers(driver_id),

    CONSTRAINT fk_deliveries_vehicle
        FOREIGN KEY (vehicle_id)
        REFERENCES vehicles(vehicle_id)
);
select * from customers;
select * from orders;
select * from drivers;
select * from vehicles;
select * from deliveries;

# Sprint 3:

-- Basic Analysis / Data Exploration

-- 1.	What is the total number of customers?
select count(*) as Total_No_Customers from customers;

-- 2.	What is the total number of orders?
select count(order_id) as total_no_orders from orders;

-- 3.	What is the total number of deliveries?
select count(delivery_id) as total_No_Delivery from deliveries;

-- 4.	What are the different service types available?
select distinct service_type from orders;

-- 5.	How many drivers are currently active?
select * from drivers;
select count(driver_id) as Active_drivers from drivers where is_active="Yes";

-- 6.	What are the different vehicle types?
select distinct vehicle_type from vehicles;

-- 7.	What is the total order value?
select sum(total_value) as TOTAL_ORDER_VALUE from orders;

-- 8.	What is the average package weight?
select avg(package_weight_kg) as AVG_Package_Weight from orders;


# Sprint - 4 


## 4.1 Understand Delivery Demand

-- 1. Which delivery zones generate the highest and lowest number of orders?
select * from orders;
select delivery_zone_id , count(order_id) as total_orders from orders
group by delivery_zone_id 
order by total_orders desc ;

-- 2. What percentage of total orders comes from each delivery zone?

select delivery_zone_id , count(order_id) as total_orders ,count(*) * 100/ (select count(*) from orders) as order_percentage
from orders
group by delivery_zone_id 
order by total_orders desc ;

-- 3. Which service types are most frequently used?
select service_type, count(*) as count_each_service from orders
group by service_type
order by count_each_service desc;

-- 4. Which service types generate the highest order value?
select * from orders;
select service_type, sum(total_value) as total_order_value from orders
group by service_type
order by total_order_value desc;

-- 5. How are orders distributed across priority levels?
select priority, count(*) as total_orders from orders 
group by priority
order by total_orders desc;

-- 6. Which priority level generates the highest business value?
SELECT priority, COUNT(*) AS total_orders, ROUND(SUM(total_value), 2) AS total_order_value,
ROUND(AVG(total_value), 2) AS average_order_value
FROM orders
GROUP BY priority
ORDER BY total_order_value DESC;

-- 7. Which months generate the highest total order value?
SELECT DATE_FORMAT(order_date, '%Y-%m') AS order_month, COUNT(*) AS total_orders, 
ROUND(SUM(total_value), 2) AS total_revenue
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY total_revenue DESC;

-- 8. Which delivery zones generate the highest total order value?
select delivery_zone_id , count(*) as total_orders, round(sum(total_value),2) as order_Value from orders
group by delivery_zone_id
order by order_value desc;



## 4.2 Understand Customer Order Behaviour

-- 1. Which customers have placed the highest number of orders?

select c.customer_name, count(o.order_id) as total_orders from customers as c
join orders as o 
on c.customer_id = o.customer_id
group by c.customer_name
order by total_orders desc; 

-- 2. Which customers have generated the highest total order value?

select c.customer_name, sum(o.total_value) as Total_Order_Value from customers as c
join orders as o 
on c.customer_id=o.customer_id
group by c.customer_name
order by Total_Order_Value desc;

-- 3. What is the average order value for each customer?

select c.customer_name, avg(o.total_value) as Avg_Order_Value from customers as c
join orders as o 
on c.customer_id=o.customer_id
group by c.customer_name
order by Avg_Order_Value;

-- 4. Which delivery zones have the highest number of customers and orders?
select * from orders;
select * from customers;

select c.delivery_zone_id , count(o.order_id) as total_noOf_orders,
count(Distinct c.customer_id) as total_noOf_customers from customers as c
join orders as o
on c.customer_id=o.customer_id
group by c.delivery_zone_id
order by total_noof_orders desc;

-- 5. Which customers are the most active in each delivery zone based on their number of orders?

SELECT c.delivery_zone_id, c.customer_id, c.customer_name, COUNT(o.order_id) AS total_orders
FROM customers AS c
JOIN orders AS o ON c.customer_id = o.customer_id
GROUP BY c.delivery_zone_id, c.customer_id, c.customer_name
ORDER BY c.delivery_zone_id, total_orders DESC;

-- 6. How do Business and Individual customers differ in terms of total orders and total order value?

SELECT c.customer_type, COUNT(o.order_id) AS total_orders, SUM(o.total_value) AS total_order_value
FROM customers AS c
JOIN orders AS o ON c.customer_id = o.customer_id
GROUP BY c.customer_type ORDER BY total_order_value DESC;

-- 7. What is the average order value for Business customers compared with Individual customers?

SELECT c.customer_type, ROUND(AVG(o.total_value), 2) AS average_order_value
FROM customers AS c
JOIN orders AS o ON c.customer_id = o.customer_id
GROUP BY c.customer_type
ORDER BY average_order_value DESC;


##  4.3 Evaluating Delivery Performance


-- 1. Which delivery zones have the highest number of deliveries, and how do their delivery outcomes compare?
SELECT o.delivery_zone_id, COUNT(d.delivery_id) AS total_deliveries,
    SUM(CASE WHEN d.status = 'Delivered' THEN 1 ELSE 0 END) AS delivered,
    SUM(CASE WHEN d.status = 'Failed' THEN 1 ELSE 0 END) AS failed,
    SUM(CASE WHEN d.status = 'Pending' THEN 1 ELSE 0 END) AS pending,
    SUM(CASE WHEN d.status = 'Rescheduled' THEN 1 ELSE 0 END) AS rescheduled
FROM deliveries d
JOIN orders o ON d.order_id = o.order_id
GROUP BY o.delivery_zone_id
ORDER BY total_deliveries DESC;

-- 2. What is the average delivery duration for each delivery status?
SELECT status, COUNT(*) AS total_deliveries, AVG(delivery_duration_min)  AS avg_delivery_duration_min
FROM deliveries
GROUP BY status
ORDER BY avg_delivery_duration_min DESC;

-- 3. Which delivery zones have the highest number of unsuccessful or unresolved deliveries, such as Failed, Pending, or Rescheduled?
SELECT o.delivery_zone_id, COUNT(d.delivery_id) AS total_problem_deliveries
FROM orders AS o
JOIN deliveries AS d ON o.order_id = d.order_id
WHERE d.status IN ('Failed', 'Pending', 'Rescheduled')
GROUP BY o.delivery_zone_id
ORDER BY total_problem_deliveries DESC;

-- 4. How does delivery performance change over time based on the number of deliveries and their status?
SELECT  YEAR(d.assigned_date) AS delivery_year, MONTH(d.assigned_date) AS delivery_month, COUNT(d.delivery_id) AS total_deliveries,
    SUM(CASE WHEN d.status = 'Delivered' THEN 1 ELSE 0 END) AS delivered,
    SUM(CASE WHEN d.status = 'Failed' THEN 1 ELSE 0 END) AS failed,
    SUM(CASE WHEN d.status = 'Pending' THEN 1 ELSE 0 END) AS pending,
    SUM(CASE WHEN d.status = 'Rescheduled' THEN 1 ELSE 0 END) AS rescheduled
FROM deliveries AS d
GROUP BY  YEAR(d.assigned_date), MONTH(d.assigned_date)
ORDER BY delivery_year, delivery_month;

-- 5.Which delivery zones have the longest average delivery duration, and how does their performance compare with other zones?
SELECT o.delivery_zone_id, COUNT(d.delivery_id) AS total_deliveries, AVG(d.delivery_duration_min) AS avg_delivery_duration
FROM orders AS o
JOIN deliveries AS d ON o.order_id = d.order_id
GROUP BY o.delivery_zone_id
ORDER BY avg_delivery_duration DESC;


# 4.4 Understand Driver and Vehicle Performance


-- 1. Which drivers handle the highest number of deliveries, and how do they rank compared with other drivers?
select * from drivers;
select * from deliveries;

select dr.driver_id, dr.driver_name ,count(dl.delivery_id) as Total_deliveries,
Rank() over(order by count(dl.delivery_id) DESC) as delivery_rank  from drivers dr
join deliveries as dl on dr.driver_id = dl.driver_id
group by dr.driver_id, dr.driver_name
order by total_deliveries DESC;

-- 2. How do delivery outcomes differ across drivers?
SELECT dr.driver_id, dr.driver_name, COUNT(d.delivery_id) AS total_deliveries,
    SUM(CASE WHEN d.status = 'Delivered' THEN 1 ELSE 0 END) AS delivered,
    SUM(CASE WHEN d.status = 'Failed' THEN 1 ELSE 0 END) AS failed,
    SUM(CASE WHEN d.status = 'Pending' THEN 1 ELSE 0 END) AS pending,
    SUM(CASE WHEN d.status = 'Rescheduled' THEN 1 ELSE 0 END) AS rescheduled
FROM drivers AS dr
JOIN deliveries AS d ON dr.driver_id = d.driver_id
GROUP BY dr.driver_id, dr.driver_name
ORDER BY total_deliveries DESC;

-- 3. Which drivers have the longest average delivery duration?

SELECT dr.driver_id, dr.driver_name, COUNT(d.delivery_id) AS total_deliveries,
ROUND(AVG(d.delivery_duration_min), 2) AS avg_delivery_duration FROM drivers AS dr
JOIN deliveries AS d ON dr.driver_id = d.driver_id
GROUP BY dr.driver_id, dr.driver_name
ORDER BY avg_delivery_duration DESC;

-- 4. How frequently is each vehicle type being used? And how does their usage rank?

SELECT v.vehicle_type, COUNT(dl.delivery_id) AS total_deliveries,
RANK() OVER (ORDER BY COUNT(dl.delivery_id) DESC) AS usage_rank FROM vehicles v
LEFT JOIN deliveries dl ON v.vehicle_id = dl.vehicle_id
GROUP BY v.vehicle_type
ORDER BY total_deliveries DESC;

-- 5. Which vehicles have handled the highest number of deliveries?

SELECT v.vehicle_id, v.vehicle_type, v.fuel_type, COUNT(d.delivery_id) AS total_deliveries
FROM vehicles AS v
JOIN deliveries AS d ON v.vehicle_id = d.vehicle_id
GROUP BY v.vehicle_id, v.vehicle_type, v.fuel_type
ORDER BY total_deliveries DESC;

-- 6. Which drivers have handled more deliveries than the average number of deliveries handled by all drivers?

SELECT dr.driver_id, dr.driver_name, COUNT(d.delivery_id) AS total_deliveries FROM drivers AS dr
JOIN deliveries AS d ON dr.driver_id = d.driver_id
GROUP BY dr.driver_id, dr.driver_name
HAVING COUNT(d.delivery_id) > (
    SELECT AVG(driver_delivery_count)
    FROM (
        SELECT COUNT(delivery_id) AS driver_delivery_count
        FROM deliveries
        GROUP BY driver_id
    ) AS driver_counts
)
ORDER BY total_deliveries DESC;


## 4.5 Identify Delivery Problems


-- 1. Which deliveries required more than one delivery attempt?

SELECT delivery_id, order_id, driver_id, delivery_attempt, status FROM deliveries
WHERE delivery_attempt > 1
ORDER BY delivery_attempt DESC;

-- 2. What is the distribution of deliveries across different statuses?
SELECT status, COUNT(delivery_id) AS total_deliveries FROM deliveries
GROUP BY status
ORDER BY total_deliveries DESC;

-- 3. Which drivers have not handled any deliveries?

SELECT dr.driver_id, dr.driver_name
FROM drivers AS dr
LEFT JOIN deliveries AS d ON dr.driver_id = d.driver_id
WHERE d.delivery_id IS NULL;

-- 4.Which delivery zones have the highest number of problematic deliveries?
SELECT o.delivery_zone_id, COUNT(d.delivery_id) AS problem_deliveries
FROM orders AS o
JOIN deliveries AS d ON o.order_id = d.order_id
WHERE d.status IN ('Failed', 'Pending', 'Rescheduled')
GROUP BY o.delivery_zone_id
ORDER BY problem_deliveries DESC;
