REM  ***************************************************************************
REM  제 목 : PL/SQL 활용 모듈화 패키지 및 CURSOR 활용 비즈니스 로직 프로시저 작성
REM  작성자 : 박경덕
REM  작성일 : 2023-06-06
REM
REM  비즈니스 로직 CURSOR 적용 프로시저 추가 - LTC_INCREASE_CREDIT_LIMIT
REM  : 가입일(ENROLL_DT) 기준 장기 고객에게 신용한도(CREDIT_LIMIT) 향상
REM                 5 <= YEAR < 10 : CREDIT_LIMIT + 100
REM                 10 <= YEAR < 15 : CREDIT_LIMIT + 200
REM                 15 <= YEAR < 20 : CREDIT_LIMIT + 300
REM                 20 <= YEAR : CREDIT_LIMIT + 500
REM                 
REM     각 구간 별, 장기 고객의 수를 로그 테이블(CUST_PROCESS_LOG)에 남기고자 한다.
REM  ***************************************************************************
--------------------------------------------------------------------------------
-- 필요 테이블 생성
--------------------------------------------------------------------------------
-- 탈퇴 회원을 저장할 OLD_CUSTOMER 테이블 생성
CREATE TABLE OLD_CUSTOMER AS SELECT * FROM CUSTOMER WHERE 1=0;

-- 예외 관련 로그 테이블 생성
CREATE TABLE CSS_LOG (
  LOG_DATE VARCHAR2(8) DEFAULT TO_CHAR(SYSDATE,'YYYYMMDD'), -- 로그 기록 일자
  LOG_TIME VARCHAR2(6) DEFAULT TO_CHAR(SYSDATE,'HH24MISS'), -- 로그 기록 시간
  PROGRAM_NAME VARCHAR2(100), -- EXCEPTION 발생 프로그램
  ERROR_MESSAGE VARCHAR2(250), -- EXCEPTION MESSAGE
  DESCRIPTION VARCHAR2(250) -- 비고 사항
);

-- 비즈니스 로직 처리 관련 로그 테이블 생성
CREATE TABLE CUST_PROCESS_LOG (
  LOG_DATE VARCHAR2(8) DEFAULT TO_CHAR(SYSDATE,'YYYYMMDD'), -- 로그 기록 일자
  LOG_TIME VARCHAR2(6) DEFAULT TO_CHAR(SYSDATE,'HH24MISS'), -- 로그 기록 시간
  PROGRAM_NAME VARCHAR2(100), -- 비즈니스 로직 프로그램
  DESCRIPTION VARCHAR2(250) -- 설명
);

--------------------------------------------------------------------------------
-- Trigger 생성 [AUTONOMOUS TRANSACTION 적용]
--------------------------------------------------------------------------------
-- CUSTOMER TABLE DELETE 후, 해당 탈퇴 회원 OLD_CUSTOMER 테이블에 자동 삽입
CREATE OR REPLACE TRIGGER trg_after_delete_customer
AFTER DELETE
ON CUSTOMER
FOR EACH ROW
DECLARE
  PRAGMA AUTONOMOUS_TRANSACTION; -- Autonomous transaction
BEGIN
  INSERT INTO OLD_CUSTOMER VALUES (
  :OLD.id, :OLD.pwd, :OLD.name, :OLD.zipcode, :OLD.address1, :OLD.address2, 
  :OLD.mobile_no, :OLD.phone_no, :OLD.credit_limit, :OLD.email, :OLD.mgr_empno, 
  :OLD.birth_dt, :OLD.enroll_dt, :OLD.gender
  );
  COMMIT;
END;
/

--------------------------------------------------------------------------------
-- CUSTOMER_MNG PACKAGE HEADER 정의
--------------------------------------------------------------------------------
  /*
    PK, UNIQUE 컬럼을 제외한 데이터는 DEFAULT NULL을 통해,
    NVL()를 활용하여 매개변수로 입력받지 않더라도 이전 데이터로 대체되도록 구현했다.
  */
  
