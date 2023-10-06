--creating Dimension tables for Star schema
Use [Data Warehouse]

--Creating SellerDim Table
CREATE TABLE Seller_dim(
SellerID NVARCHAR(50),
Seller_Zip_Code int,
Seller_city NVARCHAR(50),
Seller_state NVARCHAR(50)
);

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
