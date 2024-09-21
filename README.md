Music Store Database Queries

Table of Contents


Project Overview

Technologies Used

Key Queries

Query 1: Fetching All Customers

Query 2: Top-selling Albums

Query 3: Revenue by Genre

More Queries...


How to Run

Future Enhancements

Project Overview

The Music Store Database project consists of various SQL queries designed to solve real-world business problems such as identifying top-selling albums, calculating revenue, and understanding customer behavior. This project is aimed at improving the performance of data extraction and manipulation for a fictional music store.

Objectives:

Query optimization for faster results.

Insights into customer behavior and sales trends.
Practical exposure to database functions such as JOIN, GROUP BY, and aggregate functions.
Technologies Used
Database: MySQL
Programming Language: SQL



Key Queries
Query 1: Fetching All Customers
SQL

SELECT * FROM customers;

This query retrieves all customers from the database, allowing the store to see the entire list of users.

Query 2: Top-selling Albums
SQL

SELECT album_name, COUNT(order_id) AS total_sales
FROM sales
JOIN albums ON sales.album_id = albums.album_id
GROUP BY album_name
ORDER BY total_sales DESC;


This query displays the top-selling albums based on the number of sales.

Query 3: Revenue by Genre
SQL

SELECT genre_name, SUM(price) AS total_revenue
FROM sales
JOIN albums ON sales.album_id = albums.album_id
JOIN genres ON albums.genre_id = genres.genre_id
GROUP BY genre_name
ORDER BY total_revenue DESC;


This query calculates the total revenue generated for each music genre.

How to Run

Clone this repository:
bash
git clone https://github.com/ASHISHJK786/music_store.git


Import the database dump (music_store.sql) into your MySQL or relevant database system.

Run the SQL queries provided in the repository.

Future Enhancements

Integrating more complex queries to analyze customer lifetime value (CLV).

Adding more reports, such as weekly/monthly sales trends.

Automating report generation using Python or SQL scripts.
