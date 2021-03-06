-- 1. How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT 
  COUNT(*) AS num_copies
FROM inventory
WHERE film_id  = (
  SELECT film_id
  FROM film
  WHERE title = 'Hunchback Impossible')
GROUP BY film_id;

-- -- Without subqueries
-- SELECT
--   film.title,
--   COUNT(*) AS num_copies
-- FROM film
-- JOIN inventory USING (film_id)
-- WHERE film.title = 'Hunchback Impossible'
-- GROUP BY film.title
-- ORDER BY film.title;

-- 2. List all films whose length is longer than the average of all the films.
SELECT title
FROM film
WHERE `length` > (SELECT AVG(`length`) FROM film);

-- 3. Use subqueries to display all actors who appear in the film Alone Trip.
SELECT
  CONCAT(first_name, ' ', last_name) AS actor   
FROM actor
WHERE actor_id IN (
  SELECT actor_id
  FROM film_actor
  WHERE film_id = (
    SELECT film_id
    FROM film
    WHERE title = 'Alone Trip')
  );
    
-- -- Without subqueries
-- SELECT
--   CONCAT(first_name, ' ', last_name) AS actor   
-- FROM actor
-- JOIN film_actor USING (actor_id)
-- JOIN film USING (film_id)
-- WHERE film.title = 'Alone Trip';

-- 4. Sales have been lagging among young families, and you wish to target all family movies for a promotion.
-- Identify all movies categorized as family films.
SELECT title
FROM film
WHERE film_id IN (
  SELECT film_id
  FROM film_category
  WHERE category_id = (
    SELECT category_id
    FROM category
    WHERE `name` = 'Family')
  );

-- -- Without subqueries
-- SELECT title
-- FROM film
-- JOIN film_category USING (film_id)
-- JOIN category USING (category_id)
-- WHERE `name` = 'Family';

-- 5. Get name and email from customers from Canada using subqueries. Do the same with joins. Note that to create a join,
-- you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.
-- -- Using subqueries
SELECT email
FROM customer
WHERE address_id IN (
  SELECT address_id
  FROM address
  WHERE city_id IN (
    SELECT city_id
    FROM city
    WHERE country_id = (
      SELECT country_id
      FROM country
      WHERE country = 'Canada')
    )
  );

-- -- Using joins
SELECT email
FROM customer
JOIN address USING (address_id)
JOIN city USING (city_id)
JOIN country USING (country_id)
WHERE country.country = 'Canada';
    
-- 6. Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films.
-- First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.    
SELECT title
FROM film
WHERE film_id IN (
  SELECT film_id
  FROM film_actor
  WHERE actor_id = (
    SELECT actor_id
    FROM film_actor
    GROUP BY actor_id
    ORDER BY COUNT(*) DESC
    LIMIT 1)
  );

-- -- Alternatively
-- SELECT title
-- FROM film
-- JOIN film_actor USING (film_id)
-- WHERE actor_id = (
--   SELECT actor_id
-- 	 FROM film_actor
-- 	 GROUP BY actor_id
-- 	 ORDER BY COUNT(*) DESC
-- 	 LIMIT 1);
		
-- 7. Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer
-- ie the customer that has made the largest sum of payments
SELECT title
FROM film
WHERE film_id IN (
  SELECT film_id
  FROM inventory
  WHERE inventory_id IN (
    SELECT inventory_id
    FROM rental
    WHERE customer_id = (
      SELECT customer_id
      FROM payment
      GROUP BY customer_id
      ORDER BY SUM(amount) DESC
      LIMIT 1)
    )
  );

-- ALternatively
-- SELECT title
-- FROM film
-- JOIN inventory USING (film_id)
-- JOIN rental USING (inventory_id)
-- WHERE customer_id = (
--   SELECT customer_id
--   FROM payment
-- 	 GROUP BY customer_id
-- 	 ORDER BY SUM(amount) DESC
-- 	 LIMIT 1);

-- 8. Customers who spent more than the average payments
WITH customer_spent AS (
  SELECT 
    CONCAT(first_name, ' ', last_name) AS customer,
    SUM(amount) AS total_spent
  FROM payment
  JOIN customer USING (customer_id)
  GROUP BY payment.customer_id)

SELECT customer
FROM customer_spent
WHERE total_spent > (
  SELECT AVG(total_spent)
  FROM customer_spent);