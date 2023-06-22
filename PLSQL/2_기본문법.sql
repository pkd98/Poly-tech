-- 1
SET SERVEROUTPUT ON
DECLARE
    V_XX NUMBER(4) := 10;
    V_YY NUMBER(4);
    V_TAX_RATE CONSTANT NUMBER(5, 3) := 0.054;
    V_SAL NUMBER(4) NOT NULL := 9999;
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_XX => ' || V_XX);
    DBMS_OUTPUT.PUT_LINE('V_YY => ' || V_YY);
    DBMS_OUTPUT.PUT_LINE('V_YY => ' || NVL(V_YY, -99));
    DBMS_OUTPUT.PUT_LINE('V_ZZ + V_YY => ' || TO_CHAR(V_XX + V_YY));
    DBMS_OUTPUT.PUT_LINE('V_TAX_RATE => ' || V_TAX_RATE);
    
    -- V_TAX_RATE := 0.055;
    -- V_SAL := V_XX + V_YY;   
END;
/

-- 2
DECLARE
	V_XX NUMBER(4) := 10; 
	V_YY BOOLEAN;  -- SQL���� BOOLEAN�� T, F, NULL ���� ������.
	V_TAX_RATE CONSTANT NUMBER(5,3) := 0.054;
	V_SAL NUMBER(4) := 9999; 
BEGIN
    IF V_YY IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('SQL operator');
    END IF;
	V_YY := ((V_XX - 1) ** 3 > 500) AND (V_SAL > 7000); -- ��� ������ & �� ������ & ���� ������
	DBMS_OUTPUT.PUT_LINE(case when V_YY then 'TRUE' else 'FALSE' end); -- case & decode
	IF (V_SAL * V_TAX_RATE) BETWEEN 500 AND 1000 THEN -- SQL ������
		DBMS_OUTPUT.PUT_LINE('High pay'); 
	END IF; 
END;
/

-- 3
DECLARE
	V_EMPNO NUMBER(4) := 8888;                -- �������� �� �ʱ�ȭ
	V_DEPTNO NUMBER(2);  
	V_ENAME VARCHAR2(10) := 'XMAN';           -- �������� �� �ʱ�ȭ
	V_JOB VARCHAR2(9);
	V_SAL NUMBER(7,2); 
BEGIN 
	V_DEPTNO := 20;                           -- ������ �� ����
	IF V_JOB IS NULL THEN
		V_JOB := '����';
	END IF;
	IF V_JOB = '����' THEN                    -- TRUE, FALSE, NULL
		V_SAL := 2000;
	ELSIF V_JOB IN ('MANAGER','ANALYST') THEN -- ELSEIF(X)
		V_SAL := 3500;
	ELSE
		V_SAL := 2500;
	END IF;
	INSERT INTO EMP(DEPTNO,EMPNO,ENAME,SAL,JOB)  -- TRANSACTION START
		VALUES(V_DEPTNO,V_EMPNO,V_ENAME,V_SAL,V_JOB);
	COMMIT; -- TRANSACTION STOP
END;
/

SELECT * FROM EMP WHERE EMPNO = 8888;

-- 3-1
desc dbms_output; -- Ŭ���� ���� ���Ե� �޼��� ���� ǥ��ȴ�. public method��.

-- �ݺ���
-- 1. �⺻ LOOP
SET SERVEROUTPUT ON
DECLARE
    LOOP_INDEX NUMBER(4) := 1;
    MAX_LOOP_INDEX NUMBER(4) := 30;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE('LOOP COUNT => ' || TO_CHAR(LOOP_INDEX));
        LOOP_INDEX := LOOP_INDEX + 1;
        EXIT WHEN MAX_LOOP_INDEX < LOOP_INDEX;
    END LOOP;
END;
/

-- 2. FOR LOOP
SET SERVEROUTPUT ON
DECLARE
    -- LOOP_INDEX NUMBER(4) := 100;
    MAX_LOOP_INDEX NUMBER(4) := 30;
BEGIN
    FOR LOOP_INDEX IN 1.. MAX_LOOP_INDEX
    -- FOR LOOP_INDEX IN 30..1
	-- FOR LOOP_INDEX IN REVERSE 1..30
    -- FOR LOOP_INDEX IN REVERSE 30..1
    LOOP
        DBMS_OUTPUT.PUT_LINE('COUNT :' || TO_CHAR(LOOP_INDEX));
    END LOOP;
END;
/

-- 3. WHILE LOOP
DECLARE 
	-- V_INDEX NUMBER(3) := 0; -- loop Ƚ�� üũ
	-- V_INDEX NUMBER(3); -- NULL
	V_INDEX NUMBER(3) := 30; -- loop Ƚ�� üũ
BEGIN
	WHILE(V_INDEX >= 0 )
	LOOP
		DBMS_OUTPUT.PUT_LINE(' While loop ['||TO_CHAR(V_INDEX)||']');
		V_INDEX := V_INDEX - 1;
	END LOOP;
END;
/
