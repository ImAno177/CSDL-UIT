﻿-- 1.	Nhập dữ liệu cho các quan hệ trên.
SET DATEFORMAT DMY;
USE QUANLYBANHANG
GO

-------------------------------- KHACHHANG --------------------------------------------
INSERT INTO KHACHHANG(MAKH, HOTEN, DCHI, SODT, NGSINH, DOANHSO, NGDK) 
VALUES
('KH01', 'Nguyen Van A', '731 Tran Hung Dao,  Q5,  TpHCM', '08823451', '22/10/1960', '13060000', '22/07/2006'),
('KH02', 'Tran Ngoc Han', '23/5 Nguyen Trai,  Q5, TpHCM', '0908256478', '03/04/1974', '280000', '30/07/2006'),
('KH03', 'Tran Ngoc Linh', '45 Nguyen Canh Chan,  Q1,  TpHCM', '0938776266', '12/06/1980', '3860000', '05/08/2006'),
('KH04', 'Tran Minh Long', '50/34 Le Dai Hanh,  Q10,  TpHCM', '0917325476', '09/03/1965', '250000', '02/10/2006'),
('KH05', 'Le Nhat Minh', '34 Truong Dinh,  Q3,  TpHCM', '08246108', '10/03/1950', '21000', '28/10/2006'),
('KH06', 'Le Hoai Thuong', '227 Nguyen Van Cu,  Q5,  TpHCM', '08631738', '31/12/1981', '915000', '24/11/2006'),
('KH07', 'Nguyen Van Tam', '32/3 Tran Binh Trong,  Q5,  TpHCM', '0916783565', '06/04/1971', '12500', '01/12/2006'),
('KH08', 'Phan Thi Thanh', '45/2 An Duong Vuong,  Q5,  TpHCM', '0938435756', '10/01/1971', '365000', '13/12/2006'),
('KH09', 'Le Ha Vinh', '873 Le Hong Phong,  Q5,  TpHCM', '08654763', '03/09/1979', '70000', '14/01/2007'),
('KH10', 'Ha Duy Lap', '34/34B Nguyen Trai,  Q1,  TpHCM', '08768904', '02/05/1983', '675000', '16/01/2007')
GO

--------------------------------- NHANVIEN --------------------------------------------
INSERT INTO NHANVIEN(MANV, HOTEN, SODT, NGVL) 
VALUES
('NV01', 'Nguyen Nhu Nhut', '0927345678', '13/04/2006'),
('NV02', 'Le Thi Phi Yen', '0987567390', '21/04/2006'),
('NV03', 'Nguyen Van B', '0997047382', '27/04/2006'),
('NV04', 'Ngo Thanh Tuan', '0913758498', '24/06/2006'),
('NV05', 'Nguyen Thi Truc Thanh', '0918590387', '20/07/2006')
GO

--------------------------------- SANPHAM ---------------------------------------------
INSERT INTO SANPHAM(MASP, TENSP, DVT, NUOCSX, GIA) 
VALUES
('BC01', 'But chi', 'cay', 'Singapore', '3000'),
('BC02', 'But chi', 'cay', 'Singapore', '5000'),
('BC03', 'But chi', 'cay', 'Viet Nam', '3500'),
('BC04', 'But chi', 'hop', 'Viet Nam', '30000'),
('BB01', 'But bi', 'cay', 'Viet Nam', '5000'),
('BB02', 'But bi', 'cay', 'Trung Quoc', '5000'),
('BB03', 'But bi', 'hop', 'Thai Lan', '100000'),
('TV01', 'Tap 100 giay mong', 'quyen', 'Trung Quoc', '2500'),
('TV02', 'Tap 200 giay mong', 'quyen', 'Trung Quoc', '4500'),
('TV03', 'Tap 100 giay tot', 'quyen', 'Viet Nam', '3000'),
('TV04', 'Tap 200 giay tot', 'quyen', 'Viet Nam', '5500'),
('TV05', 'Tap 100 trang', 'chuc', 'Viet Nam', '23000'),
('TV06', 'Tap 200 trang', 'chuc', 'Viet Nam', '53000'),
('TV07', 'Tap 100 trang', 'chuc', 'Trung Quoc', '34000'),
('ST01', 'So tay 500 trang', 'quyen', 'Trung Quoc', '40000'),
('ST02', 'So tay loai 1', 'quyen', 'Viet Nam', '55000'),
('ST03', 'So tay loai 2', 'quyen', 'Viet Nam', '51000'),
('ST04', 'So tay', 'quyen', 'Thai Lan', '55000'),
('ST05', 'So tay mong', 'quyen', 'Thai Lan', '20000'),
('ST06', 'Phan viet bang', 'hop', 'Viet Nam', '5000'),
('ST07', 'Phan khong bui', 'hop', 'Viet Nam', '7000'),
('ST08', 'Bong bang', 'cai', 'Viet Nam', '5000'),
('ST09', 'But long', 'cay', 'Viet Nam', '5000'),
('ST10', 'But long', 'cay', 'Trung Quoc', '7000')
GO

---------------------------------- HOADON ---------------------------------------------
INSERT INTO HOADON(SOHD, NGHD, MAKH, MANV, TRIGIA) 
VALUES
('1001', '23/07/2006', 'KH01', 'NV01', '320000'),
('1002', '12/08/2006', 'KH01', 'NV02', '840000'),
('1003', '23/08/2006', 'KH02', 'NV01', '100000'),
('1004', '01/09/2006', 'KH02', 'NV01', '180000'),
('1005', '20/10/2006', 'KH01', 'NV02', '3800000'),
('1006', '16/10/2006', 'KH01', 'NV03', '2430000'),
('1007', '28/10/2006', 'KH03', 'NV03', '510000'),
('1008', '28/10/2006', 'KH01', 'NV03', '440000'),
('1009', '28/10/2006', 'KH03', 'NV04', '200000'),
('1010', '01/11/2006', 'KH01', 'NV01', '5200000'),
('1011', '04/11/2006', 'KH04', 'NV03', '250000'),
('1012', '30/11/2006', 'KH05', 'NV03', '21000'),
('1013', '12/12/2006', 'KH06', 'NV01', '5000'),
('1014', '31/12/2006', 'KH03', 'NV02', '3150000'),
('1015', '01/01/2007', 'KH06', 'NV02', '910000'),
('1016', '01/01/2007', 'KH07', 'NV02', '12500'),
('1017', '02/01/2007', 'KH08', 'NV03', '35000'),
('1018', '13/01/2007', 'KH01', 'NV03', '330000'),
('1019', '13/01/2007', 'KH01', 'NV03', '30000'),
('1020', '14/01/2007', 'KH09', 'NV04', '70000'),
('1021', '16/01/2007', 'KH10', 'NV03', '67500'),
('1022', '16/01/2007',  NULL, 'NV03', '7000'),
('1023', '17/01/2007',  NULL, 'NV01', '330000')
GO

