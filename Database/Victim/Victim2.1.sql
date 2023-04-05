-- STUDENT 테이블에서 랜덤으로 뽑기
-- 2.1 수정 : 난수 알고리즘 수정 (소수점 시간을 이용한 난수 효과)
SELECT NAME AS Victim
FROM STUDENT
WHERE ID = (SELECT mod(to_number(to_char(systimestamp(3), 'FF3')), 22) + 1 from dual);