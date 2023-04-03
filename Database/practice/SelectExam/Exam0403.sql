-- 0403 일일 과제
-- 1
SELECT DECODE(ROUND(DBMS_RANDOM.VALUE(0.5,21.5),0), 1, '강은현', 2, '강태근', 3, '강태환', 4, '김관중', 5, '김남훈', 6, '김재영', 7, '김하영', 8, '박경덕', 9, '박준하', 10, '박태현', 11, '심민정', 12, '이동학', 13, '이승희', 14, '이정민', 15, '임서영', 16, '임지은', 17, '정수영', 18, '정주연', 19, '최경민', 20, '최민영', 21, '최유림', 22, '홍윤기') as Victim
FROM DUAL;

-- 2
SELECT DEPTNO,JOB,ENAME FROM EMP WHERE  DEPTNO = 20;			// 5 Rows
SELECT DEPTNO,JOB,ENAME FROM EMP WHERE  JOB = 'CLERK';			// 4 Rows
SELECT DEPTNO,JOB,ENAME FROM EMP WHERE  DEPTNO = 20  OR JOB = 'CLERK'; // 7 Rows

-- 3
SELECT DEPTNO, ENAME, JOB, SAL,
ROUND(DECODE(DEPTNO, 10, SAL * 0.003, 20, SAL * 0.2, 30, SAL * 0.1, SAL*0.01)) AS "보너스"
FROM EMP
ORDER BY DEPTNO, "보너스" DESC;

-- 4


-- 5
SELECT * FROM EMP;

SELECT DEPTNO, ENAME,
CASE 
    WHEN ENAME like '%A%' THEN 'hasA'
    WHEN ENAME IN ('SMITH')  THEN 'hasH'
    ELSE 'ETC'
    END AS NAME
FROM EMP;

SELECT DEPTNO, ENAME, JOB,
CASE
    WHEN JOB LIKE 'A%' THEN 'A'
    WHEN JOB IN('CLERK', 'SALESMAN') THEN 'B'
    ELSE 'C'
    END AS "JOB_RANK"
FROM EMP;
        
-- 6
SELECT * FROM EMP;
SELECT DEPTNO, ENAME, DECODE(DEPTNO,10,'ACCOUNTING',20,'RESEARCH','ETC') FROM EMP ORDER BY DEPTNO;
SELECT DEPTNO, ENAME, DECODE(DEPTNO,10,'ACCOUNTING',20,'RESEARCH') FROM EMP ORDER BY DEPTNO;

--첫번 째
--DEPTNO가 10, 20이 아닌 다른 값에 대해 'ETC’로 처리된다.
--조건문에서 else와 같은 로직이다.
--따라서 NULL과 같은 값도 처리할 수 있다.
--
--두번 째
--DEPTNO가 10, 20이 아닌 다른 값에 대해 NULL을 반환한다.

-- 7
select deptno,job,decode(deptno, 10 ,decode(job,'CLERK','OK','NO'),'NO')
from emp
order by deptno,job;

select deptno,job,decode(deptno||JOB, '10CLERK' , 'OK', 'NO')
from emp
order by deptno,job;
