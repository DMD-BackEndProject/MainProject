<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="dto.UserDTO" %>

<%
    UserDTO user = (UserDTO) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원정보 수정 - Cosméthique</title>

<style>
/* ===== 공통 색상 ===== */
:root {
    --bg: #f9f4f7;
    --pink1: #f2b6c1;
    --pink2: #e7c4d5;
    --text: #2C2025FF;
}

/* 페이지 애니메이션 */
body {
    margin: 0;
    background: var(--bg);
    font-family: "Noto Sans KR", sans-serif;
    animation: fadePage 0.6s ease;
}
@keyframes fadePage {
    from { opacity: 0; transform: translateY(20px); }
    to { opacity: 1; transform: translateY(0); }
}

/* 헤더 */
.header {
    display: flex;
    justify-content: space-between;
    padding: 14px 20px;
    background: rgba(255,255,255,0.7);
    border-bottom: 1px solid #e8d9e3;
    backdrop-filter: blur(10px);
    align-items: center;
}
.logo {
    font-family: 'Didot','Playfair Display', serif;
    font-size: 30px;
    font-weight: 700;
    color: var(--text);
}
.top-menu a {
    margin-left: 20px;
    font-weight: 600;
    color: var(--text);
    text-decoration: none;
}

/* 메인 박스 */
.card {
    width: 500px;
    margin: 80px auto;
    padding: 35px;
    background: rgba(255,255,255,0.8);
    backdrop-filter: blur(6px);
    border-radius: 22px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.15);
    text-align: center;
    animation: cardPop 0.6s ease;
}
@keyframes cardPop {
    from { opacity: 0; transform: scale(0.92); }
    to { opacity: 1; transform: scale(1); }
}

/* 입력창 */
.input {
    width: 80%;
    padding: 12px;
    margin: 12px 0;
    border-radius: 12px;
    border: 1px solid #d7bdca;
    background: #ffffff;
    transition: 0.25s;
}
.input:focus {
    border-color: var(--pink1);
    box-shadow: 0 0 12px rgba(242,182,193,0.4);
    outline: none;
}
/* 아이디(수정불가) */
.input-readonly {
    background: #f0e7ea;
    font-weight: 600;
}

/* 버튼 */
.btn {
    padding: 12px 26px;
    background: linear-gradient(135deg,var(--pink1),var(--pink2));
    border-radius: 14px;
    border: none;
    color: var(--text);
    font-size: 17px;
    font-weight: 600;
    cursor: pointer;
    margin-top: 15px;
    box-shadow: 0 6px 16px rgba(0,0,0,0.15);
    transition: 0.3s;
}
.btn:hover {
    transform: translateY(-4px) scale(1.05);
    box-shadow: 0 0 16px rgba(242,182,193,0.8),
                0 10px 20px rgba(0,0,0,0.25);
}

/* 뒤로가기 버튼 */
.back-btn {
    background: #ffffff;
    border: 1px solid #d7bdca;
}
.back-btn:hover {
    background: #f7ebef;
}
</style>

</head>
<body>

<!-- HEADER -->
<div class="header">
    <div class="logo">Cosméthique</div>
    <div class="top-menu">
        <a href="mypage.jsp">마이페이지</a>
        <a href="logout">로그아웃</a>
    </div>
</div>

<!-- 회원정보 수정 카드 -->
<div class="card">

    <h2 style="color:var(--text); margin-bottom:25px;">회원정보 수정</h2>

    <form action="updateUser" method="post">

       <form action="updateUser" method="post">

    <!-- 아이디(수정불가 + 반드시 name 추가!) -->
    <input type="hidden" name="user_id" value="<%= user.getUserId() %>">

    <input type="text" class="input input-readonly" value="<%= user.getUserId() %>" readonly>

    <!-- 이름 -->
    <input type="text" class="input" name="user_name" value="<%= user.getUserName() %>">

    <!-- 비밀번호(비워두면 기존 비밀번호 유지) -->
    <input type="password" class="input" name="user_pw" placeholder="새 비밀번호(변경 시에만 입력)">


        <!-- 저장 버튼 -->
        <button class="btn" type="submit">저장하기</button>

        <!-- 뒤로가기 -->
       <button type="button" class="btn back-btn" onclick="location.href='<%= request.getContextPath() %>/mypage'">
    뒤로가기
</button>


    </form>
</div>

</body>
</html>
