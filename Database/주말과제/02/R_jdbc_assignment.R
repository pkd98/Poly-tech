#JDBC 패키지 설치 및 부착
install.packages('rJava')
install.packages('RJDBC')
library(rJava)
library(RJDBC)

# 기초통계량 패키지
install.packages('Hmisc') #패키지 설치 한번만 하면 됨
library(Hmisc) #패키지 부착
install.packages('plyr')
library(plyr)

# 그래프 패키지
install.packages('ggplot2') #패키지 설치 한번만 하면 됨
library(ggplot2) #패키지 부착


# JDBC 드라이버에 driverClass, classPath 위치 대입
jdbcDriver <- JDBC(driverClass = "oracle.jdbc.OracleDriver",
                   classPath = "D://SQLDEV//ojdbc11.jar")

# 해당 Oracle DBMS 서버에 대한 정보를 통해 커넥션을 맺음
conn <- dbConnect(jdbcDriver, 
                  "jdbc:oracle:thin:@192.168.119.119:1521/dink", "scott", "tiger")

# 커넥션을 맺은 서버에 SQL 쿼리문을 Get방식으로 요청 -> 결과 테이블을 데이터프레임 형식으로 얻을 수 있다.
test <- dbGetQuery(conn,
"SELECT d.deptno AS 부서번호,
ROUND(AVG(e.sal)) AS 부서별_평균급여,
SUM(e.sal) AS 부서별_급여총액,
ROUND(AVG(s.grade)) AS 부서별_급여등급평균,
MAX(e.sal) AS 최대급여,
e_max.cnt AS 최대급여_사원수
FROM dept d
INNER JOIN EMP e
ON d.deptno = e.deptno
INNER JOIN salgrade s
ON e.sal BETWEEN s.losal AND s.hisal
INNER JOIN (
    SELECT deptno, count(deptno) AS cnt
    FROM EMP
    WHERE (deptno, sal) IN (
        SELECT deptno, MAX(sal) AS max_sal
        FROM EMP
        GROUP BY deptno
    ) group by deptno
) e_max
ON d.deptno = e_max.deptno
GROUP BY d.deptno, e_max.cnt
ORDER BY d.DEPTNO")

# SQL 쿼리 결과 테이블 확인
test

# 부서별 평균급여, 급여총액, 최대급여에 대해 막대 그래프로 시각화 (ggplot, geom_rect 함수 이용)
# test dataframe의 '부서번호'를 x축, '부서별_평균급여'를 y축으로 설정
ggplot(test, aes(x = 부서번호, y = 부서별_평균급여)) +
  scale_x_continuous(breaks = c(10, 20, 30)) +
  geom_rect(aes(xmin = 부서번호 - 1, xmax = 부서번호 - 0.5, ymin = 0, ymax = 부서별_평균급여),
            fill = "lightblue", color = "black", alpha = 0.5) +
  
  geom_rect(aes(xmin = 부서번호 - 0.2, xmax = 부서번호 + 0.3, ymin = 0, ymax = 부서별_급여총액),
            fill = "pink", color = "black", alpha = 0.5) +
  
  geom_rect(aes(xmin = 부서번호 + 0.6, xmax = 부서번호 + 1.1, ymin = 0, ymax = 최대급여),
            fill = "green", color = "black", alpha = 0.5) +
  
  # y축의 범위를 0부터 12000까지 지정
  # expand는 그래프와 축 사이에 여백을 주는 값으로, x축과 y축 각각 0으로 지정하여 여백 제거
  scale_y_continuous(limits = c(0, 12000), expand = c(0, 0)) +
  
  # 제목 및 x, y축에 라벨 부착
  labs(title = "부서별 급여 지급 현황", x = "부서번호", y = "급여")


# 부서별 급여등급평균, 최대급여_사원수에 대해 꺾은선 그래프로 시각화 (ggplot, geom_line 함수 이용)
ggplot(test, aes(x = 부서번호)) +
  scale_x_continuous(breaks = c(10, 20, 30)) +
  geom_line(aes(y = 부서별_급여등급평균, colour = "부서별_급여등급평균")) +
  geom_line(aes(y = 최대급여_사원수, colour = "최대급여_사원수")) +
  xlab("부서 번호") +
  ylab("") +
  scale_colour_manual(name = "요소", values = c("부서별_급여등급평균" = "blue", "최대급여_사원수" = "red"))
