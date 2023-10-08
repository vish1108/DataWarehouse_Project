use Staging
--Creating new customer dimension tables from data which we got
CREATE TABLE customer_dataDIM(
		customer_id NVARCHAR(50) NOT NULL PRIMARY KEY,
		customer_unique_id NVARCHAR(50) NOT NULL,
		customer_zip_code_prefix INT NOT NULL,
		customer_city NVARCHAR(20) NOT NULL,
		customer_state NVARCHAR(10) NOT NULL,

)

--Checking Table
SELECT * from customer_dataDIM


--Creating new order dimension tables from data which we got
CREATE TABLE orders_dataDIM(
		order_id NVARCHAR(50) NOT NULL,
		customer_id NVARCHAR(50) NOT NULL,
		order_status NVARCHAR(50) NOT NULL,
		order_purchase_timestamp DATETIME NOT NULL,
		order_approved_at DATETIME NOT NULL,
		order_delivered_carrier_date DATETIME NOT NULL,
		order_delivered_customer_date DATETIME NOT NULL,
		order_estimated_delivery_date DATETIME NOT NULL,
		PRIMARY KEY (order_id) ,
		FOREIGN KEY (customer_id) REFERENCES customer_dataDIM(customer_id)
)

--Checking Table
SELECT * from orders_dataDIM

--Creating new review dimension tables from data which we got
CREATE TABLE order_review_dataDIM(
		review_id NVARCHAR(50) NOT NULL,
		order_id NVARCHAR(50) NOT NULL,
		review_score int,
		review_creation_data_timestamp DATETIME NOT NULL,
		review_answer_timestamp DATETIME NOT NULL,
		PRIMARY KEY (review_id),
		FOREIGN KEY (order_id) REFERENCES orders_dataDIM(order_id)
)

--Checking Table
SELECT * from order_review_dataDIM

--Creating new order payment dimension tables from data which 
CREATE TABLE order_payment_dataDIM (
	order_id  NVARCHAR(50) NOT NULL,
	Payment_sequential INT,
	payment_type NVARCHAR(30) NOT NULL,
	payment_installments INT,
	payment_value FLOAT,
	PRIMARY KEY (order_id),
	FOREIGN KEY (order_id) REFERENCES orders_dataDIM(order_id)
)

--Checking Table
SELECT * FROM order_payment_dataDIM


--Creating new order payment dimension tables from data which 
CREATE TABLE geoloacation_dataDim(
	geoloaction_zip_code_prefix INT NOT NULL,
	geoloaction_lat FLOAT NOT NULL,
	geoloaction_lng FLOAT NOT NULL,
	geoloaction_city NVARCHAR(50) NOT NULL,
	geoloaction_state NVARCHAR(50) NOT NULL,
	PRIMARY KEY (geoloaction_zip_code_prefix)

);

--Checking Table
SELECT * FROM geoloacation_dataDim


--Creating new order payment dimension tables from data which
CREATE TABLE sellers_dataDim(
	seller_id NVARCHAR(50) NOT NULL,
	seller_zip_code INT NOT NULL,
	seller_city NVARCHAR(50) NOT NULL,
	seller_state NVARCHAR(50) NOT NULL,
	PRIMARY KEY (seller_id),
	FOREIGN KEY (seller_zip_code) REFERENCES geoloacation_dataDim(geoloaction_zip_code_prefix)

);

--Checking Table
SELECT * FROM sellers_dataDim


--Creating new order payment dimension tables from data which
CREATE TABLE order_item_dataDim(
	order_id NVARCHAR(50) NOT NULL,
	order_item_id INT NOT NULL,
	product_id NVARCHAR(50) NOT NULL,
	seller_id NVARCHAR(50) NOT NULL,
	shipping_limit_date DATETIME NOT NULL,
    price FLOAT NOT NULL,
	freight_value FLOAT NOT NULL,
	PRIMARY KEY (order_id),
	FOREIGN KEY (order_id) REFERENCES orders_dataDIM(order_id),
	FOREIGN KEY (seller_id) REFERENCES sellers_dataDim(seller_id)

);

--Checking Table
SELECT * FROM order_item_dataDim

--Data Load from data Warehouse Database to this Database is Done by ETL(Talend)






	