CREATE OR REPLACE PACKAGE CUSTOMER_MNG AS
  -- 예외 처리 로그 작성 프로시저 [AUTONOMOUS TRANSACTION 제어]
  PROCEDURE WRITE_CSS_LOG(
    A_PROGRAM_NAME IN CSS_LOG.PROGRAM_NAME%TYPE,
    A_ERROR_MESSAGE IN CSS_LOG.ERROR_MESSAGE%TYPE,
    A_DESCRIPTION IN CSS_LOG.DESCRIPTION%TYPE
  );
  
  -- 비즈니스 로직 처리 로그 작성 프로시저 [AUTONOMOUS TRANSACTION 제어]
  PROCEDURE WRITE_CUST_PROCESS_LOG(
    A_PROGRAM_NAME IN CUST_PROCESS_LOG.PROGRAM_NAME%TYPE,
    A_DESCRIPTION IN CUST_PROCESS_LOG.DESCRIPTION%TYPE
  );
  
  -- 회원 등록 프로시저 [OLTP TRANSACTION 제어]
  PROCEDURE INSERT_CUST(
    p_id IN CUSTOMER.id%TYPE,
    p_pwd IN CUSTOMER.pwd%TYPE,
    p_name IN CUSTOMER.name%TYPE,
    p_zipcode IN CUSTOMER.zipcode%TYPE default null,
    p_address1 IN CUSTOMER.address1%TYPE default null,
    p_address2 IN CUSTOMER.address2%TYPE default null,
    p_mobile_no IN CUSTOMER.mobile_no%TYPE default null,
    p_phone_no IN CUSTOMER.phone_no%TYPE default null,
    p_credit_limit IN CUSTOMER.credit_limit%TYPE default null,
    p_email IN CUSTOMER.email%TYPE default null,
    p_mgr_empno IN CUSTOMER.mgr_empno%TYPE default null,
    p_birth_dt IN CUSTOMER.birth_dt%TYPE default null,
    p_enroll_dt IN CUSTOMER.enroll_dt%TYPE default null,
    p_gender IN CUSTOMER.gender%TYPE default null
  );
  
  -- 회원 삭제 프로시저 [OLTP TRANSACTION 제어]
  PROCEDURE DELETE_CUST(
    p_id IN CUSTOMER.id%TYPE
  );
  
  -- 회원 갱신 프로시저 [OLTP TRANSACTION 제어]
  PROCEDURE UPDATE_CUST(
    p_id IN CUSTOMER.id%TYPE default null,
    p_pwd IN CUSTOMER.pwd%TYPE default null,
    p_name IN CUSTOMER.name%TYPE default null,
    p_zipcode IN CUSTOMER.zipcode%TYPE default null,
    p_address1 IN CUSTOMER.address1%TYPE default null,
    p_address2 IN CUSTOMER.address2%TYPE default null,
    p_mobile_no IN CUSTOMER.mobile_no%TYPE default null,
    p_phone_no IN CUSTOMER.phone_no%TYPE default null,
    p_credit_limit IN CUSTOMER.credit_limit%TYPE default null,
    p_email IN CUSTOMER.email%TYPE default null,
    p_mgr_empno IN CUSTOMER.mgr_empno%TYPE default null,
    p_birth_dt IN CUSTOMER.birth_dt%TYPE default null,
    p_enroll_dt IN CUSTOMER.enroll_dt%TYPE default null,
    p_gender IN CUSTOMER.gender%TYPE default null
  );
  
  -- 장기 고객 신용 한도 증가 프로시저 (비즈니스 로직)
  PROCEDURE LTC_INCREASE_CREDIT_LIMIT;
  
END CUSTOMER_MNG;
/

--------------------------------------------------------------------------------
-- CUSTOMER_MNG PACKAGE BODY 정의
--------------------------------------------------------------------------------
  /*
    PK, UNIQUE 컬럼을 제외한 데이터는 DEFAULT NULL을 통해,
    NVL()를 활용하여 매개변수로 입력받지 않더라도 이전 데이터로 대체되도록 구현했다.
  */

