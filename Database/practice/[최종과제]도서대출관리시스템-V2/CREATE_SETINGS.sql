REM  ***************************************************************************
REM  SCRIPT 용도 : 도서대출관리시스템 초기 테이블 생성 및 테스트용 샘플 데이터 삽입
REM  작성자      : 박OO
REM  작성일      : 2023-04-14
REM  주  의      :
REM  수정사항
REM              23/04/14 1
REM  ***************************************************************************

-- 초기 테스트용 테이블 삭제
DROP TABLE RENT;
DROP TABLE MEMBER;
DROP TABLE BOOK;

-- 시퀸스 값 초기화
ALTER SEQUENCE SCOTT.MEMBER_SEQ RESTART;
ALTER SEQUENCE SCOTT.BOOK_SEQ RESTART;
ALTER SEQUENCE SCOTT.RENT_SEQ RESTART;

--------------------------------------------------------------------------------
--  회원(MEMBER) 정보 테이블 생성
--------------------------------------------------------------------------------
CREATE TABLE MEMBER(
    MID NUMBER(8) NOT NULL,                      -- 회원 ID - (기본키)
    MNAME VARCHAR2(20) NOT NULL,                 -- 회원 이름
    SIGN_UP_DATE DATE DEFAULT SYSDATE NOT NULL,  -- 회원 등록일
    ADDRESS VARCHAR2(300) NOT NULL,              -- 주소 (시/군/구)
    PHONE_NUMBER VARCHAR2(11) UNIQUE NOT NULL,   -- 휴대폰 번호(01012345678)
    BIRTHDAY DATE,                               -- 생일
    
    CONSTRAINT MEMBER_ID_PK PRIMARY KEY (MID)    -- 기본키 정의
);

--------------------------------------------------------------------------------
--  도서 (BOOK) 정보 테이블 생성
--------------------------------------------------------------------------------
CREATE TABLE BOOK(
    BID NUMBER(8) NOT NULL,                      -- 도서 ID (기본키)
    BNAME VARCHAR2(100) UNIQUE NOT NULL,         -- 도서 제목
    RELEASE_DATE DATE UNIQUE NOT NULL,           -- 도서 출간일
    RENT_STATE CHAR(1) DEFAULT 'F' NOT NULL,     -- 도서 대출 여부
    
    CONSTRAINT BOOK_ID_PK PRIMARY KEY (BID),     -- 기본키 정의
    CONSTRAINT RENT_STATE_CHECK CHECK(RENT_STATE IN ('T', 'F'))-- 대출 여부 CHECK
);

--------------------------------------------------------------------------------
--  대출 (RENT) 정보 테이블 생성
--------------------------------------------------------------------------------
CREATE TABLE RENT(
    RID NUMBER(8) NOT NULL,                            -- 대출 ID (기본키)
    MID NUMBER(8) NOT NULL,                            -- 회원 ID (외래키)
    BID NUMBER(8) NOT NULL,                            -- 도서 ID (외래키)
    RENT_DATE DATE DEFAULT SYSDATE NOT NULL,           -- 대출일
    RENT_EXTENTION_STATE CHAR(1) DEFAULT 'F' NOT NULL, -- 연장 여부
    RETURN_DATE DATE DEFAULT SYSDATE + 14 NOT NULL,    -- 반납 기한
    
    CONSTRAINT RENT_ID_PK PRIMARY KEY(RID),            -- 기본키 정의
    CONSTRAINT RENT_MEMBER_ID_FK FOREIGN KEY(MID)      -- 외래키 정의
         REFERENCES MEMBER(MID),
    CONSTRAINT RENT_BOOK_ID_FK FOREIGN KEY(BID)        -- 외래키 정의
         REFERENCES BOOK(BID),
    CONSTRAINT RENT_EXTENTION_CHECK CHECK(RENT_EXTENTION_STATE IN ('T', 'F'))-- 대출 연장 여부 CHECK
);

