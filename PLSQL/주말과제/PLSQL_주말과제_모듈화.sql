REM  ***************************************************************************
REM  �� �� : PL/SQL Ȱ�� ���ȭ ��Ű�� �� CURSOR Ȱ�� ����Ͻ� ���� ���ν��� �ۼ�
REM  �ۼ��� : �ڰ��
REM  �ۼ��� : 2023-06-06
REM
REM  ����Ͻ� ���� CURSOR ���� ���ν��� �߰� - LTC_INCREASE_CREDIT_LIMIT
REM  : ������(ENROLL_DT) ���� ��� ������ �ſ��ѵ�(CREDIT_LIMIT) ���
REM                 5 <= YEAR < 10 : CREDIT_LIMIT + 100
REM                 10 <= YEAR < 15 : CREDIT_LIMIT + 200
REM                 15 <= YEAR < 20 : CREDIT_LIMIT + 300
REM                 20 <= YEAR : CREDIT_LIMIT + 500
REM                 
REM     �� ���� ��, ��� ���� ���� �α� ���̺�(CUST_PROCESS_LOG)�� ������� �Ѵ�.
REM  ***************************************************************************
--------------------------------------------------------------------------------
-- �ʿ� ���̺� ����
--------------------------------------------------------------------------------
-- Ż�� ȸ���� ������ OLD_CUSTOMER ���̺� ����
CREATE TABLE OLD_CUSTOMER AS SELECT * FROM CUSTOMER WHERE 1=0;

-- ���� ���� �α� ���̺� ����
CREATE TABLE CSS_LOG (
  LOG_DATE VARCHAR2(8) DEFAULT TO_CHAR(SYSDATE,'YYYYMMDD'), -- �α� ��� ����
  LOG_TIME VARCHAR2(6) DEFAULT TO_CHAR(SYSDATE,'HH24MISS'), -- �α� ��� �ð�
  PROGRAM_NAME VARCHAR2(100), -- EXCEPTION �߻� ���α׷�
  ERROR_MESSAGE VARCHAR2(250), -- EXCEPTION MESSAGE
  DESCRIPTION VARCHAR2(250) -- ��� ����
);

-- ����Ͻ� ���� ó�� ���� �α� ���̺� ����
CREATE TABLE CUST_PROCESS_LOG (
  LOG_DATE VARCHAR2(8) DEFAULT TO_CHAR(SYSDATE,'YYYYMMDD'), -- �α� ��� ����
  LOG_TIME VARCHAR2(6) DEFAULT TO_CHAR(SYSDATE,'HH24MISS'), -- �α� ��� �ð�
  PROGRAM_NAME VARCHAR2(100), -- ����Ͻ� ���� ���α׷�
  DESCRIPTION VARCHAR2(250) -- ����
);

--------------------------------------------------------------------------------
-- Trigger ���� [AUTONOMOUS TRANSACTION ����]
--------------------------------------------------------------------------------
-- CUSTOMER TABLE DELETE ��, �ش� Ż�� ȸ�� OLD_CUSTOMER ���̺� �ڵ� ����
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
-- CUSTOMER_MNG PACKAGE HEADER ����
--------------------------------------------------------------------------------
  /*
    PK, UNIQUE �÷��� ������ �����ʹ� DEFAULT NULL�� ����,
    NVL()�� Ȱ���Ͽ� �Ű������� �Է¹��� �ʴ��� ���� �����ͷ� ��ü�ǵ��� �����ߴ�.
  */
  
