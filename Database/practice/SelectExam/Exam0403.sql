-- 0403 ���� ����
-- 1
SELECT DECODE(ROUND(DBMS_RANDOM.VALUE(0.5,21.5),0), 1, '������', 2, '���±�', 3, '����ȯ', 4, '�����', 5, '�賲��', 6, '���翵', 7, '���Ͽ�', 8, '�ڰ��', 9, '������', 10, '������', 11, '�ɹ���', 12, '�̵���', 13, '�̽���', 14, '������', 15, '�Ӽ���', 16, '������', 17, '������', 18, '���ֿ�', 19, '�ְ��', 20, '�ֹο�', 21, '������', 22, 'ȫ����') as Victim
FROM DUAL;

-- 2
SELECT DEPTNO,JOB,ENAME FROM EMP WHERE  DEPTNO = 20;			// 5 Rows
SELECT DEPTNO,JOB,ENAME FROM EMP WHERE  JOB = 'CLERK';			// 4 Rows
SELECT DEPTNO,JOB,ENAME FROM EMP WHERE  DEPTNO = 20  OR JOB = 'CLERK'; // 7 Rows

-- 3
SELECT DEPTNO, ENAME, JOB, SAL,
ROUND(DECODE(DEPTNO, 10, SAL * 0.003, 20, SAL * 0.2, 30, SAL * 0.1, SAL*0.01)) AS "���ʽ�"
FROM EMP
ORDER BY DEPTNO, "���ʽ�" DESC;

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

--ù�� °
--DEPTNO�� 10, 20�� �ƴ� �ٸ� ���� ���� 'ETC���� ó���ȴ�.
--���ǹ����� else�� ���� �����̴�.
--���� NULL�� ���� ���� ó���� �� �ִ�.
--
--�ι� °
--DEPTNO�� 10, 20�� �ƴ� �ٸ� ���� ���� NULL�� ��ȯ�Ѵ�.

-- 7
select deptno,job,decode(deptno, 10 ,decode(job,'CLERK','OK','NO'),'NO')
from emp
order by deptno,job;

select deptno,job,decode(deptno||JOB, '10CLERK' , 'OK', 'NO')
from emp
order by deptno,job;
