-- 1. Review the tables in the database.
USE sakila;
SHOW TABLES;

-- 2. Explore tables by selecting all columns from each table or using the in built review features for your client.
-- SELECT * FROM actor;
-- SELECT * FROM actor_info;
-- SELECT * FROM address;
-- SELECT * FROM category;
-- SELECT * FROM city;
-- SELECT * FROM country;
-- SELECT * FROM customer;
-- SELECT * FROM customer_list;
-- SELECT * FROM film;
-- SELECT * FROM film_actor;
-- SELECT * FROM film_category;
-- SELECT * FROM film_list;
-- SELECT * FROM film_text;
-- SELECT * FROM inventory;
-- SELECT * FROM language;
-- SELECT * FROM nicer_but_slower_film_list;
-- SELECT * FROM payment;
-- SELECT * FROM rental;
-- SELECT * FROM sales_by_film_category;
-- SELECT * FROM sales_by_store;
-- SELECT * FROM staff;
-- SELECT * FROM staff_list;
-- SELECT * FROM store;

-- 3. Select one column from a table. Get film titles.
SELECT title FROM film;

-- 4. Select one column from a table and alias it. Get unique list of film languages under the alias language. 
-- Note that we are not asking you to obtain the language per each film, but this is a good time to think about how you might get that information in the future.
SELECT name AS language -- They are already unique
FROM language;

-- 5.
-- -- 5.1 Find out how many stores does the company have?
SELECT COUNT(*) AS num_stores
FROM store;

-- -- 5.2 Find out how many employees staff does the company have?
SELECT COUNT(*) AS num_employees
FROM staff;

-- -- 5.3 Return a list of employee first names only?
SELECT first_name
FROM staff;