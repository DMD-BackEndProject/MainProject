<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, dao.UserDAO, dto.UserDTO" %>

<%
    UserDTO admin = (UserDTO) session.getAttribute("user");

    if (admin == null || !"ADMIN".equals(admin.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    // 검색/정렬 결과
    List<UserDTO> list = (List<UserDTO>) request.getAttribute("userList");

    // 처음 접속 시 모든 유저 출력
    if (list == null) {
        UserDAO dao = new UserDAO();
        list = dao.getAllUsers();
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원관리 - Cosméthique Admin</title>

<style>
/* ===== 공통 색상 ===== */
:root {
    --bg: #f9f4f7;
    --pink1: #f2b6c1;
    --pink2: #e7c4d5;
    --text: #2C2025FF;
}

/* 페이지 fade */
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

/* ===== 헤더 ===== */
.header {
    display: flex;
    justify-content: space-between;
    padding: 14px 20px;
    background: rgba(255,255,255,0.7);
    border-bottom: 1px solid #e8d9e3;
    backdrop-filter: blur(8px);
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

/* ===== 메인 컨테이너 ===== */
.container {
    width: 900px;
    margin: 50px auto;
    text-align: center;
}

/* ===== 카드 ===== */
.card {
    padding: 30px;
    background: rgba(255,255,255,0.75);
    border-radius: 22px;
    backdrop-filter: blur(6px);
    box-shadow: 0 10px 30px rgba(0,0,0,0.15);
    margin-bottom: 40px;
    animation: cardPop 0.6s ease;
}
@keyframes cardPop {
    from { opacity: 0; transform: scale(0.92); }
    to { opacity: 1; transform: scale(1); }
}
.card h2 {
    margin-bottom: 22px;
    color: var(--text);
}

/* ===== 입력창 ===== */
.input {
    width: 60%;
    padding: 12px;
    border-radius: 14px;
    border: 1px solid #d3b8c4;
    margin-bottom: 18px;
    background: #fff;
    transition: 0.2s;
}
.input:focus {
    border-color: var(--pink1);
    box-shadow: 0 0 12px rgba(242,182,193,0.5);
    outline: none;
}

/* ===== 버튼 ===== */
.btn {
    position: relative;
    padding: 12px 24px;
    background: linear-gradient(135deg,var(--pink1),var(--pink2));
    border-radius: 14px;
    border: none;
    color: var(--text);
    font-size: 16px;
    font-weight: 600;
    cursor: pointer;
    margin: 6px;
    box-shadow: 0 6px 18px rgba(0,0,0,0.15);
    transition: 0.3s;
    overflow: hidden;
}
.btn:hover {
    transform: translateY(-4px) scale(1.05);
    box-shadow: 0 0 15px rgba(242,182,193,0.8);
}

/* ripple effect */
.btn:active::after {
    content: "";
    position: absolute;
    background: rgba(255,255,255,0.45);
    width: 0; height: 0;
    border-radius: 50%;
    top: 50%; left: 50%;
    transform: translate(-50%,-50%);
    opacity: 0;
    animation: ripple 0.6s ease-out;
}
@keyframes ripple {
    from { width:0; height:0; opacity:0.8; }
    to { width:260px; height:260px; opacity:0; }
}

/* ===== 테이블 ===== */
table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 15px;
}
th, td {
    padding: 14px;
    border-bottom: 1px solid #e9d5df;
    color: var(--text);
}
th {
    background: rgba(255,255,255,0.6);
    font-size: 17px;
}
tr:hover {
    background: #f7ecf1;
}
.delete-btn {
    background: #e0738b;
    border: none;
    padding: 8px 14px;
    border-radius: 10px;
    color: #fff;
    cursor: pointer;
    transition: 0.2s;
}
.delete-btn:hover {
    background: #d45c77;
}

</style>
</head>

<body>

<!-- HEADER -->
<div class="header">
    <div class="logo">Cosméthique Admin</div>
    <div class="top-menu">
        <a href="logout">로그아웃</a>
    </div>
</div>

<!-- MAIN -->
<div class="container">

    <!-- 검색 / 정렬 -->
    <div class="card">
        <h2>회원 검색 & 정렬</h2>

        <form action="searchUser" method="get">
            <input class="input" type="text" name="keyword" placeholder="아이디 또는 이름 입력">
            <button class="btn">검색</button>
        </form>

        <form action="orderUser" method="get">
            <button class="btn" name="type" value="latest">최신 가입순</button>
            <button class="btn" name="type" value="name">이름 순</button>
        </form>
    </div>

    <!-- 회원 목록 -->
    <div class="card">
        <h2>회원 목록</h2>

        <% if (list == null || list.isEmpty()) { %>

            <p style="color:#6d5160;">검색 결과가 없습니다.</p>

        <% } else { %>

        <table>
            <tr>
                <th>아이디</th>
                <th>이름</th>
                <th>권한</th>
                <th>관리</th>
            </tr>

            <% for (UserDTO u : list) { %>
            <tr>
                <td><%= u.getUserId() %></td>
                <td><%= u.getUserName() %></td>
                <td><%= u.getRole() %></td>

                <td>
                    <% if (!"ADMIN".equals(u.getRole())) { %>
                        <form action="deleteUser" method="post" style="display:inline;">
                            <input type="hidden" name="id" value="<%= u.getUserId() %>">
                            <button class="delete-btn">삭제</button>
                        </form>
                    <% } else { %>
                        -
                    <% } %>
                </td>
            </tr>
            <% } %>
        </table>

        <% } %>

    </div>
</div>

</body>
</html>
