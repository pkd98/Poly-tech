-- STUDENT ���̺��� �������� �̱�
-- 2.1 ���� : ���� �˰��� ���� (�Ҽ��� �ð��� �̿��� ���� ȿ��)
SELECT NAME AS Victim
FROM STUDENT
WHERE ID = (SELECT mod(to_number(to_char(systimestamp(3), 'FF3')), 22) + 1 from dual);