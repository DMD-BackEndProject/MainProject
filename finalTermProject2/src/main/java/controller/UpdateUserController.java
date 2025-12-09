package controller;

import dao.UserDAO;
import dto.UserDTO;
import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/updateUser")
public class UpdateUserController extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
	        throws ServletException, IOException {

	    req.setCharacterEncoding("UTF-8");

	    HttpSession session = req.getSession();
	    UserDTO sessionUser = (UserDTO) session.getAttribute("user");

	    UserDTO dto = new UserDTO();
	    dto.setUserId(req.getParameter("user_id"));
	    dto.setUserName(req.getParameter("user_name"));

	    String newPw = req.getParameter("user_pw");

	    // 비밀번호 비어있으면 기존 비밀번호 유지
	    if (newPw == null || newPw.trim().equals("")) {
	        dto.setUserPw(sessionUser.getUserPw());
	    } else {
	        dto.setUserPw(newPw);
	    }

	    UserDAO dao = new UserDAO();
	    int result = dao.updateUser(dto);

	    if (result > 0) {
	        // 세션 업데이트
	        session.setAttribute("user", dto);
	        resp.sendRedirect("mypage.jsp");
	    } else {
	        resp.sendRedirect("error.jsp");
	    }
	}
	}
