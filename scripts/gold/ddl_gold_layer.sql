/*
===============================================================================
DDL Script: Create Gold Views
===============================================================================
Script Purpose:
	Tạo views cho tầng gold trong data warehouse, mục đích là cho việc bảo mật
	Tầng gold đại diện cho thiết kế schema cuối để phục vụ cho việc phân tích 
	Mỗi view đại diện cho sự chuyển đổi và kết hợp dữ liệu từ tầng silver để 
	quy trình trở nên clean, không rủi ro, và có thể đưa vào phần tích kinh doanh

Usage:.
	- Những views này có thể được query trực tiếp cho việc phân tích và báo cáo.
===============================================================================
*/


IF OBJECT_ID('gold.dim_customes', 'V') IS NOT NULL
    DROP VIEW gold.dim_customes;
GO
create view gold.dim_customes As 
select 
ROW_NUMBER( ) over (order by ci.cst_id ) as customer_key ,
ci.cst_id as customer_id,
ci.cst_key as customer_number,
ci.cst_firstname as first_name,
ci.cst_lastname as last_name,
ci.cst_marital_status as marital_status,
case when ci.cst_gndr != 'n/a' then ci.cst_gndr -- CRM is the Master for gende info
	 else COALESCE(ca.gen,'n/a')
end as gender,
ci.cst_create_date as create_date,
ca.BDATE as birthday,
la.CNTRY as country
from silver.crm_cust_info ci
left join silver.erp_cust_az12 ca on ci.cst_key = ca.CID
left join silver.erp_loc_a101 la on la.CID = ci.cst_key




IF OBJECT_ID('gold.dim_products', 'V') IS NOT NULL
    DROP VIEW gold.dim_products;
GO

create view gold.dim_products as
select 
	row_number() over (order by pr.prd_start_dt, pr.prd_end_dt) as product_key, 
	pr.prd_id as product_id,
	pr.prd_key as product_number,
	pr.prd_nm as product_name,
	pr.cat_id as category_id,
	pc.CAT as category,
	pc.SUBCAT as subcategory,
	pc.MAINTENANCE ,
	pr.prd_cost as cost ,
	pr.prd_line as product_line,
	pr.prd_start_dt as start_date
from silver.crm_prd_info pr
left join silver.erp_px_cat_g1v2 pc on pc.ID = pr.cat_id
where pr.prd_end_dt is null



IF OBJECT_ID('gold.fact_sales', 'V') IS NOT NULL
    DROP VIEW gold.fact_sales;
GO

create view gold.fact_sales as
select 
sd.sls_ord_num as order_number,
pr.product_key,
cu.customer_key,
sd.sls_cust_id,
sd.sls_order_dt as order_date,
sd.sls_due_dt due_date,
sd.sls_ship_dt,
sd.sls_sales as sales_amount,
sd.sls_quantity as quantity,
sd.sls_price as price
from silver.crm_sales_details sd
left join gold.dim_products pr on  sd.sls_prd_key = pr.product_number
left join gold.dim_customes cu  on sd.sls_cust_id = cu.customer_id 

select * from gold.fact_sales
