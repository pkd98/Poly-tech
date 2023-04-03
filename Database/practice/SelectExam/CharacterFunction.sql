-- 문자 함수

-- 1
SELECT ENAME, LOWER(ENAME), UPPER(ENAME), initcap(ENAME) FROM EMP;

-- 2
SELECT ENAME, substr(ENAME, 1, 3), substr(ENAME, 4), substr(ENAME, -3, 2) FROM EMP;

-- 3
SELECT ENAME, instr(ENAME, 'A'), instr(ENAME, 'A', 2), instr(ENAME, 'A', 1, 2) FROM EMP;

-- 4-1
SELECT ENAME, rpad(ENAME, 10, ' '), rpad(ENAME, 10), rpad(ENAME, 10, ''), lpad(ENAME, 10, '+') FROM EMP;

-- 4-2
SELECT length(rpad('X', 10000, 'X')), rpad('X', 1000, 'X') FROM DUAL;

-- 5
SELECT ENAME, REPLACE(ENAME, 'S', 's') FROM EMP;

-- 6
SELECT ENAME, concat(ENAME, JOB), ENAME || JOB FROM EMP;

-- 7-1
SELECT ltrim(' 대한민국 '), rtrim(' 대한민국 '), trim(' ' from ' 대한민국 '), trim('*' from '대한민국') FROM dual;

-- 7-2
SELECT trim('장' from '장발장'), ltrim('장발장','장'), rtrim('장발장','장') FROM dual;

-- 8 (문자열 길이 리턴)
SELECT length('abcd'), substr('abcd',2,2), length('대한민국'), substr('대한민국',2,2) FROM dual;

-- 9
SELECT lengthb('abcd'),lengthb('대한민국'),substr('대한민국',2,2),substrb('대한민국',2,2) FROM dual;

-- 10
SELECT length('abcd'), vsize('abcd'), length('대한민국'), vsize('대한민국') FROM dual;

-- 11
SELECT ASCII('A'), ASCII('a') FROM dual; -- 65, 97

-- 12-1
SELECT CHR(65), CHR(97) FROM DUAL;
-- 12-2
SELECT 'Hellow'||CHR(10)||'World' FROM DUAL;