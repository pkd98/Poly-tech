-- UPDATE
-- 1. 단일 컬럼 변경
UPDATE DEPT SET DNAME = ' M연구소' WHERE DEPTNO = 50;

-- 2. 복수 컬럼 변경
UPDATE DEPT SET DNAME = ' T연구소', LOC = '인천' WHERE DEPTNO = 51;

-- 3. 변경 내역 조회
SELECT * FROM DEPT WHERE DEPTNO IN (50, 51);

-- 4. 변경사항 반영 (저장)
COMMIT;

-- 5. WHERE절 생략시 전체 ROW 대상 (유의!!!)
UPDATE DEPT SET LOC = '미개척지';

-- 6
SELECT * FROM DEPT;

-- 7. 해당 변경사항 영구히 취소
ROLLBACK;

-- 8. 결과 확인
SELECT * FROM DEPT;

-- 9. UPDATE 시 내부에 함수, 산술 연산, decode, case 등 데이터를 가공 처리 후 수정할 수 있다.
-- dname 컬럼에 공백문자 저장
select dname, replace(dname,' ','') from dept;

-- set 절에 함수 사용가능
update dept set dname=trim(dname);

select dname, replace(dname,' ','') from dept;

-- 10
COMMIT;