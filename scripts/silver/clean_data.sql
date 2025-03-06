
use DataWarehouse
go
/*
	Lam sach du lieu cho bang bronze.crm_cust_info
*/
select cst_firstname
from bronze.crm_cust_info
where cst_firstname != trim(cst_firstname)
-- trim loại bỏ khoảng trắng và kí tự thừa

-- check the consistency of values in low cardinality columns

select distinct cst_gndr
from bronze.crm_cust_info

select distinct cst_marital_status
from bronze.crm_cust_info
-- tìm những chữ viết tắt đổi thành từ có nghĩa


-- check for nulls or duplicates in primary key
-- expectation: No result
select
	cst_id,
	count(*)
from bronze.crm_cust_info
group by cst_id
having COUNT(*) > 1 or cst_id is null

-- check for unwanted Spaces

select cst_firstname
from bronze.crm_cust_info
where cst_firstname != trim(cst_firstname)
-- trim loại bỏ khoảng trắng và kí tự thừa

-- check the consistency of values in low cardinality columns

select distinct cst_gndr
from bronze.crm_cust_info

select distinct cst_marital_status
from bronze.crm_cust_info
-- tìm những chữ viết tắt đổi thành từ có nghĩa


-- check for nulls or duplicates in primary key
-- expectation: No result
select
	cst_id,
	count(*)
from silver.crm_cust_info
group by cst_id
having COUNT(*) > 1 or cst_id is null

/*
	Lam sach du lieu cho bang bronze.crm_prd_info
*/

select
	prd_id,
	count(*)
from bronze.crm_prd_info
group by prd_id
having COUNT(*) > 1 or prd_id is null

-- o cot prd_key co dang CO-RF-FR-R92B-58 chua rat nhieu thong tin trong do bao gom ma catalog


select distinct id from bronze.erp_px_cat_g1v2 
-- select thi thay cat_id va id khong cung dinh dang do do phai dung replace de thay the '-' thanh '_'

select sls_prd_key from bronze.crm_sales_details

-- filters out unmatched data after applying transformation

select prd_id,
prd_key,
Replace(SUBSTRING(prd_key,1,5),'-','_') as cat_id, -- substring dung de cat 1 chuoi

prd_line,
prd_cost,
prd_nm,
prd_start_dt,
prd_end_dt
from bronze.crm_prd_info
where Replace(SUBSTRING(prd_key,1,5),'-','_') not in (select distinct id from bronze.erp_px_cat_g1v2 )

-- len() return the number of characters in a string

select prd_id,
prd_key,
Replace(SUBSTRING(prd_key,1,5),'-','_') as cat_id, -- substring dung de cat 1 chuoi
SUBSTRING(prd_key,7, len(prd_key)),
prd_line,
prd_nm,
cast(prd_start_dt as Date) as prd_start_dt,
CAST(lead(prd_start_dt) over (partition by prd_key order by prd_start_dt) - 1 as date) as prd_end_dt
from bronze.crm_prd_info
where SUBSTRING(prd_key,7, len(prd_key)) in (select sls_prd_key from bronze.crm_sales_details )

-- check for unwanted spaces 
-- expectation: No results
select prd_nm
from silver.crm_prd_info
where prd_nm != trim(prd_nm)

-- check for nulls or negative numbers 
-- expectation: no results
select prd_cost
from silver.crm_prd_info
where prd_cost <0 or prd_cost is null

-- isNull replace null values with a specified replacement value

-- check for invalid date orders
select *
from silver.crm_prd_info
where prd_end_dt < prd_start_dt 
-- sau khi phan tich du lieu thi thay ngay nhieu cho ko valid va overlap, thoi gian khong dung
-- solution: end date = start date of the 'next' record -1 

select prd_id, prd_key, prd_nm, prd_start_dt, prd_end_dt, lead(prd_start_dt) over (partition by prd_key order by prd_start_dt) - 1 as prd_end_dt_test
from bronze.crm_prd_info
where prd_key in ('AC-HE-HL-U509-R',  'AC-HE-HL-U509')


/*
	Clean bronze.crm_sales_details
*/




-- check for invalid dates
select nullif(sls_order_dt,0) as sls_order_dt
from bronze.crm_sales_details
where sls_order_dt<=0 or len(sls_order_dt) !=8

-- oder date must be earlier than shipping date or due date
select *
from silver.crm_sales_details
where sls_order_dt > sls_ship_dt or sls_order_dt>sls_due_dt

-- check data consistency between sales, quantity and price 
-->> sales = quantity*price
-->> Values must not be null, zero, or negative

select 
case 
	when sls_sales is null or sls_sales <=0 or sls_sales!= sls_quantity*sls_price then sls_quantity*ABS(sls_price)
	else sls_sales
	end as
sls_sales, 
sls_quantity, 
case 
	when sls_price <= 0 or sls_price is null then sls_sales/nullif(sls_quantity,0)
	else sls_price
end as
sls_price
from silver.crm_sales_details
where sls_sales != sls_quantity * sls_price
or sls_sales is null or sls_quantity is null or sls_price is null
or sls_sales <=0 or sls_quantity <=0 or sls_price <=0
order by sls_sales, sls_quantity, sls_price






/*

Clean erp_cust 


*/





select * from silver.crm_cust_info -- check thi tại cid có thêm NAS

-- indentify out-of-range dates 
select distinct 
bdate
from bronze.erp_cust_az12
where bdate < '1924-01-01' or bdate>getdate()

-- Data Standardization & Consistency
select distinct gen as old_gen
from bronze.erp_cust_az12

/*
Clean erp_px_cat

*/

select ID, CAT, SUBCAT, MAINTENANCE
from bronze.erp_px_cat_g1v2


-- check for unwanted Spaces
select ID, CAT, SUBCAT, MAINTENANCE
from bronze.erp_px_cat_g1v2
where cat!= trim(cat) or SUBCAT!=trim(SUBCAT) or MAINTENANCE != trim(MAINTENANCE)

-- Data Standardization & Consistency

select Distinct cat
from bronze.erp_px_cat_g1v2
