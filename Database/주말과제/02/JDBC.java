package application;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javafx.application.Application;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.scene.Scene;
import javafx.scene.chart.BarChart;
import javafx.scene.chart.CategoryAxis;
import javafx.scene.chart.NumberAxis;
import javafx.scene.chart.XYChart;
import javafx.scene.layout.BorderPane;
import javafx.stage.Stage;

public class JDBC extends Application {

    // 그래프의 데이터를 저장하기 위한 ObservableList
    private ObservableList<XYChart.Data<String, Number>> dataAvgSalary =
            FXCollections.observableArrayList();
    private ObservableList<XYChart.Data<String, Number>> dataTotalSalary =
            FXCollections.observableArrayList();
    private ObservableList<XYChart.Data<String, Number>> dataMaxSalary =
            FXCollections.observableArrayList();

    @Override
    public void start(Stage primaryStage) throws Exception {
        // UI를 구성하기 위한 루트 노드 생성
        BorderPane root = new BorderPane();

        // BarChart 생성
        CategoryAxis xAxis = new CategoryAxis(); // x축
        NumberAxis yAxis = new NumberAxis(); // y축
        BarChart<String, Number> barChart = new BarChart<>(xAxis, yAxis); // BarChart 생성

        barChart.setTitle("부서별 급여 지급 현황"); // 그래프 제목 설정



        // 데이터베이스 연결 정보 설정
        String url = "jdbc:oracle:thin:@192.168.119.119:1521/dink";
        String user = "scott";
        String passwd = "tiger";

        // 질의문 작성
        String query = "SELECT d.deptno AS 부서번호,\r\n"
                + "       ROUND(AVG(e.sal)) AS 부서별_평균급여,\r\n"
                + "       SUM(e.sal) AS 부서별_급여총액,\r\n"
                + "       ROUND(AVG(s.grade)) AS 부서별_급여등급평균,\r\n"
                + "       MAX(e.sal) AS 최대급여,\r\n"
                + "       e_max.cnt AS 최대급여_사원수\r\n"
                + "       \r\n"
                + "FROM dept d\r\n"
                + "INNER JOIN EMP e\r\n"
                + "ON d.deptno = e.deptno\r\n"
                + "INNER JOIN salgrade s\r\n"
                + "ON e.sal BETWEEN s.losal AND s.hisal\r\n"
                + "INNER JOIN (\r\n"
                + "    SELECT deptno, count(deptno) AS cnt\r\n"
                + "    FROM EMP\r\n"
                + "    WHERE (deptno, sal) IN (\r\n"
                + "        SELECT deptno, MAX(sal) AS max_sal\r\n"
                + "        FROM EMP\r\n"
                + "        GROUP BY deptno\r\n"
                + "    ) group by deptno\r\n"
                + ") e_max\r\n"
                + "ON d.deptno = e_max.deptno\r\n"
                + "GROUP BY d.deptno, e_max.cnt\r\n"
                + "ORDER BY d.DEPTNO";


        // 데이터베이스에 연결하여 질의문 실행
        try (Connection con = DriverManager.getConnection(url, user, passwd);
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery(query)) {

            // 결과셋에서 데이터를 읽어와서 그래프에 데이터 추가
            while (rs.next()) {
                String deptNo = rs.getString("부서번호"); // 부서명
                String grade = rs.getString("부서별_급여등급평균"); // 평균 등급
                Double avgSal = rs.getDouble("부서별_평균급여"); // 평균 급여
                Double maxSalNumber = rs.getDouble("부서별_급여총액"); // 급여 총액
                Double maxSal = rs.getDouble("최대급여"); // 최대 급여

                // 데이터 추가
                dataAvgSalary.add(new XYChart.Data<>(deptNo + "-" + grade, avgSal));
                dataTotalSalary.add(new XYChart.Data<>(deptNo + "-" + grade, maxSalNumber));
                dataMaxSalary.add(new XYChart.Data<>(deptNo + "-" + grade, maxSal));
            }
        } catch (SQLException e) {
            e.printStackTrace(); // 예외 처리
        }

        // 데이터를 그래프에 추가
        XYChart.Series<String, Number> seriesAvgSalary = new XYChart.Series<>();
        XYChart.Series<String, Number> seriesTotalSalary = new XYChart.Series<>();
        XYChart.Series<String, Number> seriesMaxSalary = new XYChart.Series<>();

        seriesAvgSalary.setName("Average Salary");
        seriesTotalSalary.setName("Totla Salary");
        seriesMaxSalary.setName("Maximum Salary");

        seriesAvgSalary.setData(dataAvgSalary);
        seriesTotalSalary.setData(dataTotalSalary);
        seriesMaxSalary.setData(dataMaxSalary);

        barChart.getData().addAll(seriesAvgSalary, seriesTotalSalary, seriesMaxSalary);

        // 그래프를 루트 노드에 추가
        root.setCenter(barChart);

        // Scene 생성
        Scene scene = new Scene(root, 800, 600);

        // Stage에 Scene 추가 후 보여주기
        primaryStage.setScene(scene);
        primaryStage.setTitle("JDBC Bar Chart");
        primaryStage.show();
    }

    public static void main(String[] args) {
        launch(args);
    }
}
