SELECT id, name, unit_price, products.stock, color_name, product_colors.stock AS color_stock,
	description, products.photo_url, launch_date, category, discount
    FROM products LEFT JOIN product_colors
		ON id=product_id ;
        
/*如果sql_mode有ONLY_FULL_GROUP_BY, 以下指令會錯, 要把color_name改成group_concat(color_name ORDER BY ordinal)*/
SELECT id, name, unit_price, products.stock, color_name, SUM(product_colors.stock) AS color_stock,
	description, products.photo_url, launch_date, category, discount
    FROM products LEFT JOIN product_colors
		ON id=product_id GROUP BY id; 
        
/*如果sql_mode有ONLY_FULL_GROUP_BY, 以下指令會對, 已把color_name改成group_concat(color_name ORDER BY ordinal)*/
SELECT id, name, unit_price, products.stock, 
	group_concat(color_name ORDER BY ordinal) AS color_list, 
    SUM(product_colors.stock) AS color_stock,
	description, products.photo_url, launch_date, category, discount
    FROM products LEFT JOIN product_colors ON id=product_id 
    GROUP BY id;     

/*如果sql_mode有ONLY_FULL_GROUP_BY, 以下指令會錯, columns list只能保留sum欄位*/    
/*查詢全部產品的總庫存，查詢結果只有一筆 */
SELECT id, name, unit_price, products.stock, product_colors.stock, 
	SUM(IFNULL(product_colors.stock, products.stock)) as real_stock,
	description, products.photo_url, launch_date, category, discount
    FROM products LEFT JOIN product_colors ON id=product_id;

/* E04-a:查詢全部產品的總庫存，查詢結果每個產品一筆 */
SELECT id, name, unit_price, products.stock AS p_stock, group_concat(product_colors.stock) AS color_stock,
	(IFNULL(SUM(product_colors.stock), products.stock)) AS stock,
	description, products.photo_url, launch_date, category, discount
    FROM products LEFT JOIN product_colors ON id=product_id    
    GROUP BY id ; 

/* E04-a:查詢全部產品 , 1.建立View*/
CREATE VIEW products_view AS
	SELECT id, name, unit_price, 
	(IFNULL(SUM(product_colors.stock), products.stock)) AS stock,
	description, products.photo_url, launch_date, category, discount
    FROM products LEFT JOIN product_colors ON id=product_id    
    GROUP BY id;
    
/* E04-a:查詢全部產品 , 2.程式碼都從View查詢*/    
SELECT id, name, unit_price, stock, description, photo_url, 
	launch_date, category, discount
FROM products_view;


show variables LIKE '%sql_mode';
SET sql_mode = (SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));
show variables LIKE '%sql_mode';

/* E04-a:查詢全部產品 */
SELECT id,name,color_name, group_concat(color_name ORDER BY ordinal) AS color_list, SUM(products.stock),SUM(product_colors.stock) AS color_stock    
    FROM products LEFT JOIN product_colors
		ON id=product_id GROUP BY id;
    /*sql_mode=only_full_group_by*/

/* E05 檢視產品明細 */
/*CROSS JOIN*/
SELECT id, name, unit_price, products.stock, description, 
	products.photo_url, launch_date, category, discount,
    product_id, color_name
FROM products JOIN product_colors 
WHERE id='1';

/*INNER JOIN*/
SELECT id, name, unit_price, products.stock, description, 
	products.photo_url, launch_date, category, discount,
    product_id, color_name, product_colors.stock AS color_stock,
    product_colors.photo_url AS color_photo,
    icon_url, ordinal
FROM products INNER JOIN product_colors
	ON id=product_id 
    WHERE id = "1"
    ORDER BY ordinal;
    
/* ***LEFT OUTER JOIN FOR E05檢視產品明細 *** */
SELECT id, name, unit_price, products.stock, description, 
	products.photo_url, launch_date, category, discount,
    product_id, color_name, product_colors.stock AS color_stock,
    product_colors.photo_url AS color_photo,
    icon_url, ordinal
FROM products LEFT JOIN product_colors
	ON id=product_id 
    WHERE id = "11"
    ORDER BY id, ordinal;    
    
/* RIGHT OUTER JOIN FOR E05*/
SELECT id, name, unit_price, products.stock, description, 
	products.photo_url, launch_date, category, discount,
    product_id, color_name, product_colors.stock AS color_stock,
    product_colors.photo_url AS color_photo,
    icon_url, ordinal
FROM products RIGHT JOIN product_colors
	ON id=product_id 
    /*WHERE id = "11"*/
    ORDER BY id, ordinal;      
    
/* FULL OUTER JOIN(MySQL不支援) FOR E05*/
SELECT id, name, unit_price, products.stock, description, 
	products.photo_url, launch_date, category, discount,
    product_id, color_name, product_colors.stock AS color_stock,
    product_colors.photo_url AS color_photo,
    icon_url, ordinal
FROM products FULL JOIN product_colors
	ON id=product_id 
    ORDER BY id, ordinal;            