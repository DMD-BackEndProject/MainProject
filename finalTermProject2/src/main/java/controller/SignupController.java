package controller;

import dao.UserDAO;
import dto.UserDTO;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/signup")
public class SignupController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        UserDTO dto = new UserDTO();
        dto.setUserId(req.getParameter("user_id"));
        dto.setUserPw(req.getParameter("user_pw"));
        dto.setUserName(req.getParameter("user_name"));

        UserDAO dao = new UserDAO();
        int result = dao.signup(dto);

        if (result > 0) {
            resp.sendRedirect("login.jsp");
        } else {
            req.setAttribute("error", "회원가입에 실패했습니다. 다시 시도해주세요.");
            req.getRequestDispatcher("signup.jsp").forward(req, resp);
        }
    }
}
