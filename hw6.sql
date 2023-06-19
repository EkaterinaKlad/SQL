USE lesson6;
-- 1.  Создайте процедуру, которая принимает кол-во сек и формат их в кол-во дней часов. 
-- Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '
DROP PROCEDURE proc;

DELIMITER //
CREATE PROCEDURE proc(sec INT)
	BEGIN
		CASE
			WHEN sec BETWEEN 0 AND 59 THEN
				SELECT CONCAT(sec, ' seconds');
 			WHEN sec BETWEEN 60 AND 3599 THEN
 				SELECT  CONCAT(sec DIV 60, ' minutes ',sec % 60, ' seconds');
 			WHEN sec BETWEEN 3600 AND 86400 THEN
				SELECT  CONCAT(sec DIV 3600, ' hours ', (sec % 3600) DIV 60, ' minutes ',sec % 60, ' seconds');
			ELSE
				SELECT  CONCAT(sec DIV 86400, ' days ', (sec % 86400) DIV 3600, ' hours ', 
							(sec % 7200) DIV 60, ' minutes ',sec % 60, ' seconds');
		END CASE;
	END //
    DELIMITER ;
    
    CALL proc(123456);

-- 2. Создайте функцию, которая выводит только четные числа от 1 до 10. 
-- Пример: 2,4,6,8,10 
DROP FUNCTION even_number;

DELIMITER //
CREATE FUNCTION even_number(a INT, b int)
RETURNS VARCHAR(45)
DETERMINISTIC
BEGIN 
DECLARE i INT DEFAULT 0; 
DECLARE evennum INT DEFAULT 0; 
DECLARE result VARCHAR(45) DEFAULT '0';
IF a % 2 = 0 THEN
	SET evennum = a;
ELSE 
	SET evennum = a + 1;
END IF;
SET i = (b - a) DIV 2;
SET result = evennum;
WHILE i > 0
DO        
	SET evennum = evennum + 2;
	SET result = CONCAT(result, ', ', evennum);
	SET i = i - 1;
END WHILE;
 RETURN result;
 END //
 delimiter ;
 
 select even_number(1, 10);
 
 