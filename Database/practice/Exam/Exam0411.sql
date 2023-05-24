-- 1. �Ʒ��� 3 SQL�� ����� ������ �����Ͻÿ�
select * from dept;
select * from emp;

SELECT D.DNAME,E.ENAME,E.JOB,E.SAL FROM EMP E,DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO ORDER BY D.DNAME;
-- DEPT (������)�� �������� Outer ����

SELECT D.DNAME,E.ENAME,E.JOB,E.SAL FROM EMP E, DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO AND E.SAL > 2000 ORDER BY D.DNAME; -- Outer Join �� ���͸�
-- DEPT (������)�� �������� Oute ���� ����, SAL�� 2000�� �Ѵ� ���� ���͸�

SELECT D.DNAME,E.ENAME,E.JOB,E.SAL FROM EMP E,DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO AND E.SAL(+) > 2000 ORDER BY D.DNAME; -- Outer Join
-- Outer Join�� ������ �Ǵ� ���̺����� Join������ ��Ī���� �ʴ��� null�� ������ �����Ѵ�.
-- E.SAL(+)���� Outer Join�� ����ż�, DEPT�� �������� SAL ���� 2000�� ���� �ʴ��� ���ԵǾ���.

CREATE TABLE SYSTEM( SYSTEM_ID VARCHAR2(5),
SYSTEM_NAME VARCHAR2(10)
);
INSERT INTO SYSTEM VALUES('XXX','��ȭDB');
INSERT INTO SYSTEM VALUES('YYY','����DB');
INSERT INTO SYSTEM VALUES('ZZZ','������DB');
CREATE TABLE RESOURCE_USAGE(SYSTEM_ID VARCHAR2(5),
RESOURCE_NAME VARCHAR2(10)
);
INSERT INTO RESOURCE_USAGE VALUES('XXX','FTP');
INSERT INTO RESOURCE_USAGE VALUES('YYY','FTP');
INSERT INTO RESOURCE_USAGE VALUES('YYY','TELNET');
INSERT INTO RESOURCE_USAGE VALUES('YYY','EMAIL');
COMMIT;

SELECT S.SYSTEM_ID,S.SYSTEM_NAME,R.RESOURCE_NAME
FROM SYSTEM S, RESOURCE_USAGE R
WHERE S.SYSTEM_ID = R.SYSTEM_ID;

SELECT S.SYSTEM_ID,S.SYSTEM_NAME,R.RESOURCE_NAME
FROM SYSTEM S,RESOURCE_USAGE R
WHERE S.SYSTEM_ID = R.SYSTEM_ID(+);