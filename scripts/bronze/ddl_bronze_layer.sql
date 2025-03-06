use DataWarehouse
go

if object_id('bronze.crm_cust_info','U') is not null
	drop table bronze.crm_cust_info
create table bronze.crm_cust_info(
	cst_id int,	
	cst_key nvarchar(30),	
	cst_firstname nvarchar(30) ,	
	cst_lastname nvarchar(30),	
	cst_marital_status nvarchar(30),	
	cst_gndr nvarchar(30),	
	cst_create_date date
)
go

if object_id('bronze.crm_prd_info','U') is not null
	drop table bronze.crm_prd_info
create table bronze.crm_prd_info(
	prd_id int,	
	prd_key nvarchar(30),	
	prd_nm nvarchar(30),	
	prd_cost int,	
	prd_line nvarchar(30),	
	prd_start_dt datetime,	
	prd_end_dt datetime

)
go

if object_id('bronze.crm_sales_details','U') is not null
	drop table bronze.crm_sales_details
create table bronze.crm_sales_details(
	sls_ord_num nvarchar(30),	
	sls_prd_key nvarchar(30),	
	sls_cust_id int,
	sls_order_dt int,
	sls_ship_dt int,
	sls_due_dt int,
	sls_sales int,
	sls_quantity int,
	sls_price int
)
go

if object_id('bronze.erp_loc_a101','U') is not null
	drop table bronze.erp_loc_a101

create table bronze.erp_loc_a101(
	CID nvarchar(30),
	CNTRY nvarchar(30)
)
go
if object_id('bronze.erp_cust_az12','U') is not null
	drop table bronze.erp_cust_az12

create table bronze.erp_cust_az12(
	CID nvarchar(30),	
	BDATE datetime,	
	GEN nvarchar(30)

)
go
if object_id('bronze.erp_px_cat_g1v2','U') is not null
	drop table bronze.erp_px_cat_g1v2

create table bronze.erp_px_cat_g1v2(
	ID nvarchar(30),	
	CAT nvarchar(30),	
	SUBCAT nvarchar(30),	
	MAINTENANCE nvarchar(30)

)
go