CREATE OR REPLACE PACKAGE CUSTOMER_MNG AS
  -- ���� ó�� �α� �ۼ� ���ν��� [AUTONOMOUS TRANSACTION ����]
  PROCEDURE WRITE_CSS_LOG(
    A_PROGRAM_NAME IN CSS_LOG.PROGRAM_NAME%TYPE,
    A_ERROR_MESSAGE IN CSS_LOG.ERROR_MESSAGE%TYPE,
    A_DESCRIPTION IN CSS_LOG.DESCRIPTION%TYPE
  );
  
  -- ����Ͻ� ���� ó�� �α� �ۼ� ���ν��� [AUTONOMOUS TRANSACTION ����]
  PROCEDURE WRITE_CUST_PROCESS_LOG(
    A_PROGRAM_NAME IN CUST_PROCESS_LOG.PROGRAM_NAME%TYPE,
    A_DESCRIPTION IN CUST_PROCESS_LOG.DESCRIPTION%TYPE
  );
  
  -- ȸ�� ��� ���ν��� [OLTP TRANSACTION ����]
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
  
  -- ȸ�� ���� ���ν��� [OLTP TRANSACTION ����]
  PROCEDURE DELETE_CUST(
    p_id IN CUSTOMER.id%TYPE
  );
  
  -- ȸ�� ���� ���ν��� [OLTP TRANSACTION ����]
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
  
  -- ��� �� �ſ� �ѵ� ���� ���ν��� (����Ͻ� ����)
  PROCEDURE LTC_INCREASE_CREDIT_LIMIT;
  
END CUSTOMER_MNG;
/

--------------------------------------------------------------------------------
-- CUSTOMER_MNG PACKAGE BODY ����
--------------------------------------------------------------------------------
  /*
    PK, UNIQUE �÷��� ������ �����ʹ� DEFAULT NULL�� ����,
    NVL()�� Ȱ���Ͽ� �Ű������� �Է¹��� �ʴ��� ���� �����ͷ� ��ü�ǵ��� �����ߴ�.
  */