----------------------------------- CTHD ----------------------------------------------
INSERT INTO CTHD(SOHD, MASP, SL) 
VALUES
('1001', 'TV02', '10'),
('1001', 'ST01', '5'),
('1001', 'BC01', '5'),
('1001', 'BC02', '10'),
('1001', 'ST08', '10'),
('1001', 'BC04', '20'),
('1002', 'BB01', '20'),
('1002', 'BB02', '20'),
('1003', 'BB03', '10'),
('1004', 'TV01', '20'),
('1004', 'TV02', '10'),
('1004', 'TV03', '10'),
('1004', 'TV04', '10'),
('1005', 'TV05', '50'),
('1005', 'TV06', '50'),
('1006', 'TV07', '20'),
('1006', 'ST01', '30'),
('1006', 'ST02', '10'),
('1007', 'ST03', '10'),
('1008', 'ST04', '8'),
('1009', 'ST05', '10'),
('1010', 'TV07', '50'),
('1010', 'ST07', '50'),
('1010', 'ST08', '100'),
('1010', 'ST04', '50'),
('1010', 'TV03', '100'),
('1011', 'ST06', '50'),
('1012', 'ST07', '3'),
('1013', 'ST08', '5'),
('1014', 'BC02', '80'),
('1014', 'BB02', '100'),
('1014', 'BC04', '60'),
('1014', 'BB01', '50'),
('1015', 'BB02', '30'),
('1015', 'BB03', '7'),
('1016', 'TV01', '5'),
('1017', 'TV02', '1'),
('1017', 'TV03', '1'),
('1017', 'TV04', '5'),
('1018', 'ST04', '6'),
('1019', 'ST05', '1'),
('1019', 'ST06', '2'),
('1020', 'ST07', '10'),
('1021', 'ST08', '5'),
('1021', 'TV01', '7'),
('1021', 'TV02', '10'),
('1022', 'ST07', '1'),
('1023', 'ST04', '6')
GO

-- 2.	Tạo quan hệ SANPHAM1 chứa toàn bộ dữ liệu của quan hệ SANPHAM. Tạo quan hệ KHACHHANG1 chứa toàn bộ dữ liệu của quan hệ KHACHHANG.
SELECT * INTO SANPHAM1 FROM SANPHAM
SELECT * INTO KHACHHANG1 FROM KHACHHANG

GO

-- 3.	Cập nhật giá tăng 5% đối với những sản phẩm do “Thai Lan” sản xuất (cho quan hệ SANPHAM1)
UPDATE SANPHAM1 SET GIA += GIA * 0.05 
WHERE NUOCSX = 'Thai Lan' 
GO

-- 4.	Cập nhật giá giảm 5% đối với những sản phẩm do “Trung Quoc” sản xuất có giá từ 10.000 trở xuống (cho quan hệ SANPHAM1).
UPDATE SANPHAM1 SET GIA -= GIA * 0.05 
WHERE NUOCSX = 'Trung Quoc' AND GIA <= 10000
GO

/* 5.	Cập nhật giá trị LOAIKH là “Vip” đối với những khách hàng đăng ký thành viên trước ngày 1/1/2007 có doanh số từ 
10.000.000 trở lên hoặc khách hàng đăng ký thành viên từ 1/1/2007 trở về sau có doanh số từ 2.000.000 trở lên (cho quan hệ KHACHHANG1) */
UPDATE KHACHHANG1 SET LOAIKH = 'VIP' 
WHERE (NGDK < '1/1/2007' AND DOANHSO >= 10000000) OR (NGDK > '1/1/2007' AND DOANHSO >= 2000000)
GO

-- III. Ngôn ngữ truy vấn dữ liệu có cấu trúc:
-- 1.	In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất.
SELECT MASP, TENSP FROM SANPHAM 
WHERE NUOCSX = 'Trung Quoc'
GO

-- 2.	In ra danh sách các sản phẩm (MASP,TENSP) có đơn vị tính là “cay”, ”quyen”.
SELECT MASP, TENSP FROM SANPHAM 
WHERE DVT IN ('cay', 'quyen')
GO

-- 3.	In ra danh sách các sản phẩm (MASP,TENSP) có mã sản phẩm bắt đầu là “B” và kết thúc là “01”.
SELECT MASP, TENSP FROM SANPHAM 
WHERE LEFT(MASP, 1) = 'B' AND RIGHT(MASP, 2) = '01'
GO

-- 4.	In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quốc” sản xuất có giá từ 30.000 đến 40.000.
SELECT MASP, TENSP FROM SANPHAM 
WHERE NUOCSX = 'Trung Quoc' AND GIA BETWEEN 30000 AND 40000
GO

-- 5.	In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” hoặc “Thai Lan” sản xuất có giá từ 30.000 đến 40.000.
SELECT MASP,TENSP FROM SANPHAM 
WHERE (NUOCSX IN ('Trung Quoc', 'Thai Lan') AND (GIA BETWEEN 30000 AND 40000))
GO

