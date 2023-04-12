-- �ָ� ���� 2�� --
SELECT * FROM CUSTOMER;

-- ����� ������ ���̺� --
SELECT * FROM DEPT;
SELECT * FROM EMP_LARGE;
SELECT * FROM EMP;
SELECT * FROM SALGRADE;

-- ���� ����� -- 
-- �μ��� ��ձ޿��� �޿������ ���, �ִ� �޿�, �ִ�޿��� �޴� ��� �� ���
SELECT d.deptno AS �μ���ȣ,
       ROUND(AVG(e.sal)) AS �μ���_��ձ޿�,
       SUM(e.sal) AS �μ���_�޿��Ѿ�,
       ROUND(AVG(s.grade)) AS �μ���_�޿�������,
       MAX(e.sal) AS �ִ�޿�,
       e_max.cnt AS �ִ�޿�_�����
       
-- �μ�(DEPT), ���(EMP), �޿����(SALGRADE), �ִ�޿��� �޴� ��� �� (sub query) Join
FROM dept d
INNER JOIN EMP e
ON d.deptno = e.deptno
INNER JOIN salgrade s
ON e.sal BETWEEN s.losal AND s.hisal -- ����� �޿��� ��� ��޿� ���ԵǴ���
INNER JOIN (
    SELECT deptno, count(deptno) AS cnt -- �ִ� �޿��� �޴� ��� ��
    FROM EMP
    WHERE (deptno, sal) IN (
        SELECT deptno, MAX(sal) AS max_sal -- �׷� �� �ִ� �޿�
        FROM EMP
        GROUP BY deptno
    ) group by deptno
) e_max
ON d.deptno = e_max.deptno -- Join ����
GROUP BY d.deptno, e_max.cnt
ORDER BY d.DEPTNO;

--
--
---- �μ�, ���, �޿���� ���̺� ���� --
--SELECT d.deptno, d.dname, e.ename, e.job, e.sal, s.grade
--FROM dept d
--INNER JOIN EMP_LARGE e
--ON d.deptno = e.deptno
--INNER JOIN salgrade s
--ON e.sal BETWEEN s.losal AND s.hisal; -- ����� �޿��� ���� �޿� ��� ��� ���� �߰�
--
---- �μ��� ����(EMP)�� SALGRADE ��� ���̺� ���� --
--SELECT d.deptno AS �μ���ȣ,
--       ROUND(AVG(e.sal), 3) AS �μ���_��ձ޿�,
--       ROUND(AVG(s.grade), 3) AS �μ���_�޿�������,
--       MAX(e.sal)
--FROM dept d
--INNER JOIN EMP_LARGE e
--ON d.deptno = e.deptno
--INNER JOIN salgrade s
--ON e.sal BETWEEN s.losal AND s.hisal
--GROUP BY d.deptno;
--
---- �μ��� ����(EMP_LARGE)�� SALGRADE ��� ���̺� ���� --
--SELECT d.deptno AS �μ���ȣ,
--       ROUND(AVG(e.sal)) AS �μ���_��ձ޿�,
--       ROUND(AVG(s.grade)) AS �μ���_�޿�������,
--       MAX(e.sal) AS �ִ�޿�
--FROM dept d
--INNER JOIN EMP e
--ON d.deptno = e.deptno
--INNER JOIN salgrade s
--ON e.sal BETWEEN s.losal AND s.hisal
--GROUP BY d.deptno;
--
---- �μ��� ������ SALGRADE ��� ���̺� ���� --
--SELECT d.deptno, count(e.job)AS ����
--FROM dept d
--INNER JOIN  EMP e
--ON d.deptno = e.deptno
--INNER JOIN salgrade s
--ON e.sal BETWEEN s.losal AND s.hisal
--GROUP BY d.deptno;
--
--SELECT d.deptno AS �μ���ȣ,
--       ROUND(AVG(e.sal)) AS �μ���_��ձ޿�,
--       ROUND(AVG(s.grade)) AS �μ���_�޿�������,
--       e_max.ename AS �ִ�޿�_����̸�,
--       MAX(e.sal) AS �ִ�޿�
--FROM dept d
--INNER JOIN EMP e
--ON d.deptno = e.deptno
--INNER JOIN salgrade s
--ON e.sal BETWEEN s.losal AND s.hisal
--INNER JOIN (
--    SELECT deptno, ename
--    FROM EMP
--    WHERE (deptno, sal) IN (
--        SELECT deptno, MAX(sal) AS max_sal
--        FROM EMP
--        GROUP BY deptno
--    )
--) e_max
--ON d.deptno = e_max.deptno
--GROUP BY d.deptno, e_max.ename;
--
--        
---- �μ����� �ִ� �޿��� �޴� ��� (1��) ���ϱ�
--SELECT deptno, ename, sal
--FROM (
--    SELECT deptno, ename, sal,
--        ROW_NUMBER() OVER (PARTITION BY deptno ORDER BY sal DESC) AS rn
--    FROM EMP
--) e
--WHERE rn = 1;


