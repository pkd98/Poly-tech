-- ���� Ƚ�� �߰� ����
SET SERVEROUTPUT ON
DECLARE
  v_id NUMBER(2);
BEGIN
  v_id := ROUND(DBMS_RANDOM.VALUE(0.5,21.5),0);

  UPDATE STUDENT
  SET COUNT = COUNT + 1
  WHERE ID = v_id;

  SELECT NAME AS Victim INTO :victim
  FROM STUDENT
  WHERE ID = v_id;
  
  DBMS_OUTPUT.PUT_LINE('Selected victim: ' || :victim);
END;
/


-- COUNT ���� �������� �� �� �ִ�.
-- SELECT * FROM STUDENT;