---------------------Day 10 - SQL Scripts: Banupriya

/*Write  a function to Calculate the total stock value for a given category:
(Stock value=ROUND(SUM(unit_price * units_in_stock)::DECIMAL, 2)
Return data type is DECIMAL(10,2)*/

------Function creation script:
CREATE OR REPLACE FUNCTION get_total_stock_value_by_category(p_category_id INT)
RETURNS DECIMAL(10,2) AS $$
DECLARE
    v_stock_value DECIMAL(10,2);
BEGIN
    SELECT ROUND(SUM(unit_price * units_in_stock)::DECIMAL, 2)
    INTO v_stock_value
    FROM products
    WHERE category_id = p_category_id;

    RETURN COALESCE(v_stock_value, 0.00); -- Return 0 if no products found
END;
$$ LANGUAGE plpgsql;

------Function Call to get the total stock value for category id 2
SELECT get_total_stock_value_by_category(2);


-- 2. Cursor Query Example (Read Products One by One)

DO $$
DECLARE
    cur_products_table CURSOR FOR
        SELECT product_id, product_name, unit_price FROM products;

    rec_product RECORD;
BEGIN
    OPEN cur_products_table;

    LOOP
        FETCH cur_products_table INTO rec_product;
        EXIT WHEN NOT FOUND;

        RAISE NOTICE 'Product ID: %, Name: %, Price: %',
            rec_product.product_id, rec_product.product_name, rec_product.unit_price;
    END LOOP;

    CLOSE cur_products_table;
END;
$$;
