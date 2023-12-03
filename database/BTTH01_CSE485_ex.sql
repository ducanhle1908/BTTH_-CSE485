--a

--b

--c

--d

--e

--f

--g

--h

--i

--j
CREATE PROCEDURE sp_DSBaiViet (
    IN ten_tloai_param VARCHAR(50)
)
BEGIN
    DECLARE ten_tloai_exist INT;

    SELECT COUNT(*) INTO ten_tloai_exist
    FROM theloai
    WHERE ten_tloai = ten_tloai_param;

    IF ten_tloai_exist > 0 THEN
        SELECT baiviet.ma_bviet, baiviet.tieude, baiviet.ten_bhat, tacgia.ten_tgia, theloai.ten_tloai
        FROM baiviet
        JOIN tacgia ON baiviet.ma_tgia = tacgia.ma_tgia
        JOIN theloai ON baiviet.ma_tloai = theloai.ma_tloai
        WHERE theloai.ten_tloai = ten_tloai_param;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Thể loại không tồn tại.';
    END IF;
END 

DELIMITER ;

--k
ALTER TABLE theloai
ADD SLBaiViet INT;

CREATE TRIGGER tg_CapNhatTheLoai
ON baiviet
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    UPDATE theloai
    SET SLBaiViet = (SELECT COUNT(*) FROM baiviet WHERE baiviet.ma_tloai = theloai.ma_tloai);
END;


--l
CREATE TABLE Users (
    id INT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL
);
