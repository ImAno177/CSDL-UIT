USE QUANLYBANHANG
--19. Có bao nhiêu hóa đơn không phải của khách hàng đăng ký thành viên mua? 
SELECT COUNT(*) AS SOHD_KH_KHONG_DK
FROM HOADON
WHERE MAKH IS NULL
--20. Có bao nhiêu sản phẩm khác nhau được bán ra trong năm 2006.
SELECT COUNT(DISTINCT CTHD.MASP) AS SOSP
FROM CTHD 
JOIN HOADON ON CTHD.SOHD = HOADON.SOHD
WHERE YEAR(HOADON.NGHD) = 2006
--21. Cho biết trị giá hóa đơn cao nhất, thấp nhất là bao nhiêu?
SELECT MAX(TRIGIA) GTCAONHAT, MIN(TRIGIA) GTTHAPNHAT FROM HOADON
--22. Trị giá trung bình của tất cả các hóa đơn được bán ra trong năm 2006 là bao nhiêu?
SELECT AVG(TRIGIA) GTTB FROM HOADON
WHERE YEAR(NGHD) = 2006
--23. Tính doanh thu bán hàng trong năm 2006. 
SELECT SUM(TRIGIA) DOANHTHU FROM HOADON
WHERE YEAR(NGHD) = 2006
--24. Tìm số hóa đơn có trị giá cao nhất trong năm 2006. 
SELECT TOP 1 SOHD, TRIGIA FROM HOADON
WHERE YEAR(NGHD) = 2006
ORDER BY TRIGIA DESC
--25. Tìm họ tên khách hàng đã mua hóa đơn có trị giá cao nhất trong năm 2006. 
SELECT HOTEN FROM KHACHHANG
WHERE MAKH IN 
	(
	SELECT TOP 1 MAKH FROM HOADON
	WHERE YEAR(NGHD) = 2006
	ORDER BY TRIGIA DESC
	)
--26. In ra danh sách 3 khách hàng (MAKH, HOTEN) có doanh số cao nhất. 
SELECT TOP 3 KHACHHANG.MAKH, HOTEN 
FROM KHACHHANG
JOIN HOADON ON HOADON.MAKH = KHACHHANG.MAKH
GROUP BY KHACHHANG.MAKH, KHACHHANG.HOTEN
ORDER BY SUM(TRIGIA) DESC
--27. In ra danh sách các sản phẩm (MASP, TENSP) có giá bán bằng 1 trong 3 mức giá cao nhất. 
SELECT MASP, TENSP FROM SANPHAM
WHERE GIA IN
	(
	SELECT TOP 3 GIA FROM SANPHAM
	ORDER BY GIA DESC
	)
--28. In ra danh sách các sản phẩm (MASP, TENSP) do “Thai Lan” sản xuất có giá bằng 1 trong 3 mức giá cao nhất (của tất cả các sản phẩm). 
SELECT MASP, TENSP FROM SANPHAM
WHERE GIA IN
	(
	SELECT TOP 3 GIA FROM SANPHAM
	ORDER BY GIA DESC
	)
	AND NUOCSX = N'Thai Lan'
--29. In ra danh sách các sản phẩm (MASP, TENSP) do “Trung Quoc” sản xuất có giá bằng 1 trong 3 mức giá cao nhất (của sản phẩm do “Trung Quoc” sản xuất). 
SELECT MASP, TENSP FROM SANPHAM
WHERE GIA IN
	(
	SELECT TOP 3 GIA FROM SANPHAM
	WHERE NUOCSX = N'Trung Quoc'
	ORDER BY GIA DESC
	)
	AND NUOCSX = N'Trung Quoc'
