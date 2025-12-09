package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DBConnection {

    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";

    // ★ 핵심 수정 — 네가 실제 사용 중인 DB 이름으로 변경!
    private static final String URL =
            "jdbc:mysql://localhost:3306/finaltermproject?serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true";

    // ★ 본인이 사용하는 MySQL root 계정 비밀번호와 동일해야 함
    private static final String USER = "root";
    private static final String PASS = "1234";

    public static Connection getConnection() {
        Connection conn = null;

        try {
            Class.forName(DRIVER);
            conn = DriverManager.getConnection(URL, USER, PASS);

        } catch (Exception e) {
            System.out.println("❌ DB 연결 실패! URL 또는 계정 정보를 확인하세요.");
            e.printStackTrace();
        }

        return conn;
    }

    // ★ close()는 NullPointer 방지 및 안전하게 닫기
    public static void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {

        try {
            if (rs != null) rs.close();
        } catch (Exception ignored) {}

        try {
            if (pstmt != null) pstmt.close();
        } catch (Exception ignored) {}

        try {
            if (conn != null) conn.close();
        } catch (Exception ignored) {}
    }
}
