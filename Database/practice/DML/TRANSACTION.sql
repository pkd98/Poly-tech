-- TRANSACTION--
-- [TRANSACTION 시작과 종료 확인하기]--
DESC EMP;
-- 1. 트랜잭션 시작
INSERT INTO DEPT(DEPTNO, DNAME, LOC) VALUES(90, '신사업부', '경기도');

-- 2. 트랜잭션 진행 중
UPDATE EMP SET DEPTNO = 90 WHERE DEPTNO = 30;
DELETE FROM DEPT WHERE DEPTNO = 30;

-- 3. 변경 진행중인 데이터 조회하기
-- ( 다른 세션 환경에서도 해당 데이터를 조회시 COMMIT 이전에는 변경사항 반영 안되는 것 확인 )
SELECT * FROM DEPT;
SELECT * FROM EMP WHERE DEPTNO = 30;

-- 4. 트랜잭션 종료
ROLLBACK;

-- 5. ROLLBACK 취소 범위를 확인하기
SELECT * FROM DEPT;
SELECT * FROM EMP;


-- [ COMMIT 이전으로 ROLLBACK 불가 확인 ]
-- 1. 트랜잭션 시작
INSERT INTO EMP(EMPNO,ENAME,JOB,SAL)VALUES (1111,'ORACLE','DBA',3500);

-- 2. 트랜잭션 진행중
UPDATE EMP SET SAL = SAL* 1.3 WHERE EMPNO= 1111;

-- 3. 트랜잭션 종료 (COMMIT)
COMMIT;

-- 4. 트랜잭션 종료 (ROLLBACK)
ROLLBACK;

-- 5. 데이터 조회
SELECT * FROM EMP;


-- [ 문장 범위 ROLLBACK ( Statement Level ROLLBACK ) ]
-- 1. 이전 트랜잭션 종료
ROLLBACK;

-- 2. 트랜잭션 시작
DELETE FROM EMP WHERE EMPNO = 1111;

-- 3. 트랜잭션 진행중, 에러 발생
UPDATE EMP SET SAL = 123456789 WHERE EMPNO = 7788;

-- 4. 실행 or skip?
UPDATE EMP SET SAL = 1234 WHERE EMPNO = 7902;

-- 5. 트랜잭션 종료
COMMIT;

-- 6 트랜잭션 일부만 반영
SELECT EMPNO,SAL FROM EMP WHERE EMPNO IN (1111,7788,7902);

---- 트랜잭션 범위 ROLLBACK(Transaction Level Rollback)
--BEGIN -- Block 시작
--DELETE FROM EMP WHERE DEPTNO = 20; -- 트랜잭션 시작 ①
--UPDATE EMP SET SAL = 123456789 WHERE EMPNO = 7499; -- 에러발생 ②
--UPDATE EMP SET SAL = 1234 WHERE EMPNO = 7698; -- 실행 SKIP ③
--COMMIT; -- 실행 SKIP ④
--EXCEPTION -- 예외처리부 ⑤
--WHEN OTHERS THEN
--ROLLBACK; -- 트랜잭션 레벨 ROLLBACK
--END; -- PL/SQL Block 종료
--/ -- Block 실행(Send to DBMS)

SELECT EMPNO,SAL FROM EMP WHERE DEPTNO = 20 or EMPNO IN (7499,7698); -- 결과확인



-- [ TRANSACTION과 DDL ]
-- 1. 트랜잭션 시작
INSERT INTO EMP(EMPNO,ENAME,DEPTNO) VALUES(9999,'OCPOK',20);

-- 2. DDL문
ALTER TABLE EMP ADD( SEX CHAR(1) DEFAULT 'M');
 
-- 3. ROLLBACK의 취소 범위 : DDL문에 의해 암시적으로 커밋되어 트랜잭션이 종료되었으므로, 취소될 것이 없다.
ROLLBACK; 

-- 4
DESC EMP;

-- 5
ALTER TABLE EMP DROP COLUMN SEX; 

-- 6. 취소 범위 : 마찬가지로 취소될 것이 없다.
ROLLBACK; 

-- 7
DESC EMP;