--30. * In ra danh sách 3 khách hàng có doanh số cao nhất (sắp xếp theo kiểu xếp hạng). 
SELECT TOP 3 RANK() OVER(ORDER BY DOANHSO DESC) THUHANG, KHACHHANG.MAKH, HOTEN, SUM(HOADON.TRIGIA) AS DOANHSO
FROM KHACHHANG
JOIN HOADON ON HOADON.MAKH = KHACHHANG.MAKH
GROUP BY KHACHHANG.MAKH, KHACHHANG.HOTEN, DOANHSO
ORDER BY SUM(TRIGIA) DESC
--31. Tính tổng số sản phẩm do “Trung Quoc” sản xuất. 
SELECT COUNT (MASP) SOSP_TQ FROM SANPHAM
WHERE NUOCSX = N'Trung Quoc'
--32. Tính tổng số sản phẩm của từng nước sản xuất. 
SELECT NUOCSX, COUNT (MASP) SOSP FROM SANPHAM
GROUP BY NUOCSX
--33. Với từng nước sản xuất, tìm giá bán cao nhất, thấp nhất, trung bình của các sản phẩm. 
SELECT NUOCSX, MAX(GIA) GIACAONHAT, MIN(GIA) GIATHAPNHAT, AVG(GIA) GIATB FROM SANPHAM
GROUP BY NUOCSX
--34. Tính doanh thu bán hàng mỗi ngày. 
SELECT NGHD, SUM(TRIGIA) DOANHTHU FROM HOADON
GROUP BY NGHD
--35. Tính tổng số lượng của từng sản phẩm bán ra trong tháng 10/2006.
SELECT SP.TENSP, SP.MASP, SUM(CTHD.SL) SLSP FROM SANPHAM SP
JOIN CTHD ON SP.MASP = CTHD.	MASP
JOIN HOADON HD ON CTHD.SOHD = HD.SOHD
WHERE MONTH(HD.NGHD)=10
AND YEAR(HD.NGHD)=2006
GROUP BY CTHD.MASP, SP.TENSP, SP.MASP
GO
--36. Tính doanh thu bán hàng của từng tháng trong năm 2006. 
WITH THANG_2006 AS (
    SELECT 1 AS THANG
    UNION ALL SELECT 2
    UNION ALL SELECT 3
    UNION ALL SELECT 4
    UNION ALL SELECT 5
    UNION ALL SELECT 6
    UNION ALL SELECT 7
    UNION ALL SELECT 8
    UNION ALL SELECT 9
    UNION ALL SELECT 10
    UNION ALL SELECT 11
    UNION ALL SELECT 12
)
SELECT T.THANG, COALESCE(SUM(H.TRIGIA), 0) AS DOANHTHU
FROM THANG_2006 T
LEFT JOIN HOADON H ON T.THANG = MONTH(H.NGHD) AND YEAR(H.NGHD) = 2006
GROUP BY T.THANG
ORDER BY T.THANG
GO
--37. Tìm hóa đơn có mua ít nhất 4 sản phẩm khác nhau. 
SELECT SOHD FROM CTHD
GROUP BY SOHD
HAVING COUNT(DISTINCT MASP) >3
--38. Tìm hóa đơn có mua 3 sản phẩm do “Viet Nam” sản xuất (3 sản phẩm khác nhau). 
SELECT CTHD.SOHD FROM CTHD
JOIN SANPHAM SP ON CTHD.MASP=SP.MASP
WHERE NUOCSX = N'Viet Nam'
GROUP BY SOHD
HAVING COUNT (DISTINCT CTHD.MASP) = 3
--39. Tìm khách hàng (MAKH, HOTEN) có số lần mua hàng nhiều nhất. 
SELECT MAKH, HOTEN FROM KHACHHANG
WHERE MAKH IN
	(
	SELECT TOP 1 MAKH FROM HOADON 
	GROUP BY MAKH
	ORDER BY COUNT(*) DESC
	)
