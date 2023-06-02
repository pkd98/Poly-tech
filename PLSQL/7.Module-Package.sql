-- Module - Package
desc dbms_output; -- desc 해서 출력되는 것이 패키지 명세

-- 실습 1 : 패키지 Header (명세)만 선언하고, 동일한 Session 별 전역 변수로 사용
CREATE OR REPLACE PACKAGE P_GLOBAL_VAR
AS
	-- begin이 생략됨. (선언부만 존재)
	-- HEADER 에서 선언하는 경우 PUBLIC 접근지정자 [PUBLIC|PRIVATE|PROTECTED]
	LAST_CHANGE_DATE DATE;
	MAX_VALUE NUMBER(4);
END;
/

-- Procedure/Function(O) , variable(X)
DESC P_GLOBAL_VAR;
SET SERVEROUTPUT ON;

-- 첫번째 BLOCK에서 변수값 초기화
BEGIN 
	P_GLOBAL_VAR.MAX_VALUE := 3000; -- notation: package_name.variable
	P_GLOBAL_VAR.LAST_CHANGE_DATE := SYSDATE;
	DBMS_OUTPUT.PUT_LINE('BLOCK1 P_GLOBAL_VAR.MAX_VALUE = '||P_GLOBAL_VAR.MAX_VALUE);
END;
/

-- 서로 다른 독립적인 BLOCK간에 DATA 공유
BEGIN 
	P_GLOBAL_VAR.MAX_VALUE := P_GLOBAL_VAR.MAX_VALUE + 3000;
	DBMS_OUTPUT.PUT_LINE('BLOCK2 P_GLOBAL_VAR.MAX_VALUE = '||P_GLOBAL_VAR.MAX_VALUE);
	DBMS_OUTPUT.PUT_LINE('BLOCK2 P_GLOBAL_VARS.LAST_CHANGE_DATE = '||
	TO_CHAR(P_GLOBAL_VAR.LAST_CHANGE_DATE,'YYYY-MM-DD'));
END;
/

-- 실습 2 : Header 정의, Body 구현
-- Header 영역 정의 (헤더에 정의한 변수는 Public)
CREATE OR REPLACE PACKAGE P_EMPLOYEE -- Package Header 생성
AS
-- Bigin 생략 : 선언부만 존재
-- PUBLIC PROCEDURE/FUNCTION/VARIABLE 명세(=SPECIFICATION)
	PROCEDURE DELETE_EMP(P_EMPNO EMP.EMPNO%TYPE); -- 사원 퇴사
	PROCEDURE INSERT_EMP(P_EMPNO NUMBER,P_ENAME VARCHAR2, -- 사원 입사 등록
		P_JOB VARCHAR2,P_SAL NUMBER,P_DEPTNO NUMBER);
	FUNCTION SEARCH_MNG(P_EMPNO EMP.EMPNO%TYPE) RETURN VARCHAR2; -- 사원의 Manager 이름 검색 함수
	GV_ROWS NUMBER(6); -- PUBLIC 변수
END P_EMPLOYEE;
/

desc p_employee
-- 보이지 않지만 사용가능
exec p_employee.gv_rows := 999;
-- 출력 999
exec dbms_output.put_line(p_employee.gv_rows);


-- Body 영역 정의 (실제 데이터 처리 Logic을 정의한다.)
-- Body에 정의된 변수는 Private,
CREATE OR REPLACE PACKAGE BODY P_EMPLOYEE
AS
	V_ENAME EMP.ENAME%TYPE; -- Private 변수
	V_ROWS NUMBER(6); -- Private 변수
    
-- Private Function 정의
	FUNCTION PRVT_FUNC(P_NUM IN NUMBER) RETURN NUMBER IS -- IS, AS 둘다 가능
    BEGIN
        V_ROWS := ROUND(DBMS_RANDOM.VALUE(1,20),0);
        RETURN V_ROWS- P_NUM ; -- 예제를 위한 예제 ~~~
    END PRVT_FUNC;

