-- NULL
SET SERVEROUTPUT ON
DECLARE
	V_NUM1 NUMBER(4,2); -- �������� (NULL)
	V_NUM2 NUMBER(4,2) := 30; -- ���� ���� AND �ʱⰪ �Ҵ�
BEGIN
	IF (V_NUM1 > 1 AND V_NUM2 < 31) THEN -- NULL AND TRUE 
		DBMS_OUTPUT.PUT_LINE('(V_NUM1 > 1 AND V_NUM2 < 31) IS TRUE '); 
	ELSIF NOT (V_NUM1 > 1 AND V_NUM2 < 31) THEN
		DBMS_OUTPUT.PUT_LINE('(V_NUM1 > 1 AND V_NUM2 < 31) IS FALSE '); 
	ELSE 
		DBMS_OUTPUT.PUT_LINE(' NOT TRUE, NOT FALSE... ???? '); 
	END IF;
END;
/

-- Nested Block
SET SERVEROUTPUT ON
<<MAIN_BLK>> -- ���� BLOCK�� LABEL
DECLARE
	V_DNAME VARCHAR2(14);
	V_DEPTNO NUMBER(2);
	V_LOC VARCHAR2(13);
BEGIN
	V_DEPTNO := 77;
	V_DNAME := 'Global var';
	V_LOC := 'Main_Block';
	<<LOCAL_BLOCK_1>> -- ���� BLOCK�� LABEL
	DECLARE -- NESTED BLOCK ���� (����ó��, ���ȭ �뵵)
		V_DNAME VARCHAR2(14);
		V_DEPTNO NUMBER(2);
	BEGIN
		V_DEPTNO := 88;
		V_DNAME := 'Local var1';
		V_LOC := 'Nested_Block1';
		INSERT INTO DEPT 
		VALUES(V_DEPTNO,MAIN_BLK.V_DNAME,V_LOC);
	END LOAL_BLOCK_1;

	<<LOCAL_BLOCK_2>>
	DECLARE
		V_DNAME VARCHAR2(14);
		V_DEPTNO NUMBER(2);
	BEGIN
		V_DEPTNO := 99;
		V_DNAME := 'Local var2';
		V_LOC := 'Nested_Block2';
		INSERT INTO DEPT VALUES(V_DEPTNO,V_DNAME,V_LOC);
	END;

	INSERT INTO DEPT VALUES(V_DEPTNO,V_DNAME,V_LOC);

END MAIN_BLK; -- GLOBAL NAME LABEL ���� (������)
/

SELECT * FROM DEPT;

ROLLBACK; -- PL/SQL Block�� ��� ����� ���� Transaction�� ����ȴ�.
          -- Block�� Transaction�� �ƹ��� ���谡 ����.

SELECT * FROM DEPT;

ROLLBACK; -- PL/SQL Block�� ��� ����� ���� Transaction�� ����ȴ�.
          -- Block�� Transaction�� �ƹ��� ���谡 ����.
          
-- NESTED BLOCK 2
INSERT INTO DEPT VALUES(66,'Outer block','Outlander'); -- BLOCK �� Ʈ������� ����
<<MAIN_BLK>>
DECLARE
	V_DNAME VARCHAR2(14);
	V_DEPTNO NUMBER(2);
	V_LOC VARCHAR2(13);
BEGIN
	V_DEPTNO := 77;
	V_DNAME := 'Global var';
	V_LOC := 'Main_Block';
	<<LOCAL_BLOCK_1>>
	DECLARE
		V_DNAME VARCHAR2(14);
		V_DEPTNO NUMBER(2);
	BEGIN
		V_DEPTNO := 88;
		V_DNAME := 'Local var';
		V_LOC := 'Nested_Block1';
		INSERT INTO DEPT 
		VALUES(V_DEPTNO,MAIN_BLK.V_DNAME,V_LOC);
		COMMIT;
	END LOAL_BLOCK_1;
	<<LOCAL_BLOCK_2>>
	DECLARE
		V_DNAME VARCHAR2(14);
		V_DEPTNO NUMBER(2);
	BEGIN
		V_DEPTNO := 99;
		V_DNAME := 'Local var';
		V_LOC := 'Nested_Block2';
		INSERT INTO DEPT VALUES(V_DEPTNO,V_DNAME,V_LOC);
		ROLLBACK;
	END LOCAL_BLOCK_2;
	INSERT INTO DEPT VALUES(V_DEPTNO,V_DNAME,V_LOC); -- 77 INSERT
