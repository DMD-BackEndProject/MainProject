<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원가입 - Cosméthique</title>

<style>
/* === 전체 색상 === */
:root {
    --bg: #f9f4f7;
    --pink1: #f2b6c1;
    --pink2: #e7c4d5;
    --text: #2C2025FF;
}

/* === 페이지 fade-in === */
body {
    margin: 0;
    background: var(--bg);
    font-family: "Noto Sans KR", sans-serif;
    animation: fadePage 0.6s ease;
}

@keyframes fadePage {
    from { opacity: 0; transform: translateY(15px); }
    to { opacity: 1; transform: translateY(0); }
}

/* === 회원가입 박스 === */
.signup-box {
    width: 450px;
    margin: 95px auto;
    padding: 35px;
    background: rgba(255, 255, 255, 0.85);
    backdrop-filter: blur(6px);
    border-radius: 20px;
    box-shadow: 0 12px 32px rgba(0,0,0,0.15);
    text-align: center;
    animation: scaleIn 0.6s ease;
}

@keyframes scaleIn {
    from { opacity: 0; transform: scale(0.88); }
    to { opacity: 1; transform: scale(1); }
}

/* === 로고 === */
.logo {
    font-family: 'Didot','Playfair Display', serif;
    font-size: 38px;
    font-weight: 700;
    color: var(--text);
    margin-bottom: 25px;
    cursor: pointer;
}

/* === 입력창 === */
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
    outline: none;
    border-color: var(--pink1);
    box-shadow: 0 0 12px rgba(242,182,193,0.4);
}

/* === 버튼 스타일 === */
.btn {
    position: relative;
    padding: 12px 26px;
    background: linear-gradient(135deg,var(--pink1),var(--pink2));
    border-radius: 14px;
    color: var(--text);
    border: none;
    font-size: 17px;
    font-weight: 600;
    cursor: pointer;
    margin-top: 15px;
    width: 70%;
    box-shadow: 0 6px 16px rgba(0,0,0,0.15);
    transition: 0.3s ease;
    overflow: hidden;
}

/* hover glow */
.btn:hover {
    transform: translateY(-6px) scale(1.05);
    box-shadow: 0 0 15px rgba(242,182,193,0.8),
                0 10px 22px rgba(0,0,0,0.25);
}

/* ripple animation */
.btn:active::after {
    content: "";
    position: absolute;
    background: rgba(255,255,255,0.45);
    width: 0; height: 0;
    border-radius: 50%;
    top: 50%; left: 50%;
    transform: translate(-50%, -50%) scale(1);
    opacity: 0;
    animation: ripple 0.6s ease-out;
}

@keyframes ripple {
    from { width: 0; height: 0; opacity: 0.9; }
    to { width: 250px; height: 250px; opacity: 0; }
}

/* 뒤로가기 버튼 */
.back-btn {
    margin-top: 10px;
    background: #ffffff;
    border: 1px solid #d7bdca;
}
.back-btn:hover {
    background: #f7ebef;
    transform: translateY(-4px);
}

/* 에러메시지 */
.error {
    color: #d75f76;
    font-size: 14px;
}
</style>

</head>
<body>

<div class="signup-box">

    <!-- 로고 -->
    <div class="logo" onclick="location.href='index.jsp'">Cosméthique</div>

    <% if (request.getAttribute("error") != null) { %>
        <div class="error"><%= request.getAttribute("error") %></div>
    <% } %>

    <!-- 회원가입 폼 -->
    <form action="signup" method="post">
        <input class="input" type="text" name="user_id" placeholder="아이디">
        <input class="input" type="password" name="user_pw" placeholder="비밀번호">
        <input class="input" type="text" name="user_name" placeholder="이름">

        <button class="btn">회원가입</button>

        <!-- 뒤로가기 버튼 -->
        <button type="button" class="btn back-btn" onclick="location.href='login.jsp'">
            뒤로가기
        </button>
    </form>

</div>

</body>
</html>