CREATE OR REPLACE PACKAGE BODY CUSTOMER_MNG AS
  -- 사용자 정의 예외 타입 선언
  EXC_MANDATORY_FIELDS_MISSING EXCEPTION; -- 필수 입력 필드 누락에 대한 예외
  EXC_NO_RECORD_FOUND EXCEPTION; -- 대상 레코드 누락에 대한 예외
  
  -- 유효성 검사용 변수
  rec_count NUMBER;

  -- 로그 작성 프로시저 [AUTONOMOUS TRANSACTION 적용]
  PROCEDURE WRITE_CSS_LOG(
    A_PROGRAM_NAME IN CSS_LOG.PROGRAM_NAME%TYPE,
    A_ERROR_MESSAGE IN CSS_LOG.ERROR_MESSAGE%TYPE,
    A_DESCRIPTION IN CSS_LOG.DESCRIPTION%TYPE
  ) IS
  
  PRAGMA AUTONOMOUS_TRANSACTION; -- AUTONOMOUS TRANSACTION
  
  BEGIN
  -- EXCEPTION을 LOG 테이블에 기록
    INSERT INTO CSS_LOG(PROGRAM_NAME,ERROR_MESSAGE,DESCRIPTION)
      VALUES(A_PROGRAM_NAME,A_ERROR_MESSAGE,A_DESCRIPTION);
    COMMIT; -- AUTONOMOUS TRANSACTION 종료
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
  END WRITE_CSS_LOG;

  -- 비즈니스 로직 처리 로그 작성 프로시저
  PROCEDURE WRITE_CUST_PROCESS_LOG(
    A_PROGRAM_NAME IN CUST_PROCESS_LOG.PROGRAM_NAME%TYPE,
    A_DESCRIPTION IN CUST_PROCESS_LOG.DESCRIPTION%TYPE
  ) IS
  
    PRAGMA AUTONOMOUS_TRANSACTION; -- AUTONOMOUS TRANSACTION
  
  BEGIN
  -- EXCEPTION을 LOG 테이블에 기록
    INSERT INTO CUST_PROCESS_LOG(PROGRAM_NAME, DESCRIPTION)
      VALUES(A_PROGRAM_NAME, A_DESCRIPTION);
    COMMIT;
    
  -- 예외 처리 및 로그 기록
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
  END WRITE_CUST_PROCESS_LOG;

  -- 회원 등록 프로시저 [OLTP TRANSACTION 제어]
  PROCEDURE INSERT_CUST(
    p_id IN CUSTOMER.id%TYPE,
    p_pwd IN CUSTOMER.pwd%TYPE,
    p_name IN CUSTOMER.name%TYPE,
    p_zipcode IN CUSTOMER.zipcode%TYPE default null,
    p_address1 IN CUSTOMER.address1%TYPE default null,
    p_address2 IN CUSTOMER.address2%TYPE default null,
    p_mobile_no IN CUSTOMER.mobile_no%TYPE default null,
    p_phone_no IN CUSTOMER.phone_no%TYPE default null,
    p_credit_limit IN CUSTOMER.credit_limit%TYPE default null,
    p_email IN CUSTOMER.email%TYPE default null,
    p_mgr_empno IN CUSTOMER.mgr_empno%TYPE default null,
    p_birth_dt IN CUSTOMER.birth_dt%TYPE default null,
    p_enroll_dt IN CUSTOMER.enroll_dt%TYPE default null,
    p_gender IN CUSTOMER.gender%TYPE default null
  ) IS
  BEGIN
    -- PK, UNIQUE인 ID, PWD, NAME의 매개변수 입력 값이 NULL이면 사용자 정의 예외 처리
    IF p_id IS NULL OR p_pwd IS NULL OR p_name IS NULL THEN
      RAISE EXC_MANDATORY_FIELDS_MISSING;
      
    ELSE
      INSERT INTO CUSTOMER(id, pwd, name, zipcode, address1, address2, mobile_no, phone_no, credit_limit, email, mgr_empno, birth_dt, enroll_dt, gender)
      VALUES (p_id, p_pwd, p_name, p_zipcode, p_address1, p_address2, p_mobile_no, p_phone_no, p_credit_limit, p_email, p_mgr_empno, p_birth_dt, p_enroll_dt, p_gender);
      COMMIT; -- OLTP Transaction 종료
    END IF;

  -- 예외 처리 및 로그 기록
  EXCEPTION
    WHEN EXC_MANDATORY_FIELDS_MISSING THEN
      ROLLBACK;
      WRITE_CSS_LOG('INSERT_CUST', 'MANDATORY_FIELDS_MISSING', 'ID, PWD, NAME 은 필수 입력 해야 합니다.');
    
    WHEN OTHERS THEN
      ROLLBACK;
      WRITE_CSS_LOG('INSERT_CUST', SQLERRM, '');
      
  END INSERT_CUST;

  -- 회원 삭제 프로시저 [OLTP TRANSACTION 제어]
  PROCEDURE DELETE_CUST(
    p_id IN CUSTOMER.id%TYPE
  ) IS
  BEGIN
    -- PK 컬럼인 ID 값 매개변수 NULL일 경우 사용자 정의 예외 처리
    IF p_id IS NULL THEN
      RAISE EXC_MANDATORY_FIELDS_MISSING;
      
    ELSE
      -- 삭제 대상 ID 레코드 없을 경우 사용자 정의 예외 처리
      SELECT COUNT(*) INTO rec_count FROM CUSTOMER WHERE id = p_id;
      IF rec_count = 0 THEN
        RAISE EXC_NO_RECORD_FOUND;
        
      ELSE
        DELETE FROM CUSTOMER WHERE id = p_id;
        COMMIT; -- OLTP Transaction 종료
      END IF;
    END IF;
    
    -- 예외 처리 및 로그 기록
    EXCEPTION
    WHEN EXC_MANDATORY_FIELDS_MISSING THEN
        ROLLBACK;
        WRITE_CSS_LOG('DELETE_CUST', 'MANDATORY_FIELDS_MISSING', 'ID은 필수 입력 해야 합니다.');
        
    WHEN EXC_NO_RECORD_FOUND THEN
        ROLLBACK;
        WRITE_CSS_LOG('DELETE_CUST', 'NO_RECORD_FOUND', '대상 레코드를 찾을 수 없습니다.');

    WHEN OTHERS THEN
        ROLLBACK;
        WRITE_CSS_LOG('DELETE_CUST', SQLERRM, '');
        
  END DELETE_CUST;

  -- 회원 갱신 프로시저 [OLTP TRANSACTION 제어]
  PROCEDURE UPDATE_CUST(
    p_id IN CUSTOMER.id%TYPE,
    p_pwd IN CUSTOMER.pwd%TYPE default null,
    p_name IN CUSTOMER.name%TYPE default null,
    p_zipcode IN CUSTOMER.zipcode%TYPE default null,
    p_address1 IN CUSTOMER.address1%TYPE default null,
    p_address2 IN CUSTOMER.address2%TYPE default null,
    p_mobile_no IN CUSTOMER.mobile_no%TYPE default null,
    p_phone_no IN CUSTOMER.phone_no%TYPE default null,
    p_credit_limit IN CUSTOMER.credit_limit%TYPE default null,
    p_email IN CUSTOMER.email%TYPE default null,
    p_mgr_empno IN CUSTOMER.mgr_empno%TYPE default null,
    p_birth_dt IN CUSTOMER.birth_dt%TYPE default null,
    p_enroll_dt IN CUSTOMER.enroll_dt%TYPE default null,
    p_gender IN CUSTOMER.gender%TYPE default null
  ) IS
  BEGIN
    -- PK 컬럼인 ID 값 매개변수 NULL일 경우 사용자 정의 예외 처리
    IF p_id IS NULL THEN
      RAISE EXC_MANDATORY_FIELDS_MISSING;
      
    ELSE
      -- 삭제 대상 ID 레코드 없을 경우 사용자 정의 예외 처리
      SELECT COUNT(*) INTO rec_count FROM CUSTOMER WHERE id = p_id;
      IF rec_count = 0 THEN
        RAISE EXC_NO_RECORD_FOUND;
        
      ELSE
      /* NVL()을 이용해, default null을 활용하여 
         - 매개변수 입력 값이 없으면 기존값 대체
         - 매개변수 입력 값 있으면 해당 값으로 치환 후 UPDATE 수행
      */
        UPDATE CUSTOMER
        SET pwd = NVL(p_pwd, pwd),
            name = NVL(p_name, name),
            zipcode = NVL(p_zipcode, zipcode),
            address1 = NVL(p_address1, address1),
            address2 = NVL(p_address2, address2),
            mobile_no = NVL(p_mobile_no, mobile_no),
            phone_no = NVL(p_phone_no, phone_no),
            credit_limit = NVL(p_credit_limit, credit_limit),
            email = NVL(p_email, email),
            mgr_empno = NVL(p_mgr_empno, mgr_empno),
            birth_dt = NVL(p_birth_dt, birth_dt),
            enroll_dt = NVL(p_enroll_dt, enroll_dt),
            gender = NVL(p_gender, gender)
        WHERE id = p_id;
        COMMIT; -- OLTP Transaction 종료
      END IF;
    END IF;
    
  -- 예외 처리 및 로그 기록
  EXCEPTION
    WHEN EXC_MANDATORY_FIELDS_MISSING THEN
        ROLLBACK;
        WRITE_CSS_LOG('UPDATE_CUST', 'MANDATORY_FIELDS_MISSING', 'ID은 필수 입력 해야 합니다.');
        
    WHEN EXC_NO_RECORD_FOUND THEN
        ROLLBACK;
        WRITE_CSS_LOG('UPDATE_CUST', 'NO_RECORD_FOUND', '대상 레코드를 찾을 수 없습니다.');

    WHEN OTHERS THEN
        ROLLBACK;
        WRITE_CSS_LOG('UPDATE_CUST', SQLERRM, '');

  END UPDATE_CUST;
  
  -- 가입일(ENROLL_DT) 기준 장기 고객에게 신용한도(CREDIT_LIMIT) 향상 프로시저
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
    TYPE CUSTOMER_MAP_ IS TABLE OF NUMBER
    INDEX BY BINARY_INTEGER;
    -- 신용한도 증가된 회원 수 저장 변수 선언
    CUSTOMER_MAP CUSTOMER_MAP_; 
    -- map key 값 순회를 위한 변수 선언
    key_value BINARY_INTEGER;
  BEGIN
    -- CURSOR 열기
    OPEN CUR_CUSTOMER;

    -- CURSOR로부터 데이터 읽기
    LOOP
      FETCH CUR_CUSTOMER INTO v_customer_id, v_credit_limit, v_enroll_dt;
      EXIT WHEN CUR_CUSTOMER%NOTFOUND;

      -- 현재 날짜와 ENROLL_DT와의 차이 계산 (년 단위) - NESTED BLOCK 구조
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
      
        -- MAP 초기화 및 AMOUNT 별 고객 수 카운트
        IF NOT CUSTOMER_MAP.EXISTS(v_amount) THEN
          CUSTOMER_MAP(v_amount) := 1;
        ELSE
          CUSTOMER_MAP(v_amount) := CUSTOMER_MAP(v_amount) + 1;
        END IF;
      END;

