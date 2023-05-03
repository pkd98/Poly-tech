-- View
-- View의 보안성
-- 1. 사용자 계정에서 뷰 생성
CREATE VIEW VW_EMP(ENO,E_NAME,DNO,SAL) -- 컬럼 이름을 마치 Alias처럼 변경하여 재정의
AS SELECT EMPNO,ENAME,DEPTNO,SAL
FROM EMP
WHERE SAL > 1500; -- Base data의 COLUMN,ROW 제한

-- 1-1. 시스템 계정에서 뷰 생성 권한 부여
GRANT CREATE VIEW TO SCOTT;

-- 2.
desc VW_EMP; -- a logical table
select * from tab;

-- 3.
select * from vw_emp;
select dno,e_name,sal from vw_emp where dno in (10,20);
select deptno,ename from emp where deptno in (10,20) and sal > 1500; -- Merge
select dno,e_name,sal from vw_emp where dno in (10,20); -- Restrict

-- View의 편리성
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
select * from vw_simple; -- 만능뷰(?)

-- View의 독립성
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
ALTER TABLE BASE_TBL ADD(NEW_COL DATE); -- base table 구조 변경

-- 5.
SELECT * FROM VW_IND; -- Independence of base table change
SELECT EMPNO_NEW,ENAME_NEW FROM VW_IND;

-- View의 다변성
-- **** 1~3번 System 계정에서 실습 ****
-- 1.
CREATE TABLE DBA_TBLS -- System 계정에서 실습
AS SELECT OWNER, TABLE_NAME FROM DBA_TABLES; --DBMS내에 존재하는 모든 테이블

SELECT * FROM DBA_TBLS;

SELECT OWNER, COUNT(*) -- System , Scott owner의 테이블 갯수 확인.
FROM DBA_TBLS
GROUP BY OWNER;

-- 2.
CREATE OR REPLACE VIEW VW_DIFF -- View 생성
AS SELECT * FROM DBA_TBLS WHERE OWNER = USER;

SELECT * FROM VW_DIFF;        -- System owner의 데이터만 조회

SELECT count(*) FROM VW_DIFF;

-- 3.
GRANT SELECT ON VW_DIFF TO PUBLIC; -- DBMS내의 모든 사용자에게 SELECT 권한부여

-- 4. SCOTT 계정에서 실습!
SELECT * FROM VW_DIFF;        -- Scott 계정에서 실습
SELECT * FROM SYSTEM.VW_DIFF;
SELECT count(*) FROM VW_DIFF; -- Scott owner의 데이터만 조회 ??
SELECT count(*) FROM SYSTEM.VW_DIFF;

-- View Merge
-- 1. View의 정의
CREATE VIEW VW_DEPTEMP
AS SELECT E.EMPNO,E.ENAME,E.SAL,D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

-- 2. View 질의
SELECT * FROM VW_DEPTEMP WHERE DNAME = 'SALES';

-- 3. View 처리
SELECT E.EMPNO,E.ENAME,E.SAL,D.DEPTNO,D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO AND D.DNAME = 'SALES';

-- 4. Stored Query
SELECT VIEW_NAME,TEXT FROM USER_VIEWS; -- 내 소유의 모든 뷰
