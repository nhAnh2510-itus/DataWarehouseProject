# 📊 Data Warehouse & Analytics Project

Chào mừng đến với kho lưu trữ **Dự án Kho Dữ liệu & Phân Tích**! 🚀  
Dự án này trình bày một giải pháp toàn diện về kho dữ liệu và phân tích, từ việc xây dựng kho dữ liệu đến tạo ra những thông tin có thể hành động. Được thiết kế như một **dự án portfolio**, nó làm nổi bật các phương pháp tốt nhất trong ngành về kỹ thuật dữ liệu và phân tích.  

---

## 🏗️ Kiến Trúc Dữ Liệu  

Dự án tuân theo **Kiến trúc Medallion**, bao gồm ba lớp chính:  

- **Lớp Đồng (Bronze):** Lưu trữ dữ liệu thô nguyên bản từ các hệ thống nguồn. Dữ liệu được nhập từ tệp CSV vào **SQL Server**.  
- **Lớp Bạc (Silver):** Làm sạch, chuẩn hóa và biến đổi dữ liệu để chuẩn bị cho phân tích.  
- **Lớp Vàng (Gold):** Chứa dữ liệu đã được mô hình hóa và sẵn sàng cho báo cáo, phân tích kinh doanh.  

---

## 📖 Tổng Quan Dự Án  

Dự án này bao gồm:  

✔ **Kiến trúc Dữ liệu:** Thiết kế kho dữ liệu hiện đại với mô hình **Medallion**.  
✔ **Quy trình ETL:** Trích xuất, chuyển đổi và tải dữ liệu từ hệ thống nguồn vào kho dữ liệu.  
✔ **Mô hình hóa Dữ liệu:** Xây dựng bảng **fact** và **dimension** tối ưu hóa cho truy vấn phân tích.  
✔ **Phân tích & Báo cáo:** Tạo các báo cáo và dashboard bằng SQL để cung cấp thông tin hữu ích.  

---

## 🛠️ Công Cụ & Tài Nguyên  

- **Bộ dữ liệu:** Các tệp CSV dùng trong dự án.  
- **SQL Server Express:** Hệ quản trị cơ sở dữ liệu.  
- **SQL Server Management Studio (SSMS):** Công cụ GUI để quản lý và thao tác dữ liệu.  
- **Git Repository:** Lưu trữ và quản lý mã nguồn dự án.  

---

## 🚀 Yêu Cầu Dự Án  

### **Xây dựng Kho Dữ Liệu (Data Engineering)**  

#### 🎯 **Mục Tiêu**  
Phát triển một **kho dữ liệu hiện đại** bằng **SQL Server**, tập trung vào dữ liệu bán hàng để hỗ trợ báo cáo phân tích và ra quyết định kinh doanh.  

#### 📌 **Thông Số Kỹ Thuật**  
✅ **Nguồn Dữ Liệu:** Nhập dữ liệu từ **ERP & CRM**, được cung cấp dưới dạng **tệp CSV**.  
✅ **Chất Lượng Dữ Liệu:** Làm sạch và xử lý lỗi dữ liệu trước khi phân tích.  
✅ **Tích Hợp:** Kết hợp hai nguồn dữ liệu vào **một mô hình duy nhất**, tối ưu cho truy vấn phân tích.  
✅ **Phạm Vi:** Chỉ tập trung vào dữ liệu **mới nhất**, không yêu cầu lịch sử hóa dữ liệu.  
✅ **Tài Liệu:** Cung cấp tài liệu mô hình dữ liệu hỗ trợ **doanh nghiệp & nhóm phân tích**.  

---  
