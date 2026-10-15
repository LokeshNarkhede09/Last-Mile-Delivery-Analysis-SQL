# Last-Mile Delivery Operations Analytics | MySQL

## 📌 Project Overview

The **Last-Mile Delivery Operations Analytics** project is a SQL-based business analytics project developed using MySQL to analyze the operations of QuickRoute Logistics, a last-mile delivery company.

The project focuses on delivery demand, customer ordering behaviour, delivery performance, driver and vehicle utilization, and delivery-related problems.

Using relational database design and objective-wise SQL queries, the project aims to transform operational data into meaningful insights that can help the operations team make better business decisions.

## 🎯 Business Problem

The logistics business needs to understand its delivery operations and identify opportunities for improvement.

The key business challenges include:

- Delivery demand varies across zones and service types.
- Customer ordering behaviour differs between Business and Individual customers.
- Delivery duration and outcomes need to be evaluated across zones.
- Driver workload and vehicle utilization require analysis.
- Orders requiring multiple delivery attempts may increase operational effort and cause delays.

## 🎯 Project Objectives

### A. Delivery Demand Analysis

- Identify delivery zones generating the highest order volumes and order values.
- Determine the most frequently used delivery service types.
- Analyze order distribution across priority levels.
- Examine monthly and yearly changes in order demand.
- Compare average order values across service types and zones.

### B. Customer Order Behaviour

- Identify customers placing the highest number of orders.
- Find customers generating the highest total order values.
- Compare Business and Individual customer ordering behaviour.
- Analyze customer activity across delivery zones.
- Calculate the percentage of repeat customers.
- Compare average order values by customer type.

### C. Delivery Performance

- Analyze delivery status distributions.
- Identify zones with higher delivery activity.
- Compare average delivery durations across zones.
- Examine delivery outcomes by order priority.
- Analyze the relationship between delivery distance and duration.
- Compare average delivery distances across zones.

### D. Driver & Vehicle Performance

- Calculate the number of deliveries handled by each driver.
- Analyze delivery outcomes by driver.
- Compare average delivery duration across drivers and vehicle types.
- Examine delivery distribution across different vehicle types.
- Compare vehicle type and fuel type based on delivery distance and duration.
- Evaluate workload differences between active and inactive drivers.

### E. Delivery Problems Analysis

- Identify orders requiring multiple delivery attempts.
- Compare multiple-attempt orders across delivery zones.
- Analyze the relationship between delivery attempts and outcomes.
- Examine delivery outcomes across order priorities.
- Identify drivers handling the highest number of multiple-attempt orders.

## 📂 Dataset Description

The project uses a relational dataset organized into five tables.

### 1. Customers Table

Contains customer information.

Key columns:

- `customer_id`
- `customer_name`
- `city`
- `delivery_zone_id`
- `preferred_time_slot`
- `customer_type`
- `account_since`

### 2. Orders Table

Contains order and purchase information.

Key columns:

- `order_id`
- `customer_id`
- `order_date`
- `delivery_zone_id`
- `package_weight_kg`
- `service_type`
- `priority`
- `total_value`

### 3. Deliveries Table

Contains delivery execution and performance information.

Key columns:

- `delivery_id`
- `order_id`
- `driver_id`
- `vehicle_id`
- `assigned_date`
- `actual_delivery_date`
- `status`
- `delivery_attempt`
- `distance_km`
- `delivery_duration_min`

### 4. Drivers Table

Contains driver details and employment information.

Key columns:

- `driver_id`
- `driver_name`
- `hire_date`
- `rating`
- `employment_type`
- `is_active`

### 5. Vehicles Table

Contains vehicle and fleet information.

Key columns:

- `vehicle_id`
- `vehicle_type`
- `fuel_type`
- `max_payload_kg`
- `depot`
- `last_service_date`
- `is_active`

### Dataset Overview

| Table | Rows Reported | Columns |
|---|---:|---:|
| Customers | 400 | 7 |
| Orders | 3,000 | 8 |
| Deliveries | 2,581 | 10 |
| Drivers | 80 | 6 |
| Vehicles | 50 | 7 |

**Database Name:** `last_mile_delivery`

**Note:** The project documentation lists 3,500 delivery rows, whereas the presentation reports 2,581. These figures should be verified against the final imported dataset.

## 🛠️ Tools and Technologies

- **MySQL** — Database creation, relational data management, and SQL analysis.
- **MySQL Workbench** — SQL query execution and database exploration.
- **SQL** — Business analysis, data aggregation, and analytical calculations.
- **Relational Database Design** — Primary keys, foreign keys, and table relationships.

## 🗄️ Database Design

The database contains five related tables connected through primary keys and foreign keys.

- `customers` → `orders`
- `orders` → `deliveries`
- `drivers` → `deliveries`
- `vehicles` → `deliveries`

The `deliveries` table connects delivery records with their corresponding orders, drivers, and vehicles.

## 📊 Basic Data Analysis

The SQL script includes basic queries to understand the database before performing objective-wise analysis.

The basic analysis covers:

- Total number of customers.
- Total number of orders.
- Total number of deliveries.
- Available delivery service types.
- Number of active drivers.
- Vehicle information.
- Total order value.
- Average package weight.

### Basic Results Reported in the Presentation

| Metric | Reported Result |
|---|---:|
| Total Customers | 400 |
| Total Orders | 3,000 |
| Total Deliveries | 2,581 |
| Active Drivers | 75 |
| Total Order Value | 7,522,414.78 |
| Average Package Weight | 25.092 kg |

