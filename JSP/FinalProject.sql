SELECT
    *
FROM
    BOARD;

DROP TABLE BOARD;

TRUNCATE TABLE BOARD;

-- 시퀀스 생성
DROP SEQUENCE BOARD_SEQ;

CREATE SEQUENCE BOARD_SEQ START WITH 1 INCREMENT BY 1;

-- 테이블 생성
CREATE TABLE BOARD (
    ID NUMBER DEFAULT BOARD_SEQ.NEXTVAL PRIMARY KEY,
    NAME VARCHAR2(100),
    TITLE VARCHAR2(100),
    CONTENT VARCHAR2(1000),
    CREATED_AT TIMESTAMP DEFAULT SYSTIMESTAMP(1),
    VIEWS NUMBER DEFAULT 0,
    PARENT_ID NUMBER,
    DEPTH NUMBER
);

-- 샘플 데이터 삽입
INSERT INTO BOARD (
    ID,
    NAME,
    TITLE,
    CONTENT,
    VIEWS,
    PARENT_ID,
    DEPTH
) VALUES (
    BOARD_SEQ.NEXTVAL,
    'pkd',
    '하금티',
    '가즈아 ㅋㅋ',
    10,
    NULL,
    0
);

INSERT INTO BOARD (
    ID,
    NAME,
    TITLE,
    CONTENT,
    VIEWS,
    PARENT_ID,
    DEPTH
) VALUES (
    BOARD_SEQ.NEXTVAL,
    '홍길동',
    '나도',
    'ㅈㄱㄴ',
    5,
    NULL,
    0
);

INSERT INTO BOARD (
    ID,
    NAME,
    TITLE,
    CONTENT,
    VIEWS,
    PARENT_ID,
    DEPTH
) VALUES (
    BOARD_SEQ.NEXTVAL,
    '익명',
    'TEST',
    'TEST',
    5,
    NULL,
    0
);

INSERT INTO BOARD (
    ID,
    NAME,
    TITLE,
    CONTENT,
    VIEWS,
    PARENT_ID,
    DEPTH
) VALUES (
    BOARD_SEQ.NEXTVAL,
    '익명',
    'TEST',
    'TEST',
    5,
    NULL,
    0
);

INSERT INTO BOARD (
    ID,
    NAME,
    TITLE,
    CONTENT,
    VIEWS,
    PARENT_ID,
    DEPTH
) VALUES (
    BOARD_SEQ.NEXTVAL,
    '익명',
    'TEST',
    'TEST',
    5,
    NULL,
    0
);

INSERT INTO BOARD (
    ID,
    NAME,
    TITLE,
    CONTENT,
    VIEWS,
    PARENT_ID,
    DEPTH
) VALUES (
    BOARD_SEQ.NEXTVAL,
    '익명',
    'TEST',
    'TEST',
    5,
    NULL,
    0
);

INSERT INTO BOARD (
    ID,
    NAME,
    TITLE,
    CONTENT,
    VIEWS,
    PARENT_ID,
    DEPTH
) VALUES (
    BOARD_SEQ.NEXTVAL,
    '익명',
    'TEST',
    'TEST',
    5,
    NULL,
    0
);

INSERT INTO BOARD (
    ID,
    NAME,
    TITLE,
    CONTENT,
    VIEWS,
    PARENT_ID,
    DEPTH
) VALUES (
    BOARD_SEQ.NEXTVAL,
    '익명',
    'TEST',
    'TEST',
    5,
    NULL,
    0
);

INSERT INTO BOARD (
    ID,
    NAME,
    TITLE,
    CONTENT,
    VIEWS,
    PARENT_ID,
    DEPTH
) VALUES (
    BOARD_SEQ.NEXTVAL,
    '익명',
    'TEST',
    'TEST',
    5,
    NULL,
    0
);

INSERT INTO BOARD (
    ID,
    NAME,
    TITLE,
    CONTENT,
    VIEWS,
    PARENT_ID,
    DEPTH
) VALUES (
    BOARD_SEQ.NEXTVAL,
    '익명',
    'TEST',
    'TEST',
    5,
    NULL,
    0
);

INSERT INTO BOARD (
    ID,
    NAME,
    TITLE,
    CONTENT,
    VIEWS,
    PARENT_ID,
    DEPTH
) VALUES (
    BOARD_SEQ.NEXTVAL,
    '익명',
    'TEST',
    'TEST',
    5,
    NULL,
    0
);

