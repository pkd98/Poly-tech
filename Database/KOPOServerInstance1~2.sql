select E.EMPNO, E.ENAME from emp e;
select ename, sal+12, SAL*12 as annual_salary from emp;
select ename, MGR Manager, SAL*12 as annual_SAL, COMM + 300 "Special Bonus" from EMP;
select ename, comm+300 보너스, COMM + 300 AS "Special Bonus" from emp;
select * from emp;

select ename||JOB from emp;
select dname||' 부서는 ' ||LOC||' 지역에 위치합니다.' as LOC from DEPT;
select ename||'''s JOB is '||job as job_list from emp;
select sal, sal*100, sal || '00', to_char(sal)||'00' from emp;

desc dual;
select * from DUAL;
select sysdate from dual;
select 202512345, to_char(202512345123, '999,999,999'), to_char(2025*12345,'999,999,999') as cal from dual;

select * from emp where deptno = 10;
select DEPTNO, ENAME, SAL, JOB FROM EMP WHERE SAL > 2000;
select deptno, ename, sal, job from emp where deptno = 10 and sal > 2000;
select deptno, ename, sal, job from emp where deptno = 10 or sal > 2000;
SELECT DEPTNO, SAL, JOB FROM EMP WHERE DEPTNO = 10 AND SAL > 2000 OR JOB='MANAGER';
SELECT DEPTNO, SAL, JOB FROM EMP WHERE DEPTNO = 10 AND SAL > 2000 OR JOB='MANAGER';
SELECT DEPTNO, SAL, JOB FROM EMP WHERE (DEPTNO = 10 AND SAL > 2000) OR JOB='MANAGER';
SELECT DEPTNO, SAL, JOB FROM EMP WHERE DEPTNO = 10 AND (SAL > 2000 OR JOB='MANAGER');
SELECT DEPTNO, ENAME, SAL, JOB FROM EMP WHERE JOB = 'manager';
select deptno, ename, job from emp where 1=2;

select deptno, ename, sal, job from emp where (deptno, job, mgr) = ((10, 'MANAGER', 7839));

select 300/0 from dual;
select 300+400, 300 + NULL, 300/NULL from dual;
select ename, sal, comm, comm+sal*0.3 as bonus from emp;

select ename, sal, comm from emp where comm > -1;
select ename, sal, comm from emp where comm = null;
select ename, sal, comm from emp where comm <> null;
select ename, sal, comm from emp where comm is null;
select ename, sal, comm from emp where comm is not null;

select ename, length(ename), comm, length(comm) from emp;
select sal, comm, abs(sal-comm) + 300 from emp;

select comm, nvl(COMM,0), DECODE(COMM, NULL, 0, COMM) as NVL_SIMUL from emp;
select concat('Commission is ', COMM), 'Commission is '||COMM FROM EMP;
select count(sal) as sal_cnt, count(comm) as comm_cnt, sum(comm) as comm_sum from emp;


SELECT EMPNO || ',' || ENAME || ',' || JOB || ',' || SAL || ',' || DEPTNO FROM EMP;
SELECT TO_CHAR(systimestamp, 'HH24:MI:SS.FF2') FROM DUAL;
SELECT TO_CHAR(systimestamp, 'HH24:MI:SS.FF3') FROM DUAL;


desc emp;


select ename, hiredate, sal, comm from emp order by ename;
select ename, hiredate, sal, comm from emp order by ename asc;
select ename, hiredate, sal, comm from emp order by hiredate desc;
select ename, hiredate, sal, comm from emp order by ename;
select ename, hiredate, sal, comm from emp order by 2;
select ename, sal*12 as 연봉 from emp order by 연봉;
select ename, hiredate, sal, comm from emp order by comm * 12;
select ename, hiredate, sal, comm from emp order by comm * 12 NULLS first;
select deptno, job, ename from emp order by deptno;
select deptno, job, ename from emp order by deptno, job;
select deptno, job, ename from emp order by deptno, job desc;

select * from customer order by credit_limit DESC;
