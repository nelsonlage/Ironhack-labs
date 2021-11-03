-- 1. Which actor has appeared in the most films?
SELECT
	CONCAT(actor.first_name, ' ', actor.last_name) AS actor, 
    COUNT(*) AS num_movies
FROM film_actor
JOIN actor
  ON actor.actor_id = film_actor.actor_id
GROUP BY film_actor.actor_id
ORDER BY num_movies DESC
LIMIT 1;

-- 2. Most active customer (the customer that has rented the most number of films)
SELECT
	CONCAT(customer.first_name, ' ', customer.last_name) AS costumer, 
    COUNT(*) AS num_movies_rented
FROM customer
JOIN rental
  ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id
ORDER BY num_movies_rented DESC
LIMIT 1;

-- 3. List number of films per category.
SELECT
	category.name AS category,
    COUNT(*) AS num_movies
FROM category
JOIN film_category
  ON category.category_id = film_category.category_id
GROUP BY category.category_id
ORDER BY num_movies;

-- 4. Display the first and last names, as well as the address, of each staff member.
SELECT
	staff.first_name,
    staff.last_name,
    address.address
FROM staff
JOIN address
  ON staff.address_id = address.address_id;
    
-- 5. Display the total amount rung up by each staff member in August of 2005.
SELECT
	CONCAT(staff.first_name, ' ', staff.last_name) AS employee,
    SUM(payment.amount) AS total_sales
FROM staff
JOIN payment
  ON staff.staff_id = payment.staff_id
WHERE payment.payment_date LIKE '2005-08%'
GROUP BY staff.staff_id;

-- 6. List each film and the number of actors who are listed for that film.
SELECT
	film.title AS film,
    COUNT(*) AS num_actors
FROM film
JOIN film_actor
  ON film.film_id = film_actor.film_id
GROUP BY film.film_id
ORDER BY num_actors DESC
LIMIT 10;

-- 7. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name. 
SELECT
	customer.first_name,
    customer.last_name,
    SUM(payment.amount) AS total_amount
FROM customer
JOIN payment
  ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id
ORDER BY customer.last_name
LIMIT 10;
    
-- Bonus: Which is the most rented film?
SELECT
	film.title AS film
FROM film
JOIN inventory
  ON film.film_id = inventory.film_id
JOIN rental
  ON rental.inventory_id = inventory.inventory_id
GROUP BY film.film_id
ORDER BY COUNT(*) DESC
LIMIT 1;