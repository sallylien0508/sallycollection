USE vgb;
/*SELECT ... FROM tableName*/
SELECT id, email, password, name, birthday, gender
	,address, phone, blood_type, subscribed FROM customers;
    
/*
	SELECT ...FROM tableName
		WHERE ....
        
	E01:會員登入
*/    
SELECT id, email, password, name, birthday, gender
	,address, phone, blood_type, subscribed FROM customers
    WHERE id='A123123123' AND password='12345;lkj';

/*
	SELECT ...FROM tableName
		ORDER BY...
*/     
SELECT id, email, password, name, birthday, gender
	,address, phone, blood_type, subscribed FROM customers
    ORDER BY birthday DESC, email DESC;    
    
/*
	SELECT ...FROM tableName
		WHERE ....
        ORDER BY ....
*/    
SELECT id, email, password, name, birthday, gender
	,address, phone, blood_type, subscribed FROM customers
    WHERE id>='A123123123' AND password<='12345;lkj'
    ORDER BY birthday;
    
    
UPDATE customers
set email=?, password=?, name=?, birthday=?, gender=?
	,address=?, phone=?, blood_type=?, subscribed =?
    WHERE id=?;
    
UPDATE customers
set  email='aaa123@uuu.com', password=?, name=?, birthday=?
    WHERE id='A123123123';