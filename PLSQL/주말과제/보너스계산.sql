-- customer table
CREATE OR REPLACE PROCEDURE insert_bonus_primitive AS 
  -- EMP 테이블에서 데이터를 가져오는 커서를 선언
  CURSOR emp_cursor IS
    SELECT EMPNO, ENAME, JOB, SAL FROM EMP;

  -- 각 커서의 현재 행을 저장할 변수 선언
  emp_record emp_cursor%ROWTYPE;
  customer_record CUSTOMER%ROWTYPE;

  -- 보너스와 고객 수를 저장할 변수 선언
  comm NUMBER;
  customer_count NUMBER;
BEGIN
  -- EMP cursor open
  OPEN emp_cursor;

  LOOP
    -- EMP 커서에서 한 행씩 Fetch
    FETCH emp_cursor INTO emp_record;
    -- loop 종료 조건 : EMP 커서의 모든 행을 처리
    EXIT WHEN emp_cursor%NOTFOUND;

    customer_count := 0;
    
    FOR customer_record IN (SELECT MGR_EMPNO FROM CUSTOMER) LOOP
      -- 현재 EMP 행의 직원이 현재 CUSTOMER 행의 계정 관리자이면 고객 수를 증가
      IF emp_record.EMPNO = customer_record.MGR_EMPNO THEN
        customer_count := customer_count + 1;
      END IF;
    END LOOP;

    -- 직원의 직무에 따라 보너스를 계산
    IF emp_record.JOB IN ('PRESIDENT', 'ANALYST') THEN
      comm := NULL;
    ELSIF customer_count >= 100000 THEN
      comm := 2000;
    ELSE
      comm := 1000;
    END IF;

    -- BONUS 테이블에 데이터를 삽입
    INSERT INTO BONUS (ENAME, JOB, SAL, COMM)
    VALUES (emp_record.ENAME, emp_record.JOB, emp_record.SAL, NVL(comm,0));
  END LOOP;

  -- 커서 종료
  CLOSE emp_cursor;
  
  -- 변경 사항을 커밋
  COMMIT;
EXCEPTION
  -- 커서가 이미 닫혀있는 경우
  WHEN INVALID_CURSOR THEN
    DBMS_OUTPUT.PUT_LINE('Invalid cursor');
  -- 쿼리가 두 개 이상의 행을 반환하는 경우
  WHEN TOO_MANY_ROWS THEN
    DBMS_OUTPUT.PUT_LINE('Too many rows');
  -- 쿼리가 행을 반환하지 않는 경우
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No data found');
  -- 그 외의 모든 예외를 처리합니다.
  WHEN OTHERS THEN
    -- 오류 메시지를 출력합니다.
    DBMS_OUTPUT.PUT_LINE('An error has occurred: ' || SQLERRM);
    -- 트랜잭션을 롤백합니다.
    ROLLBACK;
END;
/