END MAIN_BLK;
/

SELECT * FROM DEPT;
DELETE FROM DEPT WHERE DEPTNO IN (66,77,88);
COMMIT;

-- Exception
INSERT INTO DEPT VALUES(66,'Outer block','Outlander');
<<MAIN_BLK>>
DECLARE
V_DNAME VARCHAR2(14);
V_DEPTNO NUMBER(200);
V_LOC VARCHAR2(13);
BEGIN
V_DEPTNO := 77;
V_DNAME := 'Global var';
V_LOC := 'Main_Block';

BEGIN
INSERT INTO DEPT VALUES(66,'OUTER_BLK','Main_Blk');
<<Nested_BLOCK_1>>
BEGIN
INSERT INTO DEPT VALUES(76,'LOCAL_PART1','Nested_Blk1'); 
INSERT INTO DEPT VALUES(777,'LOCAL_PART1','Nested_Blk1'); -- Run Time Error �߻�
--INSERT INTO DEPT VALUES(77,'LOCAL_PART1','Nested_Blk1'); 
INSERT INTO DEPT VALUES(78,'LOCAL_PART1','Nested_Blk1');
COMMIT;
-- Exception section
END Nested_BLOCK_1;
<<Nested_BLOCK_2>>
BEGIN
INSERT INTO DEPT VALUES(86,'LOCAL_PART2','Nested_Blk2');
COMMIT;
END Nested_BLOCK_2; 
INSERT INTO DEPT VALUES(96,'OUTER_BLK_PART','Main_Blk');
END;
/
SELECT * FROM DEPT WHERE DEPTNO IN (66,76,77,78,88,99);
DELETE FROM DEPT WHERE DEPTNO IN (66,76,77,78,88,99);
COMMIT;

-- ������� ���� (Run Time Error)
SET SERVEROUTPUT ON
BEGIN
	 INSERT INTO DEPT VALUES(66,'OUTER_BLK','Main_Blk');
	<<Nested_BLOCK_1>>
	BEGIN
		INSERT INTO DEPT VALUES(76,'LOCAL_PART1','Nested_Blk1'); 
        INSERT INTO DEPT VALUES(777,'LOCAL_PART1','Nested_Blk1'); -- 2. ���� ���� Run Time Error �߻�
	    --INSERT INTO DEPT VALUES(77,'LOCAL_PART1','Nested_Blk1'); 
		INSERT INTO DEPT VALUES(78,'LOCAL_PART1','Nested_Blk1');
		COMMIT;
  -- Exception section
	END Nested_BLOCK_1;
	<<Nested_BLOCK_2>>
	BEGIN
		INSERT INTO DEPT VALUES(86,'LOCAL_PART2','Nested_Blk2');
		COMMIT;
	END Nested_BLOCK_2; 
	INSERT INTO DEPT VALUES(96,'OUTER_BLK_PART','Main_Blk');
END;
/

SELECT * FROM DEPT WHERE DEPTNO IN (66,76,77,78,88,99);
DELETE FROM DEPT WHERE DEPTNO IN (66,76,77,78,88,99);
COMMIT;

