-- 1. �Ͻ��� Ŀ�� �Ӽ� �ǽ�
SET SERVEROUTPUT ON
BEGIN
	-- ù��° DELETE
	DELETE FROM EMP WHERE SAL > 2000;
	DBMS_OUTPUT.PUT_LINE('[1-DELETE]'||TO_CHAR(SQL%ROWCOUNT)||'ROWS IS DELETED'); -- SQL%ROWCOUNT�� 3�� ����
	IF SQL%FOUND THEN
		DBMS_OUTPUT.PUT_LINE('SQL%FOUND = TRUE ');
	ELSE
		DBMS_OUTPUT.PUT_LINE('SQL%NOTFOUND = FALSE ');
	END IF;
	DBMS_OUTPUT.PUT_LINE('-------------------------------------------------');
	-- �ι�° DELETE : ������ DELETE �� 2��° �����ϹǷ� ������ ����Ÿ�� ����
	DELETE FROM EMP WHERE SAL > 2000;
	DBMS_OUTPUT.PUT_LINE('[2-DELETE]'||TO_CHAR(SQL%ROWCOUNT)||'ROWS IS DELETED');
	IF SQL%FOUND THEN
		DBMS_OUTPUT.PUT_LINE('SQL%FOUND = TRUE');
	ELSE
		DBMS_OUTPUT.PUT_LINE('SQL%NOTFOUND = FALSE');
	END IF;
	ROLLBACK;
END;
/

-- 2. ������ Ŀ�� �Ӽ� �ǽ� ( �ָ����� Ȱ�� )
TRUNCATE TABLE BONUS; -- DDL
DECLARE
	CURSOR CUR_EMP IS -- ��� ������ �̸� : CUR_EMP
		SELECT EMPNO,JOB,SAL,COMM FROM EMP WHERE DEPTNO = 10;
	V_ENAME VARCHAR2(10);
	V_JOB VARCHAR2(9);
	V_SAL NUMBER(7,2);
	V_COMM NUMBER(7,2);
BEGIN
	OPEN CUR_EMP; -- Ŀ�� ����
	LOOP
		FETCH CUR_EMP INTO V_ENAME, V_JOB, V_SAL, V_COMM ;
		EXIT WHEN CUR_EMP%NOTFOUND; -- Ŀ������ ���̻� fetch�� �� ������, EXIT
		-- Business Logic
		INSERT INTO BONUS(ENAME,JOB,SAL,COMM) VALUES(V_ENAME,V_JOB,V_SAL,V_COMM);
	END LOOP;
    -- ������ Ŀ�������� ROWCOUNT�� ������ ��
    DBMS_OUTPUT.PUT_LINE('TOTAL '||TO_CHAR(CUR_EMP%ROWCOUNT)||' rows processed');
	CLOSE CUR_EMP; -- �ڿ� �ݳ�
	COMMIT;
	END;
/

SELECT * FROM BONUS;

-- 3. (Column) ���� ����
TRUNCATE TABLE BONUS;
SET SERVEROUTPUT ON
DECLARE
	CURSOR CUR_EMP IS
		SELECT ENAME,JOB,SAL,COMM FROM EMP WHERE DEPTNO = 10;
	V_ENAME EMP.ENAME%TYPE;
	V_JOB EMP.JOB%TYPE;
	V_SAL EMP.SAL%TYPE;
	V_COMM EMP.COMM%TYPE;
BEGIN
	OPEN CUR_EMP;
	LOOP
		FETCH CUR_EMP INTO V_ENAME,V_JOB,V_SAL,V_COMM ;
		EXIT WHEN CUR_EMP%NOTFOUND;
		INSERT INTO BONUS(ENAME,JOB,SAL,COMM) VALUES(V_ENAME,V_JOB,V_SAL,V_COMM);
	END LOOP;
		DBMS_OUTPUT.PUT_LINE('TOTAL '||TO_CHAR(CUR_EMP%ROWCOUNT)||' rows processed');
	CLOSE CUR_EMP;
	COMMIT;
