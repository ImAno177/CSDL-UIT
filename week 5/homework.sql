USE ViecLam
GO

-- 101. Tạo trigger để tự động cập nhật trường NgayCapNhat trong bảng ChuyenGia mỗi khi có sự thay đổi thông tin.
ALTER TABLE ChuyenGia 
ADD NgayCapNhat DATETIME DEFAULT GETDATE();
GO
CREATE TRIGGER update_NgayCapNhat_ChuyenGia
ON ChuyenGia
AFTER UPDATE
AS
BEGIN
    UPDATE ChuyenGia
    SET NgayCapNhat = GETDATE()
    WHERE MaChuyenGia IN (SELECT MaChuyenGia FROM INSERTED); 
END;
GO

-- 102. Tạo trigger để ghi log mỗi khi có sự thay đổi trong bảng DuAn.
CREATE TRIGGER log_DuAn_changes
ON DuAn
AFTER UPDATE
AS
BEGIN
    DECLARE @project_id INT, @old_status NVARCHAR(50), @new_status NVARCHAR(50), @old_name NVARCHAR(255), @new_name NVARCHAR(255);
    SELECT @project_id = MaDuAn, @old_status = TrangThai, @old_name = TenDuAn FROM DELETED;
    SELECT @project_id = MaDuAn, @new_status = TrangThai, @new_name = TenDuAn FROM INSERTED;

    INSERT INTO LogTable (Action, TableName, RecordID, OldValue, NewValue, ChangeDate)
    VALUES ('UPDATE', 'DuAn', @project_id, CONCAT('Status: ', @old_status, ', Name: ', @old_name), CONCAT('Status: ', @new_status, ', Name: ', @new_name), GETDATE());
END;
GO

-- 103. Tạo trigger để đảm bảo rằng một chuyên gia không thể tham gia vào quá 5 dự án cùng một lúc.
CREATE TRIGGER check_max_projects_for_specialist
ON ChuyenGia_DuAn
AFTER INSERT
AS
BEGIN
    DECLARE @specialist_id INT, @project_count INT;
    SELECT @specialist_id = MaChuyenGia FROM INSERTED;

    SELECT @project_count = COUNT(*) FROM ChuyenGia_DuAn WHERE MaChuyenGia = @specialist_id;

    IF @project_count > 5
    BEGIN
        ROLLBACK TRANSACTION;
        RAISERROR('Chuyên gia không thể tham gia quá 5 dự án cùng một lúc.', 16, 1);
    END
END;
GO

-- 104. Tạo trigger để tự động cập nhật số lượng nhân viên trong bảng CongTy mỗi khi có sự thay đổi trong bảng ChuyenGia_DuAn.
CREATE TRIGGER update_employee_count_in_congty
ON ChuyenGia_DuAn
AFTER INSERT, DELETE
AS
BEGIN
    DECLARE @company_id INT, @employee_count INT;
    SELECT @company_id = (SELECT MaCongTy FROM DuAn WHERE MaDuAn = (SELECT MaDuAn FROM INSERTED));
        IF @company_id IS NULL 
        BEGIN
        SELECT @company_id = (SELECT MaCongTy FROM DuAn WHERE MaDuAn = (SELECT MaDuAn FROM DELETED));
        END
        IF @company_id IS NULL RETURN;
    SELECT @employee_count = COUNT(DISTINCT cg.MaChuyenGia)
    FROM ChuyenGia_DuAn cgd
    JOIN DuAn da ON cgd.MaDuAn = da.MaDuAn
    JOIN ChuyenGia cg ON cgd.MaChuyenGia = cg.MaChuyenGia
    WHERE da.MaCongTy = @company_id;
    IF @employee_count is null set @employee_count = 0;

    UPDATE CongTy
    SET SoNhanVien = @employee_count
    WHERE MaCongTy = @company_id;
END;
GO

-- 105. Tạo trigger để ngăn chặn việc xóa các dự án đã hoàn thành.
CREATE TRIGGER prevent_delete_completed_projects
ON DuAn
INSTEAD OF DELETE
AS
BEGIN
    DECLARE @project_status NVARCHAR(50);
    SELECT @project_status = TrangThai FROM DELETED;

    IF @project_status = 'Hoan thanh'
    BEGIN
        RAISERROR('Không thể xóa dự án đã hoàn thành.', 16, 1);
    END
    ELSE
    BEGIN
        DELETE FROM DuAn WHERE MaDuAn IN (SELECT MaDuAn FROM DELETED);
    END