-- 6.	In ra các số hóa đơn, trị giá hóa đơn bán ra trong ngày 1/1/2007 và ngày 2/1/2007.
SELECT SOHD, TRIGIA FROM HOADON 
WHERE NGHD IN ('1/1/2007', '2/1/2007')
GO

-- 7.	In ra các số hóa đơn, trị giá hóa đơn trong tháng 1/2007, sắp xếp theo ngày (tăng dần) và trị giá của hóa đơn (giảm dần).
SELECT SOHD, TRIGIA FROM HOADON 
WHERE YEAR(NGHD) = 2007 AND MONTH(NGHD) = 1 
ORDER BY NGHD ASC, TRIGIA DESC
GO

-- 8.	In ra danh sách các khách hàng (MAKH, HOTEN) đã mua hàng trong ngày 1/1/2007.
SELECT HD.MAKH, HOTEN 
FROM HOADON HD INNER JOIN KHACHHANG KH 
ON HD.MAKH = KH.MAKH 
WHERE NGHD = '1/1/2007'
GO

-- 9.	In ra số hóa đơn, trị giá các hóa đơn do nhân viên có tên “Nguyen Van B” lập trong ngày 28/10/2006.
SELECT HD.SOHD, TRIGIA 
FROM HOADON HD INNER JOIN NHANVIEN NV 
ON HD.MANV = NV.MANV 
WHERE HOTEN = 'Nguyen Van B' AND NGHD = '28/10/2006'
GO

-- 10.	In ra danh sách các sản phẩm (MASP,TENSP) được khách hàng có tên “Nguyen Van A” mua trong tháng 10/2006.
SELECT CT.MASP, TENSP 
FROM CTHD CT INNER JOIN SANPHAM SP 
ON CT.MASP = SP.MASP
WHERE SOHD IN (
	SELECT SOHD 
	FROM HOADON HD INNER JOIN KHACHHANG KH 
	ON HD.MAKH = KH.MAKH
	WHERE HOTEN = 'Nguyen Van A' AND YEAR(NGHD) = 2006 AND MONTH(NGHD) = 10 
)
GO

-- 11.	Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”.
SELECT SOHD FROM CTHD WHERE MASP = 'BB01' 
UNION
SELECT SOHD FROM CTHD WHERE MASP = 'BB02' 
GO

-------------------------------- QUANLYHOCVU ------------------------------------------

-- I. Ngôn ngữ định nghĩa dữ liệu (Data Definition Language):
USE QUANLYHOCVU
-- 11.	Học viên ít nhất là 18 tuổi.
ALTER TABLE HOCVIEN ADD CONSTRAINT CK_TUOI CHECK(GETDATE() - NGSINH >= 18)
GO

-- 12.	Giảng dạy một môn học ngày bắt đầu (TUNGAY) phải nhỏ hơn ngày kết thúc (DENNGAY).
ALTER TABLE GIANGDAY ADD CONSTRAINT CK_NGAY CHECK(TUNGAY < DENNGAY)
GO

-- 13.	Giáo viên khi vào làm ít nhất là 22 tuổi.
ALTER TABLE GIAOVIEN ADD CONSTRAINT CK_NGVL CHECK(GETDATE() - NGVL >= 22)
GO

-- 14.	Tất cả các môn học đều có số tín chỉ lý thuyết và tín chỉ thực hành chênh lệch nhau không quá 3.
ALTER TABLE MONHOC ADD CONSTRAINT CK_TC CHECK(ABS(TCLT - TCTH) <= 3)
GO

----------------------------------- KHOA ----------------------------------------------

INSERT KHOA (MAKHOA, TENKHOA, NGTLAP, TRGKHOA) 
VALUES 
(N'KHMT', N'Khoa hoc may tinh', CAST(N'2005-06-07T00:00:00.000' AS DateTime), NULL),
(N'HTTT', N'He thong thong tin', CAST(N'2005-06-07T00:00:00.000' AS DateTime), NULL),
(N'CNPM', N'Cong nghe phan mem', CAST(N'2005-06-07T00:00:00.000' AS DateTime), NULL),
(N'MTT', N'Mang va truyen thong', CAST(N'2005-10-20T00:00:00.000' AS DateTime), NULL),
(N'KTMT', N'Ky thuat may tinh', CAST(N'2005-12-20T00:00:00.000' AS DateTime), NULL)
GO

---------------------------------- MONHOC ---------------------------------------------
INSERT MONHOC (MAMH, TENMH, TCLT, TCTH, MAKHOA) 
VALUES 
(N'THDC', N'Tin hoc dai cuong', 4, 1, N'KHMT'),
(N'CTRR', N'Cau truc roi rac', 5, 0, N'KHMT'),
(N'CSDL', N'Co so du lieu', 3, 1, N'HTTT'),
(N'CTDLGT', N'Cau truc du lieu va giai thuat', 3, 1, N'KHMT'),
(N'PTTKTT', N'Phan tich thiet ke thuat toan', 3, 0, N'KHMT'),
(N'DHMT', N'Do hoa may tinh', 3, 1, N'KHMT'),
(N'KTMT', N'Kien truc may tinh', 3, 0, N'KTMT'),
(N'TKCSDL', N'Thiet ke co so du lieu', 3, 1, N'HTTT'),
(N'PTTKHTTT', N'Phan tich thiet ke he thong thong tin', 4, 1, N'HTTT'),
(N'HDH', N'He dieu hanh', 4, 0, N'KTMT'),
(N'NMCNPM', N'Nhap mon cong nghe phan mem', 3, 0, N'CNPM'),
(N'LTCFW', N'Lap trinh C for win', 3, 1, N'CNPM'),
(N'LTHDT', N'Lap trinh huong doi tuong', 3, 1, N'CNPM')
GO

--------------------------------- DIEUKIEN --------------------------------------------
INSERT DIEUKIEN (MAMH, MAMH_TRUOC) 
VALUES 
(N'CSDL', N'CTRR'),
(N'CSDL', N'CTDLGT'),
(N'CTDLGT', N'THDC'),
(N'PTTKTT', N'THDC'),
(N'PTTKTT', N'CTDLGT'),
(N'DHMT', N'THDC'),
(N'LTHDT', N'THDC'),
(N'PTTKHTTT', N'CSDL')
GO