END;
/

SELECT * FROM BONUS;

-- 4. (Row) ���� ����
TRUNCATE TABLE BONUS;
SET SERVEROUTPUT ON
DECLARE
	CURSOR CUR_EMP IS
		SELECT ENAME,JOB,SAL,COMM FROM EMP WHERE DEPTNO = 10;
-- %ROWTYPE�̿� ������ Cursor�� �����ؼ� ������ ����.
-- �ڵ����� 4���� �ʵ带 ������ ���ڵ带 ������
	R_CUR_EMP CUR_EMP%ROWTYPE; 
BEGIN
	OPEN CUR_EMP;
	LOOP
		FETCH CUR_EMP INTO R_CUR_EMP;
		EXIT WHEN CUR_EMP%NOTFOUND;
		INSERT INTO BONUS(ENAME,JOB,SAL,COMM)
			VALUES(R_CUR_EMP.ENAME,R_CUR_EMP.JOB,R_CUR_EMP.SAL,R_CUR_EMP.COMM);
	END LOOP;
		DBMS_OUTPUT.PUT_LINE('TOTAL '||TO_CHAR(CUR_EMP%ROWCOUNT)||' rows processed');
	CLOSE CUR_EMP;
	COMMIT;
END;
/

SELECT * FROM BONUS;

-- 5. Cursor for loop
TRUNCATE TABLE BONUS;
SET SERVEROUTPUT ON;
DECLARE
    CURSOR CUR_EMP IS
        SELECT ENAME, JOB, SAL, COMM FROM EMP WHERE DEPTNO = 10;
BEGIN
    FOR R_CUR_EMP IN CUR_EMP
    LOOP
        INSERT INTO BONUS(ENAME, JOB, SAL, COMM)
            VALUES(R_CUR_EMP.ENAME, R_CUR_EMP.JOB, R_CUR_EMP.SAL, R_CUR_EMP.COMM);
    END LOOP;
    -- DBMS_OUTPUT.PUT_LINE('TOTAL '||TO_CHAR(CUR_EMP%ROWCOUNT)||' rows processed��); -- Error?
    COMMIT;
END;
/
SELECT * FROM BONUS;

-- 6. Cursor for loop2
TRUNCATE TABLE BONUS;
SET SERVEROUTPUT ON

BEGIN
	FOR R_CUR_EMP IN (SELECT ENAME,JOB,SAL,COMM FROM EMP WHERE DEPTNO = 10)
	LOOP
		INSERT INTO BONUS(ENAME,JOB,SAL,COMM)
		VALUES(R_CUR_EMP.ENAME,R_CUR_EMP.JOB,R_CUR_EMP.SAL,R_CUR_EMP.COMM);
	END LOOP;
	COMMIT;
END;
/
SELECT * FROM BONUS;

-- 7. Cursor Parameter
TRUNCATE TABLE BONUS;
DECLARE
	CURSOR CUR_EMP(P_DEPTNO IN NUMBER) IS -- Parameter ������. data type ����
		SELECT ENAME,JOB,SAL,COMM FROM EMP WHERE DEPTNO = P_DEPTNO;
	V_DEPTNO DEPT.DEPTNO%TYPE;
BEGIN
	V_DEPTNO := 20; -- ���� �� ����
	FOR R_CUR_EMP IN CUR_EMP(V_DEPTNO) -- Ŀ���� ���� �� ����
	-- FOR R_CUR_EMP IN CUR_EMP(20) -- ���� ������ �ƴ�, ����� ���� �����Ѱ�?
		LOOP
			INSERT INTO BONUS(ENAME,JOB,SAL,COMM)
			VALUES(R_CUR_EMP.ENAME,R_CUR_EMP.JOB,R_CUR_EMP.SAL,R_CUR_EMP.COMM);
		END LOOP;
	COMMIT;
END;
/
SELECT * FROM BONUS;
