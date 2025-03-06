/*
	Know more about the business, choose the suit data model
	DATA INTEGRATION from silver layer

*/


Select cst_id, count(*)
from
(select 
ci.cst_id,
ci.cst_key,
ci.cst_firstname,
ci.cst_lastname,
ci.cst_marital_status,
ci.cst_gndr,
ca.BDATE,
ca.GEN
from silver.crm_cust_info ci
left join silver.erp_cust_az12 ca on ci.cst_key = ca.CID
left join silver.erp_loc_a101 la on la.CID = ci.cst_key) as t
group by cst_id
having COUNT(*) > 1 --after joining table, check if any duplicates were introduce by the join logic


select distinct
ci.cst_gndr,
ca.GEN,
case when ci.cst_gndr != 'n/a' then ci.cst_gndr -- CRM is the Master for gende info
	 else COALESCE(ca.gen,'n/a')
end as new_gen
from silver.crm_cust_info ci
left join silver.erp_cust_az12 ca on ci.cst_key = ca.CID
left join silver.erp_loc_a101 la on la.CID = ci.cst_key
order by 1,2

/*
Product

*/

select prd_key, count(*) from(
select 
pr.prd_id,
pr.cat_id,
pr.prd_key,
pr.prd_nm,
pr.prd_cost,
pr.prd_line,
pr.prd_start_dt,
pc.CAT,
pc.SUBCAT,
pc.MAINTENANCE
from silver.crm_prd_info pr
left join silver.erp_px_cat_g1v2 pc on pc.ID = pr.cat_id
where pr.prd_end_dt is null -- filter out all historical data
-- if End date is null then it is current info of the product!
) as t group by prd_key
having count(*)>1


select * from silver.crm_sales_details

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


-- foreign key integrity (Dimensions)
select *
from gold.fact_sales f
left join gold.dim_customes c on c.customer_key = f.customer_key
left join gold.dim_products p on p.product_key = f.product_key
where c.customer_key is null
