-- 1. Composite data type
SET SERVEROUTPUT ON
DECLARE
TYPE T_ADDRESS IS RECORD( -- 4개의 필드를 가진 Record type 정의
	ADDR1 VARCHAR2(60), -- 주소1
	ADDR2 VARCHAR2(60), -- 주소2
	ZIP VARCHAR2(7), -- 우편번호
	PHONE VARCHAR2(14) -- 전화번호
);

TYPE T_EMP_RECORD IS RECORD ( -- 5개의 필드를 가진 Record type 정의
	EMPNO NUMBER(4) , -- 사번
	ENAME VARCHAR2(10), -- 이름
	JOB VARCHAR2(9), -- 직업
	ADDRESS T_ADDRESS,
-- 주소 ??? Field에 Record type 정의가 가능한지.
-- 앞서 정의한 RECORD Type을 새로운 필드 변수로 정의할 수 있다.
	HIREDATE DATE); -- 입사일

	REC_EMP T_EMP_RECORD; -- Record 변수 선언

BEGIN
-- Record의 field에 값을 대입(저장)
REC_EMP.EMPNO := 1234;
REC_EMP.ENAME := 'XMAN';
REC_EMP.JOB := 'DBA';
REC_EMP.ADDRESS.ADDR1 := '강남구 역삼동'; -- 레코드 안에 레코드 중첩적으로 접근
REC_EMP.ADDRESS.ZIP := '150-036';
REC_EMP.HIREDATE := SYSDATE - 365;

-- -- Record의 field값 조회
DBMS_OUTPUT.PUT_LINE('**************************************************************');
DBMS_OUTPUT.PUT_LINE('사번 :' || REC_EMP.EMPNO);
DBMS_OUTPUT.PUT_LINE('이름 :' || REC_EMP.ENAME);
DBMS_OUTPUT.PUT_LINE('직업 :' || REC_EMP.JOB);
DBMS_OUTPUT.PUT_LINE('주소 :' || REC_EMP.ADDRESS.ADDR1);
DBMS_OUTPUT.PUT_LINE('주소 :' || REC_EMP.ADDRESS.ZIP);
DBMS_OUTPUT.PUT_LINE('입사일 :' || TO_CHAR(REC_EMP.HIREDATE,'YYYY/MM/DD'));
DBMS_OUTPUT.PUT_LINE('**************************************************************');
END;
/

-- 2. Index by table data type 동적 배열(Dynamic Array)와 유사
SET SERVEROUTPUT ON
DECLARE
	TYPE T_EMP_LIST IS TABLE OF VARCHAR2(20) -- TABLE TYPE 정의 , Dynamic array와 유사
	INDEX BY BINARY_INTEGER; 
	TBL_EMP_LIST T_EMP_LIST; -- TABLE 변수 선언
	V_TMP VARCHAR2(20);
	V_INDEX NUMBER(10);
BEGIN
	TBL_EMP_LIST(1) := 'SCOTT'; -- TABLE에 DATA 입력한다
	TBL_EMP_LIST(1000) := 'MILLER'; -- Index 첨자의 범위 -2147483647 ~ 2147483647
	TBL_EMP_LIST(-2134) := 'ALLEN'; -- 불연속적 첨자 사용
	TBL_EMP_LIST(0) := 'XMAN';
	V_TMP := TBL_EMP_LIST(1000); -- TABLE에서 DATA조회
	-- TABLE에 있는 DATA를 조회해서 RETURN한다.
	DBMS_OUTPUT.PUT_LINE('DATA OF KEY 1000 IS '||TBL_EMP_LIST(1000));
	DBMS_OUTPUT.PUT_LINE('DATA OF KEY -2134 IS '||TBL_EMP_LIST(-2134));
	DBMS_OUTPUT.PUT_LINE('DATA OF KEY 1 IS '||TBL_EMP_LIST(1));
	-- Method 사용 ex) FIRST,LAST,NEXT,PRIOR, EXISTS, COUNT, DELETE ..
	IF NOT TBL_EMP_LIST.EXISTS(888) THEN
		DBMS_OUTPUT.PUT_LINE('DATA OF KEY 888 IS NOT EXIST ');
	END IF;
		-- LOOP를 사용하여 데이타 조회
		V_INDEX := TBL_EMP_LIST.FIRST; -- EX) PRIOR,FIRST,LAST
	LOOP
		DBMS_OUTPUT.PUT_LINE('LOOP:'||TO_CHAR(V_INDEX)||' ==>'||TBL_EMP_LIST(V_INDEX));
		V_INDEX := TBL_EMP_LIST.NEXT(V_INDEX); -- 다음번 유효한 INDEX RETURN 
		EXIT WHEN V_INDEX IS NULL;
	END LOOP;
	DBMS_OUTPUT.PUT_LINE('DATA OF KEY 999 IS '||TBL_EMP_LIST(999)); -- 존재하지 않는값을 조회(예외 발생)
	DBMS_OUTPUT.PUT_LINE('DATA OF KEY 0 IS '||TBL_EMP_LIST(0));
