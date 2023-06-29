DROP TABLE REPLIES;

CREATE TABLE REPLIES (
    ID NUMBER,
    CONTENT VARCHAR2(100),
    PARENT_ID NUMBER,
    "level" NUMBER
);

INSERT INTO REPLIES (
    ID,
    CONTENT,
    PARENT_ID,
    "level"
) VALUES (
    1,
    'Root Reply 1',
    NULL,
    0
);

INSERT INTO REPLIES (
    ID,
    CONTENT,
    PARENT_ID,
    "level"
) VALUES (
    2,
    'Root Reply 2',
    NULL,
    0
);

INSERT INTO REPLIES (
    ID,
    CONTENT,
    PARENT_ID,
    "level"
) VALUES (
    3,
    'Child Reply 1-1',
    1,
    1
);

INSERT INTO REPLIES (
    ID,
    CONTENT,
    PARENT_ID,
    "level"
) VALUES (
    4,
    'Child Reply 1-2',
    1,
    1
);

INSERT INTO REPLIES (
    ID,
    CONTENT,
    PARENT_ID,
    "level"
) VALUES (
    5,
    'Grandchild Reply 1-2-1',
    4,
    2
);

INSERT INTO REPLIES (
    ID,
    CONTENT,
    PARENT_ID,
    "level"
) VALUES (
    6,
    'Child Reply 2-1',
    2,
    1
);

INSERT INTO REPLIES (
    ID,
    CONTENT,
    PARENT_ID,
    "level"
) VALUES (
    7,
    'Child Reply 2-2',
    2,
    1
);

INSERT INTO REPLIES (
    ID,
    CONTENT,
    PARENT_ID,
    "level"
) VALUES (
    8,
    'Child Reply 1-1-1',
    3,
    2
);

SELECT
    *
FROM
    REPLIES START WITH PARENT_ID IS NULL -- 부모가 없는 루트 답글부터 시작
CONNECT BY
    PRIOR ID = PARENT_ID ORDER SIBLINGS BY ID;