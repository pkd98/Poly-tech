-- Date Type
-- 1
SELECT sysdate, sysdate + 7, sysdate - 2, sysdate + 1/24 FROM dual;

-- 2
SELECT deptno, ename, trunc(sysdate - hiredate) AS work_day
FROM emp
ORDER BY deptno, work_day DESC;

-- 3
SELECT ename, sysdate, hiredate, to_char(sysdate, 'YYYY-MM-DD:HH24:MI:SS'), to_char(hiredate, 'YYYY-MM-DD::HH24:MI:SS')
FROM emp;

-- 4
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD:HH24:MI:SS';
SELECT ename, sysdate, hiredate FROM emp;
SELECT sysdate FROM dual;

-- 내 sid 확인해보기
desc v$mystat;
select sid from v$mystat;

-- DATE Function 활용
-- 1
SELECT HIREDATE,trunc(months_between(sysdate,HIREDATE)),trunc(months_between(HIREDATE,sysdate)) FROM EMP;

-- 2
SELECT sysdate, add_months(sysdate,3), add_months(sysdate,-1) FROM dual;

-- 3
SELECT sysdate, last_day(sysdate), next_day(sysdate,'일요일'), next_day(sysdate,2) FROM dual;

-- 4
SELECT sysdate,round(sysdate,'YEAR'),round(sysdate,'MONTH'),round(sysdate,'DAY'),round(sysdate)
FROM dual;

-- 5
SELECT sysdate,trunc(sysdate,'YEAR'),trunc(sysdate,'MONTH'),trunc(sysdate,'DAY'),trunc(sysdate) FROM dual;

-- 6
SELECT to_char(sysdate,'MM"월"DD"일"') as mmdd1,
to_char(sysdate,'MM')||'월'||to_char(sysdate,'DD')||'일' as mmdd2 FROM dual;

-- 7 
SELECT EXTRACT(YEAR FROM SYSDATE),EXTRACT(MONTH FROM SYSDATE),EXTRACT(DAY FROM SYSDATE) FROM DUAL;