END;
GO

-- 106. Tạo trigger để tự động cập nhật cấp độ kỹ năng của chuyên gia khi họ tham gia vào một dự án mới.
CREATE TRIGGER update_skill_level_on_project_assignment
ON ChuyenGia_DuAn
AFTER INSERT
AS
BEGIN
    DECLARE @specialist_id INT, @project_id INT, @skill_level INT;
    SELECT @specialist_id = MaChuyenGia, @project_id = MaDuAn FROM INSERTED;

    SELECT @skill_level = MAX(CapDo) FROM ChuyenGia_KyNang WHERE MaChuyenGia = @specialist_id;

    UPDATE ChuyenGia_KyNang
    SET CapDo = @skill_level
    WHERE MaChuyenGia = @specialist_id;
END;
GO

-- 107. Tạo trigger để ghi log mỗi khi có sự thay đổi cấp độ kỹ năng của chuyên gia.
CREATE TABLE LogTable (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Action NVARCHAR(50),          
    TableName NVARCHAR(50),       
    RecordID INT,               
    OldValue NVARCHAR(MAX),     
    NewValue NVARCHAR(MAX),     
    ChangeDate DATETIME DEFAULT GETDATE(),
);
GO
CREATE TRIGGER log_skill_level_changes
ON ChuyenGia_KyNang
AFTER UPDATE
AS
BEGIN
    DECLARE @specialist_id INT, @old_skill_level INT, @new_skill_level INT;
    SELECT @specialist_id = MaChuyenGia, @old_skill_level = CapDo FROM DELETED;
    SELECT @specialist_id = MaChuyenGia, @new_skill_level = CapDo FROM INSERTED;

    IF @old_skill_level != @new_skill_level
    BEGIN
        INSERT INTO LogTable (Action, TableName, RecordID, OldValue, NewValue, ChangeDate)
        VALUES ('UPDATE', 'ChuyenGia', @specialist_id, CAST(@old_skill_level AS NVARCHAR(10)), CAST(@new_skill_level AS NVARCHAR(10)), GETDATE());
    END
END;
GO

