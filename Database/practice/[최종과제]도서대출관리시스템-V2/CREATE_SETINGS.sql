REM  ***************************************************************************
REM  SCRIPT �뵵 : ������������ý��� �ʱ� ���̺� ���� �� �׽�Ʈ�� ���� ������ ����
REM  �ۼ���      : ��OO
REM  �ۼ���      : 2023-04-14
REM  ��  ��      :
REM  ��������
REM              23/04/14 1
REM  ***************************************************************************

-- �ʱ� �׽�Ʈ�� ���̺� ����
DROP TABLE RENT;
DROP TABLE MEMBER;
DROP TABLE BOOK;

-- ������ �� �ʱ�ȭ
ALTER SEQUENCE SCOTT.MEMBER_SEQ RESTART;
ALTER SEQUENCE SCOTT.BOOK_SEQ RESTART;
ALTER SEQUENCE SCOTT.RENT_SEQ RESTART;

--------------------------------------------------------------------------------
--  ȸ��(MEMBER) ���� ���̺� ����
--------------------------------------------------------------------------------
CREATE TABLE MEMBER(
    MID NUMBER(8) NOT NULL,                      -- ȸ�� ID - (�⺻Ű)
    MNAME VARCHAR2(20) NOT NULL,                 -- ȸ�� �̸�
    SIGN_UP_DATE DATE DEFAULT SYSDATE NOT NULL,  -- ȸ�� �����
    ADDRESS VARCHAR2(300) NOT NULL,              -- �ּ� (��/��/��)
    PHONE_NUMBER VARCHAR2(11) UNIQUE NOT NULL,   -- �޴��� ��ȣ(01012345678)
    BIRTHDAY DATE,                               -- ����
    
    CONSTRAINT MEMBER_ID_PK PRIMARY KEY (MID)    -- �⺻Ű ����
);

--------------------------------------------------------------------------------
--  ���� (BOOK) ���� ���̺� ����
--------------------------------------------------------------------------------
CREATE TABLE BOOK(
    BID NUMBER(8) NOT NULL,                      -- ���� ID (�⺻Ű)
    BNAME VARCHAR2(100) UNIQUE NOT NULL,         -- ���� ����
    RELEASE_DATE DATE UNIQUE NOT NULL,           -- ���� �Ⱓ��
    RENT_STATE CHAR(1) DEFAULT 'F' NOT NULL,     -- ���� ���� ����
    
    CONSTRAINT BOOK_ID_PK PRIMARY KEY (BID),     -- �⺻Ű ����
    CONSTRAINT RENT_STATE_CHECK CHECK(RENT_STATE IN ('T', 'F'))-- ���� ���� CHECK
);

--------------------------------------------------------------------------------
--  ���� (RENT) ���� ���̺� ����
--------------------------------------------------------------------------------
CREATE TABLE RENT(
    RID NUMBER(8) NOT NULL,                            -- ���� ID (�⺻Ű)
    MID NUMBER(8) NOT NULL,                            -- ȸ�� ID (�ܷ�Ű)
    BID NUMBER(8) NOT NULL,                            -- ���� ID (�ܷ�Ű)
    RENT_DATE DATE DEFAULT SYSDATE NOT NULL,           -- ������
    RENT_EXTENTION_STATE CHAR(1) DEFAULT 'F' NOT NULL, -- ���� ����
    RETURN_DATE DATE DEFAULT SYSDATE + 14 NOT NULL,    -- �ݳ� ����
    
    CONSTRAINT RENT_ID_PK PRIMARY KEY(RID),            -- �⺻Ű ����
    CONSTRAINT RENT_MEMBER_ID_FK FOREIGN KEY(MID)      -- �ܷ�Ű ����
         REFERENCES MEMBER(MID),
    CONSTRAINT RENT_BOOK_ID_FK FOREIGN KEY(BID)        -- �ܷ�Ű ����
         REFERENCES BOOK(BID),
    CONSTRAINT RENT_EXTENTION_CHECK CHECK(RENT_EXTENTION_STATE IN ('T', 'F'))-- ���� ���� ���� CHECK
);