--------------------------------------------------------------------------------
--  회원 (MEMBER) - MID용 SEQUENCE 생성
--------------------------------------------------------------------------------
CREATE SEQUENCE SCOTT.MEMBER_SEQ -- SEQUENCE 오브젝트 생성
INCREMENT BY 1        -- 1씩 증가
START WITH 1          -- 시작 값 1
MAXVALUE 99999999 -- 최대 값
MINVALUE 1            -- 최소 값
NOCYCLE               -- 최대 값 도달시 에러 리턴 (사이클 X)
CACHE 30;

--------------------------------------------------------------------------------
--  도서 (BOOK) - BID용 SEQUENCE 생성
--------------------------------------------------------------------------------
CREATE SEQUENCE SCOTT.BOOK_SEQ -- SEQUENCE 오브젝트 생성
INCREMENT BY 1        -- 1씩 증가
START WITH 1          -- 시작 값 1
MAXVALUE 99999999 -- 최대 값
MINVALUE 1            -- 최소 값
NOCYCLE               -- 최대 값 도달시 에러 리턴 (사이클 X)
CACHE 30;

--------------------------------------------------------------------------------
--  대출 (RENT) - RID용 SEQUENCE 생성
--------------------------------------------------------------------------------
CREATE SEQUENCE SCOTT.RENT_SEQ -- SEQUENCE 오브젝트 생성
INCREMENT BY 1        -- 1씩 증가
START WITH 1          -- 시작 값 1
MAXVALUE 99999999 -- 최대 값
MINVALUE 1            -- 최소 값
NOCYCLE               -- 최대 값 도달시 에러 리턴 (사이클 X)
CACHE 30;

--------------------------------------------------------------------------------
-- SAMPLE DATA Insert
--------------------------------------------------------------------------------
INSERT INTO MEMBER(MID, MNAME, ADDRESS, PHONE_NUMBER, BIRTHDAY) VALUES(MEMBER_SEQ.NEXTVAL, '박길동', '서울시 구로구', '01000000000', '1998/10/10');
INSERT INTO MEMBER(MID, MNAME, ADDRESS, PHONE_NUMBER, BIRTHDAY) VALUES(MEMBER_SEQ.NEXTVAL, '이수박', '서울시 노원구', '01011111111', '1997/01/01');
INSERT INTO MEMBER(MID, MNAME, ADDRESS, PHONE_NUMBER, BIRTHDAY) VALUES(MEMBER_SEQ.NEXTVAL, '박오이', '경기도 군포시', '01022222222', '1996/02/02');
INSERT INTO MEMBER(MID, MNAME, ADDRESS, PHONE_NUMBER, BIRTHDAY) VALUES(MEMBER_SEQ.NEXTVAL, '박김치', '서울시 강남구', '01033333333', '1996/03/03');

INSERT INTO BOOK(BID, BNAME, RELEASE_DATE) VALUES(BOOK_SEQ.NEXTVAL, 'Effective Java', '2020/01/05');
INSERT INTO BOOK(BID, BNAME, RELEASE_DATE) VALUES(BOOK_SEQ.NEXTVAL, 'SQL 도서', '2023/03/01');
INSERT INTO BOOK(BID, BNAME, RELEASE_DATE) VALUES(BOOK_SEQ.NEXTVAL, 'Python 도서', '2010/10/20');
INSERT INTO BOOK(BID, BNAME, RELEASE_DATE) VALUES(BOOK_SEQ.NEXTVAL, '토비의 Spring', '2006/07/14');

INSERT INTO RENT(RID, MID, BID) VALUES(RENT_SEQ.NEXTVAL, 1, 1);
UPDATE BOOK SET RENT_STATE = 'T' WHERE BID = 1;

COMMIT;

-- 테스트 조회
SELECT * FROM MEMBER;
SELECT * FROM BOOK;
SELECT * FROM RENT;

DESC MEMBER;
DESC book;
DESC RENT;