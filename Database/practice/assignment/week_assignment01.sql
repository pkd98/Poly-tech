-- 주말 과제 1번 --
DESC CUSTOMER;
DESC ESTABLISHMENT;
DESC ESTABLISHMENT1;
select * from customer;
select * from establishment;
select * from establishment1;
-- ADDRESS1 결측치 - 주소2로 대체하기 --
UPDATE ESTABLISHMENT SET ADDRESS1 = ADDRESS2 WHERE ADDRESS1 is null;

-- 공백 2개 기준 주소 분리 테스트
UPDATE ESTABLISHMENT
SET ADDRESS1 = SUBSTRING_INDEX(전체주소, ' ', 1);
select substr(address, 0, instr(address, ' ', 1, 2)) from establishment;

-- 공백 2개 기준 주소 update
UPDATE ESTABLISHMENT SET ADDRESS = substr(address1, 0, instr(address1, ' ', 1, 2));
commit;

-- 시설 구 단위별 대기오염 시설이 가장 많은 지역 확인 -> 경기도 화성시
SELECT ADDRESS AS 주소, COUNT(ADDRESS) AS 시설수
FROM ESTABLISHMENT
GROUP BY ADDRESS
HAVING COUNT(ADDRESS) > 10
ORDER BY 시설수 DESC;

-- 최대값 하나만 표시
SELECT 주소, 시설수
FROM (
    SELECT ADDRESS AS 주소, COUNT(ADDRESS) AS 시설수
    FROM ESTABLISHMENT
    GROUP BY ADDRESS
    HAVING COUNT(ADDRESS) > 10
    ORDER BY 시설수 DESC
)
FETCH FIRST ROW ONLY;

-- CUSTOMER 분리 --
SELECT NAME, MOBILE_NO, EMAIL,
DECODE(SUBSTR(TMP, 0, 2), '서울', '서울특별시',
          '울산', '울산광역시',
          '부산', '부산광역시',
          '대전', '대전광역시',
          '인천', '인천광역시',
          '대구', '대구광역시',
          '광주', '광주광역시',
          '세종', '세종특별자치시',
          '경기', '경기도',
          '강원', '강원도',
          '전남', '전라남도',
          '전북', '전라북도',
          '충남', '충청남도',
          '충북', '충청북도',
          '경남', '경상남도',
          '경북', '경상북도',
          '제주', '제주특별자치도') || ' ' || SUBSTR(TMP, 4) AS ADDRESS
FROM (
      SELECT SUBSTR(ADDRESS1,1,INSTR(ADDRESS1,' ',1,2)) AS TMP, NAME, MOBILE_NO, EMAIL
      FROM CUSTOMER
    );
    

-- 최종 결과물(1) -- 
--
SELECT NAME, MOBILE_NO, EMAIL,
DECODE(SUBSTR(TMP, 0, 2),
      '서울', '서울특별시',
      '울산', '울산광역시',
      '부산', '부산광역시',
      '대전', '대전광역시',
      '인천', '인천광역시',
      '대구', '대구광역시',
      '광주', '광주광역시',
      '세종', '세종특별자치시',
      '경기', '경기도',
      '강원', '강원도',
      '전남', '전라남도',
      '전북', '전라북도',
      '충남', '충청남도',
      '충북', '충청북도',
      '경남', '경상남도',
      '경북', '경상북도',
      '제주', '제주특별자치도') || ' ' || SUBSTR(TMP, 4) AS ADDRESS
FROM(
      SELECT SUBSTR(ADDRESS1,1,INSTR(ADDRESS1,' ',1,2)) AS TMP, NAME, MOBILE_NO, EMAIL
      FROM CUSTOMER
    )
WHERE DECODE(SUBSTR(TMP, 0, 2), '서울', '서울특별시',
      '울산', '울산광역시',
      '부산', '부산광역시',
      '대전', '대전광역시',
      '인천', '인천광역시',
      '대구', '대구광역시',
      '광주', '광주광역시',
      '세종', '세종특별자치시',
      '경기', '경기도',
      '강원', '강원도',
      '전남', '전라남도',
      '전북', '전라북도',
      '충남', '충청남도',
      '충북', '충청북도',
      '경남', '경상남도',
      '경북', '경상북도',
      '제주', '제주특별자치도') || ' ' || SUBSTR(TMP, 4) = 
      (
      SELECT 주소
      FROM(
            SELECT ADDRESS AS 주소, COUNT(ADDRESS) AS 시설수
            FROM ESTABLISHMENT
            GROUP BY ADDRESS
            HAVING COUNT(ADDRESS) > 10
            ORDER BY 시설수 DESC
          )
      FETCH FIRST ROW ONLY
      );
    

-- 최종 결과물 (2) Inner Join 사용 --
SELECT c.*
FROM (
    SELECT ADDRESS, COUNT(ADDRESS) AS 시설수
    FROM ESTABLISHMENT
    GROUP BY ADDRESS
    HAVING COUNT(ADDRESS) > 10
    ORDER BY 시설수 DESC
    FETCH FIRST ROW ONLY
) e
INNER JOIN (
  SELECT NAME, MOBILE_NO, EMAIL,
    DECODE(SUBSTR(TMP, 0, 2),
    '서울', '서울특별시',
    '울산', '울산광역시',
    '부산', '부산광역시',
    '대전', '대전광역시',
    '인천', '인천광역시',
    '대구', '대구광역시',
    '광주', '광주광역시',
    '세종', '세종특별자치시',
    '경기', '경기도',
    '강원', '강원도',
    '전남', '전라남도',
    '전북', '전라북도',
    '충남', '충청남도',
    '충북', '충청북도',
    '경남', '경상남도',
    '경북', '경상북도',
    '제주', '제주특별자치도') || ' ' || SUBSTR(TMP, 4) AS ADDRESS
  FROM (
    SELECT SUBSTR(ADDRESS1,1,INSTR(ADDRESS1,' ',1,2)) AS TMP, NAME, MOBILE_NO, EMAIL
    FROM CUSTOMER
      )
) c
ON c.ADDRESS = e.ADDRESS;
