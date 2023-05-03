-- View
-- View�� ���ȼ�
-- 1. ����� �������� �� ����
CREATE VIEW VW_EMP(ENO,E_NAME,DNO,SAL) -- �÷� �̸��� ��ġ Aliasó�� �����Ͽ� ������
AS SELECT EMPNO,ENAME,DEPTNO,SAL
FROM EMP
WHERE SAL > 1500; -- Base data�� COLUMN,ROW ����

-- 1-1. �ý��� �������� �� ���� ���� �ο�
GRANT CREATE VIEW TO SCOTT;

-- 2.
desc VW_EMP; -- a logical table
select * from tab;

-- 3.
select * from vw_emp;
select dno,e_name,sal from vw_emp where dno in (10,20);
select deptno,ename from emp where deptno in (10,20) and sal > 1500; -- Merge
select dno,e_name,sal from vw_emp where dno in (10,20); -- Restrict

-- View�� ����
-- 1.
CREATE VIEW VW_SIMPLE AS SELECT EMP.EMPNO,EMP.ENAME,DEPT.DNAME,SALGRADE.GRADE AS GD
FROM EMP, DEPT, SALGRADE
WHERE EMP.DEPTNO = DEPT.DEPTNO AND
EMP.SAL BETWEEN SALGRADE.LOSAL AND SALGRADE.HISAL;

-- 2.
 -- NOT NULL, DATA TYPE
desc vw_simple;
select * from tab;

-- 3.
select * from vw_simple; -- ���ɺ�(?)

-- View�� ������
-- 1.
CREATE TABLE BASE_TBL(EMPNO_NEW,ENAME_NEW)
AS SELECT EMPNO,ENAME
FROM EMP
WHERE JOB IN ('CLERK','SALESMAN');

-- 2.
desc base_tbl;
select * from tab;

-- 3.
CREATE VIEW VW_IND AS SELECT * FROM BASE_TBL;
SELECT * FROM VW_IND;

-- 4.
ALTER TABLE BASE_TBL ADD(NEW_COL DATE); -- base table ���� ����

-- 5.
SELECT * FROM VW_IND; -- Independence of base table change
SELECT EMPNO_NEW,ENAME_NEW FROM VW_IND;

-- View�� �ٺ���
-- **** 1~3�� System �������� �ǽ� ****
-- 1.
CREATE TABLE DBA_TBLS -- System �������� �ǽ�
AS SELECT OWNER, TABLE_NAME FROM DBA_TABLES; --DBMS���� �����ϴ� ��� ���̺�

SELECT * FROM DBA_TBLS;

SELECT OWNER, COUNT(*) -- System , Scott owner�� ���̺� ���� Ȯ��.
FROM DBA_TBLS
GROUP BY OWNER;

-- 2.
CREATE OR REPLACE VIEW VW_DIFF -- View ����
AS SELECT * FROM DBA_TBLS WHERE OWNER = USER;

SELECT * FROM VW_DIFF;        -- System owner�� �����͸� ��ȸ

SELECT count(*) FROM VW_DIFF;

-- 3.
GRANT SELECT ON VW_DIFF TO PUBLIC; -- DBMS���� ��� ����ڿ��� SELECT ���Ѻο�

-- 4. SCOTT �������� �ǽ�!
SELECT * FROM VW_DIFF;        -- Scott �������� �ǽ�
SELECT * FROM SYSTEM.VW_DIFF;
SELECT count(*) FROM VW_DIFF; -- Scott owner�� �����͸� ��ȸ ??
SELECT count(*) FROM SYSTEM.VW_DIFF;

-- View Merge
-- 1. View�� ����
CREATE VIEW VW_DEPTEMP
AS SELECT E.EMPNO,E.ENAME,E.SAL,D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

-- 2. View ����
SELECT * FROM VW_DEPTEMP WHERE DNAME = 'SALES';

-- 3. View ó��
SELECT E.EMPNO,E.ENAME,E.SAL,D.DEPTNO,D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO AND D.DNAME = 'SALES';

-- 4. Stored Query
SELECT VIEW_NAME,TEXT FROM USER_VIEWS; -- �� ������ ��� ��
