set serveroutput on;
-- ���ν��� ����
CREATE OR REPLACE PROCEDURE INSERT_BONUS_BULK_BINDING AS

    -- Ŀ�� ����
    CURSOR CUSTOMER_CURSOR IS
        SELECT MGR_EMPNO FROM CUSTOMER;
    
    -- ��ũ ���� �� ���̺�
    TYPE TABLE_BULK_ IS TABLE OF NUMBER;
    
    -- MAP ����
    ---- TYPE �̸� IS TABLE OF �� ������ Ÿ��
    ---- INDEX BY Ű ������ Ÿ��
    TYPE CUSTOMER_MAP_ IS TABLE OF NUMBER
    INDEX BY BINARY_INTEGER;
    
    -- ���� ����
    TABLE_BULK TABLE_BULK_; -- ��ũ �� ������ ���̺� �÷��� ����
    CUSTOMER_MAP CUSTOMER_MAP_; -- ������ ���� �� �� ������ MAP
    COSTOMER_RECORD CUSTOMER_CURSOR%ROWTYPE; -- Ŀ���� ���� �� ���� ����
    BULK_SIZE CONSTANT NUMBER := 10000;
    COMM NUMBER;
    
BEGIN
    -- Ŀ�� ����
    OPEN CUSTOMER_CURSOR;
    
    LOOP
        -- CUSTOMER Ŀ������ BULK_SIZE ��ŭ ������
        FETCH CUSTOMER_CURSOR BULK COLLECT INTO TABLE_BULK LIMIT BULK_SIZE;
        
        -- �����ð� ������ ����
        EXIT WHEN CUSTOMER_CURSOR%NOTFOUND;
        
        -- ������ BULK ��ŭ �ݺ� -> CUSTOMER_MAP �ʱ�ȭ �� �� �� ����
        FOR i IN 1 .. TABLE_BULK.COUNT LOOP
            IF NOT CUSTOMER_MAP.EXISTS(TABLE_BULK(i)) THEN
                CUSTOMER_MAP(TABLE_BULK(i)) := 1;
            ELSE
                CUSTOMER_MAP(TABLE_BULK(i)) := CUSTOMER_MAP(TABLE_BULK(i)) + 1;
            END IF;
        END LOOP;
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

exec INSERT_BONUS_BULK_BINDING;

SELECT * FROM CUSTOMER;
SELECT * FROM EMP;
select * from bonus;
truncate table bonus;