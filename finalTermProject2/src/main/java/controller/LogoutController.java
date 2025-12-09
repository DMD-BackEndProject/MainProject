package controller;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.ServletException;
import java.io.IOException;

@WebServlet("/logout")
public class LogoutController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.getSession().invalidate();
        resp.sendRedirect("index.jsp");
    }
}