-- header에 정의된 프로시저 (public) 내부 로직 정의
    PROCEDURE INSERT_EMP(P_EMPNO NUMBER,P_ENAME VARCHAR2,P_JOB VARCHAR2,P_SAL NUMBER,
        P_DEPTNO NUMBER) IS
    BEGIN
        INSERT INTO EMP(EMPNO,ENAME,JOB,SAL,DEPTNO) VALUES(P_EMPNO,P_ENAME,P_JOB,P_SAL,P_DEPTNO);
        COMMIT; -- 예외처리(?), 트랜잭션 제어(?)
    END INSERT_EMP;

-- Public procedure 내부 로직 정의
    PROCEDURE DELETE_EMP(P_EMPNO EMP.EMPNO%TYPE) IS 
    BEGIN
        DELETE FROM EMP WHERE EMPNO = P_EMPNO;
        -- COMMIT; -- COMMIT 와 SQL속성자 참조 순서 ?? : commit이 여기에 있으면 커서 속성자 사용 불가능하다.
                --Implicit cursor attribute(커서 속성자), public변수 참조
                -- %ROWCONT : 이전 실행된 명령어(DELETE)에 의해 영향받은 ROW 개수
        GV_ROWS := GV_ROWS + SQL%ROWCOUNT; 
        COMMIT;
        V_ROWS := PRVT_FUNC(GV_ROWS); -- Private function 참조 (패키지 내부에서만 호출 가능)
    
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        WRITE_LOG('P_EMPLOYEE.DELETE',SQLERRM,'VALUES : [EMPNO]=>'||P_EMPNO);
    END DELETE_EMP;
    
-- Public Function 내부 로직 정의
    FUNCTION SEARCH_MNG(P_EMPNO EMP.EMPNO%TYPE) RETURN VARCHAR2
    IS
        V_ENAME EMP.ENAME%TYPE;
    
    BEGIN -- 사원의 매니저 이름 검색
        SELECT ENAME INTO V_ENAME FROM EMP -- V_ENAME에 값 대입
        -- 실행부에 SQL 서브쿼리, JOIN 등 사용 가능
        WHERE EMPNO = (SELECT MGR FROM EMP WHERE EMPNO = P_EMPNO); 
        RETURN V_ENAME;
    
    EXCEPTION
        -- 단순 에러 명을 리턴함. 로그 테이블에 삽입으로 바꿔보기
        WHEN NO_DATA_FOUND THEN
            V_ENAME := 'NO_DATA';
            RETURN V_ENAME;
            
        WHEN OTHERS THEN
            V_ENAME := SUBSTR(SQLERRM,1,12);
            RETURN V_ENAME;

    END SEARCH_MNG;

-- 패키지에서의 실행부는 초기화 작업만을 한다!!
BEGIN
-- Package에서는 실행부가 Optional
	GV_ROWS := 0; -- 주로 초기화 작업 수행하는 역할.
    
END P_EMPLOYEE;
/


-- Public procedure
DESC P_EMPLOYEE;

BEGIN
	P_EMPLOYEE.GV_ROWS := 100; -- Public 변수 직접 참조 가능 (접근 O)
	-- P_EMPLOYEE.V_ROWS := 100; -- Private 변수 직접 참조 불가능(접근 X)
	-- V_ROWS := ROUND(DBMS_RANDOM.VALUE(1,20),0);
END;
/

BEGIN
P_EMPLOYEE.INSERT_EMP(1111,'PACKAGE', 'CIO',9999,10);
P_EMPLOYEE.INSERT_EMP(1112,'PACKAGE2','CTO',9999,20);
P_EMPLOYEE.DELETE_EMP(1112);
DBMS_OUTPUT.PUT_LINE('DELETED ROWS => '||P_EMPLOYEE.GV_ROWS);
END;
/

SELECT * FROM EMP;


VARIABLE H_ENAME VARCHAR2(10)
DECLARE
	V_ENAME EMP.ENAME%TYPE;

BEGIN
	V_ENAME := P_EMPLOYEE.SEARCH_MNG(1111); -- 존재하지 않는 사원 조회. NO_DATA 문자열이 리턴되어 값 할당됨.
	DBMS_OUTPUT.PUT_LINE('MANAGER NAME => '|| V_ENAME);

	V_ENAME := P_EMPLOYEE.SEARCH_MNG(7788);
	DBMS_OUTPUT.PUT_LINE('MANAGER NAME => '|| V_ENAME);

	:H_ENAME := P_EMPLOYEE.SEARCH_MNG(7369);
END;
/

PRINT H_ENAME;