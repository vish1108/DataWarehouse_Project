--creating Dimension tables for Star schema
Use [Data Warehouse]

--Creating SellerDim Table
CREATE TABLE Seller_dim(
SellerID NVARCHAR(50) primary key,
Seller_Zip_Code int,
Seller_city NVARCHAR(50),
Seller_state NVARCHAR(50)
);

ALTER TABLE Seller_dim
ALTER COLUMN SellerID varbinary NOT NULL;

--Checking For Working of Seller Dimension Table
Select * from Seller_dim;

--Loading Sellers_data in seller_dim
INSERT INTO Seller_dim
SELECT * FROM sellers_data;

--Checking For Working of Seller Dimension Table
Select * from Seller_dim;


--Creating Order_itemDim Table
CREATE TABLE Order_itemDim(
		order_id  VARBINARY(MAX),
        order_item_id int,
        product_id VARBINARY(MAX),
        seller_id VARBINARY(MAX),
        shipping_limit_date DATETIME,
        price float,
        freight_value float
        
    )
use [Data Warehouse]
--Checking For Working of Order Dimension Table
Select * from Order_itemDim;

--Loading Order_item_data in Order_itemDim
INSERT INTO Order_itemDim
SELECT * FROM order_item_data;

--Checking For Working of Order Dimension Table
Select * from Order_itemDim;


--Creating geolocationDim Table
 CREATE TABLE geolocationDim (
        geolocation_zip_code_prefix INT,
        geolocation_lat FLOAT,
        geolocation_lng FLOAT,
        geolocation_city NVARCHAR(50),
        geolocation_state NVARCHAR(10)
    )

--Checking For Working of Geolocation Dimension Table
Select * from geolocationDim;

--Loading Geolocation_data in geolocationDim
INSERT INTO geolocationDim
SELECT * FROM geolocation_data;

--Checking For Working of Geolocation Dimension Table
Select * from geolocationDim;

--Creating Customers Dimension Table
 CREATE TABLE customer_DIM (
        customer_id VARBINARY(32) PRIMARY KEY,
        customer_unique_id VARBINARY(32),
        customer_zip_code_prefix INT,
        customer_city NVARCHAR(50),
        customer_state NVARCHAR(10)
    )

--Checking For Working of Customers Dimension Table
Select * from customer_DIM;

--Loading Customer_data in customer_DIM
INSERT INTO customer_DIM
SELECT * FROM customer_data;


--Creating Review Dimension Table 
CREATE TABLE order_reviewDim (
        review_id VARBINARY(max),
        order_id VARBINARY(max),
        review_score int,
        review_creation_date DATETIME,
        review_answer_timestamp DATETIME
        
    )
--Loading review_data in order_reviewDim
INSERT INTO order_reviewDim
SELECT * FROM order_review_data;

--Checking its wroking or not
Select * from order_reviewDim

--cretaing a combine Central order_fact table which consist of all important data
Create Table order_fact (
	order_id VARBINARY(MAX),
    order_item_id int,
	seller_id VARBINARY(MAX),
    shipping_limit_date DATETIME,
    price float,
    freight_value float,
	payment_type NVARCHAR(50),
	payment_installments INT,
    payment_value float,
	order_status NVARCHAR(50),
    order_purchase_timestamp DATETIME,
	order_delivered_customer_date DATETIME
	
);

--Checking For Working of Order Fact Table
Select * from order_fact

--Loading And combining data in order_fact
INSERT INTO order_fact
SELECT order_item_data.order_id, order_item_data.order_item_id,order_item_data.seller_id,order_item_data.shipping_limit_date,order_item_data.price, 
order_item_data.freight_value, order_payment_data.payment_type, order_payment_data.payment_installments, order_payment_data.payment_value, orders_data.order_status,
 orders_data.order_purchase_timestamp, orders_data.order_delivered_customer_date
FROM order_item_data
join order_payment_data ON order_item_data.order_id = order_payment_data.order_id
join orders_data ON order_payment_data.order_id = orders_data.order_id;

--Checking For Working of Order Fact Table
Select * from order_fact



--For any changes of table name you can use this querry
--EXEC sp_rename 'old_table_name', 'updated_table_name';



--Creating Central Combine Table For product fact Data
CREATE TABLE Product_data_fact(
	product_id NVARCHAR(50) primary Key,
	Product_category_name NVARCHAR(50),
	Product_category_name_English NVARCHAR(50)

	)

--Loading review_data in Product_data_fact
INSERT INTO Product_data_fact
SELECT olist_products_dataset.["product_id"], category_name_dat.product_category_name, category_name_dat.product_category_name_english FROM category_name_dat
join olist_products_dataset
on category_name_dat.product_category_name = olist_products_dataset.["product_category_name"];

--Checking it's working or not
SELECT * FROM Product_data_fact


	

