package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.SkinHistoryDAO;
import dto.SkinHistoryDTO;
import dto.UserDTO;

@WebServlet("/historyAll")
public class HistoryAllController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        SkinHistoryDAO dao = new SkinHistoryDAO();
        List<SkinHistoryDTO> list = dao.findAll(user.getUserId());

        req.setAttribute("list", list);

        req.getRequestDispatcher("historyAll.jsp").forward(req, resp);
    }
}
