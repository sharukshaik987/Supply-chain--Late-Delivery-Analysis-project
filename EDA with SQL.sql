select * from c_data

-----what is late delivery percentage---
SELECT 
    COUNT(CASE WHEN delivery_status = 'Late delivery' THEN 1 END) * 100.0 / COUNT(*) AS late_delivery_percentage
FROM c_data;

----- top 10 categories with latedelivery and with highest avg_delays
SELECT 
     top 10 category_name, 
    COUNT(*) AS late_orders, 
    AVG(days_for_shipping_real - days_for_shipment_scheduled) AS avg_delay_days
FROM c_data
WHERE delivery_status = 'Late delivery'
GROUP BY category_name
ORDER BY avg_delay_days DESC;


-------which shipping mode has the highest late_delivery rate---------
SELECT 
    shipping_mode, 
    COUNT(*) AS total_orders, 
    COUNT(CASE WHEN delivery_status = 'Late delivery' THEN 1 END) AS late_orders,
    (COUNT(CASE WHEN delivery_status = 'Late delivery' THEN 1 END) * 100.0 / COUNT(*)) AS late_delivery_percentage
FROM c_data
GROUP BY shipping_mode
ORDER BY late_delivery_percentage DESC;

-----top 10 order_regions with highest late_delivery-------
SELECT 
    top 10 order_region,
 
    COUNT(*) AS total_orders,
    COUNT(CASE WHEN delivery_status = 'Late delivery' THEN 1 END) AS late_orders,
    (COUNT(CASE WHEN delivery_status = 'Late delivery' THEN 1 END) * 100.0 / COUNT(*)) AS late_delivery_percentage
FROM c_data
GROUP BY order_region
ORDER BY late_delivery_percentage DESC;

-----which countries has the highest latedelivered order------
SELECT 
   order_country_en,
    COUNT(*) AS total_orders,
    COUNT(CASE WHEN delivery_status = 'Late delivery' THEN 1 END) AS late_orders,
    (COUNT(CASE WHEN delivery_status = 'Late delivery' THEN 1 END) * 100.0 / COUNT(*)) AS late_delivery_percentage
FROM c_data
GROUP BY  order_country_en
ORDER BY late_delivery_percentage DESC;

------which customer_segments has highest late deliveries------
SELECT 
    customer_segment, 
    COUNT(*) AS total_orders, 
    COUNT(CASE WHEN delivery_status = 'Late delivery' THEN 1 END) AS late_orders,
    (COUNT(CASE WHEN delivery_status = 'Late delivery' THEN 1 END) * 100.0 / COUNT(*)) AS late_delivery_percentage
FROM c_data
GROUP BY customer_segment
ORDER BY late_delivery_percentage DESC;

----how much revenue is lost due to late deliveries----------
SELECT 
    ROUND(SUM(sales_per_customer),2) AS total_sales,
    ROUND(SUM(CASE WHEN delivery_status = 'Late delivery' THEN sales_per_customer ELSE 0 END),2)AS lost_revenue,
    ROUND((SUM(CASE WHEN delivery_status = 'Late delivery' THEN sales_per_customer ELSE 0 END) * 100.0 / SUM(sales_per_customer)),2) AS lost_revenue_percentage
FROM c_data;



----checking wheather discounts are effecting the deliveries to be late----
SELECT 
    order_item_discount, 
    COUNT(CASE WHEN delivery_status = 'Late delivery' THEN 1 END) AS late_orders,
    (COUNT(CASE WHEN delivery_status = 'Late delivery' THEN 1 END) * 100.0 / COUNT(*)) AS late_percentage
FROM c_data
GROUP BY order_item_discount
ORDER BY order_item_discount DESC;



