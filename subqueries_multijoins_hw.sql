-- (Q) List all customers who live in Texas (use JOIN)
-- (A) Jennifer Davis, Kim Cruz, Richard Mccrary, Bryan Hardison, Ian Still

SELECT first_name, last_name, district
FROM customer
FULL JOIN address
ON customer.address_id = address.address_id
WHERE district = 'Texas';



-- (Q) Get all payments above $6.99 with the customer's full name
-- (A) Alvin Deloach ($33.44), Douglas Graf ($919.67), Harold Martino ($81.99), Alfredo Mcadams ($74.94)
-- Peter Menard ($111.99, $116.99, $114.99, $109.99, $115.99, $118.99, $116.99, $110.99, $116.99, $111.99, $111.99, $111.99, $109.99, $117.99, $113.99, $113.99, $109.99, $115.99,
-- $113.99, $111.99, $113.99, $109.99 <-- 22 total payments), Mary Smith ($980.45, $478.86 <-- 2 total payments)

SELECT first_name, last_name, amount
FROM customer
JOIN payment
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99
ORDER BY last_name ASC;

SELECT customer.customer_id, first_name, last_name, COUNT(amount)
FROM customer
JOIN payment
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99
GROUP BY customer.customer_id
ORDER BY last_name ASC;


-- (Q) Show all customers' names who have made payments over $175 (Use subqueries)
-- (A1) Mary Smith, Douglas Graf
-- (A2) Mary Smith ($980.45, $478.86), Douglas Graf ($919.67)

SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	WHERE amount > 175
);

SELECT first_name, last_name, amount
FROM customer
JOIN payment
ON customer.customer_id = payment.customer_id
WHERE amount > 175
ORDER BY amount DESC;


-- (Q) List all customers that live in Nepal (use the city table)
-- (A) Kevin Schuler

SELECT first_name, last_name, country
FROM customer
JOIN address
ON customer.address_id = address.address_id
JOIN city
ON address.city_id = city.city_id
JOIN country 
ON city.country_id = country.country_id
WHERE country = 'Nepal';


-- (Q) Which staff member had the most transactions?
-- (A) Jon Stephens with 7,304 transactions.

SELECT first_name, last_name, COUNT(staff.staff_id) 
FROM payment
JOIN staff
ON payment.staff_id = staff.staff_id
GROUP BY staff.staff_id;



-- (Q) How many movies of each rating are there?
-- (A) G(178), PG(194), PG-13(223), R(196), NC-17(209)

SELECT COUNT(title), rating
FROM film
GROUP BY rating
ORDER BY rating ASC;



-- (Q) Show all customers who have made a single payment above $6.99 (Use subqueries)
-- (A) Harold Martino, Douglas Graf, Alvin Deloach, Alfredo Mcadams


SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM payment
    WHERE amount > 6.99
    GROUP BY customer_id
    HAVING COUNT(amount) = 1
);


-- (Q) How many free rentals did our stores give away?
-- (A) 0
SELECT COUNT(amount)
FROM payment
WHERE amount = 0;
