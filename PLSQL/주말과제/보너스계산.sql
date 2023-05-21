-- customer table
CREATE OR REPLACE PROCEDURE insert_bonus_primitive AS 
  -- EMP ���̺��� �����͸� �������� Ŀ���� ����
  CURSOR emp_cursor IS
    SELECT EMPNO, ENAME, JOB, SAL FROM EMP;

  -- �� Ŀ���� ���� ���� ������ ���� ����
  emp_record emp_cursor%ROWTYPE;
  customer_record CUSTOMER%ROWTYPE;

  -- ���ʽ��� �� ���� ������ ���� ����
  comm NUMBER;
  customer_count NUMBER;
BEGIN
  -- EMP cursor open
  OPEN emp_cursor;

  LOOP
    -- EMP Ŀ������ �� �྿ Fetch
    FETCH emp_cursor INTO emp_record;
    -- loop ���� ���� : EMP Ŀ���� ��� ���� ó��
    EXIT WHEN emp_cursor%NOTFOUND;

    customer_count := 0;
    
    FOR customer_record IN (SELECT MGR_EMPNO FROM CUSTOMER) LOOP
      -- ���� EMP ���� ������ ���� CUSTOMER ���� ���� �������̸� �� ���� ����
      IF emp_record.EMPNO = customer_record.MGR_EMPNO THEN
        customer_count := customer_count + 1;
      END IF;
    END LOOP;

    -- ������ ������ ���� ���ʽ��� ���
    IF emp_record.JOB IN ('PRESIDENT', 'ANALYST') THEN
      comm := NULL;
    ELSIF customer_count >= 100000 THEN
      comm := 2000;
    ELSE
      comm := 1000;
    END IF;

    -- BONUS ���̺� �����͸� ����
    INSERT INTO BONUS (ENAME, JOB, SAL, COMM)
    VALUES (emp_record.ENAME, emp_record.JOB, emp_record.SAL, NVL(comm,0));
  END LOOP;

  -- Ŀ�� ����
  CLOSE emp_cursor;
  
  -- ���� ������ Ŀ��
  COMMIT;
EXCEPTION
  -- Ŀ���� �̹� �����ִ� ���
  WHEN INVALID_CURSOR THEN
    DBMS_OUTPUT.PUT_LINE('Invalid cursor');
  -- ������ �� �� �̻��� ���� ��ȯ�ϴ� ���
  WHEN TOO_MANY_ROWS THEN
    DBMS_OUTPUT.PUT_LINE('Too many rows');
  -- ������ ���� ��ȯ���� �ʴ� ���
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No data found');
  -- �� ���� ��� ���ܸ� ó���մϴ�.
  WHEN OTHERS THEN
    -- ���� �޽����� ����մϴ�.
    DBMS_OUTPUT.PUT_LINE('An error has occurred: ' || SQLERRM);
    -- Ʈ������� �ѹ��մϴ�.
    ROLLBACK;
END;
/