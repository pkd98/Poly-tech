PROCEDURE UPDATE_CUST(

P_ID IN CUSTOMER.ID%TYPE,

P_PWD IN CUSTOMER.PWD%TYPE DEFAULT NULL,

P_NAME IN CUSTOMER.NAME%TYPE DEFAULT NULL,

P_ZIPCODE IN CUSTOMER.ZIPCODE%TYPE DEFAULT NULL,

P_ADDRESS1 IN CUSTOMER.ADDRESS1%TYPE DEFAULT NULL,

P_ADDRESS2 IN CUSTOMER.ADDRESS2%TYPE DEFAULT NULL,

P_MOBILE_NO IN CUSTOMER.MOBILE_NO%TYPE DEFAULT NULL,

P_PHONE_NO IN CUSTOMER.PHONE_NO%TYPE DEFAULT NULL,

P_CREDIT_LIMIT IN CUSTOMER.CREDIT_LIMIT%TYPE DEFAULT NULL,

P_EMAIL IN CUSTOMER.EMAIL%TYPE DEFAULT NULL,

P_MGR_EMPNO IN CUSTOMER.MGR_EMPNO%TYPE DEFAULT NULL,

P_BIRTH_DT IN CUSTOMER.BIRTH_DT%TYPE DEFAULT NULL,

P_ENROLL_DT IN CUSTOMER.ENROLL_DT%TYPE DEFAULT NULL,

P_GENDER IN CUSTOMER.GENDER%TYPE DEFAULT NULL

) IS

BEGIN
 -- PK 컬럼인 ID 값 매개변수 NULL일 경우 사용자 정의 예외 처리
    IF P_ID IS NULL THEN
        RAISE EXC_MANDATORY_FIELDS_MISSING;
    ELSE
 -- 삭제 대상 ID 레코드 없을 경우 사용자 정의 예외 처리
        SELECT
            COUNT(*) INTO REC_COUNT
        FROM
            CUSTOMER
        WHERE
            ID = P_ID;
        IF REC_COUNT = 0 THEN
            RAISE EXC_NO_RECORD_FOUND;
        ELSE
 /* NVL()을 이용해, default null을 활용하여 
         - 매개변수 입력 값이 없으면 기존값 대체
         - 매개변수 입력 값 있으면 해당 값으로 치환 후 UPDATE 수행
      */
            UPDATE CUSTOMER
            SET
                PWD = NVL(
                    P_PWD,
                    PWD
                ),
                NAME = NVL(
                    P_NAME,
                    NAME
                ),
                ZIPCODE = NVL(
                    P_ZIPCODE,
                    ZIPCODE
                ),
                ADDRESS1 = NVL(
                    P_ADDRESS1,
                    ADDRESS1
                ),
                ADDRESS2 = NVL(
                    P_ADDRESS2,
                    ADDRESS2
                ),
                MOBILE_NO = NVL(
                    P_MOBILE_NO,
                    MOBILE_NO
                ),
                PHONE_NO = NVL(
                    P_PHONE_NO,
                    PHONE_NO
                ),
                CREDIT_LIMIT = NVL(
                    P_CREDIT_LIMIT,
                    CREDIT_LIMIT
                ),
                EMAIL = NVL(
                    P_EMAIL,
                    EMAIL
                ),
                MGR_EMPNO = NVL(
                    P_MGR_EMPNO,
                    MGR_EMPNO
                ),
                BIRTH_DT = NVL(
                    P_BIRTH_DT,
                    BIRTH_DT
                ),
                ENROLL_DT = NVL(
                    P_ENROLL_DT,
                    ENROLL_DT
                ),
                GENDER = NVL(
                    P_GENDER,
                    GENDER
                )
            WHERE
                ID = P_ID;
            COMMIT; -- OLTP Transaction 종료
        END IF;
    END IF;
 -- 예외 처리 및 로그 기록
EXCEPTION
    WHEN EXC_MANDATORY_FIELDS_MISSING THEN
        ROLLBACK;
        WRITE_CSS_LOG('UPDATE_CUST', 'MANDATORY_FIELDS_MISSING', 'ID은 필수 입력 해야 합니다.');
    WHEN EXC_NO_RECORD_FOUND THEN
        ROLLBACK;
        WRITE_CSS_LOG('UPDATE_CUST', 'NO_RECORD_FOUND', '대상 레코드를 찾을 수 없습니다.');
    WHEN OTHERS THEN
        ROLLBACK;
        WRITE_CSS_LOG('UPDATE_CUST', SQLERRM, '');
END UPDATE_CUST;