--------------------------------------------------------------------------------
--  ȸ�� (MEMBER) - MID�� SEQUENCE ����
--------------------------------------------------------------------------------
CREATE SEQUENCE SCOTT.MEMBER_SEQ -- SEQUENCE ������Ʈ ����
INCREMENT BY 1        -- 1�� ����
START WITH 1          -- ���� �� 1
MAXVALUE 99999999 -- �ִ� ��
MINVALUE 1            -- �ּ� ��
NOCYCLE               -- �ִ� �� ���޽� ���� ���� (����Ŭ X)
CACHE 30;

--------------------------------------------------------------------------------
--  ���� (BOOK) - BID�� SEQUENCE ����
--------------------------------------------------------------------------------
CREATE SEQUENCE SCOTT.BOOK_SEQ -- SEQUENCE ������Ʈ ����
INCREMENT BY 1        -- 1�� ����
START WITH 1          -- ���� �� 1
MAXVALUE 99999999 -- �ִ� ��
MINVALUE 1            -- �ּ� ��
NOCYCLE               -- �ִ� �� ���޽� ���� ���� (����Ŭ X)
CACHE 30;

--------------------------------------------------------------------------------
--  ���� (RENT) - RID�� SEQUENCE ����
--------------------------------------------------------------------------------
CREATE SEQUENCE SCOTT.RENT_SEQ -- SEQUENCE ������Ʈ ����
INCREMENT BY 1        -- 1�� ����
START WITH 1          -- ���� �� 1
MAXVALUE 99999999 -- �ִ� ��
MINVALUE 1            -- �ּ� ��
NOCYCLE               -- �ִ� �� ���޽� ���� ���� (����Ŭ X)
CACHE 30;

--------------------------------------------------------------------------------
-- SAMPLE DATA Insert
--------------------------------------------------------------------------------
INSERT INTO MEMBER(MID, MNAME, ADDRESS, PHONE_NUMBER, BIRTHDAY) VALUES(MEMBER_SEQ.NEXTVAL, '�ڱ浿', '����� ���α�', '01000000000', '1998/10/10');
INSERT INTO MEMBER(MID, MNAME, ADDRESS, PHONE_NUMBER, BIRTHDAY) VALUES(MEMBER_SEQ.NEXTVAL, '�̼���', '����� �����', '01011111111', '1997/01/01');
INSERT INTO MEMBER(MID, MNAME, ADDRESS, PHONE_NUMBER, BIRTHDAY) VALUES(MEMBER_SEQ.NEXTVAL, '�ڿ���', '��⵵ ������', '01022222222', '1996/02/02');
INSERT INTO MEMBER(MID, MNAME, ADDRESS, PHONE_NUMBER, BIRTHDAY) VALUES(MEMBER_SEQ.NEXTVAL, '�ڱ�ġ', '����� ������', '01033333333', '1996/03/03');

INSERT INTO BOOK(BID, BNAME, RELEASE_DATE) VALUES(BOOK_SEQ.NEXTVAL, 'Effective Java', '2020/01/05');
INSERT INTO BOOK(BID, BNAME, RELEASE_DATE) VALUES(BOOK_SEQ.NEXTVAL, 'SQL ����', '2023/03/01');
INSERT INTO BOOK(BID, BNAME, RELEASE_DATE) VALUES(BOOK_SEQ.NEXTVAL, 'Python ����', '2010/10/20');
INSERT INTO BOOK(BID, BNAME, RELEASE_DATE) VALUES(BOOK_SEQ.NEXTVAL, '����� Spring', '2006/07/14');

INSERT INTO RENT(RID, MID, BID) VALUES(RENT_SEQ.NEXTVAL, 1, 1);
UPDATE BOOK SET RENT_STATE = 'T' WHERE BID = 1;

COMMIT;

-- �׽�Ʈ ��ȸ
SELECT * FROM MEMBER;
SELECT * FROM BOOK;
SELECT * FROM RENT;

DESC MEMBER;
DESC book;
DESC RENT;