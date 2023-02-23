/* E04-a查詢全部產品 */
SELECT id, name, unit_price, stock, description, photo_url, launch_date, category, discount FROM products;
/* E04-b用關鍵字產品 */
SELECT id, name, unit_price, stock, description, photo_url, launch_date, category, discount FROM products where name LIKE '%Top';

SELECT id, name, unit_price, stock, description, photo_url, launch_date, category, discount FROM products where name LIKE 'Sleeveless%';

/* E04-c分類產品 */
SELECT id, name, unit_price, stock, description, photo_url, launch_date, category, discount FROM products where category= '書籍';

/* E04-d新品上架 */
SELECT id, name, unit_price, stock, description, photo_url, launch_date, category, discount FROM products
where launch_date <=curdate()  ORDER BY launch_date DESC LIMIT 10;

SELECT id, name, unit_price, stock, description, photo_url, launch_date, category, discount FROM products ORDER BY launch_date DESC LIMIT 10;

/*  產品分類清單 */
SELECT distinct category FROM products;

SELECT category ,count(category) AS category_counter FROM products group by category;

/* E05檢視產品明細 */
SELECT id, name, unit_price, stock, description, photo_url, 
	launch_date, category, discount
FROM products
WHERE id='1';