CREATE OR REPLACE PACKAGE BODY CUSTOMER_MNG AS
  -- ����� ���� ���� Ÿ�� ����
  EXC_MANDATORY_FIELDS_MISSING EXCEPTION; -- �ʼ� �Է� �ʵ� ������ ���� ����
  EXC_NO_RECORD_FOUND EXCEPTION; -- ��� ���ڵ� ������ ���� ����
  
  -- ��ȿ�� �˻�� ����
  rec_count NUMBER;

  -- �α� �ۼ� ���ν��� [AUTONOMOUS TRANSACTION ����]
  PROCEDURE WRITE_CSS_LOG(
    A_PROGRAM_NAME IN CSS_LOG.PROGRAM_NAME%TYPE,
    A_ERROR_MESSAGE IN CSS_LOG.ERROR_MESSAGE%TYPE,
    A_DESCRIPTION IN CSS_LOG.DESCRIPTION%TYPE
  ) IS
  
  PRAGMA AUTONOMOUS_TRANSACTION; -- AUTONOMOUS TRANSACTION
  
  BEGIN
  -- EXCEPTION�� LOG ���̺� ���
    INSERT INTO CSS_LOG(PROGRAM_NAME,ERROR_MESSAGE,DESCRIPTION)
      VALUES(A_PROGRAM_NAME,A_ERROR_MESSAGE,A_DESCRIPTION);
    COMMIT; -- AUTONOMOUS TRANSACTION ����
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
  END WRITE_CSS_LOG;

  -- ����Ͻ� ���� ó�� �α� �ۼ� ���ν���
  PROCEDURE WRITE_CUST_PROCESS_LOG(
    A_PROGRAM_NAME IN CUST_PROCESS_LOG.PROGRAM_NAME%TYPE,
    A_DESCRIPTION IN CUST_PROCESS_LOG.DESCRIPTION%TYPE
  ) IS
  
    PRAGMA AUTONOMOUS_TRANSACTION; -- AUTONOMOUS TRANSACTION
  
  BEGIN
  -- EXCEPTION�� LOG ���̺� ���
    INSERT INTO CUST_PROCESS_LOG(PROGRAM_NAME, DESCRIPTION)
      VALUES(A_PROGRAM_NAME, A_DESCRIPTION);
    COMMIT;
    
  -- ���� ó�� �� �α� ���
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
  END WRITE_CUST_PROCESS_LOG;

  -- ȸ�� ��� ���ν��� [OLTP TRANSACTION ����]
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
    -- PK, UNIQUE�� ID, PWD, NAME�� �Ű����� �Է� ���� NULL�̸� ����� ���� ���� ó��
    IF p_id IS NULL OR p_pwd IS NULL OR p_name IS NULL THEN
      RAISE EXC_MANDATORY_FIELDS_MISSING;
      
    ELSE
      INSERT INTO CUSTOMER(id, pwd, name, zipcode, address1, address2, mobile_no, phone_no, credit_limit, email, mgr_empno, birth_dt, enroll_dt, gender)
      VALUES (p_id, p_pwd, p_name, p_zipcode, p_address1, p_address2, p_mobile_no, p_phone_no, p_credit_limit, p_email, p_mgr_empno, p_birth_dt, p_enroll_dt, p_gender);
      COMMIT; -- OLTP Transaction ����
    END IF;

  -- ���� ó�� �� �α� ���
  EXCEPTION
    WHEN EXC_MANDATORY_FIELDS_MISSING THEN
      ROLLBACK;
      WRITE_CSS_LOG('INSERT_CUST', 'MANDATORY_FIELDS_MISSING', 'ID, PWD, NAME �� �ʼ� �Է� �ؾ� �մϴ�.');
    
    WHEN OTHERS THEN
      ROLLBACK;
      WRITE_CSS_LOG('INSERT_CUST', SQLERRM, '');
      
  END INSERT_CUST;

  -- ȸ�� ���� ���ν��� [OLTP TRANSACTION ����]
  PROCEDURE DELETE_CUST(
    p_id IN CUSTOMER.id%TYPE
  ) IS
  BEGIN
    -- PK �÷��� ID �� �Ű����� NULL�� ��� ����� ���� ���� ó��
    IF p_id IS NULL THEN
      RAISE EXC_MANDATORY_FIELDS_MISSING;
      
    ELSE
      -- ���� ��� ID ���ڵ� ���� ��� ����� ���� ���� ó��
      SELECT COUNT(*) INTO rec_count FROM CUSTOMER WHERE id = p_id;
      IF rec_count = 0 THEN
        RAISE EXC_NO_RECORD_FOUND;
        
      ELSE
        DELETE FROM CUSTOMER WHERE id = p_id;
        COMMIT; -- OLTP Transaction ����
      END IF;
    END IF;
    
    -- ���� ó�� �� �α� ���
    EXCEPTION
    WHEN EXC_MANDATORY_FIELDS_MISSING THEN
        ROLLBACK;
        WRITE_CSS_LOG('DELETE_CUST', 'MANDATORY_FIELDS_MISSING', 'ID�� �ʼ� �Է� �ؾ� �մϴ�.');
        
    WHEN EXC_NO_RECORD_FOUND THEN
        ROLLBACK;
        WRITE_CSS_LOG('DELETE_CUST', 'NO_RECORD_FOUND', '��� ���ڵ带 ã�� �� �����ϴ�.');

    WHEN OTHERS THEN
        ROLLBACK;
        WRITE_CSS_LOG('DELETE_CUST', SQLERRM, '');
        
  END DELETE_CUST;

  -- ȸ�� ���� ���ν��� [OLTP TRANSACTION ����]
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
    -- PK �÷��� ID �� �Ű����� NULL�� ��� ����� ���� ���� ó��
    IF p_id IS NULL THEN
      RAISE EXC_MANDATORY_FIELDS_MISSING;
      
    ELSE
      -- ���� ��� ID ���ڵ� ���� ��� ����� ���� ���� ó��
      SELECT COUNT(*) INTO rec_count FROM CUSTOMER WHERE id = p_id;
      IF rec_count = 0 THEN
        RAISE EXC_NO_RECORD_FOUND;
        
      ELSE
      /* NVL()�� �̿���, default null�� Ȱ���Ͽ� 
         - �Ű����� �Է� ���� ������ ������ ��ü
         - �Ű����� �Է� �� ������ �ش� ������ ġȯ �� UPDATE ����
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
        COMMIT; -- OLTP Transaction ����
      END IF;
    END IF;
    
  -- ���� ó�� �� �α� ���
  EXCEPTION
    WHEN EXC_MANDATORY_FIELDS_MISSING THEN
        ROLLBACK;
        WRITE_CSS_LOG('UPDATE_CUST', 'MANDATORY_FIELDS_MISSING', 'ID�� �ʼ� �Է� �ؾ� �մϴ�.');
        
    WHEN EXC_NO_RECORD_FOUND THEN
        ROLLBACK;
        WRITE_CSS_LOG('UPDATE_CUST', 'NO_RECORD_FOUND', '��� ���ڵ带 ã�� �� �����ϴ�.');

    WHEN OTHERS THEN
        ROLLBACK;
        WRITE_CSS_LOG('UPDATE_CUST', SQLERRM, '');

  END UPDATE_CUST;
  
  -- ������(ENROLL_DT) ���� ��� ������ �ſ��ѵ�(CREDIT_LIMIT) ��� ���ν���
  PROCEDURE LTC_INCREASE_CREDIT_LIMIT IS
    -- CURSOR ����
    CURSOR CUR_CUSTOMER IS
      SELECT ID, CREDIT_LIMIT, ENROLL_DT
      FROM CUSTOMER;

    -- CURSOR ����
    v_customer_id CUSTOMER.ID%TYPE;
    v_credit_limit CUSTOMER.CREDIT_LIMIT%TYPE;
    v_enroll_dt CUSTOMER.ENROLL_DT%TYPE;
    
    -- �ſ� �ѵ� ������ ����
    v_amount number;
    
    -- �ſ��ѵ� ������ ȸ�� �� ī��Ʈ MAP ����
    TYPE CUSTOMER_MAP_ IS TABLE OF NUMBER
    INDEX BY BINARY_INTEGER;
    -- �ſ��ѵ� ������ ȸ�� �� ���� ���� ����
    CUSTOMER_MAP CUSTOMER_MAP_; 
    -- map key �� ��ȸ�� ���� ���� ����
    key_value BINARY_INTEGER;
  BEGIN
    -- CURSOR ����
    OPEN CUR_CUSTOMER;

    -- CURSOR�κ��� ������ �б�
    LOOP
      FETCH CUR_CUSTOMER INTO v_customer_id, v_credit_limit, v_enroll_dt;
      EXIT WHEN CUR_CUSTOMER%NOTFOUND;

      -- ���� ��¥�� ENROLL_DT���� ���� ��� (�� ����) - NESTED BLOCK ����
      DECLARE
      v_years_diff NUMBER;
        
      BEGIN
        SELECT EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM v_enroll_dt)
        INTO v_years_diff
        FROM DUAL;

        -- ENROLL_DT���� ���̿� ���� CREDIT_LIMIT ����
        IF v_years_diff >= 5 AND v_years_diff < 10 THEN
          v_amount := 100;
        ELSIF v_years_diff >= 10 AND v_years_diff < 15 THEN
          v_amount := 200;
        ELSIF v_years_diff >= 15 AND v_years_diff < 20 THEN
          v_amount := 300;
        ELSIF v_years_diff >= 20 then
          v_amount := 500;
        END IF;
      
        -- MAP �ʱ�ȭ �� AMOUNT �� �� �� ī��Ʈ
        IF NOT CUSTOMER_MAP.EXISTS(v_amount) THEN
          CUSTOMER_MAP(v_amount) := 1;
        ELSE
          CUSTOMER_MAP(v_amount) := CUSTOMER_MAP(v_amount) + 1;
        END IF;
      END;

--      ������ CREDIT_LIMIT�� ������Ʈ
--      UPDATE CUSTOMER
--      SET CREDIT_LIMIT = v_credit_limit + v_amount
--      WHERE CURRENT OF CUR_CUSTOMER;
    END LOOP;

    -- ó�� �Ϸ� �α� �ۼ�
    key_value := CUSTOMER_MAP.first;
        while key_value is not null
            loop
                WRITE_CUST_PROCESS_LOG('LTC_INCREASE_CREDIT_LIMIT', '������ '|| key_value || ' : ' || CUSTOMER_MAP(key_value) || '��');
                key_value := CUSTOMER_MAP.next(key_value);
            end loop;
--    COMMIT; -- OLAP TRANSACTION ����
    
    -- CURSOR �ݱ�
    CLOSE CUR_CUSTOMER;
  
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      WRITE_CSS_LOG('LTC_INCREASE_CREDIT_LIMIT', SQLERRM, '');

  END LTC_INCREASE_CREDIT_LIMIT;
  
END CUSTOMER_MNG;
/

--------------------------------------------------------------------------------
-- ** ��Ű�� �׽�Ʈ �ڵ� **
--------------------------------------------------------------------------------
-- INSERT_CUST �׽�Ʈ �ڵ� BLOCK
--------------------------------------------------------------------------------
BEGIN
  -- ���� INSERT_CUST �Է�
  CUSTOMER_MNG.INSERT_CUST(
    p_id => '12345678',
    p_pwd => 'TEST',
    p_name => 'TEST'
  );
  
  -- ���� ID �ߺ� �Է� ���� ó�� �׽�Ʈ
  CUSTOMER_MNG.INSERT_CUST(
    p_id => '12345678',
    p_pwd => 'TEST2',
    p_name => 'TEST2'
  );
  
  -- PW ���� ���� ó�� �׽�Ʈ
  CUSTOMER_MNG.INSERT_CUST(
    p_id => '12345678',
    p_pwd => '',
    p_name => 'TEST'
  );
  
  -- name ���� ���� ó�� �׽�Ʈ
  CUSTOMER_MNG.INSERT_CUST(
    p_id => '12345678',
    p_pwd => 'TEST',
    p_name => ''
  );
  
  -- id, pwd, name ���� ���� ó�� �׽�Ʈ
  CUSTOMER_MNG.INSERT_CUST(
    p_id => '',
    p_pwd => '',
    p_name => ''
  );
END;
/

--------------------------------------------------------------------------------
-- UPDATE_CUST �׽�Ʈ �ڵ� BLOCK
--------------------------------------------------------------------------------
BEGIN
  -- UPDATE_CUST ���� ���� ����
  CUSTOMER_MNG.UPDATE_CUST(
    p_id => '12345678',
    p_name => 'MODIFIED'
  );
  
  -- ID ���� ���� ó�� �׽�Ʈ
  CUSTOMER_MNG.UPDATE_CUST(
    p_id => '',
    p_name => 'MODIFIED'
  );
  
  -- UPDATE ��� ���ڵ� ���� ��� ���� ó�� �׽�Ʈ
  CUSTOMER_MNG.UPDATE_CUST(
    p_id => '99999999',
    p_name => 'MODIFIED'
  );
END;
/

--------------------------------------------------------------------------------
-- DELETE_CUST �׽�Ʈ
--------------------------------------------------------------------------------
BEGIN
  -- DELETE_CUST ���� ���� ����
  CUSTOMER_MNG.DELETE_CUST(
    p_id => '12345678'
  );
  
  -- ID ���� ���� ó�� �׽�Ʈ
  CUSTOMER_MNG.DELETE_CUST(
    p_id => ''
  );
  
  -- DELETE ��� ���ڵ� ���� ��� ���� ó��
  CUSTOMER_MNG.DELETE_CUST(
    p_id => '99999999'
  );
END;
/

--------------------------------------------------------------------------------
-- LTC_INCREASE_CREDIT_LIMIT �׽�Ʈ (����Ͻ� ����)
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
