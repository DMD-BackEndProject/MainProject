package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.SkinHistoryDAO;
import dao.ProductDAO;
import dto.SkinHistoryDTO;
import dto.ProductDTO;
import dto.UserDTO;

@WebServlet("/mypage")
public class MyPageController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        SkinHistoryDAO historyDAO = new SkinHistoryDAO();

        // 🔥 최근 피부 타입 가져오기
        String latestSkinType = historyDAO.getLatestSkinType(user.getUserId());
        req.setAttribute("skinType", latestSkinType);

        // 🔥 추천 제품 조회
        if (latestSkinType != null) {
            ProductDAO pdao = new ProductDAO();
            List<ProductDTO> recommendList = pdao.findBySkinType(latestSkinType);
            req.setAttribute("recommendList", recommendList);
        }

        // 🔥 최근 3개 피부 기록
        List<SkinHistoryDTO> historyList = historyDAO.findRecent3(user.getUserId());
        req.setAttribute("historyList", historyList);

        req.getRequestDispatcher("mypage.jsp").forward(req, resp);
    }
}
