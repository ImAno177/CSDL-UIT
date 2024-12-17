USE QUANLYBANHANG
-- 11. Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”. 
SELECT DISTINCT SOHD
FROM CTHD
WHERE MaSP IN ('BB01', 'BB02');

-- 12. Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”, mỗi sản phẩm mua với số lượng từ 10 đến 20. 
SELECT DISTINCT SOHD
FROM CTHD
WHERE MaSP IN ('BB01', 'BB02') AND SL BETWEEN 10 AND 20;

-- 13. Tìm các số hóa đơn mua cùng lúc 2 sản phẩm có mã số “BB01” và “BB02”, mỗi sản phẩm mua với số lượng từ 10 đến 20.
SELECT SOHD
FROM CTHD
WHERE (MaSP = 'BB01' AND SL BETWEEN 10 AND 20)
   OR (MaSP = 'BB02' AND SL BETWEEN 10 AND 20)
GROUP BY SOHD
HAVING COUNT(DISTINCT MaSP) = 2;

-- 14. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất hoặc các sản phẩm được bán ra trong ngày 1/1/2007.
SELECT DISTINCT SP.MASP, SP.TENSP
FROM SANPHAM SP
LEFT JOIN CTHD CTHD ON SP.MASP = CTHD.MASP
LEFT JOIN HoaDon HD ON CTHD.SOHD = HD.SOHD
WHERE SP.NUOCSX = 'Trung Quoc'
   OR HD.NGHD = '2007-01-01';

