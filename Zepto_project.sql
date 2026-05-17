DROP TABLE IF EXISTS zepto;

CREATE TABLE zepto(
sku_id SERIAL PRIMARY KEY,
category VARCHAR(120),
name VARCHAR(150) NOT NULL,
mrp NUMERIC(8,2),
discountPercent NUMERIC(5,2),
availableQuantity INTEGER,
discountedSellingPrice NUMERIC(8,2),
weightInGms INTEGER,
outOfStock BOOLEAN,	
quantity INTEGER
);
---count rows
SELECT COUNT(*) FROM zepto;

---count columns
SELECT * FROM zepto
LIMIT 10;

SELECT * FROM zepto
WHERE name IS NULL
OR
category IS NULL
OR
mrp IS NULL
OR
discountPercent IS NULL
OR
availableQuantity IS NULL
OR
discountedSellingPrice IS NULL
OR
weightInGms IS NULL
OR
outOfStock IS NULL
OR
quantity IS NULL;


SELECT DISTINCT category
FROM zepto
ORDER BY category;

SELECT * FROM zepto;
SELECT outOfStock,COUNT(sku_id) FROM zepto GROUP BY outOfStock;

SELECT name, COUNT(sku_id) as "Numbers_of_SKUs" FROM zepto GROUP BY name HAVING COUNT(sku_id)>1
ORDER BY COUNT(sku_id) DESC;

SELECT * FROM zepto WHERE mrp=0  OR discountedSellingPrice=0;

DELETE FROM zepto WHERE mrp=0;

UPDATE zepto
SET mrp=mrp/100.0,
discountedSellingPrice=discountedSellingPrice/100.0;

SELECT mrp , discountedSellingPrice FROM zepto;


--top 10 high discountpercent product

SELECT DISTINCT name, mrp,discountPercent FROM zepto
ORDER BY discountPercent DESC
LIMIT 10;

-- high price item out of stock or not

SELECT DISTINCT name ,mrp from zepto
WHERE outOfStock=TRUE and mrp>300
ORDER BY mrp DESC;

SELECT mrp FROM zepto ORDER BY mrp DESC;

SELECT * FROM zepto;

--total revenue
SELECT category,
SUM(discountedSellingPrice * availableQuantity) as total_revenue FROM zepto
GROUP BY category
ORDER BY total_revenue;

--mrp>500 and discountPercentis less than 10%
SELECT DISTINCT name, mrp , discountPercent FROM zepto
WHERE  mrp>500 AND discountPercent<10
ORDER BY mrp DESC, discountPercent DESC ;

--top 5 categories offering the highest average discount percentage.
SELECT category, 
ROUND(AVG(discountPercent),2) AS highest_average FROM zepto
GROUP BY category
ORDER BY highest_average DESC
LIMIT 5;

--price per gram for products above 100g and sort by best value.
SELECT DISTINCT name, weightInGms,discountedSellingPrice,
ROUND(discountedSellingPrice/weightInGms,2) AS price_per_gram
FROM zepto
WHERE weightInGms>=100
ORDER BY price_per_gram;

--the products into categories like Low, Medium, Bulk.
SELECT DISTINCT name, weightInGms,
CASE WHEN weightInGms < 1000 THEN 'Low'
	WHEN weightInGms < 5000 THEN 'Medium'
	ELSE 'Bulk'
	END AS weight_category
FROM zepto;

--the Total Inventory Weight Per Category 
SELECT category,
SUM(weightInGms * availableQuantity) AS total_weight
FROM zepto
GROUP BY category
ORDER BY total_weight;