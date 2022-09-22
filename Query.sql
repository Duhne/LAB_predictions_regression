SELECT * FROM sakila.rental;
SELECT * FROM sakila.inventory;
SELECT * FROM sakila.film;

SELECT r.rental_id, r.inventory_id, f.film_id, f.title, r.rental_date, f.rental_duration from sakila.film f
JOIN sakila.inventory i USING (film_id)
JOIN sakila.rental r USING (inventory_id)
WHERE rental_date BETWEEN '2005-05-00 00:00:00' AND '2005-06-00 00:00:00'
ORDER BY rental_id;

SELECT r.rental_id, inventory_id, f.film_id, f.title, l.name AS language, f.length, f.rating, (
SELECT
CASE WHEN rental_date BETWEEN '2005-05-00 00:00:00' AND '2005-06-00 00:00:00' then 1
else 0
end as rented_may) AS rental_may
from sakila.rental r
JOIN sakila.inventory i USING (inventory_id)
JOIN sakila.film f USING (film_id)
JOIN sakila.language l USING (language_id)
GROUP BY rental_may, inventory_id, film_id, rental_id
ORDER BY rental_may DESC;

SELECT
CASE WHEN rental_date BETWEEN '2005-05-00 00:00:00' AND '2005-06-00 00:00:00' then 1
else 0
end as rented_may
from sakila.rental;


SELECT count(r.rental_id) AS times_rented, f.film_id, f.title, r.rental_date, f.rental_duration, (
SELECT
CASE WHEN rental_date BETWEEN '2005-05-00 00:00:00' AND '2005-06-00 00:00:00' then 1
else 0
end as rented_may) AS rental_may
from sakila.rental r
JOIN sakila.inventory i USING (inventory_id)
JOIN sakila.film f USING (film_id)
GROUP BY inventory_id
ORDER BY film_id;