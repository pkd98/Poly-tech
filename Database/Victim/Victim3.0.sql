-- 뽑힌 횟수 추가 버전
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


-- COUNT 값이 증가함을 볼 수 있다.
-- SELECT * FROM STUDENT;