--      조정된 CREDIT_LIMIT을 업데이트
--      UPDATE CUSTOMER
--      SET CREDIT_LIMIT = v_credit_limit + v_amount
--      WHERE CURRENT OF CUR_CUSTOMER;
    END LOOP;

    -- 처리 완료 로그 작성
    key_value := CUSTOMER_MAP.first;
        while key_value is not null
            loop
                WRITE_CUST_PROCESS_LOG('LTC_INCREASE_CREDIT_LIMIT', '증가량 '|| key_value || ' : ' || CUSTOMER_MAP(key_value) || '명');
                key_value := CUSTOMER_MAP.next(key_value);
            end loop;
--    COMMIT; -- OLAP TRANSACTION 종료
    
    -- CURSOR 닫기
    CLOSE CUR_CUSTOMER;
  
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      WRITE_CSS_LOG('LTC_INCREASE_CREDIT_LIMIT', SQLERRM, '');

  END LTC_INCREASE_CREDIT_LIMIT;
  
END CUSTOMER_MNG;
/

--------------------------------------------------------------------------------
-- ** 패키지 테스트 코드 **
--------------------------------------------------------------------------------
-- INSERT_CUST 테스트 코드 BLOCK
--------------------------------------------------------------------------------
BEGIN
  -- 정상 INSERT_CUST 입력
  CUSTOMER_MNG.INSERT_CUST(
    p_id => '12345678',
    p_pwd => 'TEST',
    p_name => 'TEST'
  );
  
  -- 같은 ID 중복 입력 예외 처리 테스트
  CUSTOMER_MNG.INSERT_CUST(
    p_id => '12345678',
    p_pwd => 'TEST2',
    p_name => 'TEST2'
  );
  
  -- PW 누락 예외 처리 테스트
  CUSTOMER_MNG.INSERT_CUST(
    p_id => '12345678',
    p_pwd => '',
    p_name => 'TEST'
  );
  
  -- name 누락 예외 처리 테스트
  CUSTOMER_MNG.INSERT_CUST(
    p_id => '12345678',
    p_pwd => 'TEST',
    p_name => ''
  );
  
  -- id, pwd, name 누락 예외 처리 테스트
  CUSTOMER_MNG.INSERT_CUST(
    p_id => '',
    p_pwd => '',
    p_name => ''
  );
