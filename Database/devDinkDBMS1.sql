select * from customer order by credit_limit DESC;
select * from customer where name = '전지현';
select * from customer where name = '박경덕';

select job from emp;
select unique job from emp;
select distinct job from emp;
select distinct deptno, job from emp;
select job from emp order by job;
SELECT DISTINCT JOB, DISTINCT DEPTNO FROM EMP;
SELECT JOB, DISTINCT DEPTNO FROM EMP;
SELECT COMM FROM EMP WHERE COMM IS NOT NULL;
select distinct comm from emp;

