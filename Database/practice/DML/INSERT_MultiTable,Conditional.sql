-- Multi table INSERT
-- 1
INSERT ALL
    INTO DEPT(DEPTNO, DNAME, LOC) VALUES(55, 'Multi', 'INSERT1')
    INTO DEPT(DEPTNO, DNAME, LOC) VALUES(56, 'Multi', 'INSERT2')
    INTO DEPT(DEPTNO, DNAME, LOC) VALUES(57, 'Multi', 'INSERT3')
    SELECT 1 FROM dual;
    
SELECT * FROM DEPT; -- N�� Row 1 Insert
-- 2
ROLLBACK;
SELECT * FROM DEPT;

-- Conditional INSERT
-- 1
-- ���� ���̺��� ���� �״�� ���ο� ���̺��� �����.
CREATE TABLE BONUS_2 AS SELECT * FROM BONUS WHERE 1=2; -- FALSE

-- ���� ���̺� �����ͱ��� ��� �����ؼ� ���ο� ���̺� �����.
CREATE TABLE BONUS_3 AS SELECT * FROM BONUS WHERE 1=1; -- TRUE

DESC BONUS_2;
SELECT * FROM BONUS_2;

-- 2
-- ���� ����
INSERT ALL
	WHEN COMM > 0 THEN INTO BONUS -- ���ǿ� ���� INSERT
	WHEN COMM IS NULL THEN INTO BONUS_2
	-- ���� ����
	SELECT ename,job,sal,comm FROM emp WHERE job IN ('CLERK','SALESMAN');

SELECT * FROM bonus;
SELECT * FROM bonus_2;

-- 3
ROLLBACK;