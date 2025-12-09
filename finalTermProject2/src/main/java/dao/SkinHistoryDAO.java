package dao;

import dto.SkinHistoryDTO;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SkinHistoryDAO {

    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    // INSERT 저장
    public void save(SkinHistoryDTO dto) {
        try {
            conn = DBConnection.getConnection();

            String sql = "INSERT INTO skin_history (userId, wrinkle, pore, redness, oil, tone, skinType) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dto.getUserId());
            pstmt.setInt(2, dto.getWrinkle());
            pstmt.setInt(3, dto.getPore());
            pstmt.setInt(4, dto.getRedness());
            pstmt.setInt(5, dto.getOil());
            pstmt.setInt(6, dto.getTone());
            pstmt.setString(7, dto.getSkinType());

            pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBConnection.close(conn, pstmt, rs);
        }
    }


    // 최근 3개 조회
    public List<SkinHistoryDTO> findRecent3(String userId) {
        List<SkinHistoryDTO> list = new ArrayList<>();

        try {
            conn = DBConnection.getConnection();

            String sql = "SELECT * FROM skin_history " +
                         "WHERE userId = ? " +
                         "ORDER BY created_at DESC " +
                         "LIMIT 3";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);

            rs = pstmt.executeQuery();

            while (rs.next()) {
                SkinHistoryDTO dto = new SkinHistoryDTO();

                dto.setId(rs.getInt("id"));
                dto.setUserId(rs.getString("userId"));
                dto.setWrinkle(rs.getInt("wrinkle"));
                dto.setPore(rs.getInt("pore"));
                dto.setRedness(rs.getInt("redness"));
                dto.setOil(rs.getInt("oil"));
                dto.setTone(rs.getInt("tone"));
                dto.setSkinType(rs.getString("skinType"));
                dto.setCreatedAt(rs.getString("created_at"));

                list.add(dto);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBConnection.close(conn, pstmt, rs);
        }

        return list;
    }

    // 전체 기록 조회
    public List<SkinHistoryDTO> findAll(String userId) {
        List<SkinHistoryDTO> list = new ArrayList<>();

        try {
            conn = DBConnection.getConnection();

            String sql = "SELECT * FROM skin_history WHERE userId = ? ORDER BY created_at DESC";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);

            rs = pstmt.executeQuery();

            while (rs.next()) {
                SkinHistoryDTO dto = new SkinHistoryDTO();

                dto.setId(rs.getInt("id"));
                dto.setUserId(rs.getString("userId"));
                dto.setWrinkle(rs.getInt("wrinkle"));
                dto.setPore(rs.getInt("pore"));
                dto.setRedness(rs.getInt("redness"));
                dto.setOil(rs.getInt("oil"));
                dto.setTone(rs.getInt("tone"));
                dto.setSkinType(rs.getString("skinType"));
                dto.setCreatedAt(rs.getString("created_at"));

                list.add(dto);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBConnection.close(conn, pstmt, rs);
        }

        return list;
    }

    // 최근 기록 1개 skinType 가져오기 (추천화장품용)
    public String getLatestSkinType(String userId) {
        String skinType = null;

        String sql = "SELECT skinType FROM skin_history WHERE userId=? ORDER BY created_at DESC LIMIT 1";

        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                skinType = rs.getString("skinType");
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBConnection.close(conn, pstmt, rs);   // ← 수정 포인트
        }

        return skinType;
    }
}