EXCEPTION
	WHEN NO_DATA_FOUND THEN -- 예외처리
	DBMS_OUTPUT.PUT_LINE('ERROR CODE=>'||TO_CHAR(SQLCODE));
	DBMS_OUTPUT.PUT_LINE('ERROR MSG =>'||SQLERRM);
END;
/

-- 3. %TYPE & %ROWTYPE
SET SERVEROUTPUT ON
DECLARE
	REC_EMP EMP%ROWTYPE; -- Row 참조 연산자
	V_EMPNO EMP.EMPNO%TYPE; -- Column 참조 연산자
BEGIN
	-- 1개의 Row를 SELECT 해서 Record 변수에 저장
	SELECT * INTO REC_EMP FROM EMP WHERE EMPNO = 7369;
	DBMS_OUTPUT.PUT_LINE('EMPNO =>'||REC_EMP.EMPNO);
	DBMS_OUTPUT.PUT_LINE('ENAME =>'||REC_EMP.ENAME);
	DBMS_OUTPUT.PUT_LINE('JOB =>'||REC_EMP.JOB);
	DBMS_OUTPUT.PUT_LINE('MGR =>'||REC_EMP.MGR);
	DBMS_OUTPUT.PUT_LINE('HIREDATE =>'||REC_EMP.HIREDATE);
	DBMS_OUTPUT.PUT_LINE('SAL =>'||REC_EMP.SAL);
	-- Record의 개개 Field를 독립적으로 사용
	SELECT EMPNO,ENAME INTO V_EMPNO, REC_EMP.ENAME -- V_EMPNO -> REC_EMP.EMPNO 이렇게 해도됨
	FROM EMP
	WHERE EMPNO = 7369;
	DBMS_OUTPUT.PUT_LINE('----------------------------------');
	DBMS_OUTPUT.PUT_LINE('EMPNO =>'||V_EMPNO);
	DBMS_OUTPUT.PUT_LINE('ENAME =>'||REC_EMP.ENAME);
END;
/

-- 4. NO_DATA_FOUND
SET SERVEROUTPUT ON 
DECLARE
	V_EMPNO EMP.EMPNO%TYPE;
	V_ENAME EMP.ENAME%TYPE;
	V_HIREDATE EMP.HIREDATE%TYPE;
BEGIN
	-- SELECT 되는 대상 데이타가 없는 조회
	SELECT EMPNO,ENAME,HIREDATE INTO V_EMPNO,V_ENAME,V_HIREDATE
	FROM EMP 
	WHERE EMPNO = 10000; -- 없는 데이터 조회

	DBMS_OUTPUT.PUT_LINE('selected exactly one row by '||V_EMPNO );
EXCEPTION 
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('NO DATA FOUND !!!!!');
	WHEN TOO_MANY_ROWS THEN
		DBMS_OUTPUT.PUT_LINE('TOO MANY ROWS FOUND !!!!');
END;
/

-- 5. TOO_MANY_ROWS
SET SERVEROUTPUT ON
DECLARE
	V_EMPNO EMP.EMPNO%TYPE;
	V_ENAME EMP.ENAME%TYPE;
	V_HIREDATE EMP.HIREDATE%TYPE;
BEGIN
-- INTO 이하의 변수들은 Scalar 유형의 변수 (1개의 변수는 1개의 데이터를 저장 가능함)
-- SELECT 되는 대상 데이타가 1개 이상인 조회
-- => 예외 발생
	SELECT EMPNO,ENAME,HIREDATE INTO V_EMPNO,V_ENAME,V_HIREDATE -- 여러개의 RECORD가 조회됨
	FROM EMP
	WHERE EMPNO >= 1;
	DBMS_OUTPUT.PUT_LINE('selected exactly one row by '||V_EMPNO );
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('NO DATA FOUND !!!!!');
	WHEN TOO_MANY_ROWS THEN
		DBMS_OUTPUT.PUT_LINE('TOO MANY ROWS FOUND !!!!');
END;
/