--40. Tháng mấy trong năm 2006, doanh số bán hàng cao nhất ? 
SELECT TOP 1 MONTH(NGHD) THANG_CAO_NHAT, SUM(TRIGIA) DOANHTHU FROM HOADON
WHERE YEAR(NGHD) = 2006
GROUP BY MONTH(NGHD)
ORDER BY SUM(TRIGIA) DESC
--41. Tìm sản phẩm (MASP, TENSP) có tổng số lượng bán ra thấp nhất trong năm 2006. 
SELECT MASP, TENSP FROM SANPHAM
WHERE MASP IN 
	(
	SELECT TOP 1 MASP FROM CTHD
	JOIN HOADON HD ON HD.SOHD = CTHD.SOHD
	WHERE YEAR(HD.NGHD) = 2006
	GROUP BY MASP
	ORDER BY SUM(SL) 
	)
--42. *Mỗi nước sản xuất, tìm sản phẩm (MASP,TENSP) có giá bán cao nhất. 
SELECT NUOCSX, MASP, TENSP FROM (
	SELECT NUOCSX, MASP, TENSP, GIA, RANK() OVER (PARTITION BY NUOCSX ORDER BY GIA DESC) RANK_GIA FROM SANPHAM
) a
WHERE RANK_GIA = 1
GO
--43. Tìm nước sản xuất sản xuất ít nhất 3 sản phẩm có giá bán khác nhau. 
SELECT NUOCSX 
FROM SANPHAM
GROUP BY NUOCSX 
HAVING COUNT(DISTINCT GIA) >2;
--44. *Trong 10 khách hàng có doanh số cao nhất, tìm khách hàng có số lần mua hàng nhiều nhất.
SELECT MAKH, HOTEN FROM KHACHHANG
WHERE MAKH IN
	(
	SELECT TOP 1 MAKH FROM HOADON 
	GROUP BY MAKH
	ORDER BY COUNT(*) DESC
	)
USE QUANLYHOCVU
--19. Khoa nào (mã khoa, tên khoa) được thành lập sớm nhất.
SELECT MAKHOA, TENKHOA
FROM KHOA
WHERE NGTLAP = (SELECT MIN(NGTLAP) FROM KHOA);
--20. Có bao nhiêu giáo viên có học hàm là “GS” hoặc “PGS”. 
SELECT COUNT(*) AS SLGV
FROM GIAOVIEN
WHERE HOCHAM IN ('GS', 'PGS');
--21. Thống kê có bao nhiêu giáo viên có học vị là “CN”, “KS”, “Ths”, “TS”, “PTS” trong mỗi khoa. 
SELECT MAKHOA, HOCVI, COUNT(*) SLGV
FROM GIAOVIEN
WHERE HOCVI IN ('CN', 'KS', 'Ths', 'TS', 'PTS')
GROUP BY MAKHOA, HOCVI;
--22. Mỗi môn học thống kê số lượng học viên theo kết quả (đạt và không đạt). 
SELECT MAMH, KQUA, COUNT(*) AS SLHV
FROM KETQUATHI
GROUP BY MAMH, KQUA;
--23. Tìm giáo viên (mã giáo viên, họ tên) là giáo viên chủ nhiệm của một lớp, đồng thời dạy cho lớp đó ít nhất một môn học. 
SELECT DISTINCT GV.MAGV, GV.HOTEN
FROM GIAOVIEN GV
JOIN LOP L ON GV.MAGV = L.MAGVCN
JOIN GIANGDAY GD ON GD.MALOP = L.MALOP AND GD.MAGV = GV.MAGV;

--24. Tìm họ tên lớp trưởng của lớp có sỉ số cao nhất. 
SELECT HV.HO, HV.TEN
FROM HOCVIEN HV
JOIN LOP L ON HV.MAHV = L.TRGLOP
WHERE L.SISO = (SELECT MAX(SISO) FROM LOP);

