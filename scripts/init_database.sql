/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
	Đoạn script này dùng để tạo database 'DataWarehouse' sau khi kiểm tra nó có tồn tại hay không.
	Nếu database này tồn tại thì nó sẽ bị drop và tạo lại. Thêm vào đó đoạn script sẽ cài đặt 3 schemas 
	trong database: 'bronze', 'silver', và 'gold'.
	
WARNING: 
	Chạy script này sẽ drop toàn bộ 'DataWarehouse' database nếu nó tồn tại.
	Toàn bộ dữ liệu trong database sẽ bị xóa. Điều này có thể dẫn đến rủi ro, do đó hãy chắc chắn bạn đã 
	có dữ liệu backup trước khi chạy cái script này.
    
*/

USE master;
GO

-- Drop and recreate the 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END;
GO

-- Create the 'DataWarehouse' database
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

-- Create Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO	