--------------------------------- GIAOVIEN --------------------------------------------

INSERT GIAOVIEN (MAGV, HOTEN, HOCVI, HOCHAM, GIOITINH, NGSINH, NGVL, HESO, MUCLUONG, MAKHOA) 
VALUES 
(N'GV01', N'Ho Thanh Son', N'PTS', N'GS', N'Nam', CAST(N'1950-05-02T00:00:00.000' AS DateTime), CAST(N'2004-01-11T00:00:00.000' AS DateTime), 5, 2250000, NULL),
(N'GV02', N'Tran Tam Thanh', N'TS', N'PGS', N'Nam', CAST(N'1965-12-17T00:00:00.000' AS DateTime), CAST(N'2004-04-20T00:00:00.000' AS DateTime), 4.5, 2025000, NULL),
(N'GV03', N'Do Nghiem Phung', N'TS', N'GS', N'Nu', CAST(N'1950-08-01T00:00:00.000' AS DateTime), CAST(N'2004-09-23T00:00:00.000' AS DateTime), 4, 1800000, NULL),
(N'GV04', N'Tran Nam Son', N'TS', N'PGS', N'Nam', CAST(N'1961-02-22T00:00:00.000' AS DateTime), CAST(N'2005-01-12T00:00:00.000' AS DateTime), 4.5, 2025000, NULL),
(N'GV05', N'Mai Thanh Danh', N'ThS', N'GV', N'Nam', CAST(N'1958-03-12T00:00:00.000' AS DateTime), CAST(N'2005-01-12T00:00:00.000' AS DateTime), 3, 1350000, NULL),
(N'GV06', N'Tran Doan Hung', N'TS', N'GV', N'Nam', CAST(N'1953-03-11T00:00:00.000' AS DateTime), CAST(N'2005-01-12T00:00:00.000' AS DateTime), 4.5, 2025000, NULL),
(N'GV07', N'Nguyen Minh Tien', N'ThS', N'GV', N'Nam', CAST(N'1971-11-23T00:00:00.000' AS DateTime), CAST(N'2005-03-01T00:00:00.000' AS DateTime), 4, 1800000, NULL),
(N'GV08', N'Le Thi Tran', N'KS', N'Null', N'Nu', CAST(N'1974-03-26T00:00:00.000' AS DateTime), CAST(N'2005-03-01T00:00:00.000' AS DateTime), 1.69, 760500, NULL),
(N'GV09', N'Nguyen To Lan', N'ThS', N'GV', N'Nu', CAST(N'1966-12-31T00:00:00.000' AS DateTime), CAST(N'2005-03-01T00:00:00.000' AS DateTime), 4, 1800000, NULL),
(N'GV10', N'Le Tran Anh Loan', N'KS', N'Null', N'Nu', CAST(N'1972-07-17T00:00:00.000' AS DateTime), CAST(N'2005-03-01T00:00:00.000' AS DateTime), 1.86, 837000, NULL),
(N'GV11', N'Ho Thanh Tung', N'CN', N'GV', N'Nam', CAST(N'1980-01-12T00:00:00.000' AS DateTime), CAST(N'2005-05-15T00:00:00.000' AS DateTime), 2.67, 1201500, NULL),
(N'GV12', N'Tran Van Anh', N'CN', N'Null', N'Nu', CAST(N'1981-03-29T00:00:00.000' AS DateTime), CAST(N'2005-05-15T00:00:00.000' AS DateTime), 1.69, 760500, NULL),
(N'GV13', N'Nguyen Linh Dan', N'CN', N'Null', N'Nu', CAST(N'1980-05-23T00:00:00.000' AS DateTime), CAST(N'2005-05-15T00:00:00.000' AS DateTime), 1.69, 760500, NULL),
(N'GV14', N'Truong Minh Chau', N'ThS', N'GV', N'Nu', CAST(N'1976-11-30T00:00:00.000' AS DateTime), CAST(N'2005-05-15T00:00:00.000' AS DateTime), 3, 1350000, NULL),
(N'GV15', N'Le Ha Thanh', N'ThS', N'GV', N'Nam', CAST(N'1978-05-04T00:00:00.000' AS DateTime), CAST(N'2005-05-15T00:00:00.000' AS DateTime), 3, 1350000, NULL)
GO

----------------------------------- LOP -----------------------------------------------
INSERT LOP (MALOP, TENLOP, TRGLOP, SISO, MAGVCN) 
VALUES 
(N'K11', N'Lop 1 khoa 1', N'K1108', 11, N'GV07'),
(N'K12', N'Lop 2 khoa 1', N'K1205', 12, N'GV09'),
(N'K13', N'Lop 3 khoa 1', N'K1305', 12, N'GV14')
GO

