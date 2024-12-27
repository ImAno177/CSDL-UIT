USE ViecLam
-- Câu hỏi SQL từ cơ bản đến nâng cao, bao gồm trigger

-- Cơ bản:
--  1. Liệt kê tất cả chuyên gia trong cơ sở dữ liệu.
SELECT HoTen FROM ChuyenGia;
-- 2. Hiển thị tên và email của các chuyên gia nữ.
SELECT HoTen, Email FROM ChuyenGia
WHERE GioiTinh = N'Nữ';
-- 3. Liệt kê các công ty có trên 100 nhân viên.
SELECT TenCongTy FROM CongTy
WHERE SoNhanVien > 100;
-- 4. Hiển thị tên và ngày bắt đầu của các dự án trong năm 2023.
SELECT TenDuAn, NgayBatDau FROM DuAn
WHERE YEAR(NgayBatDau)=2023;

--5

-- Trung cấp:
-- 6. Liệt kê tên chuyên gia và số lượng dự án họ tham gia.
SELECT ChuyenGia.HoTen, COUNT(CGDA.MaDuAn) SODUAN FROM ChuyenGia
JOIN ChuyenGia_DuAn CGDA ON CGDA.MaChuyenGia= ChuyenGia.MaChuyenGia
GROUP BY ChuyenGia.HoTen, CGDA.MaChuyenGia;

-- 7. Tìm các dự án có sự tham gia của chuyên gia có kỹ năng 'Python' cấp độ 4 trở lên
SELECT DISTINCT dp.TenDuAn
FROM DuAn AS dp
JOIN ChuyenGia_DuAn AS tg ON dp.MaDuAn = tg.MaDuAn
JOIN ChuyenGia_KyNang AS cg ON tg.MaChuyenGia = cg.MaChuyenGia
JOIN KyNang AS kn ON cg.MaKyNang = kn.MaKyNang
WHERE kn.TenKyNang = 'Python' AND cg.CapDo >= 4;

-- 8. Hiển thị tên công ty và số lượng dự án đang thực hiện
SELECT c.TenCongTy, COUNT(*) AS SoLuongDuAn
FROM CongTy AS c
JOIN DuAn AS dp ON c.MaCongTy = dp.MaCongTy
WHERE dp.TrangThai = 'Đang thực hiện'
GROUP BY c.TenCongTy;

-- 9. Tìm chuyên gia có số năm kinh nghiệm cao nhất trong mỗi chuyên ngành
SELECT ChuyenNganh, MaChuyenGia,HoTen, MAX(NamKinhNghiem) AS SoNamKinhNghiem
FROM ChuyenGia
GROUP BY ChuyenNganh,MaChuyenGia,HoTen;
-- 10. Liệt kê các cặp chuyên gia đã từng làm việc cùng nhau trong ít nhất một dự án
SELECT DISTINCT tg1.MaChuyenGia AS ChuyenGia1, tg2.MaChuyenGia AS ChuyenGia2
FROM ChuyenGia_DuAn AS tg1
JOIN ChuyenGia_DuAn AS tg2 ON tg1.MaDuAn = tg2.MaDuAn AND tg1.MaChuyenGia < tg2.MaChuyenGia;
-- 11. Tính tổng thời gian (theo ngày) mà mỗi chuyên gia đã tham gia vào các dự án
SELECT tg.MaChuyenGia, SUM(ABS(DATEDIFF(DAY,da.NgayKetThuc, da.NgayBatDau))) AS TongThoiGian
FROM ChuyenGia_DuAn AS tg
JOIN DuAn da ON da.MaCongTy=tg.MaDuAn
GROUP BY tg.MaChuyenGia;
-- 12. Tìm các công ty có tỷ lệ dự án hoàn thành cao nhất (trên 90%)
SELECT c.TenCongTy, 
       (COUNT(CASE WHEN dp.TrangThai = N'Hoàn thành' THEN 1 END) * 100.0 / COUNT(*)) AS TyLeHoanThanh
FROM CongTy AS c
JOIN DuAn AS dp ON c.MaCongTy = dp.MaCongTy
GROUP BY c.TenCongTy
HAVING COUNT(CASE WHEN dp.TrangThai = N'Hoàn thành' THEN 1 END) * 100.0 / COUNT(*) > 90;
-- 13. Liệt kê top 3 kỹ năng được yêu cầu nhiều nhất trong các dự án
SELECT TOP 3 KyNangYeuCau, COUNT(*) FROM DuAn
GROUP BY KyNangYeuCau
ORDER BY COUNT(*) DESC;

-- 14. Tính lương trung bình của chuyên gia theo từng cấp độ kinh nghiệm
SELECT AVG(Luong) AS LuongTrungBinh
FROM ChuyenGia
GROUP BY NamKinhNghiem;

