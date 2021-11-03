-- 1. Write a query to display for each store its store ID, city, and country.
SELECT
  store.store_id,
  city.city,
  country.country
FROM store
JOIN address USING (address_id)
JOIN city USING (city_id)
JOIN country USING (country_id);

-- 2. Write a query to display how much business, in dollars, each store brought in.
SELECT
  store.store_id,
  SUM(payment.amount) AS total_amount
FROM store
JOIN staff USING (store_id)
JOIN payment USING (staff_id)
GROUP BY store.store_id;

-- 3. What is the average running time of films by category?
SELECT
  category.name AS category,
  ROUND(AVG(film.length), 2) AS avg_running_time
FROM category
JOIN film_category USING (category_id)
JOIN film USING (film_id)
GROUP BY category.category_id;

-- 4. Which film categories are longest?
SELECT
  category.name AS category,
  ROUND(AVG(film.length), 2) AS avg_running_time
FROM category
JOIN film_category USING (category_id)
JOIN film USING (film_id)
GROUP BY category.category_id
ORDER BY avg_running_time DESC
LIMIT 5;

-- 5. Display the most frequently rented movies in descending order.
SELECT
  film.title AS film
  -- COUNT(*) AS times_rented
FROM film
JOIN inventory USING (film_id)
JOIN rental USING (inventory_id)
GROUP BY film.film_id
ORDER BY COUNT(*) DESC
LIMIT 5;

-- 6. List the top five genres in gross revenue in descending order.
SELECT
  category.name AS category,
  SUM(payment.amount) AS revenue
FROM payment
JOIN rental USING(rental_id)
JOIN inventory USING(inventory_id)
JOIN film_category USING(film_id)
JOIN category USING(category_id)
GROUP BY category.category_id
ORDER BY revenue DESC
LIMIT 5;

-- 7. Is "Academy Dinosaur" available for rent from Store 1?
SELECT 
  film.title,
  inventory.store_id
  -- COUNT(*) As num_copies
FROM film
JOIN inventory USING(film_id)
WHERE 
  film.title = 'Academy Dinosaur' AND
  inventory.store_id = 1
GROUP BY
  film.title,
  inventory.store_id
ORDER BY film.title;
