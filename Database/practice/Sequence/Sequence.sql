-- Sequence
-- 1.
CREATE SEQUENCE SCOTT.ORDER_SEQ -- SEQUENCE ������Ʈ ����
INCREMENT BY 1        -- 1�� ����
START WITH 1          -- ���� �� 1
MAXVALUE 999999999999 -- �ִ� ��
MINVALUE 1            -- �ּ� ��
NOCYCLE               -- �ִ� �� ���޽� ���� ���� (����Ŭ X)
CACHE 30;

-- 2.
SELECT ORDER_SEQ.CURRVAL FROM DUAL; -- error �߻� ������?

-- 3.
SELECT ORDER_SEQ.NEXTVAL FROM DUAL;
SELECT ORDER_SEQ.CURRVAL FROM DUAL; -- error �߻����� �ʴ� ������?
SELECT ORDER_SEQ.CURRVAL FROM DUAL;

-- 4.
SELECT ORDER_SEQ.NEXTVAL FROM DUAL;
SELECT ORDER_SEQ.NEXTVAL FROM DUAL;
ROLLBACK; -- ������ sequence�� rollback �Ǵ°�?
SELECT ORDER_SEQ.NEXTVAL FROM DUAL;

-- 5.
SELECT EMPNO,ENAME,ORDER_SEQ.NEXTVAL FROM EMP;

SELECT EMPNO,ENAME,ORDER_SEQ.CURRVAL FROM EMP;

-- ���� ���ǿ��� Sequence �׽�Ʈ
-- SESSION 1
SELECT ORDER_SEQ.NEXTVAL FROM DUAL;

-- SESSION 2
SELECT ORDER_SEQ.NEXTVAL FROM DUAL;

-- SESSION 1
SELECT ORDER_SEQ.NEXTVAL FROM DUAL;

-- SESSION 2
SELECT ORDER_SEQ.NEXTVAL FROM DUAL;

-- SESSION 1
SELECT ORDER_SEQ.CURRVAL FROM DUAL;

-- SESSION 2
SELECT ORDER_SEQ.CURRVAL FROM DUAL;

-- SESSION 1
SELECT ORDER_SEQ.CURRVAL FROM DUAL;

-- SESSION 2
SELECT ORDER_SEQ.CURRVAL FROM DUAL;

-- Sequence ���� ��ȸ
CREATE SEQUENCE ORDER_SEQ2; -- defualt value�� �̿��� �����ϰ� Sequence ����

SELECT * FROM USER_SEQUENCES;

SELECT sequence_name,
			 min_value,max_value,
			 increment_by,
			 cycle_flag,
			 cache_size,
			 last_number
FROM USER_SEQUENCES;

-- Sequence �ǽ�
DROP TABLE SCOTT.ORDERS;
CREATE TABLE SCOTT.ORDERS -- ORDER ���̺����� ����Ҽ� ���� ������?
       ( ORDER_ID NUMBER(12) CONSTRAINT ORDER_ID_PK PRIMARY KEY,
        ORDER_DATE DATE DEFAULT SYSDATE CONSTRAINT ORDER_DATE_NN NOT NULL,
        ORDER_MODE VARCHAR2(8) CONSTRAINT ORDER_MODE_CHK CHECK(ORDER_MODE IN ('direct','online')),
        CUSTOMER_ID NUMBER(6) CONSTRAINT ORDER_CUSTOMER_ID_NN NOT NULL,
        ORDER_STATUS NUMBER(2), /* 0: �ֹ��� , 1: �ֹ��Ϸ�, 2: ��� , 3: �߼� 4: ���� */
        SALES_ID NUMBER(6), -- �ǸŻ����ȣ
        CONSTRAINT ORDER_SALES_ID_FK FOREIGN KEY(SALES_ID) REFERENCES SCOTT.EMP(EMPNO)
);

DESC SCOTT.ORDERS

-- 1.
INSERT INTO ORDERS(ORDER_ID,ORDER_MODE,CUSTOMER_ID,ORDER_STATUS,SALES_ID)
VALUES(ORDER_SEQ.NEXTVAL,'direct',166,1,7499);

-- 2.
INSERT INTO SCOTT.ORDERS(ORDER_ID,ORDER_DATE,ORDER_MODE,CUSTOMER_ID,ORDER_STATUS,SALES_ID)
VALUES(SCOTT.ORDER_SEQ.NEXTVAL,SYSDATE,'online',200,3,7521);

-- 3.
COMMIT;

-- 4.
INSERT INTO ORDERS(ORDER_ID,ORDER_DATE,ORDER_MODE,CUSTOMER_ID,ORDER_STATUS,SALES_ID)
VALUES(ORDER_SEQ.NEXTVAL,SYSDATE,'online',135,2,7844);

-- 5.
ROLLBACK; -- ORDER_SEQ.NEXTVAL�� ��� �Ǵ°�?

-- 6.
SELECT ORDER_ID FROM ORDERS;
SELECT ORDER_SEQ.CURRVAL FROM DUAL;
-- Hole �߻�

-- 7.
INSERT INTO ORDERS(ORDER_ID,ORDER_DATE,ORDER_MODE,CUSTOMER_ID,ORDER_STATUS,SALES_ID)
VALUES(ORDER_SEQ.NEXTVAL,SYSDATE,'direct',135,4,7844);

-- 8.
INSERT INTO scott.ORDERS(ORDER_ID,ORDER_MODE,CUSTOMER_ID,ORDER_STATUS,SALES_ID)
VALUES((SELECT MAX(ORDER_ID)+1 FROM scott.ORDERS),'direct',335,1,7654);


SELECT LPAD(ORDER_SEQ.NEXTVAL, 8, '0') AS ORDER_SEQ FROM dual;
SELECT TO_CHAR(ORDER_SEQ.NEXTVAL, '00000000') AS ORDER_SEQ FROM dual;