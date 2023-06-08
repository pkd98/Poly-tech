PROCEDURE LTC_INCREASE_CREDIT_LIMIT IS
  -- CURSOR 선언
  CURSOR CUR_CUSTOMER IS
    SELECT ID, CREDIT_LIMIT, ENROLL_DT
    FROM CUSTOMER;

  -- CURSOR 변수
  v_customer_id CUSTOMER.ID%TYPE;
  v_credit_limit CUSTOMER.CREDIT_LIMIT%TYPE;
  v_enroll_dt CUSTOMER.ENROLL_DT%TYPE;
  
  -- 신용 한도 증가량 변수
  v_amount number;
  
  -- 신용한도 증가된 회원 수 카운트 MAP 정의
  -- TYPE 이름 IS TABLE OF 값 데이터 타입
  -- INDEX BY 키 데이터 타입
  TYPE CUSTOMER_MAP_ IS TABLE OF NUMBER
  INDEX BY BINARY_INTEGER;

  CUSTOMER_MAP CUSTOMER_MAP_; -- 신용한도 증가된 회원 수 저장 변수 선언
    
BEGIN
  -- CURSOR 열기
  OPEN CUR_CUSTOMER;

  -- CURSOR로부터 데이터 읽기
  LOOP
    FETCH CUR_CUSTOMER INTO v_customer_id, v_credit_limit, v_enroll_dt;
    EXIT WHEN CUR_CUSTOMER%NOTFOUND;

    -- 현재 날짜와 ENROLL_DT와의 차이 계산 (년 단위)
    DECLARE
      v_years_diff NUMBER;
        
    BEGIN
      SELECT EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM v_enroll_dt)
      INTO v_years_diff
      FROM DUAL;

      -- ENROLL_DT와의 차이에 따라 CREDIT_LIMIT 조정
      IF v_years_diff >= 5 AND v_years_diff < 10 THEN
        v_amount := 100;
      ELSIF v_years_diff >= 10 AND v_years_diff < 15 THEN
        v_amount := 200;
      ELSIF v_years_diff >= 15 AND v_years_diff < 20 THEN
        v_amount := 300;
      ELSIF v_years_diff >= 20 then
        v_amount := 500;
      END IF;
      
      -- map 초기화 및 amount별 고객 수 카운트
      IF NOT CUSTOMER_MAP.EXISTS(v_amount) THEN
        CUSTOMER_MAP(v_amount) := 1;
      ELSE
        CUSTOMER_MAP(v_amount) := CUSTOMER_MAP(v_amount) + 1;
      END IF;
    END;

    -- 조정된 CREDIT_LIMIT을 업데이트
    UPDATE CUSTOMER
    SET CREDIT_LIMIT = v_credit_limit + v_amount
    WHERE CURRENT OF CUR_CUSTOMER;

    -- 로그 작성
    WRITE_CUST_PROCESS_LOG(LTC_INCREASE_CREDIT_LIMIT, 'INCREASE CREDIT_LIMIT ' || v_amount);
  END LOOP;

  -- CURSOR 닫기
  CLOSE CUR_CUSTOMER;
  
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    WRITE_CSS_LOG('LTC_INCREASE_CREDIT_LIMIT', SQLERRM, '');

END LTC_INCREASE_CREDIT_LIMIT;
/