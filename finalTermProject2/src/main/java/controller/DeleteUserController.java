package controller;

import dao.UserDAO;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/deleteUser")
public class DeleteUserController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException {

        String id = req.getParameter("id");

        UserDAO dao = new UserDAO();
        dao.deleteUser(id);

        resp.sendRedirect("searchUser");  // 갱신
    }
}
