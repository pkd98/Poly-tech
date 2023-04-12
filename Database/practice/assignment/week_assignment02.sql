-- 주말 과제 2번 --
SELECT * FROM CUSTOMER;

-- 사용할 데이터 테이블 --
SELECT * FROM DEPT;
SELECT * FROM EMP_LARGE;
SELECT * FROM EMP;
SELECT * FROM SALGRADE;

-- 최종 결과물 -- 
-- 부서별 평균급여와 급여등급의 평균, 최대 급여, 최대급여를 받는 사원 수 출력
SELECT d.deptno AS 부서번호,
       ROUND(AVG(e.sal)) AS 부서별_평균급여,
       SUM(e.sal) AS 부서별_급여총액,
       ROUND(AVG(s.grade)) AS 부서별_급여등급평균,
       MAX(e.sal) AS 최대급여,
       e_max.cnt AS 최대급여_사원수
       
-- 부서(DEPT), 사원(EMP), 급여등급(SALGRADE), 최대급여를 받는 사원 수 (sub query) Join
FROM dept d
INNER JOIN EMP e
ON d.deptno = e.deptno
INNER JOIN salgrade s
ON e.sal BETWEEN s.losal AND s.hisal -- 사원의 급여가 어느 등급에 포함되는지
INNER JOIN (
    SELECT deptno, count(deptno) AS cnt -- 최대 급여를 받는 사원 수
    FROM EMP
    WHERE (deptno, sal) IN (
        SELECT deptno, MAX(sal) AS max_sal -- 그룹 별 최대 급여
        FROM EMP
        GROUP BY deptno
    ) group by deptno
) e_max
ON d.deptno = e_max.deptno -- Join 조건
GROUP BY d.deptno, e_max.cnt
ORDER BY d.DEPTNO;

--
--
---- 부서, 사원, 급여등급 테이블 조인 --
--SELECT d.deptno, d.dname, e.ename, e.job, e.sal, s.grade
--FROM dept d
--INNER JOIN EMP_LARGE e
--ON d.deptno = e.deptno
--INNER JOIN salgrade s
--ON e.sal BETWEEN s.losal AND s.hisal; -- 사원의 급여에 대해 급여 등급 계산 조건 추가
--
---- 부서별 직원(EMP)의 SALGRADE 평균 테이블 생성 --
--SELECT d.deptno AS 부서번호,
--       ROUND(AVG(e.sal), 3) AS 부서별_평균급여,
--       ROUND(AVG(s.grade), 3) AS 부서별_급여등급평균,
--       MAX(e.sal)
--FROM dept d
--INNER JOIN EMP_LARGE e
--ON d.deptno = e.deptno
--INNER JOIN salgrade s
--ON e.sal BETWEEN s.losal AND s.hisal
--GROUP BY d.deptno;
--
---- 부서별 직원(EMP_LARGE)의 SALGRADE 평균 테이블 생성 --
--SELECT d.deptno AS 부서번호,
--       ROUND(AVG(e.sal)) AS 부서별_평균급여,
--       ROUND(AVG(s.grade)) AS 부서별_급여등급평균,
--       MAX(e.sal) AS 최대급여
--FROM dept d
--INNER JOIN EMP e
--ON d.deptno = e.deptno
--INNER JOIN salgrade s
--ON e.sal BETWEEN s.losal AND s.hisal
--GROUP BY d.deptno;
--
---- 부서별 직원의 SALGRADE 평균 테이블 생성 --
--SELECT d.deptno, count(e.job)AS 직업
--FROM dept d
--INNER JOIN  EMP e
--ON d.deptno = e.deptno
--INNER JOIN salgrade s
--ON e.sal BETWEEN s.losal AND s.hisal
--GROUP BY d.deptno;
--
--SELECT d.deptno AS 부서번호,
--       ROUND(AVG(e.sal)) AS 부서별_평균급여,
--       ROUND(AVG(s.grade)) AS 부서별_급여등급평균,
--       e_max.ename AS 최대급여_사원이름,
--       MAX(e.sal) AS 최대급여
--FROM dept d
--INNER JOIN EMP e
--ON d.deptno = e.deptno
--INNER JOIN salgrade s
--ON e.sal BETWEEN s.losal AND s.hisal
--INNER JOIN (
--    SELECT deptno, ename
--    FROM EMP
--    WHERE (deptno, sal) IN (
--        SELECT deptno, MAX(sal) AS max_sal
--        FROM EMP
--        GROUP BY deptno
--    )
--) e_max
--ON d.deptno = e_max.deptno
--GROUP BY d.deptno, e_max.ename;
--
--        
---- 부서별로 최대 급여를 받는 사람 (1명씩) 구하기
--SELECT deptno, ename, sal
--FROM (
--    SELECT deptno, ename, sal,
--        ROW_NUMBER() OVER (PARTITION BY deptno ORDER BY sal DESC) AS rn
--    FROM EMP
--) e
--WHERE rn = 1;


