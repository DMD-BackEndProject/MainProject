package controller;

import dao.UserDAO;
import dto.UserDTO;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/searchUser")
public class SearchUserController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException {

        String keyword = req.getParameter("keyword");

        UserDAO dao = new UserDAO();
        List<UserDTO> list = dao.searchUsers(keyword);

        req.setAttribute("userList", list);
        req.getRequestDispatcher("adminUserManage.jsp").forward(req, resp);
    }
}