INSERT INTO BOARD (
    ID,
    NAME,
    TITLE,
    CONTENT,
    VIEWS,
    PARENT_ID,
    DEPTH
) VALUES (
    BOARD_SEQ.NEXTVAL,
    '익명',
    'TEST',
    'TEST',
    5,
    NULL,
    0
);

INSERT INTO BOARD (
    ID,
    NAME,
    TITLE,
    CONTENT,
    VIEWS,
    PARENT_ID,
    DEPTH
) VALUES (
    BOARD_SEQ.NEXTVAL,
    '익명',
    'TEST',
    'TEST',
    5,
    NULL,
    0
);

INSERT INTO BOARD (
    ID,
    NAME,
    TITLE,
    CONTENT,
    VIEWS,
    PARENT_ID,
    DEPTH
) VALUES (
    BOARD_SEQ.NEXTVAL,
    '익명',
    'TEST',
    'TEST',
    5,
    NULL,
    0
);

INSERT INTO BOARD (
    ID,
    NAME,
    TITLE,
    CONTENT,
    VIEWS,
    PARENT_ID,
    DEPTH
) VALUES (
    BOARD_SEQ.NEXTVAL,
    '익명',
    'TEST',
    'TEST',
    5,
    NULL,
    0
);

INSERT INTO BOARD (
    ID,
    NAME,
    TITLE,
    CONTENT,
    VIEWS,
    PARENT_ID,
    DEPTH
) VALUES (
    BOARD_SEQ.NEXTVAL,
    '익명',
    'TEST',
    'TEST',
    5,
    NULL,
    0
);

INSERT INTO BOARD (
    ID,
    NAME,
    TITLE,
    CONTENT,
    VIEWS,
    PARENT_ID,
    DEPTH
) VALUES (
    BOARD_SEQ.NEXTVAL,
    '익명',
    'TEST',
    'TEST',
    5,
    NULL,
    0
);

INSERT INTO BOARD (
    ID,
    NAME,
    TITLE,
    CONTENT,
    VIEWS,
    PARENT_ID,
    DEPTH
) VALUES (
    BOARD_SEQ.NEXTVAL,
    '익명',
    'TEST',
    'TEST',
    5,
    NULL,
    0
);

INSERT INTO BOARD (
    ID,
    NAME,
    TITLE,
    CONTENT,
    VIEWS,
    PARENT_ID,
    DEPTH
) VALUES (
    BOARD_SEQ.NEXTVAL,
    '익명',
    'TEST',
    'TEST',
    5,
    NULL,
    0
);

INSERT INTO BOARD (
    ID,
    NAME,
    TITLE,
    CONTENT,
    VIEWS,
    PARENT_ID,
    DEPTH
) VALUES (
    BOARD_SEQ.NEXTVAL,
    '익명',
    'TEST',
    'TEST',
    5,
    NULL,
    0
);

INSERT INTO BOARD (
    ID,
    NAME,
    TITLE,
    CONTENT,
    VIEWS,
    PARENT_ID,
    DEPTH
) VALUES (
    BOARD_SEQ.NEXTVAL,
    '익명',
    'TEST',
    'TEST',
    5,
    NULL,
    0
);

INSERT INTO BOARD (
    ID,
    NAME,
    TITLE,
    CONTENT,
    VIEWS,
    PARENT_ID,
    DEPTH
) VALUES (
    BOARD_SEQ.NEXTVAL,
    '익명',
    'TEST',
    'TEST',
    5,
    NULL,
    0
);

DELETE FROM BOARD
WHERE
    ID = NULL;

SELECT
    *
FROM
    BOARD START WITH PARENT_ID IS NULL -- 부모가 없는 루트 답글부터 시작
CONNECT BY
    PRIOR ID = PARENT_ID ORDER SIBLINGS BY ID ASC;

SELECT
    *
FROM
    BOARD START WITH PARENT_ID IS NULL
CONNECT BY
    PRIOR ID = PARENT_ID ORDER SIBLINGS BY ID;

SELECT
    COUNT(*) AS COUNT
FROM
    BOARD
WHERE
    ID = NULL;

UPDATE BOARD
SET
    TITLE = 'test',
    CONTENT = 'test'
WHERE
    ID = NULL;

UPDATE BOARD
SET
    TITLE = 'TEST',
    CONTENT = 'TEST'
WHERE
    ID = 1;