END;
/

--------------------------------------------------------------------------------
-- UPDATE_CUST 테스트 코드 BLOCK
--------------------------------------------------------------------------------
BEGIN
  -- UPDATE_CUST 정상 수정 갱신
  CUSTOMER_MNG.UPDATE_CUST(
    p_id => '12345678',
    p_name => 'MODIFIED'
  );
  
  -- ID 누락 예외 처리 테스트
  CUSTOMER_MNG.UPDATE_CUST(
    p_id => '',
    p_name => 'MODIFIED'
  );
  
  -- UPDATE 대상 레코드 없을 경우 예외 처리 테스트
  CUSTOMER_MNG.UPDATE_CUST(
    p_id => '99999999',
    p_name => 'MODIFIED'
  );
END;
/

--------------------------------------------------------------------------------
-- DELETE_CUST 테스트
--------------------------------------------------------------------------------
BEGIN
  -- DELETE_CUST 정상 삭제 수행
  CUSTOMER_MNG.DELETE_CUST(
    p_id => '12345678'
  );
  
  -- ID 누락 예외 처리 테스트
  CUSTOMER_MNG.DELETE_CUST(
    p_id => ''
  );
  
  -- DELETE 대상 레코드 없을 경우 예외 처리
  CUSTOMER_MNG.DELETE_CUST(
    p_id => '99999999'
  );
END;
/

--------------------------------------------------------------------------------
-- LTC_INCREASE_CREDIT_LIMIT 테스트 (비즈니스 로직)
--------------------------------------------------------------------------------
BEGIN
  CUSTOMER_MNG.LTC_INCREASE_CREDIT_LIMIT;
END;
/

SELECT * FROM CUSTOMER WHERE ID = 12345678;
SELECT * FROM OLD_CUSTOMER;
SELECT * FROM CSS_LOG;
SELECT * FROM CUST_PROCESS_LOG;

TRUNCATE TABLE OLD_CUSTOMER;
TRUNCATE TABLE CSS_LOG;
TRUNCATE TABLE CUST_PROCESS_LOG;
