SELECT DECODE(ROUND(DBMS_RANDOM.VALUE(0.5,21.5),0), 1, '������', 2, '���±�', 3, '����ȯ', 4, '�����', 5, '�賲��', 6, '���翵', 7, '���Ͽ�', 8, '�ڰ��', 9, '������', 10, '������', 11, '�ɹ���', 12, '�̵���', 13, '�̽���', 14, '������', 15, '�Ӽ���', 16, '������', 17, '������', 18, '���ֿ�', 19, '�ְ��', 20, '�ֹο�', 21, '������', 22, 'ȫ����') as Victim FROM DUAL;