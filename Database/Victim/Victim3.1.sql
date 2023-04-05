---- 뽑힌 횟수 업데이트 기능
---- 랜덤 알고리즘 수정 버전, (timestamp - 소숫점 이하 시간 이용 뽑기)
---- 학번, 이름, 뽑힌 횟수 출력

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

  DBMS_OUTPUT.PUT_LINE( '발표자 : ' || v_id || '-' || :victim  || ' ' || '[' || v_count || '번 당첨]' );
END;
/

select * from STUDENT;
--desc student;