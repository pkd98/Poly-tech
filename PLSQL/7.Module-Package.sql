-- Module - Package
desc dbms_output; -- desc �ؼ� ��µǴ� ���� ��Ű�� ��

-- �ǽ� 1 : ��Ű�� Header (��)�� �����ϰ�, ������ Session �� ���� ������ ���
CREATE OR REPLACE PACKAGE P_GLOBAL_VAR
AS
	-- begin�� ������. (����θ� ����)
	-- HEADER ���� �����ϴ� ��� PUBLIC ���������� [PUBLIC|PRIVATE|PROTECTED]
	LAST_CHANGE_DATE DATE;
	MAX_VALUE NUMBER(4);
END;
/

-- Procedure/Function(O) , variable(X)
DESC P_GLOBAL_VAR;
SET SERVEROUTPUT ON;

-- ù��° BLOCK���� ������ �ʱ�ȭ
BEGIN 
	P_GLOBAL_VAR.MAX_VALUE := 3000; -- notation: package_name.variable
	P_GLOBAL_VAR.LAST_CHANGE_DATE := SYSDATE;
	DBMS_OUTPUT.PUT_LINE('BLOCK1 P_GLOBAL_VAR.MAX_VALUE = '||P_GLOBAL_VAR.MAX_VALUE);
END;
/

-- ���� �ٸ� �������� BLOCK���� DATA ����
BEGIN 
	P_GLOBAL_VAR.MAX_VALUE := P_GLOBAL_VAR.MAX_VALUE + 3000;
	DBMS_OUTPUT.PUT_LINE('BLOCK2 P_GLOBAL_VAR.MAX_VALUE = '||P_GLOBAL_VAR.MAX_VALUE);
	DBMS_OUTPUT.PUT_LINE('BLOCK2 P_GLOBAL_VARS.LAST_CHANGE_DATE = '||
	TO_CHAR(P_GLOBAL_VAR.LAST_CHANGE_DATE,'YYYY-MM-DD'));
END;
/

-- �ǽ� 2 : Header ����, Body ����
-- Header ���� ���� (����� ������ ������ Public)
CREATE OR REPLACE PACKAGE P_EMPLOYEE -- Package Header ����
AS
-- Bigin ���� : ����θ� ����
-- PUBLIC PROCEDURE/FUNCTION/VARIABLE ��(=SPECIFICATION)
	PROCEDURE DELETE_EMP(P_EMPNO EMP.EMPNO%TYPE); -- ��� ���
	PROCEDURE INSERT_EMP(P_EMPNO NUMBER,P_ENAME VARCHAR2, -- ��� �Ի� ���
		P_JOB VARCHAR2,P_SAL NUMBER,P_DEPTNO NUMBER);
	FUNCTION SEARCH_MNG(P_EMPNO EMP.EMPNO%TYPE) RETURN VARCHAR2; -- ����� Manager �̸� �˻� �Լ�
	GV_ROWS NUMBER(6); -- PUBLIC ����
END P_EMPLOYEE;
/

desc p_employee
-- ������ ������ ��밡��
exec p_employee.gv_rows := 999;
-- ��� 999
exec dbms_output.put_line(p_employee.gv_rows);


-- Body ���� ���� (���� ������ ó�� Logic�� �����Ѵ�.)
-- Body�� ���ǵ� ������ Private,
CREATE OR REPLACE PACKAGE BODY P_EMPLOYEE
AS
	V_ENAME EMP.ENAME%TYPE; -- Private ����
	V_ROWS NUMBER(6); -- Private ����
    
-- Private Function ����
	FUNCTION PRVT_FUNC(P_NUM IN NUMBER) RETURN NUMBER IS -- IS, AS �Ѵ� ����
    BEGIN
        V_ROWS := ROUND(DBMS_RANDOM.VALUE(1,20),0);
        RETURN V_ROWS- P_NUM ; -- ������ ���� ���� ~~~
    END PRVT_FUNC;