USE QUANLYHOCVU
-- 9. Lớp trưởng của một lớp phải là học viên của lớp đó. 
ALTER TABLE LOP
ADD CONSTRAINT FK_LOP_HOCVIEN
FOREIGN KEY (TRGLOP) REFERENCES HOCVIEN(MAHV);
GO
-- 10. Trưởng khoa phải là giáo viên thuộc khoa và có học vị “TS” hoặc “PTS”.
CREATE TRIGGER TRG_Check_TruongKhoa
ON KHOA
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (
        SELECT 1
        FROM INSERTED I
        LEFT JOIN GIAOVIEN G ON I.TRGKHOA = G.MAGV
        WHERE G.HOCVI NOT IN ('TS', 'PTS') OR G.HOCVI IS NULL
    )
    BEGIN
        RAISERROR('Truong khoa must be a teacher with "TS" or "PTS" degree.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO
-- 15. Học viên chỉ được thi một môn học nào đó khi lớp của học viên đã học xong môn học này. 
CREATE TRIGGER TRG_INS_KQT ON KETQUATHI
FOR INSERT
AS
BEGIN
	DECLARE @MaHV CHAR(5), @MaLop CHAR (3),
			@NgayThi SMALLDATETIME, @NgayKTKH SMALLDATETIME
	SELECT @MaHV = MAHV, @NgayThi = NGTHI
	FROM INSERTED 

	SELECT @MaLop = MALOP
	FROM GIANGDAY
	WHERE @MaHV = (SELECT MAHV
					FROM HOCVIEN 
					WHERE MAHV = @MaHV)

	SELECT @NgayKTKH = DENNGAY
	FROM GIANGDAY
	WHERE MALOP = @MaLop

	IF (@NgayThi < @NgayKTKH)
		BEGIN
			PRINT 'LOI: NGAY THI VA NGAY KET THUC KHOA HOC KHONG HOP LE'
			ROLLBACK TRANSACTION
		END 
	ELSE
	BEGIN
		PRINT 'THEM MOT KET QUA THI THANH CONG'
	END
END
GO
-- 16. Mỗi học kỳ của một năm học, một lớp chỉ được học tối đa 3 môn. 
CREATE TRIGGER TRG_INS_GD ON GIANGDAY
FOR INSERT
AS
BEGIN
	DECLARE @SoMonHoc INT, @MaLop CHAR(3)
	SELECT @MaLop = MALOP
	FROM INSERTED

	SELECT @SoMonHoc = COUNT(MAMH)
	FROM GIANGDAY GD1
	WHERE HOCKY IN (SELECT HOCKY 
					FROM GIANGDAY GD2
					WHERE GD1.NAM = GD2.NAM
						AND GD1.HOCKY = GD2.HOCKY)
	GROUP BY MALOP,HOCKY,NAM

	IF (@SoMonHoc > 3)
	BEGIN
		PRINT 'LOI: MOT HOC KY MOT LOP KHONG DUOC HOC NHIEU HON 3 MON'
		ROLLBACK TRANSACTION
	END
	ELSE
	BEGIN
		PRINT'THEM MOT GIANG DAY THANH CONG'
	END
END
GO
-- 17. Sỉ số của một lớp bằng với số lượng học viên thuộc lớp đó. 
CREATE VIEW V_SI_SO_LOP AS
SELECT MALOP, COUNT(*) AS SO_LUONG_HOC_VIEN
FROM HOCVIEN
GROUP BY MALOP;
GO

CREATE TRIGGER TR_UPDATE_SI_SO
ON LOP
AFTER UPDATE, INSERT
AS
BEGIN
   IF UPDATE(SISO)
   BEGIN
       DECLARE @MALOP char(3);
       DECLARE @SISO int;
       DECLARE @SO_LUONG_HOC_VIEN int;

       DECLARE update_cursor CURSOR FOR 
       SELECT MALOP, SISO 
       FROM INSERTED;

       OPEN update_cursor;
       FETCH NEXT FROM update_cursor INTO @MALOP, @SISO;

       WHILE @@FETCH_STATUS = 0
       BEGIN
           SELECT @SO_LUONG_HOC_VIEN = COUNT(*)
           FROM HOCVIEN 
           WHERE MALOP = @MALOP;

           IF @SISO <> @SO_LUONG_HOC_VIEN
           BEGIN
               RAISERROR('Sỉ số không đúng với số lượng học viên thực tế', 16, 1);
               ROLLBACK TRANSACTION;
               CLOSE update_cursor;
               DEALLOCATE update_cursor;
               RETURN;
           END

           FETCH NEXT FROM update_cursor INTO @MALOP, @SISO;
       END

       CLOSE update_cursor;
       DEALLOCATE update_cursor;
   END
END;
GO
-- 18. Trong quan hệ DIEUKIEN giá trị của thuộc tính MAMH và MAMH_TRUOC trong cùng một bộ không được giống nhau (“A”,”A”) và cũng không tồn tại hai bộ (“A”,”B”) và (“B”,”A”). 
ALTER TABLE DIEUKIEN
ADD CONSTRAINT CK_MAMH_MAMH_TRUOC
CHECK (MAMH <> MAMH_TRUOC);
GO
-- 19. Các giáo viên có cùng học vị, học hàm, hệ số lương thì mức lương bằng nhau. 

CREATE TRIGGER TR_CONSISTENT_SALARY
ON GIAOVIEN
AFTER INSERT, UPDATE
AS
BEGIN

    IF EXISTS (
        SELECT HOCVI, HOCHAM, HESO, 
               COUNT(DISTINCT MUCLUONG) AS DISTINCT_SALARY_COUNT
        FROM GIAOVIEN
        GROUP BY HOCVI, HOCHAM, HESO
        HAVING COUNT(DISTINCT MUCLUONG) > 1
    )
    BEGIN
        RAISERROR('Giáo viên cùng học vị, học hàm, hệ số phải có mức lương giống nhau', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

-- 20. Học viên chỉ được thi lại (lần thi >1) khi điểm của lần thi trước đó dưới 5. 
CREATE TRIGGER TRG_Check_ThiLai
ON KETQUATHI
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM INSERTED I
        JOIN KETQUATHI KQ 
            ON I.MAHV = KQ.MAHV 
            AND I.MAMH = KQ.MAMH
            AND I.LANTHI = KQ.LANTHI + 1
        WHERE KQ.DIEM >= 5
    )
    BEGIN
        RAISERROR('Học viên chỉ được thi lại khi điểm của lần thi trước đó dưới 5.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

GO
-- 21. Ngày thi của lần thi sau phải lớn hơn ngày thi của lần thi trước (cùng học viên, cùng môn học). 
CREATE TRIGGER TRG_INS_KQT_NT ON KETQUATHI
FOR INSERT 
AS
BEGIN
	DECLARE @MaHV CHAR(5), @MaMH CHAR(10), @NgayThiTruoc SMALLDATETIME, @NgayThiSau SMALLDATETIME
	SELECT @MaHV = MAHV, @MaMH = MAMH
	FROM INSERTED

	SELECT @NgayThiTruoc = NGTHI
	FROM KETQUATHI KQT1
	WHERE MAMH IN (SELECT MAMH
					FROM KETQUATHI KQT2
					WHERE KQT1.MAHV = KQT2.MAHV
						AND KQT1.LANTHI = 1
						AND KQT1.MAMH = KQT2.MAMH)

	SELECT @NgayThiSau = NGTHI
	FROM KETQUATHI KQT1
	WHERE MAMH IN (SELECT MAMH
					FROM KETQUATHI KQT2
					WHERE KQT1.MAHV = KQT2.MAHV
						AND KQT1.LANTHI <> 1
						AND KQT1.MAMH = KQT2.MAMH)

	IF(@NgayThiSau < @NgayThiTruoc)
	BEGIN
		PRINT'LOI: NGAY THI SAU KHONG HOP LE'
		ROLLBACK TRANSACTION
	END
	ELSE
	BEGIN
		PRINT'THEM MOT KET QUA THI THANH CONG'
	END
END
GO
-- 22. Khi phân công giảng dạy một môn học, phải xét đến thứ tự trước sau giữa các môn học (sau khi học xong những môn học phải học trước mới được học những môn liền sau). 

CREATE TRIGGER TR_CHECK_PREREQUISITE_ORDER
ON GIANGDAY
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @MAMH CHAR(5), @MAGV CHAR(5);
    SELECT @MAMH = MAMH, @MAGV = MAGV FROM INSERTED;

    IF EXISTS (
        SELECT 1 
        FROM DIEUKIEN DK
        WHERE DK.MAMH = @MAMH
        AND NOT EXISTS (

            SELECT 1 
            FROM GIANGDAY GD
            WHERE GD.MAMH = DK.MAMH_TRUOC 
            AND GD.MAGV IN (

                SELECT MAGV 
                FROM GIAOVIEN 
                WHERE MAKHOA = (SELECT MAKHOA FROM GIAOVIEN WHERE MAGV = @MAGV)
            )
        )
    )
    BEGIN
        RAISERROR('Chưa hoàn thành môn học tiên quyết', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO
-- 23. Giáo viên chỉ được phân công dạy những môn thuộc khoa giáo viên đó phụ trách.
CREATE TRIGGER TR_KIEM_TRA_KHOA_GIANG_DAY
ON GIANGDAY
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM INSERTED I
        JOIN GIAOVIEN GV ON I.MAGV = GV.MAGV
        JOIN MONHOC MH ON I.MAMH = MH.MAMH
        WHERE GV.MAKHOA <> MH.MAKHOA
    )
    BEGIN
        RAISERROR('Giáo viên chỉ được dạy môn học thuộc khoa của mình', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO
