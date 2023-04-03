-- DECODE 예시
-- 1
SELECT DEPTNO, ENAME, DECODE(DEPTNO, 10, 'ACCOUNTING', 20, 'RESEARCH', 30, 'SALES', 'ETC')
FROM EMP
ORDER BY DEPTNO;

-- 2 
SELECT COMM, DECODE(COMM, NULL, 0, COMM) FROM EMP;

-- 3 - 1
SELECT GREATEST(3000,1500,2100,5000),LEAST(3000,1500,2100,5000) FROM DUAL;

-- 3 - 2
SELECT DEPTNO, ENAME, SAL,
DECODE(GREATEST(SAL,4800),SAL,'HIGH',DECODE(GREATEST(SAL,3000),SAL,'MID','LOW'))
FROM EMP
ORDER BY DEPTNO;



-- CASE 예시
-- 1
SELECT DEPTNO,ENAME,
CASE DEPTNO WHEN '10' THEN 'ACCOUNTING' -- 암시적(x), 에러 원인? 수정후 실행
            WHEN 20 THEN 'RESEARCH'
            WHEN 30 THEN 'SALES'
            ELSE 'ETC'
            END AS DEPARTMENT
FROM EMP
ORDER BY DEPTNO;

SELECT DEPTNO, ENAME,
CASE DEPTNO WHEN 10 THEN 'ACCOUNTING'
            WHEN 20 THEN 'RESEARCH'
            WHEN 30 THEN 'SALES'
            ELSE 'ETC'
            END AS DEPARTMENT
FROM EMP
ORDER BY DEPTNO;

-- 2
SELECT DEPTNO, ENAME, SAL, -- Searched case
CASE WHEN SAL >= 4800 THEN 'HIGH' -- 비교 연산자
     WHEN SAL BETWEEN 3000 AND 4799 THEN 'MID' -- SQL 연산자
     WHEN SAL >= 1000 AND SAL <=2999 THEN 'LOW' -- 비교 & 논리 연산자
     ELSE 'Passion pay'
     END SAL_GRADE
FROM EMP
ORDER BY DEPTNO;

-- 3
SELECT DEPTNO, ENAME, COMM,
CASE WHEN COMM >= 1000 THEN 'Great'
     WHEN COMM >= 500 THEN 'Good'
     WHEN COMM >= 0 THEN 'Bad'
     ELSE 'Dreadful' -- ELSE에서 NULL Catch
END COMM_GRADE
FROM EMP
ORDER BY DEPTNO;

-- 4 - 1
SELECT SAL,
CASE
    WHEN SAL >= 1000 THEN 1
    WHEN SAL >= 2000 THEN 2
    WHEN SAL >= 3000 THEN 3
    WHEN SAL >= 4000 THEN 4
    WHEN SAL >= 5000 THEN 5
    ELSE 0
    END AS SAL_GRADE
FROM EMP
ORDER BY SAL;

-- 4 - 2
SELECT SAL, CASE
    WHEN SAL >= 5000 THEN 5
    WHEN SAL >= 4000 THEN 4
    WHEN SAL >= 3000 THEN 3
    WHEN SAL >= 2000 THEN 2
    WHEN SAL >= 1000 THEN 1
    ELSE 0
    END "Sal Grade"
FROM EMP
ORDER BY SAL;