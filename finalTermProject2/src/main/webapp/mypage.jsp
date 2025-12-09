<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="dto.UserDTO, java.util.*" %>

<%
    UserDTO user = (UserDTO) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<String> history = (List<String>) request.getAttribute("history");
    List<String> allergy = (List<String>) request.getAttribute("allergy");
    String skinType = (String) request.getAttribute("skinType");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>My Page - Cosméthique</title>

<style>
/* === 색상 테마 === */
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

/* === 헤더 === */
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

/* === 카드 공통 === */
.card {
    width: 700px;
    margin: 40px auto;
    padding: 28px;
    background: rgba(255,255,255,0.75);
    border-radius: 22px;
    backdrop-filter: blur(6px);
    box-shadow: 0 10px 30px rgba(0,0,0,0.15);
    animation: cardPop 0.6s ease;
    text-align: center;
}
@keyframes cardPop {
    from { opacity: 0; transform: scale(0.92); }
    to { opacity: 1; transform: scale(1); }
}

/* === 제목 === */
.card h3 {
    color: var(--text);
    font-weight: 700;
    margin-bottom: 18px;
}

/* === 버튼 === */
.btn {
    position: relative;
    padding: 12px 26px;
    background: linear-gradient(135deg,var(--pink1),var(--pink2));
    border-radius: 14px;
    border: none;
    color: var(--text);
    font-size: 16px;
    font-weight: 600;
    cursor: pointer;
    margin-top: 12px;
    box-shadow: 0 6px 16px rgba(0,0,0,0.15);
    transition: 0.3s;
    overflow: hidden;
}

/* hover glow */
.btn:hover {
    transform: translateY(-4px) scale(1.05);
    box-shadow: 0 0 15px rgba(242,182,193,0.8),
                0 10px 20px rgba(0,0,0,0.25);
}

/* ripple */
.btn:active::after {
    content: "";
    position: absolute;
    background: rgba(255,255,255,0.45);
    width: 0; height: 0;
    border-radius: 50%;
    top: 50%; left: 50%;
    transform: translate(-50%,-50%) scale(1);
    opacity: 0;
    animation: ripple 0.6s ease-out;
}
@keyframes ripple {
    from { width:0; height:0; opacity:0.8; }
    to { width:260px; height:260px; opacity:0; }
}

/* 삭제 버튼 */
.delete-link {
    color: #d05c73;
    font-weight: 600;
    margin-left: 10px;
    text-decoration: none;
    transition: 0.2s;
}
.delete-link:hover {
    color: #e27c90;
}

</style>
</head>

<body>

<!-- HEADER -->
<div class="header">
    <div class="logo">Cosméthique</div>
    <div class="top-menu">
        <a href="userMain.jsp">홈</a>
        <a href="logout">로그아웃</a>
    </div>
</div>

<div class="card">
    <h3>회원정보 수정하기</h3>
    <button class="btn" onclick="location.href='updateUser.jsp'">회원정보 수정</button>
</div>

<!-- 피부 진단 다시하기 -->
<div class="card">
    <h3>피부 진단 다시하기</h3>
    <button class="btn" onclick="location.href='userMain.jsp'">AI 피부 분석하기</button>
</div>

<%
    List<dto.ProductDTO> recommendList =
        (List<dto.ProductDTO>) request.getAttribute("recommendList");
%>

<div class="card">
    <h3>맞춤 추천 화장품</h3>

    <% if (skinType == null) { %>
        <p>아직 피부 분석 기록이 없습니다.</p>

    <% } else { %>

        <p><b>최근 피부 타입:</b> <%= skinType %></p>

        <% if (recommendList == null || recommendList.isEmpty()) { %>
            <p>추천 가능한 제품이 없습니다.</p>

        <% } else { %>

            <div style="margin-top:20px;">

            <% for (dto.ProductDTO p : recommendList) { 
                String imgFile = p.getImageUrl();
                if (imgFile != null && imgFile.startsWith("/img/")) {
                    imgFile = imgFile.substring(5); 
                }
            %>
                <div style="margin-bottom:30px;">

                    <p><b>제품명:</b> <%= p.getName() %></p>
                    <p><b>카테고리:</b> <%= p.getCategory() %></p>
                    <p><b>설명:</b> <%= p.getInfo() %></p>

                    <% if (imgFile != null && !imgFile.isEmpty()) { %>
                        <img src="<%= request.getContextPath() %>/img/<%= imgFile %>"
                             alt="제품 이미지"
                             style="width:140px; border-radius:14px; margin-top:12px;">
                    <% } else { %>
                        <p style="color:gray;">이미지 없음</p>
                    <% } %>

                    <hr style="margin-top:20px;">
                </div>
            <% } %>

            </div>

        <% } %>

    <% } %>
</div>




<!-- 피부 히스토리 -->
<div class="card">
    <h3>내 피부 기록 (최근 3개)</h3>

    <%
        List<dto.SkinHistoryDTO> historyList =
            (List<dto.SkinHistoryDTO>) request.getAttribute("historyList");

        if (historyList == null || historyList.isEmpty()) {
    %>
        <p>피부 분석 기록이 없습니다.</p>

    <% } else {
           for (dto.SkinHistoryDTO h : historyList) {
    %>
        <div>
            <p>피부 타입: <%= h.getSkinType() %></p>
            <p>주름: <%= h.getWrinkle() %> / 모공: <%= h.getPore() %> / 홍조: <%= h.getRedness() %></p>
            <p>유분: <%= h.getOil() %> / 톤: <%= h.getTone() %></p>
            <p>날짜: <%= h.getCreatedAt() %></p>
            <hr>
        </div>

    <%   }
       } %>

    <button class="btn" onclick="location.href='historyAll'">전체 기록 보기</button>
</div>

</body>
</html>
