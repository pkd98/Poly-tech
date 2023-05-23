CREATE OR REPLACE FUNCTION CALC_BONUS(P_SALARY IN NUMBER,P_DEPTNO IN NUMBER)
RETURN NUMBER

IS -- AS 도 가능. (선언부)
	V_BONUS_RATE NUMBER := 0; -- 정수, 실수 타입 (length가 없다.)
	V_BONUS NUMBER(7,2) := 0; -- 실수 타입 (총 자리수, 소수점 이하 자리수)

BEGIN
-- Business Logic (부서별 보너스 비율 차등 지급)
	IF P_DEPTNO = 10 THEN
		V_BONUS_RATE := 0.1;
	ELSIF P_DEPTNO = 20 THEN
		V_BONUS_RATE := 0.2;
	ELSIF P_DEPTNO = 30 THEN
		V_BONUS_RATE := 0.3;
	ELSE
		V_BONUS_RATE := 0.05;
	END IF;
	V_BONUS := ROUND(NVL(P_SALARY,0) * V_BONUS_RATE,2); -- V_BONUS_RATE
	RETURN V_BONUS;
END CALC_BONUS;
/

-- 1. 모듈의 종류를 보여주고, 모듈의 출력할 데이터 타입, 입출력 구조를 보여준다.
desc calc_bonus;

-- 2. 생성된 함수 조회해보기
select object_name, object_type, status, created from user_objects
where object_name = 'CALC_BONUS';
-- 2-1
SELECT * FROM USER_OBJECTS where object_name = 'CALC_BONUS';

-- 3.
SELECT NAME,LINE,TEXT
FROM USER_SOURCE
WHERE NAME = 'CALC_BONUS';

-- 4.
SELECT EMPNO,ENAME,SAL,DEPTNO,CALC_BONUS(SAL,DEPTNO) FROM EMP;