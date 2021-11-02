-- 1. Write a query to display for each store its store ID, city, and country.
SELECT
	store.store_id,
    city.city,
    country.country
FROM store
JOIN address
  ON store.address_id = address.address_id
JOIN city
  ON address.city_id = city.city_id
JOIN country
  ON city.country_id = country.country_id;

-- 2. Write a query to display how much business, in dollars, each store brought in.
SELECT
	store.store_id,
    SUM(payment.amount) AS total_amount
FROM store
JOIN staff
  ON store.store_id = staff.store_id
JOIN payment
  ON staff.staff_id = payment.staff_id
GROUP BY store.store_id;

-- 3. What is the average running time of films by category?
SELECT
	category.name AS category,
    ROUND(AVG(film.length), 2) AS avg_running_time
FROM category
JOIN film_category
  ON category.category_id = film_category.category_id
JOIN film
  ON film_category.film_id = film.film_id
GROUP BY category.category_id;

-- 4. Which film categories are longest?
SELECT
	category.name AS category,
    ROUND(AVG(film.length), 2) AS avg_running_time
FROM category
JOIN film_category
  ON category.category_id = film_category.category_id
JOIN film
  ON film_category.film_id = film.film_id
GROUP BY category.category_id
ORDER BY avg_running_time DESC
LIMIT 5;

-- 5. Display the most frequently rented movies in descending order.
SELECT
	film.title AS film
    -- COUNT(*) AS times_rented
FROM film
JOIN inventory
  ON film.film_id = inventory.film_id
JOIN rental
  ON rental.inventory_id = inventory.inventory_id
GROUP BY film.film_id
ORDER BY COUNT(*) DESC
LIMIT 5;

-- 6. List the top five genres in gross revenue in descending order.
SELECT
	category.name AS category,
    SUM(payment.amount) AS revenue
FROM payment
JOIN rental
  ON payment.rental_id = rental.rental_id
JOIN inventory
  ON rental.inventory_id = inventory.inventory_id
JOIN film_category
  ON inventory.film_id = film_category.film_id
JOIN category
  ON film_category.category_id = category.category_id
GROUP BY category.category_id
ORDER BY revenue DESC
LIMIT 5;

-- 7. Is "Academy Dinosaur" available for rent from Store 1?
SELECT 
	film.title,
	inventory.store_id
    -- COUNT(*) As num_copies
FROM film
JOIN inventory
  ON film.film_id = inventory.film_id
WHERE 
  film.title = 'Academy Dinosaur' AND
  inventory.store_id = 1
GROUP BY
	film.title,
    inventory.store_id
ORDER BY film.title;
