-- ROWNUM
-- 1
SELECT ROWNUM, ENAME, DEPTNO, SAL FROM EMP;

-- 2
SELECT ROWNUM, ENAME, DEPTNO, SAL FROM EMP ORDER BY DEPTNO, SAL;

-- 3
SELECT ROWNUM, ENAME, DEPTNO, SAL FROM EMP WHERE DEPTNO IN (10, 20) ORDER BY DEPTNO, SAL;

-- 4
SELECT ENAME, DEPTNO, SAL FROM EMP WHERE ROWNUM = 1;

-- 5
SELECT ENAME, DEPTNO, SAL FROM EMP WHERE ROWNUM = 3;

-- 6
SELECT ENAME, DEPTNO, SAL FROM EMP WHERE ROWNUM > 3;

-- 7
SELECT ENAME, DEPTNO, SAL FROM EMP WHERE ROWNUM <= 3;

-- 8
SELECT ENAME, DEPTNO, SAL FROM EMP WHERE ROWNUM < 3;

-- 논리 연산자 AND OR NOT
-- 1
-- 2
-- 3
SELECT ENAME, JOB SAL, DEPTNO FROM EMP WHERE SAL > 2000 OR SAL > 2000;
