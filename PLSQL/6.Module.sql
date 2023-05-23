CREATE OR REPLACE FUNCTION CALC_BONUS(P_SALARY IN NUMBER,P_DEPTNO IN NUMBER)
RETURN NUMBER

IS -- AS �� ����. (�����)
	V_BONUS_RATE NUMBER := 0; -- ����, �Ǽ� Ÿ�� (length�� ����.)
	V_BONUS NUMBER(7,2) := 0; -- �Ǽ� Ÿ�� (�� �ڸ���, �Ҽ��� ���� �ڸ���)

BEGIN
-- Business Logic (�μ��� ���ʽ� ���� ���� ����)
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

-- 1. ����� ������ �����ְ�, ����� ����� ������ Ÿ��, ����� ������ �����ش�.
desc calc_bonus;

-- 2. ������ �Լ� ��ȸ�غ���
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