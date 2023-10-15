--Creting Star schema for further Work
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
JOIN 
    order_review_dataDIM rd ON DF.order_id = rd.order_id
JOIN 
    customer_dataDIM DC ON DF.customer_id = DC.customer_id
JOIN 
    order_payment_dataDIM DP ON DF.order_id = DP.order_id
JOIN 
    order_item_dataDim OID ON DF.order_id = OID.order_id;



-- Example query using the view
SELECT customer_id, order_id, customer_city, order_status, review_score
FROM StarSchema
WHERE customer_state = 'SP';

--Testing
SELECT * FROM StarSchema;



CREATE VIEW PowerBI_DataMart AS
SELECT
    DF.customer_id,
    DF.order_id,
    DC.customer_city,
    DC.customer_state,
	DF.order_status,
    DP.Payment_type,
    rd.review_score,
    OID.shipping_limit_date
    -- Add aggregated metrics as needed (e.g., total sales, average review score, etc.)
FROM
    orders_dataFACT AS DF
JOIN
    customer_dataDIM AS DC ON DF.customer_id = DC.customer_id
JOIN
    order_payment_dataDIM AS DP ON DF.order_id = DP.order_id
JOIN
    order_review_dataDIM AS rd ON DF.order_id = rd.order_id
JOIN
    order_item_dataDim AS OID  ON DF.order_id = OID.order_id;

use staging;

CREATE VIEW MLPrediction_DataMart AS
SELECT
    DF.order_id,
	DF.customer_id,
    DC.customer_state,
    DP.Payment_type,
    DF.order_status,
    rd.review_score,
    OID.shipping_limit_date,
	DF.order_purchase_timestamp,
	DF.order_approved_at,
	DF.order_estimated_delivery_date,
	DF.order_delivered_customer_date
FROM
    orders_dataFACT DF
JOIN
    customer_dataDIM DC ON DF.customer_id = DC.customer_id
JOIN
    order_payment_dataDIM DP ON DF.order_id = DP.order_id
JOIN
    order_review_dataDIM rd ON DF.order_id = rd.order_id
JOIN
    order_item_dataDim OID ON DF.order_id = OID.order_id;

--CHECKING FOR MLPrediction working
SELECT * FROM MLPrediction_DataMart;

SELECT count(order_status) FROM Staging.dbo.PowerBI_DataMart where order_status <> 'delivered';

SELECT *
FROM Staging.dbo.PowerBI_DataMart
WHERE payment_type = (
    SELECT MAX(payment_type)
    FROM Staging.dbo.PowerBI_DataMart
);


