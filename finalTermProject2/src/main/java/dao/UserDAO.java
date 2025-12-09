package dao;

import dto.UserDTO;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    private final String URL = "jdbc:mysql://localhost:3306/finaltermproject?serverTimezone=UTC";
    private final String USER = "root";
    private final String PASSWORD = "1234";

    // DB 연결
    private void getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // DB 자원 정리
    private void close() {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ✔ 로그인 기능
    public UserDTO login(String id, String pw) {
        UserDTO user = null;

        String sql = "SELECT * FROM user WHERE user_id=? AND user_pw=?";

        try {
            getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            pstmt.setString(2, pw);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                user = new UserDTO();
                user.setUserId(rs.getString("user_id"));
                user.setUserPw(rs.getString("user_pw"));
                user.setUserName(rs.getString("user_name"));
                user.setRole(rs.getString("role"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
        return user;
    }

    // ✔ 회원가입 기능
    public int signup(UserDTO dto) {
        int result = 0;

        String sql = "INSERT INTO user(user_id, user_pw, user_name, role) VALUES (?, ?, ?, 'USER')";

        try {
            getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dto.getUserId());
            pstmt.setString(2, dto.getUserPw());
            pstmt.setString(3, dto.getUserName());

            result = pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }

        return result;
    }

    // ✔ 전체 회원 조회 (관리자 최상단)
    public List<UserDTO> getAllUsers() {
        List<UserDTO> list = new ArrayList<>();

        String sql =
            "SELECT * FROM user " +
            "ORDER BY CASE WHEN role = 'ADMIN' THEN 0 ELSE 1 END, user_id ASC";

        try {
            getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                UserDTO dto = new UserDTO();
                dto.setUserId(rs.getString("user_id"));
                dto.setUserPw(rs.getString("user_pw"));
                dto.setUserName(rs.getString("user_name"));
                dto.setRole(rs.getString("role"));
                list.add(dto);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }

        return list;
    }

    // ✔ 특정 회원 조회
    public UserDTO getUserInfo(String id) {
        UserDTO dto = null;

        String sql = "SELECT * FROM user WHERE user_id=?";

        try {
            getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                dto = new UserDTO();
                dto.setUserId(rs.getString("user_id"));
                dto.setUserPw(rs.getString("user_pw"));
                dto.setUserName(rs.getString("user_name"));
                dto.setRole(rs.getString("role"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }

        return dto;
    }

    // ✔ 회원정보 수정 기능
    public int updateUser(UserDTO dto) {
        int result = 0;

        String sql = "UPDATE user SET user_pw=?, user_name=? WHERE user_id=?";

        try {
            getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dto.getUserPw());
            pstmt.setString(2, dto.getUserName());
            pstmt.setString(3, dto.getUserId());

            result = pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }

        return result;
    }

    // ✔ 회원 삭제 기능
    public int deleteUser(String id) {
        int result = 0;

        String sql = "DELETE FROM user WHERE user_id=?";

        try {
            getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);

            result = pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }

        return result;
    }

    // ✔ 검색 기능 (관리자 최상단)
    public List<UserDTO> searchUsers(String keyword) {
        List<UserDTO> list = new ArrayList<>();

        String sql =
            "SELECT * FROM user " +
            "WHERE user_id LIKE ? OR user_name LIKE ? " +
            "ORDER BY CASE WHEN role = 'ADMIN' THEN 0 ELSE 1 END, user_name ASC";

        try {
            getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "%" + keyword + "%");
            pstmt.setString(2, "%" + keyword + "%");
            rs = pstmt.executeQuery();

            while (rs.next()) {
                UserDTO dto = new UserDTO();
                dto.setUserId(rs.getString("user_id"));
                dto.setUserPw(rs.getString("user_pw"));
                dto.setUserName(rs.getString("user_name"));
                dto.setRole(rs.getString("role"));
                list.add(dto);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }

        return list;
    }

    // ✔ 최신가입순 정렬 (관리자 최상단)
    public List<UserDTO> getUsersOrderByLatest() {
        List<UserDTO> list = new ArrayList<>();

        // created_at 컬럼 필수
        String sql =
            "SELECT * FROM user " +
            "ORDER BY CASE WHEN role = 'ADMIN' THEN 0 ELSE 1 END, created_at DESC";

        try {
            getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                UserDTO dto = new UserDTO();
                dto.setUserId(rs.getString("user_id"));
                dto.setUserName(rs.getString("user_name"));
                dto.setUserPw(rs.getString("user_pw"));
                dto.setRole(rs.getString("role"));
                list.add(dto);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }

        return list;
    }

    // ✔ 이름순 정렬 (관리자 최상단)
    public List<UserDTO> getUsersOrderByName() {
        List<UserDTO> list = new ArrayList<>();

        String sql =
            "SELECT * FROM user " +
            "ORDER BY CASE WHEN role = 'ADMIN' THEN 0 ELSE 1 END, user_name ASC";

        try {
            getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                UserDTO dto = new UserDTO();
                dto.setUserId(rs.getString("user_id"));
                dto.setUserName(rs.getString("user_name"));
                dto.setUserPw(rs.getString("user_pw"));
                dto.setRole(rs.getString("role"));
                list.add(dto);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }

        return list;
    }
}
