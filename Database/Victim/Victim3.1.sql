---- ���� Ƚ�� ������Ʈ ���
---- ���� �˰��� ���� ����, (timestamp - �Ҽ��� ���� �ð� �̿� �̱�)
---- �й�, �̸�, ���� Ƚ�� ���

SET SERVEROUTPUT ON
DECLARE
  v_id NUMBER(2);
  v_count NUMBER(10);
BEGIN
  SELECT MOD(TO_NUMBER(EXTRACT(SECOND FROM SYSTIMESTAMP) * 100), 22) + 1 INTO v_id FROM DUAL;

  UPDATE STUDENT
  SET COUNT = COUNT + 1
  WHERE ID = v_id;

  SELECT NAME AS Victim, "COUNT" INTO :victim, v_count
  FROM STUDENT
  WHERE ID = v_id;

  DBMS_OUTPUT.PUT_LINE( '��ǥ�� : ' || v_id || '-' || :victim  || ' ' || '[' || v_count || '�� ��÷]' );
END;
/

select * from STUDENT;
--desc student;