--------------------------------- HOCVIEN ---------------------------------------------
INSERT HOCVIEN (MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALOP) 
VALUES
(N'K1101', N'Nguyen Van', N'A', CAST(N'1986-01-27T00:00:00.000' AS DateTime), N'Nam', N'TpHCM', N'K11'),
(N'K1102', N'Tran Ngoc', N'Han', CAST(N'1986-03-14T00:00:00.000' AS DateTime), N'Nu', N'Kien Giang', N'K11'),
(N'K1103', N'Ha Duy', N'Lap', CAST(N'1986-04-18T00:00:00.000' AS DateTime), N'Nam', N'Nghe An', N'K11'),
(N'K1104', N'Tran Ngoc', N'Linh', CAST(N'1986-03-30T00:00:00.000' AS DateTime), N'Nu', N'Tay Ninh', N'K11'),
(N'K1105', N'Tran Minh', N'Long', CAST(N'1986-02-27T00:00:00.000' AS DateTime), N'Nam', N'TpHCM', N'K11'),
(N'K1106', N'Le Nhat', N'Minh', CAST(N'1986-01-24T00:00:00.000' AS DateTime), N'Nam', N'TpHCM', N'K11'),
(N'K1107', N'Nguyen Nhu', N'Nhut', CAST(N'1986-01-27T00:00:00.000' AS DateTime), N'Nam', N'Ha Noi', N'K11'),
(N'K1108', N'Nguyen Manh', N'Tam', CAST(N'1986-02-27T00:00:00.000' AS DateTime), N'Nam', N'Kien Giang', N'K11'),
(N'K1109', N'Phan Thi Thanh', N'Tam', CAST(N'1986-01-27T00:00:00.000' AS DateTime), N'Nu', N'Vinh Long', N'K11'),
(N'K1110', N'Le Hoai', N'Thuong', CAST(N'1986-02-05T00:00:00.000' AS DateTime), N'Nu', N'Can Tho', N'K11'),
(N'K1111', N'Le Ha', N'Vinh', CAST(N'1986-12-25T00:00:00.000' AS DateTime), N'Nam', N'Vinh Long', N'K11'),
(N'K1201', N'Nguyen Van', N'B', CAST(N'1986-02-11T00:00:00.000' AS DateTime), N'Nam', N'TpHCM', N'K12'),
(N'K1202', N'Nguyen Thi Kim', N'Duyen', CAST(N'1986-01-18T00:00:00.000' AS DateTime), N'Nu', N'TpHCM', N'K12'),
(N'K1203', N'Tran Thi Kim', N'Duyen', CAST(N'1986-09-17T00:00:00.000' AS DateTime), N'Nu', N'TpHCM', N'K12'),
(N'K1204', N'Truong My', N'Hanh', CAST(N'1986-05-19T00:00:00.000' AS DateTime), N'Nu', N'Dong Nai', N'K12'),
(N'K1205', N'Nguyen Thanh', N'Nam', CAST(N'1986-04-17T00:00:00.000' AS DateTime), N'Nam', N'TpHCM', N'K12'),
(N'K1206', N'Nguyen Thi Truc', N'Thanh', CAST(N'1986-03-04T00:00:00.000' AS DateTime), N'Nu', N'Kien Giang', N'K12'),
(N'K1207', N'Tran Thi Bich', N'Thuy', CAST(N'1986-02-08T00:00:00.000' AS DateTime), N'Nu', N'Nghe An', N'K12'),
(N'K1208', N'Huynh Thi Kim', N'Trieu', CAST(N'1986-04-08T00:00:00.000' AS DateTime), N'Nu', N'Tay Ninh', N'K12'),
(N'K1209', N'Pham Thanh', N'Trieu', CAST(N'1986-02-23T00:00:00.000' AS DateTime), N'Nam', N'TpHCM', N'K12'),
(N'K1210', N'Ngo Thanh', N'Tuan', CAST(N'1986-02-14T00:00:00.000' AS DateTime), N'Nam', N'TpHCM', N'K12'),
(N'K1211', N'Do Thi', N'Xuan', CAST(N'1986-03-09T00:00:00.000' AS DateTime), N'Nu', N'Ha Noi', N'K12'),
(N'K1212', N'Le Thi Phi', N'Yen', CAST(N'1986-03-12T00:00:00.000' AS DateTime), N'Nu', N'TpHCM', N'K12'),
(N'K1301', N'Nguyen Thi Kim', N'Cuc', CAST(N'1986-06-09T00:00:00.000' AS DateTime), N'Nu', N'Kien Giang', N'K13'),
(N'K1302', N'Truong Thi My', N'Hien', CAST(N'1986-03-18T00:00:00.000' AS DateTime), N'Nu', N'Nghe An', N'K13'),
(N'K1303', N'Le Duc', N'Hien', CAST(N'1986-03-21T00:00:00.000' AS DateTime), N'Nam', N'Tay Ninh', N'K13'),
(N'K1304', N'Le Quang', N'Hien', CAST(N'1986-04-18T00:00:00.000' AS DateTime), N'Nam', N'TpHCM', N'K13'),
(N'K1305', N'Le Thi', N'Huong', CAST(N'1986-03-27T00:00:00.000' AS DateTime), N'Nu', N'TpHCM', N'K13'),
(N'K1306', N'Nguyen Thai', N'Huu', CAST(N'1986-03-30T00:00:00.000' AS DateTime), N'Nam', N'Ha Noi', N'K13'),
(N'K1307', N'Tran Minh', N'Man', CAST(N'1986-05-28T00:00:00.000' AS DateTime), N'Nam', N'TpHCM', N'K13'),
(N'K1308', N'Nguyen Hieu', N'Nghia', CAST(N'1986-04-08T00:00:00.000' AS DateTime), N'Nam', N'Kien Giang', N'K13'),
(N'K1309', N'Nguyen Trung', N'Nghia', CAST(N'1987-01-18T00:00:00.000' AS DateTime), N'Nam', N'Nghe An', N'K13'),
(N'K1310', N'Tran Thi Hong', N'Tham', CAST(N'1986-04-22T00:00:00.000' AS DateTime), N'Nu', N'Tay Ninh', N'K13'),
(N'K1311', N'Tran Minh', N'Thuc', CAST(N'1986-04-04T00:00:00.000' AS DateTime), N'Nam', N'TpHCM', N'K13'),
(N'K1312', N'Nguyen Thi Kim', N'Yen', CAST(N'1986-09-07T00:00:00.000' AS DateTime), N'Nu', N'TpHCM', N'K13')
GO

