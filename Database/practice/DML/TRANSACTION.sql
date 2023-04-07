-- TRANSACTION--
-- [TRANSACTION ���۰� ���� Ȯ���ϱ�]--
DESC EMP;
-- 1. Ʈ����� ����
INSERT INTO DEPT(DEPTNO, DNAME, LOC) VALUES(90, '�Ż����', '��⵵');

-- 2. Ʈ����� ���� ��
UPDATE EMP SET DEPTNO = 90 WHERE DEPTNO = 30;
DELETE FROM DEPT WHERE DEPTNO = 30;

-- 3. ���� �������� ������ ��ȸ�ϱ�
-- ( �ٸ� ���� ȯ�濡���� �ش� �����͸� ��ȸ�� COMMIT �������� ������� �ݿ� �ȵǴ� �� Ȯ�� )
SELECT * FROM DEPT;
SELECT * FROM EMP WHERE DEPTNO = 30;

-- 4. Ʈ����� ����
ROLLBACK;

-- 5. ROLLBACK ��� ������ Ȯ���ϱ�
SELECT * FROM DEPT;
SELECT * FROM EMP;


-- [ COMMIT �������� ROLLBACK �Ұ� Ȯ�� ]
-- 1. Ʈ����� ����
INSERT INTO EMP(EMPNO,ENAME,JOB,SAL)VALUES (1111,'ORACLE','DBA',3500);

-- 2. Ʈ����� ������
UPDATE EMP SET SAL = SAL* 1.3 WHERE EMPNO= 1111;

-- 3. Ʈ����� ���� (COMMIT)
COMMIT;

-- 4. Ʈ����� ���� (ROLLBACK)
ROLLBACK;

-- 5. ������ ��ȸ
SELECT * FROM EMP;


-- [ ���� ���� ROLLBACK ( Statement Level ROLLBACK ) ]
-- 1. ���� Ʈ����� ����
ROLLBACK;

-- 2. Ʈ����� ����
DELETE FROM EMP WHERE EMPNO = 1111;

-- 3. Ʈ����� ������, ���� �߻�
UPDATE EMP SET SAL = 123456789 WHERE EMPNO = 7788;

-- 4. ���� or skip?
UPDATE EMP SET SAL = 1234 WHERE EMPNO = 7902;

-- 5. Ʈ����� ����
COMMIT;

-- 6 Ʈ����� �Ϻθ� �ݿ�
SELECT EMPNO,SAL FROM EMP WHERE EMPNO IN (1111,7788,7902);

---- Ʈ����� ���� ROLLBACK(Transaction Level Rollback)
--BEGIN -- Block ����
--DELETE FROM EMP WHERE DEPTNO = 20; -- Ʈ����� ���� ��
--UPDATE EMP SET SAL = 123456789 WHERE EMPNO = 7499; -- �����߻� ��
--UPDATE EMP SET SAL = 1234 WHERE EMPNO = 7698; -- ���� SKIP ��
--COMMIT; -- ���� SKIP ��
--EXCEPTION -- ����ó���� ��
--WHEN OTHERS THEN
--ROLLBACK; -- Ʈ����� ���� ROLLBACK
--END; -- PL/SQL Block ����
--/ -- Block ����(Send to DBMS)

SELECT EMPNO,SAL FROM EMP WHERE DEPTNO = 20 or EMPNO IN (7499,7698); -- ���Ȯ��



-- [ TRANSACTION�� DDL ]
-- 1. Ʈ����� ����
INSERT INTO EMP(EMPNO,ENAME,DEPTNO) VALUES(9999,'OCPOK',20);

-- 2. DDL��
ALTER TABLE EMP ADD( SEX CHAR(1) DEFAULT 'M');
 
-- 3. ROLLBACK�� ��� ���� : DDL���� ���� �Ͻ������� Ŀ�ԵǾ� Ʈ������� ����Ǿ����Ƿ�, ��ҵ� ���� ����.
ROLLBACK; 

-- 4
DESC EMP;

-- 5
ALTER TABLE EMP DROP COLUMN SEX; 

-- 6. ��� ���� : ���������� ��ҵ� ���� ����.
ROLLBACK; 

-- 7
DESC EMP;

