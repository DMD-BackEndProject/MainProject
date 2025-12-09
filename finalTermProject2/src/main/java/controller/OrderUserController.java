package controller;

import dao.UserDAO;
import dto.UserDTO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/orderUser")
public class OrderUserController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String type = req.getParameter("type");
        UserDAO dao = new UserDAO();

        List<UserDTO> list = null;

        // 최신 가입순
        if ("latest".equals(type)) {
            list = dao.getUsersOrderByLatest();

        // 이름순
        } else if ("name".equals(type)) {
            list = dao.getUsersOrderByName();
        }

        req.setAttribute("userList", list);
        req.getRequestDispatcher("adminUserManage.jsp").forward(req, resp);
    }
}
