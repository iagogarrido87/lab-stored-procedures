-- Create the stored procedure to retrieve customer details for a given category:
DELIMITER //

CREATE PROCEDURE GetCustomersByCategory(IN categoryName VARCHAR(255))
BEGIN
  SELECT c.first_name, c.last_name, c.email
  FROM customer c
  JOIN rental r ON c.customer_id = r.customer_id
  JOIN inventory inv ON r.inventory_id = inv.inventory_id
  JOIN film f ON f.film_id = inv.film_id
  JOIN film_category fc ON fc.film_id = f.film_id
  JOIN category cat ON cat.category_id = fc.category_id
  WHERE cat.name = categoryName
  GROUP BY c.first_name, c.last_name, c.email;
END //

DELIMITER ;

-- Create the stored procedure to get the movie categories with a certain number of releases:
DELIMITER //

CREATE PROCEDURE GetCategoriesWithReleaseCount(IN minReleaseCount INT)
BEGIN
  SELECT cat.name, COUNT(*) AS movie_count
  FROM category cat
  JOIN film_category fc ON cat.category_id = fc.category_id
  GROUP BY cat.name
  HAVING movie_count > minReleaseCount;
END //

DELIMITER ;

CALL GetCustomersByCategory('Action');

CALL GetCategoriesWithReleaseCount(50);