-- 15. Tìm các dự án có sự tham gia của chuyên gia từ tất cả các chuyên ngành
SELECT dp.TenDuAn
FROM DuAn AS dp
JOIN ChuyenGia_DuAn AS tg ON dp.MaDuAn = tg.MaDuAn
JOIN ChuyenGia AS cg ON tg.MaChuyenGia = cg.MaChuyenGia
GROUP BY dp.TenDuAn
HAVING COUNT(DISTINCT cg.ChuyenNganh) = (SELECT COUNT(DISTINCT ChuyenNganh) FROM ChuyenGia);
GO
-- 16. Trigger: Tự động cập nhật số lượng dự án của công ty khi thêm hoặc xóa dự án
ALTER TABLE CongTy ADD SoLuongDuAn INT DEFAULT 0;
GO
CREATE TRIGGER UpdateSoLuongDuAn
ON DuAn
AFTER INSERT, DELETE
AS
BEGIN

    IF EXISTS (SELECT 1 FROM inserted)
    BEGIN
        UPDATE CongTy
        SET SoLuongDuAn = SoLuongDuAn + (SELECT COUNT(*) FROM inserted WHERE inserted.MaCongTy = CongTy.MaCongTy)
        WHERE MaCongTy IN (SELECT MaCongTy FROM inserted);
    END

    IF EXISTS (SELECT 1 FROM deleted)
    BEGIN
        UPDATE CongTy
        SET SoLuongDuAn = SoLuongDuAn - (SELECT COUNT(*) FROM deleted WHERE deleted.MaCongTy = CongTy.MaCongTy)
        WHERE MaCongTy IN (SELECT MaCongTy FROM deleted);
    END
END;
-- 17. Trigger: Ghi log mỗi khi có sự thay đổi trong bảng ChuyenGia
CREATE TABLE LogChuyenGia (
	HanhDong NVARCHAR(20), 
	MaChuyenGia INT, 
	ThoiGian DATETIME,
	PRIMARY KEY (HanhDong, MaChuyenGia, ThoiGian)
	)
	GO
CREATE TRIGGER LogChangeChuyenGia
ON ChuyenGia
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted)
    BEGIN
        INSERT INTO LogChuyenGia (HanhDong, MaChuyenGia, ThoiGian)
        SELECT 'INSERT', MaChuyenGia, GETDATE()
        FROM inserted;
    END

    IF EXISTS (SELECT 1 FROM inserted) AND EXISTS (SELECT 1 FROM deleted)
    BEGIN
        INSERT INTO LogChuyenGia (HanhDong, MaChuyenGia, ThoiGian)
        SELECT 'UPDATE', MaChuyenGia, GETDATE()
        FROM inserted;
    END

    IF EXISTS (SELECT 1 FROM deleted)
    BEGIN
        INSERT INTO LogChuyenGia (HanhDong, MaChuyenGia, ThoiGian)
        SELECT 'DELETE', MaChuyenGia, GETDATE()
        FROM deleted;
    END
END;
GO
-- 18. Trigger: Đảm bảo rằng một chuyên gia không thể tham gia vào quá 5 dự án cùng một lúc
CREATE TRIGGER LimitDuAnChuyenGia
ON ChuyenGia_DuAn
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT MaChuyenGia
        FROM inserted
        WHERE (SELECT COUNT(*) 
               FROM ChuyenGia_DuAn 
               WHERE MaChuyenGia = inserted.MaChuyenGia) >= 5
    )
    BEGIN
        RAISERROR('Một chuyên gia không thể tham gia quá 5 dự án cùng một lúc', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        INSERT INTO ChuyenGia_DuAn  (MaChuyenGia, MaDuAn, NgayThamGia)
        SELECT MaChuyenGia, MaDuAn, NgayThamGia
        FROM inserted;
    END
END;
GO
-- 19. Trigger: Tự động cập nhật trạng thái của dự án thành 'Hoàn thành'
CREATE TRIGGER AutoCompleteDuAn
ON DuAn
AFTER UPDATE
AS
BEGIN
    UPDATE DuAn
    SET TrangThai = 'Hoàn thành'
    WHERE NgayKetThuc IS NOT NULL
END;
GO
-- 20. Trigger: Tính toán và cập nhật điểm đánh giá trung bình của công ty
ALTER TABLE CongTy ADD DiemDanhGia INT DEFAULT 0;
GO
CREATE TRIGGER UpdateDiemDanhGia
ON DuAn
AFTER UPDATE
AS
BEGIN
    UPDATE CongTy
    SET DiemDanhGia = (
        SELECT AVG(DiemDanhGia)
        FROM DuAn
        WHERE DuAn.MaCongTy = CongTy.MaCongTy
    )
    WHERE MaCongTy IN (SELECT DISTINCT MaCongTy FROM inserted);
END;

