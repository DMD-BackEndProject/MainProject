package controller;

import dao.UserDAO;
import dto.UserDTO;
import java.io.IOException;

// Tomcat 9 = javax.servlet
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String id = req.getParameter("user_id");
        String pw = req.getParameter("user_pw");

        UserDAO dao = new UserDAO();
        UserDTO user = dao.login(id, pw);

        if (user != null) {

            HttpSession session = req.getSession();
            session.setAttribute("user", user);

            if ("ADMIN".equals(user.getRole())) {
                // 관리자 → 회원관리 화면으로 바로 이동
                resp.sendRedirect("adminUserManage.jsp");
            } else {
                // 일반 사용자 → 메인 화면
                resp.sendRedirect("userMain.jsp");
            }

        } else {
            req.setAttribute("error", "아이디 또는 비밀번호가 올바르지 않습니다.");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        }
    }
}
