-- 숫자 함수(1)
-- 1
SELECT round(45.923,2), round(45.923,1), round(45.923,0), round(45.923), round(45.923,-1) FROM dual;

-- 2
SELECT trunc(45.923,2), trunc(45.923,1), trunc(45.923,0), trunc(45.923), trunc(45.923,-1) FROM dual;

-- 3
SELECT mod(100,3), mod(100,2) FROM dual;

-- 4
SELECT ENAME,SAL,SAL * 0.053 as tax, round(SAL * 0.053,0) as rtax FROM EMP;

-- 5
SELECT CEIL(-45.594),CEIL(-45.294),CEIL(45.294),
ROUND(-45.594),ROUND(-45.294),ROUND(45.594) FROM DUAL;

-- 6
SELECT FLOOR(45.245),FLOOR(-45.245),FLOOR(45.545),FLOOR(-45.545) FROM DUAL;

-- 숫자 함수(2)
-- 1
SELECT sign(-999),sign(999) FROM dual;

-- 2
SELECT 23,power(2,3), power(-2,3), power(-2,4) FROM dual;

-- 3
variable x number
begin
:x := 23;
end;
/
print x