--------------------------------- GIANGDAY --------------------------------------------
INSERT GIANGDAY (MALOP, MAMH, MAGV, HOCKY, NAM, TUNGAY, DENNGAY) 
VALUES 
(N'K11', N'THDC', N'GV07', 1, 2006, CAST(N'2006-01-02T00:00:00.000' AS DateTime), CAST(N'2006-05-12T00:00:00.000' AS DateTime)),
(N'K12', N'THDC', N'GV06', 1, 2006, CAST(N'2006-01-02T00:00:00.000' AS DateTime), CAST(N'2006-05-12T00:00:00.000' AS DateTime)),
(N'K13', N'THDC', N'GV15', 1, 2006, CAST(N'2006-01-02T00:00:00.000' AS DateTime), CAST(N'2006-05-12T00:00:00.000' AS DateTime)),
(N'K11', 'CTRR', N'GV02', 1, 2006, CAST(N'2006-01-09T00:00:00.000' AS DateTime), CAST(N'2006-05-17T00:00:00.000' AS DateTime)),
(N'K12', N'CTRR', N'GV02', 1, 2006, CAST(N'2006-01-09T00:00:00.000' AS DateTime), CAST(N'2006-05-17T00:00:00.000' AS DateTime)),
(N'K13', N'CTRR', N'GV08', 1, 2006, CAST(N'2006-01-09T00:00:00.000' AS DateTime), CAST(N'2006-05-17T00:00:00.000' AS DateTime)),
(N'K11', N'CSDL', N'GV05', 2, 2006, CAST(N'2006-06-01T00:00:00.000' AS DateTime), CAST(N'2006-07-15T00:00:00.000' AS DateTime)),
(N'K12', N'CSDL', N'GV09', 2, 2006, CAST(N'2006-06-01T00:00:00.000' AS DateTime), CAST(N'2006-07-15T00:00:00.000' AS DateTime)),
(N'K13', N'CTDLGT', N'GV15', 2, 2006, CAST(N'2006-06-01T00:00:00.000' AS DateTime), CAST(N'2006-07-15T00:00:00.000' AS DateTime)),
(N'K13', N'CSDL', N'GV05', 3, 2006, CAST(N'2006-08-01T00:00:00.000' AS DateTime), CAST(N'2006-12-15T00:00:00.000' AS DateTime)),
(N'K13', N'DHMT', N'GV07', 3, 2006, CAST(N'2006-08-01T00:00:00.000' AS DateTime), CAST(N'2006-12-15T00:00:00.000' AS DateTime)),
(N'K11', N'CTDLGT', N'GV15', 3, 2006, CAST(N'2006-08-01T00:00:00.000' AS DateTime), CAST(N'2006-12-15T00:00:00.000' AS DateTime)),
(N'K12', N'CTDLGT', N'GV15', 3, 2006, CAST(N'2006-08-01T00:00:00.000' AS DateTime), CAST(N'2006-12-15T00:00:00.000' AS DateTime)),
(N'K11', N'HDH', N'GV04', 1, 2007, CAST(N'2007-01-02T00:00:00.000' AS DateTime), CAST(N'2007-02-18T00:00:00.000' AS DateTime)),
(N'K12', N'HDH', N'GV04', 1, 2007, CAST(N'2007-01-02T00:00:00.000' AS DateTime), CAST(N'2007-03-20T00:00:00.000' AS DateTime)),
(N'K11', N'DHMT', N'GV07', 1, 2007, CAST(N'2007-02-18T00:00:00.000' AS DateTime), CAST(N'2007-03-20T00:00:00.000' AS DateTime)),
GO

