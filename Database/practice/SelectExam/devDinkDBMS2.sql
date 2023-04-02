select * from emp;

update emp
set ENAME = '_'||ENAME
WHERE (JOB = 'SALESMAN');

select * from emp;

select * from emp
where ENAME LIKE '%\_%' escape '\';