--25. * Tìm họ tên những LOPTRG thi không đạt quá 3 môn (mỗi môn đều thi không đạt ở tất cả các lần thi). 
SELECT HV.HO, HV.TEN
FROM HOCVIEN HV
JOIN LOP L ON HV.MAHV = L.TRGLOP
WHERE HV.MAHV IN (
    SELECT MAHV
    FROM KETQUATHI
    WHERE KQUA = 'Khong Dat'
    GROUP BY MAHV, MAMH
    HAVING COUNT(DISTINCT LANTHI) = (SELECT COUNT(*) FROM KETQUATHI KQ WHERE KQ.MAHV = MAHV AND KQ.MAMH = MAMH AND KQ.KQUA = 'Khong Dat')
       AND COUNT(MAMH) > 3
);
--26. Tìm học viên (mã học viên, họ tên) có số môn đạt điểm 9, 10 nhiều nhất. 
WITH DIEM_9_10 AS (
    SELECT MAHV, COUNT(CASE WHEN DIEM IN (9, 10) THEN 1 END) AS SoLanDiemCao
    FROM KETQUATHI
    GROUP BY MAHV
)
SELECT HV.MAHV, HV.HO, HV.TEN
FROM HOCVIEN HV
JOIN DIEM_9_10 A ON HV.MAHV = A.MAHV
WHERE A.SoLanDiemCao = (SELECT MAX(SoLanDiemCao) FROM DIEM_9_10);

--27. Trong từng lớp, tìm học viên (mã học viên, họ tên) có số môn đạt điểm 9, 10 nhiều nhất. 
WITH DIEM_9_10 AS (
    SELECT LOP.MALOP, KQT.MAHV, COUNT(CASE WHEN DIEM IN (9, 10) THEN 1 END) AS SoLanDiemCao
    FROM KETQUATHI KQT
	JOIN HOCVIEN HV ON HV.MAHV=KQT.MAHV
	JOIN LOP ON LOP.MALOP=HV.MALOP
    GROUP BY LOP.MALOP, KQT.MAHV
)
SELECT A.MALOP,HV.MAHV, HV.HO, HV.TEN, A.SoLanDiemCao
FROM HOCVIEN HV
JOIN DIEM_9_10 A ON HV.MAHV = A.MAHV
WHERE A.SoLanDiemCao IN (SELECT MAX(SoLanDiemCao) FROM DIEM_9_10 GROUP BY MALOP)
--28. Trong từng học kỳ của từng năm, mỗi giáo viên phân công dạy bao nhiêu môn học, bao nhiêu lớp. 
SELECT NAM, HOCKY, MAGV, COUNT(DISTINCT MAMH) AS SOMON, COUNT(DISTINCT MALOP) AS SOLOP
FROM GIANGDAY
GROUP BY NAM, HOCKY, MAGV;
--29. Trong từng học kỳ của từng năm, tìm giáo viên (mã giáo viên, họ tên) giảng dạy nhiều nhất. 
WITH SLGD AS (
    SELECT GD.MAGV, GV.HOTEN, GD.HOCKY, GD.NAM, COUNT(*) AS SoLuongGiangDay
    FROM GIANGDAY GD
    JOIN GIAOVIEN GV ON GD.MAGV = GV.MAGV
    GROUP BY GD.MAGV, GV.HOTEN, GD.HOCKY, GD.NAM
)
SELECT  SLGD.NAM,SLGD.HOCKY,SLGD.MAGV, SLGD.HOTEN, SLGD.SoLuongGiangDay
FROM SLGD
JOIN (
    SELECT HOCKY, NAM, MAX(SoLuongGiangDay) AS MaxSoLuongGiangDay
    FROM SLGD
    GROUP BY HOCKY, NAM
) AS GDCAONHAT ON SLGD.HOCKY = GDCAONHAT.HOCKY
                   AND SLGD.NAM = GDCAONHAT.NAM
                   AND SLGD.SoLuongGiangDay = GDCAONHAT.MaxSoLuongGiangDay
