-- �ָ� ���� 1�� --
DESC CUSTOMER;
DESC ESTABLISHMENT;
DESC ESTABLISHMENT1;
select * from customer;
select * from establishment;
select * from establishment1;
-- ADDRESS1 ����ġ - �ּ�2�� ��ü�ϱ� --
UPDATE ESTABLISHMENT SET ADDRESS1 = ADDRESS2 WHERE ADDRESS1 is null;

-- ���� 2�� ���� �ּ� �и� �׽�Ʈ
UPDATE ESTABLISHMENT
SET ADDRESS1 = SUBSTRING_INDEX(��ü�ּ�, ' ', 1);
select substr(address, 0, instr(address, ' ', 1, 2)) from establishment;

-- ���� 2�� ���� �ּ� update
UPDATE ESTABLISHMENT SET ADDRESS = substr(address1, 0, instr(address1, ' ', 1, 2));
commit;

-- �ü� �� ������ ������ �ü��� ���� ���� ���� Ȯ�� -> ��⵵ ȭ����
SELECT ADDRESS AS �ּ�, COUNT(ADDRESS) AS �ü���
FROM ESTABLISHMENT
GROUP BY ADDRESS
HAVING COUNT(ADDRESS) > 10
ORDER BY �ü��� DESC;

-- �ִ밪 �ϳ��� ǥ��
SELECT �ּ�, �ü���
FROM (
    SELECT ADDRESS AS �ּ�, COUNT(ADDRESS) AS �ü���
    FROM ESTABLISHMENT
    GROUP BY ADDRESS
    HAVING COUNT(ADDRESS) > 10
    ORDER BY �ü��� DESC
)
FETCH FIRST ROW ONLY;

-- CUSTOMER �и� --
SELECT NAME, MOBILE_NO, EMAIL,
DECODE(SUBSTR(TMP, 0, 2), '����', '����Ư����',
          '���', '��걤����',
          '�λ�', '�λ걤����',
          '����', '����������',
          '��õ', '��õ������',
          '�뱸', '�뱸������',
          '����', '���ֱ�����',
          '����', '����Ư����ġ��',
          '���', '��⵵',
          '����', '������',
          '����', '���󳲵�',
          '����', '����ϵ�',
          '�泲', '��û����',
          '���', '��û�ϵ�',
          '�泲', '��󳲵�',
          '���', '���ϵ�',
          '����', '����Ư����ġ��') || ' ' || SUBSTR(TMP, 4) AS ADDRESS
FROM (
      SELECT SUBSTR(ADDRESS1,1,INSTR(ADDRESS1,' ',1,2)) AS TMP, NAME, MOBILE_NO, EMAIL
      FROM CUSTOMER
    );
    

-- ���� �����(1) -- 
--
SELECT NAME, MOBILE_NO, EMAIL,
DECODE(SUBSTR(TMP, 0, 2),
      '����', '����Ư����',
      '���', '��걤����',
      '�λ�', '�λ걤����',
      '����', '����������',
      '��õ', '��õ������',
      '�뱸', '�뱸������',
      '����', '���ֱ�����',
      '����', '����Ư����ġ��',
      '���', '��⵵',
      '����', '������',
      '����', '���󳲵�',
      '����', '����ϵ�',
      '�泲', '��û����',
      '���', '��û�ϵ�',
      '�泲', '��󳲵�',
      '���', '���ϵ�',
      '����', '����Ư����ġ��') || ' ' || SUBSTR(TMP, 4) AS ADDRESS
FROM(
      SELECT SUBSTR(ADDRESS1,1,INSTR(ADDRESS1,' ',1,2)) AS TMP, NAME, MOBILE_NO, EMAIL
      FROM CUSTOMER
    )
WHERE DECODE(SUBSTR(TMP, 0, 2), '����', '����Ư����',
      '���', '��걤����',
      '�λ�', '�λ걤����',
      '����', '����������',
      '��õ', '��õ������',
      '�뱸', '�뱸������',
      '����', '���ֱ�����',
      '����', '����Ư����ġ��',
      '���', '��⵵',
      '����', '������',
      '����', '���󳲵�',
      '����', '����ϵ�',
      '�泲', '��û����',
      '���', '��û�ϵ�',
      '�泲', '��󳲵�',
      '���', '���ϵ�',
      '����', '����Ư����ġ��') || ' ' || SUBSTR(TMP, 4) = 
      (
      SELECT �ּ�
      FROM(
            SELECT ADDRESS AS �ּ�, COUNT(ADDRESS) AS �ü���
            FROM ESTABLISHMENT
            GROUP BY ADDRESS
            HAVING COUNT(ADDRESS) > 10
            ORDER BY �ü��� DESC
          )
      FETCH FIRST ROW ONLY
      );
    

-- ���� ����� (2) Inner Join ��� --
SELECT c.*
FROM (
    SELECT ADDRESS, COUNT(ADDRESS) AS �ü���
    FROM ESTABLISHMENT
    GROUP BY ADDRESS
    HAVING COUNT(ADDRESS) > 10
    ORDER BY �ü��� DESC
    FETCH FIRST ROW ONLY
) e
INNER JOIN (
  SELECT NAME, MOBILE_NO, EMAIL,
    DECODE(SUBSTR(TMP, 0, 2),
    '����', '����Ư����',
    '���', '��걤����',
    '�λ�', '�λ걤����',
    '����', '����������',
    '��õ', '��õ������',
    '�뱸', '�뱸������',
    '����', '���ֱ�����',
    '����', '����Ư����ġ��',
    '���', '��⵵',
    '����', '������',
    '����', '���󳲵�',
    '����', '����ϵ�',
    '�泲', '��û����',
    '���', '��û�ϵ�',
    '�泲', '��󳲵�',
    '���', '���ϵ�',
    '����', '����Ư����ġ��') || ' ' || SUBSTR(TMP, 4) AS ADDRESS
  FROM (
    SELECT SUBSTR(ADDRESS1,1,INSTR(ADDRESS1,' ',1,2)) AS TMP, NAME, MOBILE_NO, EMAIL
    FROM CUSTOMER
      )
) c
ON c.ADDRESS = e.ADDRESS;