-- header�� ���ǵ� ���ν��� (public) ���� ���� ����
    PROCEDURE INSERT_EMP(P_EMPNO NUMBER,P_ENAME VARCHAR2,P_JOB VARCHAR2,P_SAL NUMBER,
        P_DEPTNO NUMBER) IS
    BEGIN
        INSERT INTO EMP(EMPNO,ENAME,JOB,SAL,DEPTNO) VALUES(P_EMPNO,P_ENAME,P_JOB,P_SAL,P_DEPTNO);
        COMMIT; -- ����ó��(?), Ʈ����� ����(?)
    END INSERT_EMP;

-- Public procedure ���� ���� ����
    PROCEDURE DELETE_EMP(P_EMPNO EMP.EMPNO%TYPE) IS 
    BEGIN
        DELETE FROM EMP WHERE EMPNO = P_EMPNO;
        -- COMMIT; -- COMMIT �� SQL�Ӽ��� ���� ���� ?? : commit�� ���⿡ ������ Ŀ�� �Ӽ��� ��� �Ұ����ϴ�.
                --Implicit cursor attribute(Ŀ�� �Ӽ���), public���� ����
                -- %ROWCONT : ���� ����� ��ɾ�(DELETE)�� ���� ������� ROW ����
        GV_ROWS := GV_ROWS + SQL%ROWCOUNT; 
        COMMIT;
        V_ROWS := PRVT_FUNC(GV_ROWS); -- Private function ���� (��Ű�� ���ο����� ȣ�� ����)
    
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        WRITE_LOG('P_EMPLOYEE.DELETE',SQLERRM,'VALUES : [EMPNO]=>'||P_EMPNO);
    END DELETE_EMP;
    
-- Public Function ���� ���� ����
    FUNCTION SEARCH_MNG(P_EMPNO EMP.EMPNO%TYPE) RETURN VARCHAR2
    IS
        V_ENAME EMP.ENAME%TYPE;
    
    BEGIN -- ����� �Ŵ��� �̸� �˻�
        SELECT ENAME INTO V_ENAME FROM EMP -- V_ENAME�� �� ����
        -- ����ο� SQL ��������, JOIN �� ��� ����
        WHERE EMPNO = (SELECT MGR FROM EMP WHERE EMPNO = P_EMPNO); 
        RETURN V_ENAME;
    
    EXCEPTION
        -- �ܼ� ���� ���� ������. �α� ���̺� �������� �ٲ㺸��
        WHEN NO_DATA_FOUND THEN
            V_ENAME := 'NO_DATA';
            RETURN V_ENAME;
            
        WHEN OTHERS THEN
            V_ENAME := SUBSTR(SQLERRM,1,12);
            RETURN V_ENAME;

    END SEARCH_MNG;

-- ��Ű�������� ����δ� �ʱ�ȭ �۾����� �Ѵ�!!
BEGIN
-- Package������ ����ΰ� Optional
	GV_ROWS := 0; -- �ַ� �ʱ�ȭ �۾� �����ϴ� ����.
    
END P_EMPLOYEE;
/


-- Public procedure
DESC P_EMPLOYEE;

BEGIN
	P_EMPLOYEE.GV_ROWS := 100; -- Public ���� ���� ���� ���� (���� O)
	-- P_EMPLOYEE.V_ROWS := 100; -- Private ���� ���� ���� �Ұ���(���� X)
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
	V_ENAME := P_EMPLOYEE.SEARCH_MNG(1111); -- �������� �ʴ� ��� ��ȸ. NO_DATA ���ڿ��� ���ϵǾ� �� �Ҵ��.
	DBMS_OUTPUT.PUT_LINE('MANAGER NAME => '|| V_ENAME);

	V_ENAME := P_EMPLOYEE.SEARCH_MNG(7788);
	DBMS_OUTPUT.PUT_LINE('MANAGER NAME => '|| V_ENAME);

	:H_ENAME := P_EMPLOYEE.SEARCH_MNG(7369);
END;
/

PRINT H_ENAME;