--------------------------------- KETQUATHI -------------------------------------------
INSERT KETQUATHI (MAHV, MAMH, LANTHI, NGTHI, DIEM, KQUA) 
VALUES 
(N'K1101', N'CSDL', 1, CAST(N'2006-07-20T00:00:00.000' AS DateTime), 10, N'Dat'),
(N'K1101', N'CTDLGT', 1, CAST(N'2006-12-28T00:00:00.000' AS DateTime), 9, N'Dat'),
(N'K1101', N'THDC', 1, CAST(N'2006-05-20T00:00:00.000' AS DateTime), 9, N'Dat'),
(N'K1101', N'CTRR', 1, CAST(N'2006-05-13T00:00:00.000' AS DateTime), 9.5, N'Dat'),
(N'K1102', N'CSDL', 1, CAST(N'2006-07-20T00:00:00.000' AS DateTime), 4, N'Khong Dat'),
(N'K1102', N'CSDL', 2, CAST(N'2006-07-27T00:00:00.000' AS DateTime), 4.25, N'Khong Dat'),
(N'K1102', N'CSDL', 3, CAST(N'2006-08-10T00:00:00.000' AS DateTime), 4.5, N'Khong Dat'),
(N'K1102', N'CTDLGT', 1, CAST(N'2006-12-28T00:00:00.000' AS DateTime), 4.5, N'Khong Dat'),
(N'K1102', N'CTDLGT', 2, CAST(N'2007-01-05T00:00:00.000' AS DateTime), 4, N'Khong Dat'),
(N'K1102', N'CTDLGT', 3, CAST(N'2007-01-15T00:00:00.000' AS DateTime), 6, N'Dat'),
(N'K1102', N'THDC', 1, CAST(N'2006-05-20T00:00:00.000' AS DateTime), 5, N'Dat'),
(N'K1102', N'CTRR', 1, CAST(N'2006-05-13T00:00:00.000' AS DateTime), 7, N'Dat'),
(N'K1103', N'CSDL', 1, CAST(N'2006-07-20T00:00:00.000' AS DateTime), 3.5, N'Khong Dat'),
(N'K1103', N'CSDL', 2, CAST(N'2006-07-27T00:00:00.000' AS DateTime), 8.25, N'Dat'),
(N'K1103', N'CTDLGT', 1, CAST(N'2006-12-28T00:00:00.000' AS DateTime), 7, N'Dat'),
(N'K1103', N'THDC', 1, CAST(N'2006-05-20T00:00:00.000' AS DateTime), 8, N'Dat'),
(N'K1103', N'CTRR', 1, CAST(N'2006-05-13T00:00:00.000' AS DateTime), 6.5, N'Dat'),
(N'K1104', N'CSDL', 1, CAST(N'2006-07-20T00:00:00.000' AS DateTime), 3.75, N'Khong Dat'),
(N'K1104', N'CTDLGT', 1, CAST(N'2006-12-28T00:00:00.000' AS DateTime), 4, N'Khong Dat'),
(N'K1104', N'THDC', 1, CAST(N'2006-05-20T00:00:00.000' AS DateTime), 4, N'Khong Dat'),
(N'K1104', N'CTRR', 1, CAST(N'2006-05-13T00:00:00.000' AS DateTime), 4, N'Khong Dat'),
(N'K1104', N'CTRR', 2, CAST(N'2006-05-20T00:00:00.000' AS DateTime), 3.5, N'Khong Dat'),
(N'K1104', N'CTRR', 3, CAST(N'2006-06-30T00:00:00.000' AS DateTime), 4, N'Khong Dat'),
(N'K1201', N'CSDL', 1, CAST(N'2006-07-20T00:00:00.000' AS DateTime), 6, N'Dat'),
(N'K1201', N'CTDLGT', 1, CAST(N'2006-12-28T00:00:00.000' AS DateTime), 5, N'Dat'),
(N'K1201', N'THDC', 1, CAST(N'2006-05-20T00:00:00.000' AS DateTime), 8.5, N'Dat'),
(N'K1201', N'CTRR', 1, CAST(N'2006-05-13T00:00:00.000' AS DateTime), 9, N'Dat'),
(N'K1202', N'CSDL', 1, CAST(N'2006-07-20T00:00:00.000' AS DateTime), 8, N'Dat'),
(N'K1202', N'CTDLGT', 1, CAST(N'2006-12-28T00:00:00.000' AS DateTime), 4, N'Khong Dat'),
(N'K1202', N'CTDLGT', 2, CAST(N'2007-01-05T00:00:00.000' AS DateTime), 5, N'Dat'),
(N'K1202', N'THDC', 1, CAST(N'2006-05-20T00:00:00.000' AS DateTime), 4, N'Khong Dat'),
(N'K1202', N'THDC', 2, CAST(N'2006-05-27T00:00:00.000' AS DateTime), 4, N'Khong Dat'),
(N'K1202', N'CTRR', 1, CAST(N'2006-05-13T00:00:00.000' AS DateTime), 3, N'Khong Dat'),
(N'K1202', N'CTRR', 2, CAST(N'2006-05-20T00:00:00.000' AS DateTime), 4, N'Khong Dat'),
(N'K1202', N'CTRR', 3, CAST(N'2006-06-30T00:00:00.000' AS DateTime), 6.25, N'Dat'),
(N'K1203', N'CSDL', 1, CAST(N'2006-07-20T00:00:00.000' AS DateTime), 9.25, N'Dat'),
(N'K1203', N'CTDLGT', 1, CAST(N'2006-12-28T00:00:00.000' AS DateTime), 9.5, N'Dat'),
(N'K1203', N'THDC', 1, CAST(N'2006-05-20T00:00:00.000' AS DateTime), 10, N'Dat'),
(N'K1203', N'CTRR', 1, CAST(N'2006-05-13T00:00:00.000' AS DateTime), 10, N'Dat'),
(N'K1204', N'CSDL', 1, CAST(N'2006-07-20T00:00:00.000' AS DateTime), 8.5, N'Dat'),
(N'K1204', N'CTDLGT', 1, CAST(N'2006-12-28T00:00:00.000' AS DateTime), 6.75, N'Dat'),
(N'K1204', N'THDC', 1, CAST(N'2006-05-20T00:00:00.000' AS DateTime), 4, N'Khong Dat'),
(N'K1204', N'CTRR', 1, CAST(N'2006-05-13T00:00:00.000' AS DateTime), 6, N'Dat'),
(N'K1301', N'CSDL', 1, CAST(N'2006-12-20T00:00:00.000' AS DateTime), 4.25, N'Khong Dat'),
(N'K1301', N'CTDLGT', 1, CAST(N'2006-07-25T00:00:00.000' AS DateTime), 8, N'Dat'),
(N'K1301', N'THDC', 1, CAST(N'2006-05-20T00:00:00.000' AS DateTime), 7.75, N'Dat'),
(N'K1301', N'CTRR', 1, CAST(N'2006-05-13T00:00:00.000' AS DateTime), 8, N'Dat'),
(N'K1302', N'CSDL', 1, CAST(N'2006-12-20T00:00:00.000' AS DateTime), 6.75, N'Dat'),
(N'K1302', N'CTDLGT', 1, CAST(N'2006-07-25T00:00:00.000' AS DateTime), 5, N'Dat'),
(N'K1302', N'THDC', 1, CAST(N'2006-05-20T00:00:00.000' AS DateTime), 8, N'Dat'),
(N'K1302', N'CTRR', 1, CAST(N'2006-05-13T00:00:00.000' AS DateTime), 8.5, N'Dat'),
(N'K1303', N'CSDL', 1, CAST(N'2006-12-20T00:00:00.000' AS DateTime), 4, N'Khong Dat'),
(N'K1303', N'CTDLGT', 1, CAST(N'2006-07-25T00:00:00.000' AS DateTime), 4.5, N'Khong Dat'),
(N'K1303', N'CTDLGT', 2, CAST(N'2006-08-07T00:00:00.000' AS DateTime), 4, N'Khong Dat'),
(N'K1303', N'CTDLGT', 3, CAST(N'2006-08-15T00:00:00.000' AS DateTime), 4.25, N'Khong Dat'),
(N'K1303', N'THDC', 1, CAST(N'2006-05-20T00:00:00.000' AS DateTime), 4.5, N'Khong Dat'),
(N'K1303', N'CTRR', 1, CAST(N'2006-05-13T00:00:00.000' AS DateTime), 3.25, N'Khong Dat'),
(N'K1303', N'CTRR', 2, CAST(N'2006-05-20T00:00:00.000' AS DateTime), 5, N'Dat'),
(N'K1304', N'CSDL', 1, CAST(N'2006-12-20T00:00:00.000' AS DateTime), 7.75, N'Dat'),
(N'K1304', N'CTDLGT', 1, CAST(N'2006-07-25T00:00:00.000' AS DateTime), 9.75, N'Dat'),
(N'K1304', N'THDC', 1, CAST(N'2006-05-20T00:00:00.000' AS DateTime), 5.5, N'Dat'),
(N'K1304', N'CTRR', 1, CAST(N'2006-05-13T00:00:00.000' AS DateTime), 5, N'Dat'),
(N'K1305', N'CSDL', 1, CAST(N'2006-12-20T00:00:00.000' AS DateTime), 9.25, N'Dat'),
(N'K1305', N'CTDLGT', 1, CAST(N'2006-07-25T00:00:00.000' AS DateTime), 10, N'Dat'),
(N'K1305', N'THDC', 1, CAST(N'2006-05-20T00:00:00.000' AS DateTime), 8, N'Dat'),
(N'K1305', N'CTRR', 1, CAST(N'2006-05-13T00:00:00.000' AS DateTime), 10, N'Dat')
GO

