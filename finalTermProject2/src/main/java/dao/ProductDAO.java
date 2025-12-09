package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import dto.ProductDTO;
import util.DBConnection;

public class ProductDAO {

    Connection conn;
    PreparedStatement ps;
    ResultSet rs;

    public ProductDAO() {
        conn = DBConnection.getConnection();   // DB 연결
    }

    public List<ProductDTO> findBySkinType(String skinType) {
        List<ProductDTO> list = new ArrayList<>();

        String sql = "SELECT * FROM product WHERE skin_type=?";

        try {
            ps = conn.prepareStatement(sql);
            ps.setString(1, skinType);

            rs = ps.executeQuery();

            while (rs.next()) {
                ProductDTO dto = new ProductDTO();

                dto.setProductId(rs.getInt("product_id"));
                dto.setName(rs.getString("name"));
                dto.setCategory(rs.getString("category"));
                dto.setSkinType(rs.getString("skin_type"));
                dto.setImageUrl(rs.getString("image_url"));
                dto.setInfo(rs.getString("info"));

                list.add(dto);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
