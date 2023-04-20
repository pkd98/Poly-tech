set heading on
set feedback off
set echo off
set term off

SPOOL assignment01.csv

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

SPOOL OFF
