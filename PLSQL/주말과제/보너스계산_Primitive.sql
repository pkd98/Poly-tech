set serveroutput on;
-- ���ν��� ����
CREATE OR REPLACE PROCEDURE insert_bonus_primitive AS

    -- Ŀ�� ����
    CURSOR CUSTOMER_CURSOR IS
        SELECT MGR_EMPNO FROM CUSTOMER;
        
    -- MAP ����
    ---- TYPE �̸� IS TABLE OF �� ������ Ÿ��
    ---- INDEX BY Ű ������ Ÿ��
    TYPE CUSTOMER_MAP_ IS TABLE OF NUMBER
    INDEX BY BINARY_INTEGER;
    
    -- ���� ����
    CUSTOMER_MAP CUSTOMER_MAP_; -- ������ ���� �� �� ������ MAP
    COSTOMER_MGR_EMPNO CUSTOMER.MGR_EMPNO%TYPE; -- Ŀ���� ���� �� ���� ����
    BULK_SIZE CONSTANT NUMBER := 1000;
    COMM NUMBER;
    
BEGIN
    -- Ŀ�� ����
    OPEN CUSTOMER_CURSOR;
    
    LOOP
        -- CUSTOMER Ŀ������ �� �྿ FETCH
        FETCH CUSTOMER_CURSOR INTO COSTOMER_MGR_EMPNO;
        
        -- �����ð� ������ ����
        EXIT WHEN CUSTOMER_CURSOR%NOTFOUND;
        
        -- ������ BULK ��ŭ �ݺ� -> CUSTOMER_MAP �ʱ�ȭ �� �� �� ����
        IF NOT CUSTOMER_MAP.EXISTS(COSTOMER_MGR_EMPNO) THEN
            CUSTOMER_MAP(COSTOMER_MGR_EMPNO) := 1;
        ELSE
            CUSTOMER_MAP(COSTOMER_MGR_EMPNO) := CUSTOMER_MAP(COSTOMER_MGR_EMPNO) + 1;
        END IF;
    END LOOP;
        
    -- Ŀ�� ����
    CLOSE CUSTOMER_CURSOR;

    -- EMP ���̺� ���� �Ͻ��� CURSOR�� FETCH
    FOR EMP_RECORD IN (SELECT EMPNO, ENAME, JOB, SAL FROM EMP) LOOP
        -- ���� ó��
        IF NOT CUSTOMER_MAP.EXISTS(EMP_RECORD.EMPNO) OR EMP_RECORD.JOB IN ('PRESIDENT', 'ANALYST') THEN
            COMM := 0;
        ELSIF CUSTOMER_MAP(EMP_RECORD.EMPNO) >= 100000 THEN
            COMM := 2000;
        ELSE
            COMM := 1000;
        END IF;
        
        -- �ش� RECORD�� ���� ������ ����
        INSERT INTO BONUS (ENAME, JOB, SAL, COMM)
        VALUES (EMP_RECORD.ENAME, EMP_RECORD.JOB, EMP_RECORD.SAL, NVL(COMM, 0));
    END LOOP;
    
    -- TRANSACTION ����
    COMMIT;
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error has occurred: ' || SQLERRM);
    ROLLBACK;
END;
/

exec insert_bonus_primitive;

SELECT * FROM CUSTOMER;
SELECT * FROM EMP;
select * from bonus;
truncate table bonus;