-- 그룹행 함수
-- 1
SELECT MIN(ENAME),MAX(ENAME),MIN(SAL),MAX(SAL),MIN(HIREDATE),MAX(HIREDATE) FROM EMP;

-- 2 
SELECT COUNT(*), COUNT(EMPNO), COUNT(MGR), COUNT(COMM) FROM EMP;

-- 3
SELECT COUNT(JOB),COUNT(ALL JOB),COUNT(DISTINCT JOB),SUM(SAL),SUM(DISTINCT SAL) FROM EMP;

-- 4
SELECT COUNT(*), SUM(COMM), SUM(COMM)/COUNT(*),AVG(COMM),SUM(COMM)/COUNT(COMM) FROM EMP;

-- 5
SELECT SAL,COMM FROM EMP;

SELECT SUM(NVL(COMM,0)) AS SUM_COMM1,      -- (1)
SUM(COMM) AS SUM_COMM2,                    -- (2)
NVL(SUM(COMM),0) AS SUM_COMM3              -- (3)
FROM EMP;


-- GROUP BY
-- 1
SELECT DEPTNO,COUNT(*) FROM SCOTT.EMP GROUP BY DEPTNO;

-- 2
SELECT DEPTNO,AVG(SAL) ,SUM(SAL) FROM EMP GROUP BY DEPTNO;

-- 3
SELECT DEPTNO,AVG(SAL) ,SUM(SAL) FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;

-- 4
SELECT DEPTNO,ROUND(AVG(SAL),1) ,SUM(SAL) FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;

-- 5
SELECT COMM, COUNT(*) FROM EMP GROUP BY COMM;


-- HAVING
-- 1
SELECT DEPTNO,COUNT(*),SUM(SAL),ROUND(AVG(SAL),1) FROM EMP
GROUP BY DEPTNO;

-- 2
SELECT DEPTNO,COUNT(*),SUM(SAL),ROUND(AVG(SAL),1) FROM EMP
GROUP BY DEPTNO
HAVING SUM(SAL) >= 9000 ;

-- 3
SELECT DEPTNO,COUNT(*),SUM(SAL),ROUND(AVG(SAL),1) FROM EMP
GROUP BY DEPTNO
HAVING DEPTNO IN (10,20);

-- 4
SELECT DEPTNO,ROUND(AVG(SAL),1) ,SUM(SAL) FROM EMP
WHERE DEPTNO IN (10,20)
GROUP BY DEPTNO
HAVING SUM(SAL) >= 9000
ORDER BY DEPTNO DESC;
