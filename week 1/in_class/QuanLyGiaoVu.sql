﻿-------------------------------- QUANLYGIAOVU ------------------------------------------
/*
DROP TABLE KHOA 
DROP TABLE MONHOC 
DROP TABLE DIEUKIEN 
DROP TABLE GIAOVIEN  
DROP TABLE LOP 
DROP TABLE HOCVIEN 
DROP TABLE GIANGDAY  
DROP TABLE KETQUATHI  

DELETE FROM KHOA 
DELETE FROM MONHOC 
DELETE FROM DIEUKIEN
DELETE FROM GIAOVIEN
DELETE FROM LOP
DELETE FROM HOCVIEN
DELETE FROM GIANGDAY
DELETE FROM KETQUATHI

SELECT * FROM KHOA 
SELECT * FROM MONHOC 
SELECT * FROM DIEUKIEN
SELECT * FROM GIAOVIEN
SELECT * FROM LOP
SELECT * FROM HOCVIEN
SELECT * FROM GIANGDAY
SELECT * FROM KETQUATHI
*/
GO
-- Tạo bảng KHOA
CREATE TABLE KHOA (
    MAKHOA VARCHAR(4) PRIMARY KEY,
    TENKHOA VARCHAR(40),
    NGTLAP SMALLDATETIME,
    TRGKHOA CHAR(4) 
);

-- Tạo bảng MONHOC
CREATE TABLE MONHOC (
    MAMH VARCHAR(10) PRIMARY KEY,
    TENMH VARCHAR(40),
    TCLT TINYINT,
    TCTH TINYINT,
    MAKHOA VARCHAR(4) FOREIGN KEY REFERENCES KHOA(MAKHOA)
);

-- Tạo bảng DIEUKIEN
CREATE TABLE DIEUKIEN (
    MAMH VARCHAR(10) FOREIGN KEY REFERENCES MONHOC(MAMH),
    MAMH_TRUOC VARCHAR(10) FOREIGN KEY REFERENCES MONHOC(MAMH),
	PRIMARY KEY(MAMH,MAMH_TRUOC)
);

-- Tạo bảng GIAOVIEN
CREATE TABLE GIAOVIEN (
    MAGV CHAR(4) PRIMARY KEY,
    HOTEN VARCHAR(40),
    HOCVI VARCHAR(10),
    HOCHAM VARCHAR(10),
    GIOITINH VARCHAR(3),
    NGSINH SMALLDATETIME,
    NGVL SMALLDATETIME,
    HESO NUMERIC(4,2),
    MUCLUONG MONEY,
    MAKHOA VARCHAR(4) FOREIGN KEY REFERENCES KHOA(MAKHOA)
);

-- Tạo bảng LOP
CREATE TABLE LOP (
    MALOP CHAR(3) PRIMARY KEY,
    TENLOP VARCHAR(40),
    TRGLOP CHAR(5), 
    SISO TINYINT,
    MAGVCN CHAR(4) FOREIGN KEY REFERENCES GIAOVIEN(MAGV),
    MAKHOA VARCHAR(4) FOREIGN KEY REFERENCES KHOA(MAKHOA)
);
-- Tạo bảng HOCVIEN
CREATE TABLE HOCVIEN (
    MAHV CHAR(5) PRIMARY KEY,
    HO VARCHAR(40),
    TEN VARCHAR(10),
    NGSINH SMALLDATETIME,
    GIOITINH VARCHAR(3),
    NOISINH VARCHAR(40),
    MALOP CHAR(3) FOREIGN KEY REFERENCES LOP(MALOP)
);


-- Tạo bảng GIANGDAY
CREATE TABLE GIANGDAY (
    MALOP CHAR(3) FOREIGN KEY REFERENCES LOP(MALOP),
    MAMH VARCHAR(10) FOREIGN KEY REFERENCES MONHOC(MAMH),
    MAGV CHAR(4) FOREIGN KEY REFERENCES GIAOVIEN(MAGV),
    HOCKY TINYINT,
    NAM SMALLINT,
    TUNGAY SMALLDATETIME,
    DENNGAY SMALLDATETIME,
    PRIMARY KEY (MALOP, MAMH)
);

-- Tạo bảng KETQUATHI
CREATE TABLE KETQUATHI (
    MAHV CHAR(5) FOREIGN KEY REFERENCES HOCVIEN(MAHV),
    MAMH VARCHAR(10) FOREIGN KEY REFERENCES MONHOC(MAMH),
    LANTHI TINYINT,
    NGTHI SMALLDATETIME,
    DIEM NUMERIC(4,2),
    KQUA VARCHAR(10),
    PRIMARY KEY (MAHV, MAMH, LANTHI)
);
ALTER TABLE KHOA ADD CONSTRAINT FK__KHOA__TRGKHOA FOREIGN KEY (TRGKHOA) REFERENCES GIAOVIEN(MAGV)
ALTER TABLE LOP ADD CONSTRAINT FK__TRGLOP__HOCVIEN FOREIGN KEY (TRGLOP) REFERENCES HOCVIEN(MAHV)
-- 3. Thuộc tính GIOITINH chỉ có giá trị là “Nam” hoặc “Nu”.
ALTER TABLE HOCVIEN ADD CONSTRAINT CK_GIOITINH CHECK(GIOITINH in ('Nam','Nu'))
-- 4. Điểm số của một lần thi có giá trị từ 0 đến 10 và cần lưu đến 2 số lẽ (VD: 6.22).
ALTER TABLE KETQUATHI ADD CONSTRAINT CK_DIEM CHECK(
	DIEM BETWEEN 0 AND 10 AND
	LEN(SUBSTRING(CAST(DIEM AS VARCHAR), CHARINDEX('.', DIEM) + 1, 1000)) >= 2
)
-- 5. Kết quả thi là “Dat” nếu điểm từ 5 đến 10 và “Khong dat” nếu điểm nhỏ hơn 5.
ALTER TABLE KETQUATHI ADD CONSTRAINT CK_KQUA CHECK(KQUA = IIF(DIEM BETWEEN 5 AND 10, 'Dat', 'Khong dat'))
-- 6. Học viên thi một môn tối đa 3 lần.
ALTER TABLE KETQUATHI ADD CONSTRAINT CK_SOLANTHI CHECK(LANTHI <= 3)
-- 7. Học kỳ chỉ có giá trị từ 1 đến 3.
ALTER TABLE GIANGDAY ADD CONSTRAINT CK_HOCKY CHECK(HOCKY BETWEEN 1 AND 3)
-- 8. Học vị của giáo viên chỉ có thể là “CN”, “KS”, “Ths”, ”TS”, ”PTS”.
ALTER TABLE GIAOVIEN ADD CONSTRAINT CK_HOCVI CHECK(HOCVI in ('CN','KS','Ths','TS','PTS'))