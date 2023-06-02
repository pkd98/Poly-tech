-- Module - Trigger
-- 예시1
create or replace trigger t_change_sal
before update of sal on emp
for each row -- 영향 받은 행 개수 만큼 트리거가 실행된다.
begin
	if ( :new.sal > 9000 ) then -- 9000 이상의 sal이 입력되었을 때, 9000으로 지정.
		:new.sal := 9000;
	end if;
end;
/

-- 두개의 레코드 9000이상 업데이트
-- UPDATE문 실행 전에 (before) 트리거 실행된다.
UPDATE EMP SET SAL = 9500 WHERE EMPNO IN (7839,7844);
SELECT EMPNO,SAL, JOB FROM EMP WHERE EMPNO IN (7839,7844);

ROLLBACK;
SELECT EMPNO,SAL,JOB FROM EMP WHERE EMPNO IN (7839,7844);


-- 예시2 : 회사 대표만 9000 이상의 급여 지급
create or replace trigger t_change_sal
before update of sal on emp
for each row
begin
	if ( :new.sal > 9000 AND :old.job != 'PRESIDENT' ) then
		:new.sal := 9000;
		-- write_log 내부에 insert 연산이 있음 (트랜잭션)
		write_log('UPDATE','Business rule: sal > 9000','empno:'||:old.empno||', sal from '||:old.sal||' to '||:new.sal);
	end if;
end;
/

UPDATE EMP SET SAL = 9500 WHERE EMPNO IN (7839,7844); -- 7839: PRESIDENT
SELECT EMPNO,SAL FROM EMP WHERE EMPNO IN (7839,7844);
SELECT * FROM EXCEPTION_LOG;

ROLLBACK; -- Transaction 취소의 범위는 Trigger도 포함되어 Rollback된다.
SELECT * FROM EXCEPTION_LOG; -- 해결방법: Autonomous transaction

-- 업무 규칙에 따른 트리거 생성
/*
우리회사는 신규 입사자의 직군이 CLERK 이나 SALESMAN인 경우 노조에 자동으로 가입 해야 하고,
퇴직시에는 퇴직자 명단에 등록 된다.

기존 급여 시스템의 수정 불가능한 기능적 오류로 인해,
사원의 급여 항목이 종종 마이너스로 바뀌게 된다.

마이너스 금액으로 수정되는 경우 원래의 급여를 되돌려 놓아야 한다.
*/
-- 퇴사자 정보
CREATE TABLE RETIRED_EMP(
EMPNO NUMBER(4) NOT NULL, -- 사번
ENAME VARCHAR2(10), -- 이름
JOB VARCHAR2(9), -- 직군
RETIRED_DATE DATE -- 퇴사일
);

-- 노조 명단 Table
CREATE TABLE LABOR_UNION(
EMPNO NUMBER(4) NOT NULL, -- 사번
ENAME VARCHAR2(10), -- 이름
JOB VARCHAR2(9), -- 직군
ENROLL_DATE DATE -- 등록일(입사일)
);

CREATE OR REPLACE TRIGGER T_EMP_CHANGE
BEFORE INSERT OR DELETE OR UPDATE OF SAL ON EMP 
FOR EACH ROW
DECLARE -- DECLARE가 있는....
BEGIN
	-- 직군이 CLERK 과 SALSEMAN 인경우 입사시에 자동으로 노조 명단에 등록
	IF INSERTING AND :NEW.JOB IN ('CLERK','SALESMAN') THEN
		INSERT INTO LABOR_UNION(EMPNO,ENAME,JOB,ENROLL_DATE) 
			VALUES(:NEW.EMPNO,:NEW.ENAME,:NEW.JOB,SYSDATE);

	ELSIF DELETING THEN -- 퇴사시 퇴직자 명단에 등록
	BEGIN
		INSERT INTO RETIRED_EMP(EMPNO,ENAME,JOB,RETIRED_DATE)
		VALUES(:OLD.EMPNO,:OLD.ENAME,:OLD.JOB,SYSDATE);

		-- 노조에서 삭제
		DELETE FROM LABOR_UNION WHERE EMPNO = :OLD.EMPNO;

	EXCEPTION
		WHEN OTHERS THEN
			NULL; --?? Write_log 사용하도록 수정
		END;

		ELSIF UPDATING THEN
			IF :NEW.SAL < 0 THEN -- 마이너스 급여가 들어오는 경우 원래 급여로 치환
				:NEW.SAL := :OLD.SAL;
			END IF;
		END IF;
END;
/

-- PACKAGE를 사용하여 사원 데이타에 변경을 수행
BEGIN
P_EMPLOYEE.DELETE_EMP(7369);
P_EMPLOYEE.INSERT_EMP(2025,'JJANG','PRESIDENT',8888,10);
P_EMPLOYEE.INSERT_EMP(10,'K', 'SALESMAN', 5555,10);
END;
/

UPDATE EMP SET SAL = -1000 WHERE EMPNO = 7900; -- 트리거가 이전 급여로 되돌리는지
SELECT * FROM RETIRED_EMP WHERE EMPNO = 7369;
SELECT * FROM LABOR_UNION WHERE EMPNO IN (2025,10);
SELECT EMPNO,SAL FROM EMP WHERE EMPNO = 7900;

select * from user_source where name like 'T%'; -- Stored Block, 텍스트 형태의 소스 확인
select * from user_triggers;
select * from user_objects where object_name like 'T%';