-- 108. Tạo trigger để đảm bảo rằng ngày kết thúc của dự án luôn lớn hơn ngày bắt đầu.
CREATE TRIGGER validate_project_dates
ON DuAn
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @start_date DATE, @end_date DATE;
    SELECT @start_date = NgayBatDau, @end_date = NgayKetThuc FROM INSERTED;

    IF @end_date <= @start_date
    BEGIN
        RAISERROR('Ngày kết thúc phải lớn hơn ngày bắt đầu.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

-- 109. Tạo trigger để tự động xóa các bản ghi liên quan trong bảng ChuyenGia_KyNang khi một kỹ năng bị xóa.
CREATE TRIGGER delete_skill_from_specialist
ON KyNang
AFTER DELETE
AS
BEGIN
    DECLARE @skill_id INT;
    SELECT @skill_id = MaKyNang FROM DELETED;

    DELETE FROM ChuyenGia_KyNang WHERE MaKyNang = @skill_id;
END;
GO

-- 110. Tạo trigger để đảm bảo rằng một công ty không thể có quá 10 dự án đang thực hiện cùng một lúc.
CREATE TRIGGER check_max_active_projects
ON DuAn
AFTER INSERT
AS
BEGIN
    DECLARE @company_id INT, @active_projects INT;
    SELECT @company_id = MaCongTy FROM INSERTED;

    SELECT @active_projects = COUNT(*) FROM DuAn WHERE MaCongTy = @company_id AND TrangThai = 'Dang thuc hien';

    IF @active_projects > 10
    BEGIN
        ROLLBACK TRANSACTION;
        RAISERROR('Công ty không thể có quá 10 dự án đang thực hiện cùng một lúc.', 16, 1);
    END
END;
GO

-- 123. Tạo trigger để tự động cập nhật lương của chuyên gia dựa trên cấp độ kỹ năng và số năm kinh nghiệm.
ALTER TABLE ChuyenGia
ADD Luong DECIMAL(10, 2);
GO
CREATE TRIGGER update_specialist_salary
ON ChuyenGia
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE cg
    SET Luong = (
        SELECT SUM(ISNULL(ck.CapDo, 0) * 1000) -- Tính tổng lương dựa trên cấp độ của *tất cả* kỹ năng
        FROM ChuyenGia_KyNang ck
        WHERE ck.MaChuyenGia = cg.MaChuyenGia
    ) + ISNULL(i.NamKinhNghiem, 0) * 500
    FROM ChuyenGia cg
    INNER JOIN INSERTED i ON cg.MaChuyenGia = i.MaChuyenGia;
END;
GO

-- 124. Tạo trigger để tự động gửi thông báo khi một dự án sắp đến hạn (còn 7 ngày).
CREATE TABLE ThongBao (ID INT IDENTITY PRIMARY KEY, Message NVARCHAR(255), NotificationDate DATETIME);
GO
CREATE TRIGGER notify_project_deadline
ON DuAn
AFTER UPDATE
AS
BEGIN
    DECLARE @project_id INT, @end_date DATE, @current_date DATE;
    SELECT @project_id = MaDuAn, @end_date = NgayKetThuc FROM INSERTED;

    SET @current_date = GETDATE();

    IF DATEDIFF(DAY, @current_date, @end_date) = 7
    BEGIN
        INSERT INTO ThongBao (Message, NotificationDate)
        VALUES ('Dự án ' + CAST(@project_id AS NVARCHAR(10)) + ' sắp đến hạn trong 7 ngày!', GETDATE());
    END
END;
GO
-- 125. Tạo trigger để ngăn chặn việc xóa hoặc cập nhật thông tin của chuyên gia đang tham gia dự án.
CREATE TRIGGER prevent_update_or_delete_specialist_in_project
ON ChuyenGia
INSTEAD OF DELETE, UPDATE
AS
BEGIN
    DECLARE @specialist_id INT;
    SELECT @specialist_id = MaChuyenGia FROM DELETED;

    IF EXISTS (SELECT 1 FROM ChuyenGia_DuAn WHERE MaChuyenGia = @specialist_id)
    BEGIN
        RAISERROR('Không thể xóa hoặc cập nhật chuyên gia đang tham gia dự án.', 16, 1);
    END
    ELSE
    BEGIN
        DELETE FROM ChuyenGia WHERE MaChuyenGia = @specialist_id;
    END
END;

-- 126. Tạo trigger để tự động cập nhật số lượng chuyên gia trong mỗi chuyên ngành.
CREATE TABLE ThongKeChuyenNganh (ID INT IDENTITY PRIMARY KEY, ChuyenNganh NVARCHAR(50), SpecialistCount INT);
GO
CREATE TRIGGER update_specialist_count_by_department
ON ChuyenGia
AFTER INSERT, DELETE
AS
BEGIN
    DECLARE @department_id NVARCHAR(50), @specialist_count INT;
    SELECT @department_id = ChuyenNganh FROM INSERTED;

    SELECT @specialist_count = COUNT(*) FROM ChuyenGia WHERE ChuyenNganh = @department_id;

    UPDATE ThongKeChuyenNganh
    SET SpecialistCount = @specialist_count
    WHERE ChuyenNganh = @department_id;
END;

-- 127. Tạo trigger để tự động tạo bản sao lưu của dự án khi nó được đánh dấu là hoàn thành.
CREATE TABLE DuAnHoanThanh (ID INT IDENTITY PRIMARY KEY, MaDuAn INT, TenDuAn NVARCHAR(255), NgayBatDau DATE, NgayKetThuc DATE, TrangThai NVARCHAR(50), CompletionDate DATETIME);
GO
CREATE TRIGGER backup_completed_project
ON DuAn
AFTER UPDATE
AS
BEGIN
    DECLARE @project_id INT, @status NVARCHAR(50), @name NVARCHAR(255), @start_date DATE, @end_date DATE;
    SELECT @project_id = MaDuAn, @status = TrangThai, @name = TenDuAn, @start_date = NgayBatDau, @end_date = NgayKetThuc FROM INSERTED;

    IF @status = 'Hoan thanh'
    BEGIN
        INSERT INTO DuAnHoanThanh (MaDuAn, TenDuAn, NgayBatDau, NgayKetThuc, TrangThai, CompletionDate)
        VALUES (@project_id, @name, @start_date, @end_date, @status, GETDATE());
    END
END;
GO
-- 128. Tạo trigger để tự động cập nhật điểm đánh giá trung bình của công ty dựa trên điểm đánh giá của các dự án.
ALTER TABLE DuAn
ADD DiemDanhGia INT;
ALTER TABLE CongTy
ADD DiemDanhGiaTrungBinh INT;
GO
CREATE TRIGGER update_company_average_rating
ON DuAn
AFTER UPDATE, INSERT, DELETE
AS
BEGIN
    DECLARE @company_id INT, @average_rating DECIMAL(5, 2);

    SELECT @company_id = MaCongTy FROM INSERTED;
    IF @company_id IS NULL
        SELECT @company_id = MaCongTy FROM DELETED;

    SELECT @average_rating = AVG(DiemDanhGia) 
    FROM DuAn
    WHERE MaCongTy = @company_id;

    UPDATE CongTy
    SET DiemDanhGiaTrungBinh = @average_rating
    WHERE MaCongTy = @company_id;
END;
GO

-- 129. Tạo trigger để tự động phân công chuyên gia vào dự án dựa trên kỹ năng và kinh nghiệm. 
ALTER TABLE DuAn
ADD KyNangYeuCau NVARCHAR(50),
    KinhNghiemYeuCau INT;
GO
CREATE TRIGGER assign_specialists_to_project
ON DuAn
AFTER INSERT
AS
BEGIN
    DECLARE @project_id INT, @required_skill NVARCHAR(50), @required_experience INT;

    SELECT @project_id = MaDuAn, @required_skill = KyNangYeuCau, @required_experience = KinhNghiemYeuCau
    FROM INSERTED;

    INSERT INTO ChuyenGia_DuAn (MaDuAn, MaChuyenGia)
    SELECT @project_id, c.MaChuyenGia
    FROM ChuyenGia c
    JOIN ChuyenGia_KyNang ckn ON c.MaChuyenGia = ckn.MaChuyenGia
    WHERE ckn.MaKyNang = @required_skill
    AND c.NamKinhNghiem >= @required_experience
    AND NOT EXISTS (SELECT 1 FROM ChuyenGia_DuAn WHERE MaDuAn = @project_id AND MaChuyenGia = c.MaChuyenGia);
END;
GO


-- 130. Tạo trigger để tự động cập nhật trạng thái "bận" của chuyên gia khi họ được phân công vào dự án mới.
ALTER TABLE ChuyenGia
ADD TrangThai NVARCHAR(10);
GO
CREATE TRIGGER update_specialist_status
ON ChuyenGia_DuAn
AFTER INSERT
AS
BEGIN
    DECLARE @specialist_id INT;
    SELECT @specialist_id = MaChuyenGia FROM INSERTED;

    UPDATE ChuyenGia
    SET TrangThai = N'Bận'
    WHERE MaChuyenGia = @specialist_id;
END;
GO
-- 131. Tạo trigger để ngăn chặn việc thêm kỹ năng trùng lặp cho một chuyên gia.
CREATE TRIGGER prevent_duplicate_skills
ON ChuyenGia_KyNang
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @chuyenGia_id INT, @skill_id INT;
    SELECT @chuyenGia_id = MaChuyenGia, @skill_id = MaKyNang FROM INSERTED;

    IF EXISTS (SELECT 1 FROM ChuyenGia_KyNang WHERE MaChuyenGia = @chuyenGia_id AND MaKyNang = @skill_id)
    BEGIN
        RAISERROR('Kỹ năng này đã tồn tại cho chuyên gia.', 16, 1);
    END
    ELSE
    BEGIN
        INSERT INTO ChuyenGia_KyNang (MaChuyenGia, MaKyNang)
        SELECT MaChuyenGia, MaKyNang FROM INSERTED;
    END
END;
GO
-- 132. Tạo trigger để tự động tạo báo cáo tổng kết khi một dự án kết thúc.
CREATE TRIGGER generate_project_report
ON DuAn
AFTER UPDATE
AS
BEGIN
    DECLARE @project_id INT, @status NVARCHAR(50), @start_date DATE, @end_date DATE;
    
    DECLARE report_cursor CURSOR FOR
    SELECT MaDuAn, TrangThai, NgayBatDau, NgayKetThuc
    FROM INSERTED;

    OPEN report_cursor;

    FETCH NEXT FROM report_cursor INTO @project_id, @status, @start_date, @end_date;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF @status = 'Hoan thanh'
        BEGIN
            DECLARE @report_content NVARCHAR(MAX) = 'Báo cáo tổng kết dự án ' + CAST(@project_id AS NVARCHAR(10)) + ':
            * Ngày bắt đầu: ' + CAST(@start_date AS NVARCHAR(10)) + '
            * Ngày kết thúc: ' + CAST(@end_date AS NVARCHAR(10)) + '
            * ... (thêm các thông tin khác như thành viên dự án, chi phí,...)';

            INSERT INTO BaoCao (MaDuAn, NoiDungBaoCao, NgayTaoBaoCao)
            VALUES (@project_id, @report_content, GETDATE());
        END;

        FETCH NEXT FROM report_cursor INTO @project_id, @status, @start_date, @end_date;
    END;

    CLOSE report_cursor;
    DEALLOCATE report_cursor;
END;
GO

-- 133. Tạo trigger để tự động cập nhật thứ hạng của công ty dựa trên số lượng dự án hoàn thành và điểm đánh giá.
ALTER TABLE CongTy
ADD ThuHang INT;
GO
CREATE TRIGGER update_company_ranking
ON DuAn
AFTER UPDATE
AS
BEGIN
    DECLARE @company_id INT, @completed_projects INT, @average_rating DECIMAL(3, 2);
    SELECT @company_id = MaCongTy FROM INSERTED;

    SELECT @completed_projects = COUNT(*) FROM DuAn WHERE MaCongTy = @company_id AND TrangThai = 'Hoan thanh';
    SELECT @average_rating = AVG(DiemDanhGia) FROM DuAn WHERE MaCongTy = @company_id;

    UPDATE CongTy
    SET ThuHang = (@completed_projects * @average_rating) 
    WHERE MaCongTy = @company_id;
END;
GO
-- 134. Tạo trigger để tự động gửi thông báo khi một chuyên gia được thăng cấp (dựa trên số năm kinh nghiệm).
CREATE TRIGGER notify_specialist_promotion
ON ChuyenGia
AFTER UPDATE
AS
BEGIN
    DECLARE @specialist_id INT, @old_experience INT, @new_experience INT;
    SELECT @specialist_id = MaChuyenGia, @old_experience = NamKinhNghiem FROM DELETED;
    SELECT @specialist_id = MaChuyenGia, @new_experience = NamKinhNghiem FROM INSERTED;

    IF @new_experience > @old_experience AND @new_experience >= 5
    BEGIN
        PRINT 'Chúc mừng chuyên gia ' + CAST(@specialist_id AS NVARCHAR(10)) + ' đã được thăng cấp!';
    END
END;
GO
-- 135. Tạo trigger để tự động cập nhật trạng thái "khẩn cấp" cho dự án khi thời gian còn lại ít hơn 10% tổng thời gian dự án.
CREATE TRIGGER update_project_urgent_status
ON DuAn
AFTER UPDATE
AS
BEGIN
    DECLARE @project_id INT, @start_date DATE, @end_date DATE, @current_date DATE;
    SELECT @project_id = MaDuAn, @start_date = NgayBatDau, @end_date = NgayKetThuc FROM INSERTED;

    SET @current_date = GETDATE();

    IF DATEDIFF(DAY, @current_date, @end_date) < DATEDIFF(DAY, @start_date, @end_date) * 0.1
    BEGIN
        UPDATE DuAn
        SET TrangThai = 'Khan cap'
        WHERE MaDuAn = @project_id;
    END
END;
GO
-- 136. Tạo trigger để tự động cập nhật số lượng dự án đang thực hiện của mỗi chuyên gia.
ALTER TABLE ChuyenGia
ADD SoDuAnDangThucHien INT;
GO
CREATE TRIGGER update_active_projects_count
ON ChuyenGia_DuAn
AFTER INSERT, DELETE
AS
BEGIN
    DECLARE @specialist_id INT, @active_projects_count INT;
    SELECT @specialist_id = MaChuyenGia FROM INSERTED;

    SELECT @active_projects_count = COUNT(*) 
    FROM ChuyenGia_DuAn
	JOIN DuAn On ChuyenGia_DuAn.MaDuAn=DuAn.MaDuAn
    WHERE MaChuyenGia = @specialist_id AND TrangThai = 'Dang thuc hien';

    UPDATE ChuyenGia
    SET SoDuAnDangThucHien = @active_projects_count
    WHERE MaChuyenGia = @specialist_id;
END;
GO
-- 137. Tạo trigger để tự động tính toán và cập nhật tỷ lệ thành công của công ty dựa trên số dự án hoàn thành và tổng số dự án.
ALTER TABLE CongTy
ADD TyLeThanhCong DECIMAL(5, 2);
GO
CREATE TRIGGER update_company_success_rate
ON DuAn
AFTER UPDATE
AS
BEGIN
    DECLARE @company_id INT, @completed_projects INT, @total_projects INT, @success_rate DECIMAL(5, 2);
    SELECT @company_id = MaCongTy FROM INSERTED;

    SELECT @completed_projects = COUNT(*) 
    FROM DuAn
    WHERE MaCongTy = @company_id AND TrangThai = 'Hoan thanh';

    SELECT @total_projects = COUNT(*) 
    FROM DuAn
    WHERE MaCongTy = @company_id;

    IF @total_projects > 0
    BEGIN
        SET @success_rate = (@completed_projects * 100.0) / @total_projects;
        UPDATE CongTy
        SET TyLeThanhCong = @success_rate
        WHERE MaCongTy = @company_id;
    END
END;
GO
-- 138. Tạo trigger để tự động ghi log mỗi khi có thay đổi trong bảng lương của chuyên gia.
CREATE TRIGGER log_salary_changes
ON ChuyenGia
AFTER UPDATE
AS
BEGIN
    DECLARE @specialist_id INT, @old_salary DECIMAL(10, 2), @new_salary DECIMAL(10, 2);
    SELECT @specialist_id = MaChuyenGia, @old_salary = Luong FROM DELETED;
    SELECT @specialist_id = MaChuyenGia, @new_salary = Luong FROM INSERTED;

    IF @old_salary != @new_salary
    BEGIN
        INSERT INTO LogTable (Action, TableName, RecordID, OldValue, NewValue, ChangeDate)
        VALUES ('UPDATE', 'ChuyenGia', @specialist_id, CAST(@old_salary AS NVARCHAR(20)), CAST(@new_salary AS NVARCHAR(20)), GETDATE());
    END
END;
GO
-- 139. Tạo trigger để tự động cập nhật số lượng chuyên gia cấp cao trong mỗi công ty.
ALTER TABLE CongTy
ADD SoChuyenGiaCapCao INT;
GO
CREATE TRIGGER update_high_level_specialists_count
ON ChuyenGia
AFTER INSERT, DELETE
AS
BEGIN
    DECLARE @company_id INT, @high_level_specialists_count INT;

    SELECT @company_id = MaCongTy
    FROM DuAn
    WHERE MaDuAn IN (SELECT MaDuAn FROM ChuyenGia_DuAn WHERE MaChuyenGia IN (SELECT MaChuyenGia FROM INSERTED));

    SELECT @high_level_specialists_count = COUNT(*) 
    FROM ChuyenGia_KyNang ckn
    JOIN ChuyenGia_DuAn cgd ON ckn.MaChuyenGia = cgd.MaChuyenGia
    WHERE cgd.MaDuAn IN (SELECT MaDuAn FROM ChuyenGia_DuAn WHERE MaChuyenGia IN (SELECT MaChuyenGia FROM INSERTED))
    AND ckn.CapDo >= 4;

    UPDATE CongTy
    SET SoChuyenGiaCapCao = @high_level_specialists_count
    WHERE MaCongTy = @company_id;
END;
GO



-- 140. Tạo trigger để tự động cập nhật trạng thái "cần bổ sung nhân lực" cho dự án khi số lượng chuyên gia tham gia ít hơn yêu cầu. 
ALTER TABLE DuAn
ADD SoChuyenGiaYeuCau INT;
ALTER TABLE DuAn
ADD TrangThai NVARCHAR(40);
GO

CREATE TRIGGER update_project_need_more_staff
ON ChuyenGia_DuAn
AFTER INSERT, DELETE
AS
BEGIN
    DECLARE @project_id INT, @required_staff INT, @current_staff INT;

    SELECT @project_id = MaDuAn FROM INSERTED; 
    IF @project_id IS NULL SELECT @project_id = MaDuAn FROM DELETED; 

    SELECT @required_staff = SoChuyenGiaYeuCau FROM DuAn WHERE MaDuAn = @project_id;

    SELECT @current_staff = COUNT(*) FROM ChuyenGia_DuAn WHERE MaDuAn = @project_id;

    IF @current_staff < @required_staff
    BEGIN
        UPDATE DuAn
        SET TrangThai = N'cần bổ sung nhân lực'
        WHERE MaDuAn = @project_id;
    END
    ELSE IF @current_staff >= @required_staff AND EXISTS (SELECT 1 FROM DuAn WHERE MaDuAn = @project_id AND TrangThai = N'cần bổ sung nhân lực')
    BEGIN
        UPDATE DuAn
        SET TrangThai = N'Dang thuc hien'
        WHERE MaDuAn = @project_id;
    END
END;
GO