These are reported project results and have not been independently recalculated here.

## 💻 SQL Concepts Used

- `CREATE DATABASE` and `CREATE TABLE`
- Primary keys and foreign keys
- `SELECT`, `DISTINCT`, and `COUNT()`
- Aggregate functions: `SUM()` and `AVG()`
- `GROUP BY`, `ORDER BY`, and `LIMIT`
- `INNER JOIN` and `LEFT JOIN`
- Subqueries
- `CASE` statements
- Date functions: `YEAR()` and `MONTH()`
- Conditional grouping
- Percentage calculations
- Window functions using `OVER()` and `PARTITION BY`
- Database metadata queries using `information_schema`

## 📈 Key Findings and Insights

The following findings were reported in the project presentation. Validate them by rerunning the SQL queries against the final dataset before treating them as verified results.

### A. Delivery Demand

- **Top Delivery Zone:** `ZONE0005`, with 240 orders and a reported total order value of 589,285.70.
- **Most-Used Service Type:** Standard, with 620 out of 3,000 orders.

**Business Implication:** Delivery resources can be planned according to zone-level demand and service-type preferences.

### B. Customer Order Behaviour

- **Repeat Customers:** 99.25%, as reported in the presentation.
- **Highest-Order Customer:** Eric Davis, with 19 orders.

**Business Implication:** Customer retention and high-value customer behaviour can be investigated to support customer loyalty initiatives.

### C. Delivery Performance

- The presentation reports that all 2,581 delivery records were marked as delivered.
- **Slowest Reported Delivery Zone:** `ZONE0011`, with an average delivery duration of 51.36 minutes.
- Delivery distance was reported to have only a small effect on delivery duration.

**Business Implication:** The operations team can investigate the slowest zone to identify potential scheduling or operational improvements.

### D. Driver & Vehicle Performance

- **Active Drivers:** 75.
- The presentation reports approximately 34 deliveries per active driver.
- Five drivers were reported as inactive and had no deliveries.
- Vans were reported as the slowest vehicle type, at approximately 50 minutes.
- Cars were reported as the fastest vehicle type, at approximately 47 minutes.

**Business Implication:** Driver workload and vehicle utilization can be reviewed to identify opportunities for more balanced resource allocation.

### E. Delivery Problems

- **Orders Requiring Multiple Attempts:** 122, as reported in the presentation.
- Approximately 95% of deliveries were reported as completed on the first attempt.
- All priority types—High, Normal, and Urgent—were reported as fully delivered.

**Business Implication:** The operations team can investigate repeat-attempt orders to identify preventable delays and improve first-attempt delivery performance.

## 💡 Business Recommendations

1. **Optimize Resource Allocation:** Assign drivers and vehicles according to delivery demand across zones and busy periods.
2. **Strengthen Customer Retention:** Examine repeat-customer and high-value customer behaviour to identify opportunities for loyalty initiatives.
3. **Investigate Slow Delivery Zones:** Review operational processes in `ZONE0011`, the slowest zone reported in the presentation.
4. **Reduce Repeat Delivery Attempts:** Investigate time-slot availability, delivery instructions, and other possible causes of additional attempts.
5. **Review Driver Workload:** Compare workloads and delivery durations to identify opportunities for better resource utilization.
6. **Evaluate Vehicle Suitability:** Compare delivery distance, duration, payload capacity, and fuel type before changing vehicle assignments.

These are suggested operational actions; the available project files do not establish the causes of the observed patterns.

## 🚀 How to Run This Project

1. Install MySQL Server and MySQL Workbench.
2. Clone or download this repository.
3. Open `Last-Mile-Delivery-Analysis.sql` in MySQL Workbench.
4. Execute the database and table creation statements.
5. Import the dataset into the corresponding tables.
6. Verify the imported records and table structures.
7. Execute the basic analysis queries.
8. Run the objective-wise SQL queries.
9. Review the query results and validate the reported findings.

**Important:** The SQL script creates the database and tables but does not include the source dataset or data-import commands. The dataset must be imported before running queries that require populated tables.

## 📁 Repository Structure

```text
Last-Mile-Delivery-Operations-Analytics/
│
├── Last-Mile-Delivery-Dataset.csv
├── Last-Mile-Delivery-Analysis.sql
├── Objective-Wise-SQL-Questions.txt
└── README.md
```

The dataset filename and extension should match the actual file uploaded to GitHub.

The repository contains the SQL script, source dataset, objective-wise questions, and README. The separate project documentation and presentation are not included.

## 🏁 Conclusion

The Last-Mile Delivery Operations Analytics project demonstrates the practical application of MySQL for relational database design and business analysis.

The project examines delivery demand, customer ordering behaviour, delivery performance, driver and vehicle utilization, and multiple-attempt deliveries through objective-based SQL queries.

The reported findings highlight areas for further investigation, including demand concentration in `ZONE0005`, slower deliveries in `ZONE0011`, driver utilization, and orders requiring multiple attempts.

By combining database design with structured SQL analysis, the project demonstrates practical skills in data exploration, relational joins, aggregation, and business problem-solving.

## 👨‍💻 Author

**Lokesh Narkhede**

- GitHub: https://github.com/LokeshNarkhede09
- LinkedIn: www.linkedin.com/in/lokeshnarkhede

**Project:** Last-Mile Delivery Operations Analytics  
**Database:** MySQL  
**Category:** SQL | Data Analytics
