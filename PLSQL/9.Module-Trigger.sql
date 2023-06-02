-- Module - Trigger
-- ����1
create or replace trigger t_change_sal
before update of sal on emp
for each row -- ���� ���� �� ���� ��ŭ Ʈ���Ű� ����ȴ�.
begin
	if ( :new.sal > 9000 ) then -- 9000 �̻��� sal�� �ԷµǾ��� ��, 9000���� ����.
		:new.sal := 9000;
	end if;
end;
/

-- �ΰ��� ���ڵ� 9000�̻� ������Ʈ
-- UPDATE�� ���� ���� (before) Ʈ���� ����ȴ�.
UPDATE EMP SET SAL = 9500 WHERE EMPNO IN (7839,7844);
SELECT EMPNO,SAL, JOB FROM EMP WHERE EMPNO IN (7839,7844);

ROLLBACK;
SELECT EMPNO,SAL,JOB FROM EMP WHERE EMPNO IN (7839,7844);


-- ����2 : ȸ�� ��ǥ�� 9000 �̻��� �޿� ����
create or replace trigger t_change_sal
before update of sal on emp
for each row
begin
	if ( :new.sal > 9000 AND :old.job != 'PRESIDENT' ) then
		:new.sal := 9000;
		-- write_log ���ο� insert ������ ���� (Ʈ�����)
		write_log('UPDATE','Business rule: sal > 9000','empno:'||:old.empno||', sal from '||:old.sal||' to '||:new.sal);
	end if;
end;
/

UPDATE EMP SET SAL = 9500 WHERE EMPNO IN (7839,7844); -- 7839: PRESIDENT
SELECT EMPNO,SAL FROM EMP WHERE EMPNO IN (7839,7844);
SELECT * FROM EXCEPTION_LOG;

ROLLBACK; -- Transaction ����� ������ Trigger�� ���ԵǾ� Rollback�ȴ�.
SELECT * FROM EXCEPTION_LOG; -- �ذ���: Autonomous transaction

-- ���� ��Ģ�� ���� Ʈ���� ����
/*
�츮ȸ��� �ű� �Ի����� ������ CLERK �̳� SALESMAN�� ��� ������ �ڵ����� ���� �ؾ� �ϰ�,
�����ÿ��� ������ ��ܿ� ��� �ȴ�.

���� �޿� �ý����� ���� �Ұ����� ����� ������ ����,
����� �޿� �׸��� ���� ���̳ʽ��� �ٲ�� �ȴ�.

���̳ʽ� �ݾ����� �����Ǵ� ��� ������ �޿��� �ǵ��� ���ƾ� �Ѵ�.
*/
-- ����� ����
CREATE TABLE RETIRED_EMP(
EMPNO NUMBER(4) NOT NULL, -- ���
ENAME VARCHAR2(10), -- �̸�
JOB VARCHAR2(9), -- ����
RETIRED_DATE DATE -- �����
);

-- ���� ��� Table
CREATE TABLE LABOR_UNION(
EMPNO NUMBER(4) NOT NULL, -- ���
ENAME VARCHAR2(10), -- �̸�
JOB VARCHAR2(9), -- ����
ENROLL_DATE DATE -- �����(�Ի���)
);

CREATE OR REPLACE TRIGGER T_EMP_CHANGE
BEFORE INSERT OR DELETE OR UPDATE OF SAL ON EMP 
FOR EACH ROW
DECLARE -- DECLARE�� �ִ�....
BEGIN
	-- ������ CLERK �� SALSEMAN �ΰ�� �Ի�ÿ� �ڵ����� ���� ��ܿ� ���
	IF INSERTING AND :NEW.JOB IN ('CLERK','SALESMAN') THEN
		INSERT INTO LABOR_UNION(EMPNO,ENAME,JOB,ENROLL_DATE) 
			VALUES(:NEW.EMPNO,:NEW.ENAME,:NEW.JOB,SYSDATE);

	ELSIF DELETING THEN -- ���� ������ ��ܿ� ���
	BEGIN
		INSERT INTO RETIRED_EMP(EMPNO,ENAME,JOB,RETIRED_DATE)
		VALUES(:OLD.EMPNO,:OLD.ENAME,:OLD.JOB,SYSDATE);

		-- �������� ����
		DELETE FROM LABOR_UNION WHERE EMPNO = :OLD.EMPNO;

	EXCEPTION
		WHEN OTHERS THEN
			NULL; --?? Write_log ����ϵ��� ����
		END;

		ELSIF UPDATING THEN
			IF :NEW.SAL < 0 THEN -- ���̳ʽ� �޿��� ������ ��� ���� �޿��� ġȯ
				:NEW.SAL := :OLD.SAL;
			END IF;
		END IF;
END;
/

-- PACKAGE�� ����Ͽ� ��� ����Ÿ�� ������ ����
BEGIN
P_EMPLOYEE.DELETE_EMP(7369);
P_EMPLOYEE.INSERT_EMP(2025,'JJANG','PRESIDENT',8888,10);
P_EMPLOYEE.INSERT_EMP(10,'K', 'SALESMAN', 5555,10);
END;
/

UPDATE EMP SET SAL = -1000 WHERE EMPNO = 7900; -- Ʈ���Ű� ���� �޿��� �ǵ�������
SELECT * FROM RETIRED_EMP WHERE EMPNO = 7369;
SELECT * FROM LABOR_UNION WHERE EMPNO IN (2025,10);
SELECT EMPNO,SAL FROM EMP WHERE EMPNO = 7900;

select * from user_source where name like 'T%'; -- Stored Block, �ؽ�Ʈ ������ �ҽ� Ȯ��
select * from user_triggers;
select * from user_objects where object_name like 'T%';