-- EXCEPTION �߻� �� Ʈ����� ó�� �ǽ�
SET SERVEROUTPUT ON
BEGIN
	INSERT INTO DEPT VALUES(66,'OUTER_BLK','Main_Blk');
	<<Nested_BLOCK_1>>
	BEGIN
	INSERT INTO DEPT VALUES(76,'LOCAL_PART1','Nested_Blk1'); 
	INSERT INTO DEPT VALUES(777,'LOCAL_PART1','Nested_Blk1'); -- 1. Run Time Error �߻�
	--INSERT INTO DEPT VALUES(77,'LOCAL_PART1','Nested_Blk1'); 
	INSERT INTO DEPT VALUES(78,'LOCAL_PART1','Nested_Blk1');
	COMMIT;
	EXCEPTION -- Exception section, Block ���� ���� ó�� �� �߰�
		WHEN OTHERS THEN NULL;
	END Nested_BLOCK_1;
	<<Nested_BLOCK_2>>
	BEGIN
		INSERT INTO DEPT VALUES(86,'LOCAL_PART2','Nested_Blk2');
		COMMIT;
	END Nested_BLOCK_2; 
	INSERT INTO DEPT VALUES(96,'OUTER_BLK_PART','Main_Blk');
END;
/

SELECT * FROM DEPT WHERE DEPTNO IN (66,76,77,78,88,99); -- ����� ����
DELETE FROM DEPT WHERE DEPTNO IN (66,76,77,78,88,99);
COMMIT;

-- EXCEPTION ���� ����
SET SERVEROUTPUT ON
BEGIN
	INSERT INTO DEPT VALUES(66,'OUTER_BLK','Main_Blk');
	<<Nested_BLOCK_1>>
	BEGIN
		INSERT INTO DEPT VALUES(76,'LOCAL_PART1','Nested_Blk1'); 
		INSERT INTO DEPT VALUES(777,'LOCAL_PART1','Nested_Blk1'); -- Run Time Error �߻�
		--INSERT INTO DEPT VALUES(77,'LOCAL_PART1','Nested_Blk1'); 
		INSERT INTO DEPT VALUES(78,'LOCAL_PART1','Nested_Blk1');
		COMMIT;
	EXCEPTION -- Exception section
		WHEN NO_DATA_FOUND THEN
				NULL;
	END Nested_BLOCK_1;
	<<Nested_BLOCK_2>>
	BEGIN
		INSERT INTO DEPT VALUES(86,'LOCAL_PART2','Nested_Blk2');
		COMMIT;
	END Nested_BLOCK_2; 
	INSERT INTO DEPT VALUES(96,'OUTER_BLK_PART','Main_Blk');
END;
/

SELECT * FROM DEPT WHERE DEPTNO IN (66,76,77,78,86,96);
DELETE FROM DEPT WHERE DEPTNO IN (66,76,77,78,86,96);
COMMIT;

-- ����ó���� OTHERS ����
SET SERVEROUTPUT ON
BEGIN
	INSERT INTO DEPT VALUES(66,'OUTER_BLK','Main_Blk');
	<<Nested_BLOCK_1>>
	BEGIN
		INSERT INTO DEPT VALUES(76,'LOCAL_PART1','Nested_Blk1'); 
		INSERT INTO DEPT VALUES(777,'LOCAL_PART1','Nested_Blk1'); -- Run Time Error �߻�
		--INSERT INTO DEPT VALUES(77,'LOCAL_PART1','Nested_Blk1'); 
		INSERT INTO DEPT VALUES(78,'LOCAL_PART1','Nested_Blk1');
		COMMIT;
	EXCEPTION -- Exception section
		WHEN NO_DATA_FOUND THEN NULL;
		WHEN OTHERS THEN NULL;
	END Nested_BLOCK_1;
	<<Nested_BLOCK_2>>
	BEGIN
		INSERT INTO DEPT VALUES(86,'LOCAL_PART2','Nested_Blk2');
		COMMIT;
	END Nested_BLOCK_2; 
	INSERT INTO DEPT VALUES(96,'OUTER_BLK_PART','Main_Blk');
END;
/

SELECT * FROM DEPT WHERE DEPTNO IN (66,76,77,78,86,96);
DELETE FROM DEPT WHERE DEPTNO IN (66,76,77,78,86,96);
COMMIT;
          