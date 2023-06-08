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
  -- TYPE �̸� IS TABLE OF �� ������ Ÿ��
  -- INDEX BY Ű ������ Ÿ��
  TYPE CUSTOMER_MAP_ IS TABLE OF NUMBER
  INDEX BY BINARY_INTEGER;

  CUSTOMER_MAP CUSTOMER_MAP_; -- �ſ��ѵ� ������ ȸ�� �� ���� ���� ����
    
BEGIN
  -- CURSOR ����
  OPEN CUR_CUSTOMER;

  -- CURSOR�κ��� ������ �б�
  LOOP
    FETCH CUR_CUSTOMER INTO v_customer_id, v_credit_limit, v_enroll_dt;
    EXIT WHEN CUR_CUSTOMER%NOTFOUND;

    -- ���� ��¥�� ENROLL_DT���� ���� ��� (�� ����)
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
      
      -- map �ʱ�ȭ �� amount�� �� �� ī��Ʈ
      IF NOT CUSTOMER_MAP.EXISTS(v_amount) THEN
        CUSTOMER_MAP(v_amount) := 1;
      ELSE
        CUSTOMER_MAP(v_amount) := CUSTOMER_MAP(v_amount) + 1;
      END IF;
    END;

    -- ������ CREDIT_LIMIT�� ������Ʈ
    UPDATE CUSTOMER
    SET CREDIT_LIMIT = v_credit_limit + v_amount
    WHERE CURRENT OF CUR_CUSTOMER;

    -- �α� �ۼ�
    WRITE_CUST_PROCESS_LOG(LTC_INCREASE_CREDIT_LIMIT, 'INCREASE CREDIT_LIMIT ' || v_amount);
  END LOOP;

  -- CURSOR �ݱ�
  CLOSE CUR_CUSTOMER;
  
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    WRITE_CSS_LOG('LTC_INCREASE_CREDIT_LIMIT', SQLERRM, '');

END LTC_INCREASE_CREDIT_LIMIT;
/