UPDATE KHOA SET TRGKHOA = N'GV01' WHERE MAKHOA = N'KHMT'
UPDATE KHOA SET TRGKHOA = N'GV02' WHERE MAKHOA = N'HTTT'
UPDATE KHOA SET TRGKHOA = N'GV03' WHERE MAKHOA = N'CNPM'
UPDATE KHOA SET TRGKHOA = N'GV04' WHERE MAKHOA = N'MTT'
UPDATE GIAOVIEN SET MAKHOA = N'KHMT' WHERE MAGV = N'GV01'
UPDATE GIAOVIEN SET MAKHOA = N'HTTT' WHERE MAGV = N'GV02'
UPDATE GIAOVIEN SET MAKHOA = N'CNPM' WHERE MAGV = N'GV03'
UPDATE GIAOVIEN SET MAKHOA = N'KTMT' WHERE MAGV = N'GV04'
UPDATE GIAOVIEN SET MAKHOA = N'HTTT' WHERE MAGV = N'GV05'
UPDATE GIAOVIEN SET MAKHOA = N'KHMT' WHERE MAGV = N'GV06'
UPDATE GIAOVIEN SET MAKHOA = N'KHMT' WHERE MAGV = N'GV07'
UPDATE GIAOVIEN SET MAKHOA = N'KHMT' WHERE MAGV = N'GV08'
UPDATE GIAOVIEN SET MAKHOA = N'HTTT' WHERE MAGV = N'GV09'
UPDATE GIAOVIEN SET MAKHOA = N'CNPM' WHERE MAGV = N'GV10'
UPDATE GIAOVIEN SET MAKHOA = N'MTT' WHERE MAGV = N'GV11'
UPDATE GIAOVIEN SET MAKHOA = N'CNPM' WHERE MAGV = N'GV12'
UPDATE GIAOVIEN SET MAKHOA = N'KTMT' WHERE MAGV = N'GV13'
UPDATE GIAOVIEN SET MAKHOA = N'MTT' WHERE MAGV = N'GV14'
UPDATE GIAOVIEN SET MAKHOA = N'KHMT' WHERE MAGV = N'GV15'

-- III. Ngôn ngữ truy vấn dữ liệu:
-- 1.	In ra danh sách (mã học viên, họ tên, ngày sinh, mã lớp) lớp trưởng của các lớp.
SELECT HV.MAHV, HO + ' ' + TEN AS HOTEN, NGSINH, HV.MALOP 
FROM HOCVIEN HV INNER JOIN LOP 
ON HV.MAHV = LOP.TRGLOP
GO

-- 2.	In ra bảng điểm khi thi (mã học viên, họ tên , lần thi, điểm số) môn CTRR của lớp “K12”, sắp xếp theo tên, họ học viên.
SELECT KQ.MAHV, HO + ' ' + TEN AS HOTEN, LANTHI, DIEM 
FROM KETQUATHI KQ INNER JOIN HOCVIEN HV 
ON KQ.MAHV = HV.MAHV
WHERE LEFT(KQ.MAHV, 3) = 'K12' AND MAMH = 'CTRR'
ORDER BY TEN, HO
GO

-- 3.	In ra danh sách những học viên (mã học viên, họ tên) và những môn học mà học viên đó thi lần thứ nhất đã đạt.
SELECT KQ.MAHV, HO + ' ' + TEN AS HOTEN, MAMH
FROM KETQUATHI KQ INNER JOIN HOCVIEN HV 
ON KQ.MAHV = HV.MAHV
GROUP BY KQ.MAHV, HO, TEN, MAMH, KQUA
HAVING MAX(LANTHI) = 1 AND KQUA ='DAT'
ORDER BY KQ.MAHV
GO

-- 4.	In ra danh sách học viên (mã học viên, họ tên) của lớp “K11” thi môn CTRR không đạt (ở lần thi 1).
SELECT KQ.MAHV, HO + ' ' + TEN AS HOTEN
FROM KETQUATHI KQ INNER JOIN HOCVIEN HV 
ON KQ.MAHV = HV.MAHV
WHERE LEFT(KQ.MAHV, 3) = 'K11' AND MAMH = 'CTRR' AND LANTHI = 1 AND KQUA = 'Khong Dat'
GO

-- 5.	* Danh sách học viên (mã học viên, họ tên) của lớp “K” thi môn CTRR không đạt (ở tất cả các lần thi).
SELECT A.MAHV, HOTEN FROM (
	SELECT KQ.MAHV, HO + ' ' + TEN AS HOTEN, LANTHI
	FROM KETQUATHI KQ INNER JOIN HOCVIEN HV 
	ON KQ.MAHV = HV.MAHV
	WHERE LEFT(KQ.MAHV, 3) = 'K11' AND MAMH = 'CTRR' AND KQUA = 'Khong Dat'
) A 
INNER JOIN (
	SELECT MAHV, MAX(LANTHI) LANTHIMAX FROM KETQUATHI 
	WHERE LEFT(MAHV, 3) = 'K11' AND MAMH = 'CTRR'
	GROUP BY MAHV, MAMH 
) B 
ON A.MAHV = B.MAHV
WHERE LANTHI = LANTHIMAX
GO