ORDER BY NAM, HOCKY 
--30. Tìm môn học (mã môn học, tên môn học) có nhiều học viên thi không đạt (ở lần thi thứ 1) nhất. 
SELECT MAMH, TENMH
FROM MONHOC
WHERE MAMH IN (
    SELECT TOP 1 MAMH
    FROM KETQUATHI
    WHERE KQUA = 'Khong Dat' AND LANTHI = 1
    GROUP BY MAMH
    ORDER BY COUNT(*) DESC
);
--31. Tìm học viên (mã học viên, họ tên) thi môn nào cũng đạt (chỉ xét lần thi thứ 1). 
SELECT MAHV, HO, TEN
FROM HOCVIEN
WHERE MAHV NOT IN (
    SELECT MAHV
    FROM KETQUATHI
    WHERE KQUA = 'Khong Dat' AND LANTHI = 1
);
--32. * Tìm học viên (mã học viên, họ tên) thi môn nào cũng đạt (chỉ xét lần thi sau cùng). 
SELECT MAHV, HO, TEN
FROM HOCVIEN
WHERE MAHV NOT IN (
    SELECT MAHV
    FROM KETQUATHI K1
    WHERE KQUA = 'Khong Dat'
    AND LANTHI = (SELECT MAX(LANTHI) FROM KETQUATHI K2 WHERE K1.MAHV = K2.MAHV AND K1.MAMH = K2.MAMH)
);
--33. * Tìm học viên (mã học viên, họ tên) đã thi tất cả các môn và đều đạt (chỉ xét lần thi thứ 1). 
SELECT MAHV, HO, TEN
FROM HOCVIEN
WHERE MAHV NOT IN (
    SELECT MAHV
    FROM MONHOC M
    LEFT JOIN KETQUATHI K ON M.MAMH = K.MAMH AND K.LANTHI = 1
    WHERE K.KQUA = 'Khong Dat'
);
--34. * Tìm học viên (mã học viên, họ tên) đã thi tất cả các môn và đều đạt (chỉ xét lần thi sau cùng). 
SELECT MAHV, HO, TEN
FROM HOCVIEN
WHERE MAHV NOT IN (
    SELECT MAHV
    FROM MONHOC M
    LEFT JOIN KETQUATHI K ON M.MAMH = K.MAMH
    WHERE K.KQUA = 'Khong Dat'
    AND K.LANTHI = (SELECT MAX(LANTHI) FROM KETQUATHI K2 WHERE K.MAHV = K2.MAHV AND K.MAMH = K2.MAMH)
);
--35. ** Tìm học viên (mã học viên, họ tên) có điểm thi cao nhất trong từng môn (lấy điểm ở lần thi sau cùng). 
WITH LanThiCuoi AS (
    SELECT MAHV, MAMH, MAX(LANTHI) AS LanThiCuoi
    FROM KETQUATHI
    GROUP BY MAHV, MAMH
),
DiemCaoNhat AS (
    SELECT KQ.MAHV, KQ.MAMH, KQ.DIEM
    FROM KETQUATHI KQ
    JOIN LanThiCuoi LTC ON KQ.MAHV = LTC.MAHV
                        AND KQ.MAMH = LTC.MAMH
                        AND KQ.LANTHI = LTC.LanThiCuoi
)
SELECT DCN.MAMH, DCN.MAHV, HV.HO, HV.TEN, DCN.DIEM
FROM DiemCaoNhat DCN
JOIN HOCVIEN HV ON DCN.MAHV = HV.MAHV
JOIN (
    SELECT MAMH, MAX(DIEM) AS MaxDiem
    FROM DiemCaoNhat
    GROUP BY MAMH
) AS DiemToiDaMonHoc ON DCN.MAMH = DiemToiDaMonHoc.MAMH
                     AND DCN.DIEM = DiemToiDaMonHoc.MaxDiem
ORDER BY MAMH