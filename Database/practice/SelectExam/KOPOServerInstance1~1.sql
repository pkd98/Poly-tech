SELECT ENAME,SAL,HIREDATE FROM EMP WHERE SAL between 1000 and 2000;
SELECT ENAME,SAL,HIREDATE FROM EMP WHERE SAL >= 1000 and SAL <= 2000;
select ename, sal, hiredate from emp where sal between 2000 and 1000;
select ename, sal, hiredate from emp where ename between 'C' and 'K';
select ename, sal, hiredate from emp
    where hiredate between '81/02/20' and '82/12/09';

select ename, sal, hiredate from emp
    where hiredate between to_date('81/02/20','rr/mm/dd') and to_date('82/12/09','rr/mm/dd');
    
select sysdate from dual;
    
select ename, hiredate, to_char(hiredate, 'YYYY/MM/DD'),
    to_char(hiredate, 'YYYY/MM/DD HH24:MI:SS'),
    to_char(hiredate, 'RRRR/MM/DD HH24:MI:SS'),
    to_char(sysdate, 'YYYY/MM/DD HH24:MI:SS') from emp;
    
select ename,sal,hiredate from emp
    where hiredate between to_date('81/02/20','rr/mm/dd') and to_date('82/12/09','yy/mm/dd');
    
    
    
select ename from emp where ename like 'A%';
select ename from emp where ename like '_A%';
select ename from emp where ename like '%L%E%';
select ename from emp where ename like '%LE%';
select ename from emp where ename like '%A%';
select ename from emp where ename not like '%A%';
select ename, hiredate from emp where hiredate like '81%';
select ename, sal from emp where sal like 2%;
SELECT ENAME,SAL FROM EMP WHERE SAL like '2%'; 
select ename, sal from emp where to_char(sal) like '2%';

select * from customer;
select * from customer where ADDRESS1 like '%¿©ÀÇµµ%' and NAME like '±è%';

select empno, job from emp where empno IN (7369, 7521, 7654);
SELECT EMPNO, JOB FROM EMP WHERE EMPNO = 7369 or EMPNO = 7521 or EMPNO=7654;
SELECT EMPNO,ENAME,JOB FROM EMP WHERE JOB IN ('clerk','manager');
SELECT EMPNO,ENAME,JOB FROM EMP WHERE JOB IN ('CLERK','MANAGER');
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE IN ('81/05/01','81/02/20');
SELECT EMPNO,ENAME,JOB,DEPTNO FROM EMP
WHERE (JOB,DEPTNO) in (('MANAGER',20),('CLERK',20)); 