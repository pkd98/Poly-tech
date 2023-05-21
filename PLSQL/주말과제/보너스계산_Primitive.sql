set serveroutput on;
-- 프로시저 정의
CREATE OR REPLACE PROCEDURE insert_bonus_primitive AS

    -- 커서 선언
    CURSOR CUSTOMER_CURSOR IS
        SELECT MGR_EMPNO FROM CUSTOMER;
        
    -- MAP 정의
    ---- TYPE 이름 IS TABLE OF 값 데이터 타입
    ---- INDEX BY 키 데이터 타입
    TYPE CUSTOMER_MAP_ IS TABLE OF NUMBER
    INDEX BY BINARY_INTEGER;
    
    -- 변수 선언
    CUSTOMER_MAP CUSTOMER_MAP_; -- 직원의 전담 고객 수 저장할 MAP
    COSTOMER_MGR_EMPNO CUSTOMER.MGR_EMPNO%TYPE; -- 커서의 현재 행 저장 변수
    BULK_SIZE CONSTANT NUMBER := 1000;
    COMM NUMBER;
    
BEGIN
    -- 커서 열기
    OPEN CUSTOMER_CURSOR;
    
    LOOP
        -- CUSTOMER 커서에서 한 행씩 FETCH
        FETCH CUSTOMER_CURSOR INTO COSTOMER_MGR_EMPNO;
        
        -- 가져올게 없으면 종료
        EXIT WHEN CUSTOMER_CURSOR%NOTFOUND;
        
        -- 가져온 BULK 만큼 반복 -> CUSTOMER_MAP 초기화 및 고객 수 세기
        IF NOT CUSTOMER_MAP.EXISTS(COSTOMER_MGR_EMPNO) THEN
            CUSTOMER_MAP(COSTOMER_MGR_EMPNO) := 1;
        ELSE
            CUSTOMER_MAP(COSTOMER_MGR_EMPNO) := CUSTOMER_MAP(COSTOMER_MGR_EMPNO) + 1;
        END IF;
    END LOOP;
        
    -- 커서 종료
    CLOSE CUSTOMER_CURSOR;

    -- EMP 테이블에 대한 암시적 CURSOR의 FETCH
    FOR EMP_RECORD IN (SELECT EMPNO, ENAME, JOB, SAL FROM EMP) LOOP
        -- 조건 처리
        IF NOT CUSTOMER_MAP.EXISTS(EMP_RECORD.EMPNO) OR EMP_RECORD.JOB IN ('PRESIDENT', 'ANALYST') THEN
            COMM := 0;
        ELSIF CUSTOMER_MAP(EMP_RECORD.EMPNO) >= 100000 THEN
            COMM := 2000;
        ELSE
            COMM := 1000;
        END IF;
        
        -- 해당 RECORD에 대해 데이터 삽입
        INSERT INTO BONUS (ENAME, JOB, SAL, COMM)
        VALUES (EMP_RECORD.ENAME, EMP_RECORD.JOB, EMP_RECORD.SAL, NVL(COMM, 0));
    END LOOP;
    
    -- TRANSACTION 종료
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