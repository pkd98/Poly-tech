set serveroutput on;
-- 프로시저 정의
CREATE OR REPLACE PROCEDURE INSERT_BONUS_BULK_BINDING AS

    -- 커서 선언
    CURSOR CUSTOMER_CURSOR IS
        SELECT MGR_EMPNO FROM CUSTOMER;
    
    -- 벌크 저장 할 테이블
    TYPE TABLE_BULK_ IS TABLE OF NUMBER;
    
    -- MAP 정의
    ---- TYPE 이름 IS TABLE OF 값 데이터 타입
    ---- INDEX BY 키 데이터 타입
    TYPE CUSTOMER_MAP_ IS TABLE OF NUMBER
    INDEX BY BINARY_INTEGER;
    
    -- 변수 선언
    TABLE_BULK TABLE_BULK_; -- 벌크 값 저장할 테이블 컬렉션 변수
    CUSTOMER_MAP CUSTOMER_MAP_; -- 직원의 전담 고객 수 저장할 MAP
    COSTOMER_RECORD CUSTOMER_CURSOR%ROWTYPE; -- 커서의 현재 행 저장 변수
    BULK_SIZE CONSTANT NUMBER := 10000;
    COMM NUMBER;
    
BEGIN
    -- 커서 열기
    OPEN CUSTOMER_CURSOR;
    
    LOOP
        -- CUSTOMER 커서에서 BULK_SIZE 만큼 가져옴
        FETCH CUSTOMER_CURSOR BULK COLLECT INTO TABLE_BULK LIMIT BULK_SIZE;
        
        -- 가져올게 없으면 종료
        EXIT WHEN CUSTOMER_CURSOR%NOTFOUND;
        
        -- 가져온 BULK 만큼 반복 -> CUSTOMER_MAP 초기화 및 고객 수 세기
        FOR i IN 1 .. TABLE_BULK.COUNT LOOP
            IF NOT CUSTOMER_MAP.EXISTS(TABLE_BULK(i)) THEN
                CUSTOMER_MAP(TABLE_BULK(i)) := 1;
            ELSE
                CUSTOMER_MAP(TABLE_BULK(i)) := CUSTOMER_MAP(TABLE_BULK(i)) + 1;
            END IF;
        END LOOP;
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

exec INSERT_BONUS_BULK_BINDING;

SELECT * FROM CUSTOMER;
SELECT * FROM EMP;
select * from bonus;
truncate table bonus;