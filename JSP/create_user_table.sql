DROP TABLE USER_TABLE;

TRUNCATE TABLE USER_TABLE;

SELECT
    *
FROM
    USER_TABLE;

CREATE TABLE USER_TABLE (
    ID VARCHAR2(10) PRIMARY KEY,
    NAME VARCHAR2(50) NOT NULL,
    PW VARCHAR2(20) NOT NULL CONSTRAINT CHK_PW CHECK ( REGEXP_LIKE(PW, '[A-Za-z]+') AND REGEXP_LIKE(PW, '[0-9]+') AND LENGTH(PW) >= 4 ),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(100),
    STATUS VARCHAR2(20) DEFAULT 'waiting' CHECK (STATUS IN ('waiting', 'normal', 'pause')) NOT NULL,
    WITHDRAW VARCHAR2(1) DEFAULT 'F' CHECK(WITHDRAW IN ('F', 'T')) NOT NULL,
    ROLE VARCHAR2(20) DEFAULT 'user' CHECK (ROLE IN ('user', 'manager')) NOT NULL
);

INSERT INTO USER_TABLE (
    ID,
    NAME,
    PW,
    STATUS,
    ROLE,
    PHONE,
    EMAIL
) VALUES (
    'admin',
    '관리자',
    'admin01',
    'normal',
    'manager',
    '010-0000-1111',
    'admin@gmail.com'
);

INSERT INTO USER_TABLE (
    ID,
    NAME,
    PW,
    STATUS,
    ROLE
) VALUES (
    'user',
    '사용자',
    'user01',
    'normal',
    'user',
    '010-1111-2222',
    'user@gmail.com'
);

INSERT INTO USER_TABLE (
    ID,
    NAME,
    PW,
    STATUS,
    ROLE
) VALUES (
    'test1',
    '홍길동',
    'user01',
    'waiting',
    'user'
);

INSERT INTO USER_TABLE (
    ID,
    NAME,
    PW,
    STATUS,
    ROLE
) VALUES (
    'test2',
    '홍길동',
    'test2',
    'pause',
    'user'
);