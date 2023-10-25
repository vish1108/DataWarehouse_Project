--Creating Star schema for further Work
USE Staging

--Checking The joins Working or not
SELECT 
DF.customer_id,
DF.order_id,
DF.order_status,
rd.review_score,
DC.customer_city,
DC.customer_state,
DP.Payment_type,
DP.Payment_installments,
OID.shipping_limit_date,
DF.order_estimated_delivery_date,
DF.order_purchase_timestamp,
rd.review_creation_data_timestamp
FROM 
orders_dataFACT DF
JOIN order_review_dataDIM rd ON DF.order_id = rd.order_id
JOIN customer_dataDIM DC ON DF.customer_id = DC.customer_id
JOIN order_payment_dataDIM DP ON DF.order_id = DP.order_id
JOIN order_item_dataDim OID ON DF.order_id = OID.order_id;


-- Create a view for the star schema
CREATE VIEW StarSchema AS
SELECT 
    DF.customer_id,
    DF.order_id,
    DF.order_status,
	OID.seller_id,
    rd.review_score,
    DC.customer_city,
    DC.customer_state,
    DP.Payment_type,
    DP.Payment_installments,
    OID.shipping_limit_date,
    DF.order_estimated_delivery_date,
	DF.order_approved_at,
	DF.order_delivered_customer_date,
    DF.order_purchase_timestamp,
    rd.review_creation_data_timestamp
FROM 
    orders_dataFACT DF
JOIN 
    order_review_dataDIM rd ON DF.order_id = rd.order_id
JOIN 
    customer_dataDIM DC ON DF.customer_id = DC.customer_id
JOIN 
    order_payment_dataDIM DP ON DF.order_id = DP.order_id
JOIN 
    order_item_dataDim OID ON DF.order_id = OID.order_id;


--Testing StarSchema
SELECT *
FROM StarSchema;



CREATE VIEW PowerBI_DataMart AS
SELECT
    customer_id,
    order_id,
	seller_id,
    customer_city,
    customer_state,
	order_status,
    Payment_type,
    review_score,
	order_purchase_timestamp,
	order_estimated_delivery_date,
    shipping_limit_date
FROM
	StarSchema

--Testing Power BI Data mart
Select * from dbo.PowerBI_DataMart;


--Creating ML Data Mart
CREATE VIEW MLPrediction_DataMart AS
SELECT
    order_id,
	customer_id,
    customer_state,
    Payment_type,
    order_status,
    review_score,
    shipping_limit_date,
	order_purchase_timestamp,
	order_approved_at,
	order_estimated_delivery_date,
	order_delivered_customer_date
FROM dbo.StarSchema

--CHECKING FOR MLPrediction working
SELECT * FROM MLPrediction_DataMart;


