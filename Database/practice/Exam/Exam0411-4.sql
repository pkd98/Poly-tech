DROP TABLE SYSTEM;
DROP TABLE RESOURCE_USAGE;
CREATE TABLE SYSTEM( SYSTEM_ID VARCHAR2(5),
SYSTEM_NAME VARCHAR2(12)
);
INSERT INTO SYSTEM VALUES('XXX','혜화DB');
INSERT INTO SYSTEM VALUES('YYY','강남DB');
INSERT INTO SYSTEM VALUES('ZZZ','영등포DB');

CREATE TABLE RESOURCE_USAGE(SYSTEM_ID VARCHAR2(5),
RESOURCE_NAME VARCHAR2(10)
);
INSERT INTO RESOURCE_USAGE VALUES('XXX','FTP');
INSERT INTO RESOURCE_USAGE VALUES('YYY','FTP');
INSERT INTO RESOURCE_USAGE VALUES('YYY','TELNET');
INSERT INTO RESOURCE_USAGE VALUES('YYY','EMAIL');
COMMIT;


SELECT S.SYSTEM_ID,S.SYSTEM_NAME,R.RESOURCE_NAME
FROM SYSTEM S, RESOURCE_USAGE R
WHERE S.SYSTEM_ID = R.SYSTEM_ID;

SELECT S.SYSTEM_ID,S.SYSTEM_NAME,R.RESOURCE_NAME
FROM SYSTEM S,RESOURCE_USAGE R
WHERE S.SYSTEM_ID = R.SYSTEM_ID(+);

----------------------------------------------------------

SELECT S.SYSTEM_ID, S.SYSTEM_NAME,
       DECODE(SUM(DECODE(R.RESOURCE_NAME, 'FTP', 1, 0)), 1, '사용', '미사용') AS FTP,
       DECODE(SUM(DECODE(R.RESOURCE_NAME, 'TELNET', 1, 0)), 1, '사용', '미사용') AS TELNET,
       DECODE(SUM(DECODE(R.RESOURCE_NAME, 'EMAIL', 1, 0)), 1, '사용', '미사용') AS EMAIL
FROM SYSTEM S LEFT OUTER JOIN RESOURCE_USAGE R
ON S.SYSTEM_ID = R.SYSTEM_ID
GROUP BY S.SYSTEM_ID, SYSTEM_NAME
ORDER BY S.SYSTEM_ID;
