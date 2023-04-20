set heading on
set feedback off
set echo off
set term off

SPOOL assignment02.csv

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

SPOOL OFF
