-- Drop table if exists
DROP TABLE IF EXISTS products;

-- create products table
CREATE TABLE products (
    id INT PRIMARY KEY,
    product_name TEXT,
    imageURL TEXT,
    productURL TEXT,
    stars FLOAT, 
    reviews INT,
    price DECIMAL(10, 2),
    discount DECIMAL(10, 2),
    category_id INT,
    is_bestseller BOOLEAN,
    boughtin_lastmonth INT
);

-- import csv --
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/amazon_products.csv'
INTO TABLE products
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;


-- Create table --
CREATE TABLE IF NOT EXISTS categories (
	id INT PRIMARY KEY,
    category TEXT
    );
 
 -- importar data for the table --
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/amazon_categories.csv'
INTO TABLE categories
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Category with most sale --
SELECT categories.category, AVG(products.boughtin_lastmonth) AS SALES, AVG(products.price) 
FROM products
INNER JOIN categories ON products.category_id = categories.id
GROUP BY categories.category
ORDER BY SALES DESC
LIMIT 10;

-- relation with sales and discounts
SELECT categories.category, AVG(products.boughtin_lastmonth) AS SALES, AVG(products.discount), AVG(products.price)
FROM products
INNER JOIN categories ON products.category_id = categories.id
GROUP BY categories.category
ORDER BY SALES DESC
LIMIT 10;

-- category with less sale --
SELECT categories.category, AVG(products.boughtin_lastmonth) AS SALES, AVG(products.price) 
FROM products
INNER JOIN categories ON products.category_id = categories.id
GROUP BY categories.category
ORDER BY SALES ASC
LIMIT 10;

-- Discount per category --
SELECT categories.category, AVG(products.discount) as Discounts
FROM products
INNER JOIN categories ON products.category_id = categories.id
GROUP BY categories.category
ORDER BY Discounts DESC
LIMIT 10;

-- client evaluation --
SELECT categories.category, AVG(products.boughtin_lastmonth) AS Sales_past_month ,AVG(products.stars) as Raitings, AVG(products.reviews), AVG(products.is_bestseller)
FROM products
INNER JOIN categories ON products.category_id = categories.id
GROUP BY categories.category
order by Sales_past_month DESC
LIMIT 10;
