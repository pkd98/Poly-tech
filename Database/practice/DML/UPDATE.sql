-- UPDATE
-- 1. ���� �÷� ����
UPDATE DEPT SET DNAME = ' M������' WHERE DEPTNO = 50;

-- 2. ���� �÷� ����
UPDATE DEPT SET DNAME = ' T������', LOC = '��õ' WHERE DEPTNO = 51;

-- 3. ���� ���� ��ȸ
SELECT * FROM DEPT WHERE DEPTNO IN (50, 51);

-- 4. ������� �ݿ� (����)
COMMIT;

-- 5. WHERE�� ������ ��ü ROW ��� (����!!!)
UPDATE DEPT SET LOC = '�̰�ô��';

-- 6
SELECT * FROM DEPT;

-- 7. �ش� ������� ������ ���
ROLLBACK;

-- 8. ��� Ȯ��
SELECT * FROM DEPT;

-- 9. UPDATE �� ���ο� �Լ�, ��� ����, decode, case �� �����͸� ���� ó�� �� ������ �� �ִ�.
-- dname �÷��� ���鹮�� ����
select dname, replace(dname,' ','') from dept;

-- set ���� �Լ� ��밡��
update dept set dname=trim(dname);

select dname, replace(dname,' ','') from dept;

-- 10
COMMIT;