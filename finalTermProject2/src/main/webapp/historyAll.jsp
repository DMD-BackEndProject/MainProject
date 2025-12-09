<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, dto.SkinHistoryDTO" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 피부 기록</title>
<style>
body {
    background: #f9f4f7;
    font-family: "Noto Sans KR", sans-serif;
}
.card {
    width: 700px;
    margin: 30px auto;
    padding: 20px;
    background: white;
    border-radius: 15px;
    box-shadow: 0 10px 25px rgba(0,0,0,0.1);
}
h2 { text-align: center; }
.record {
    margin-bottom: 20px;
    padding-bottom: 12px;
    border-bottom: 1px solid #ddd;
}
.btn-back {
    display: block;
    margin: 25px auto;
    width: 200px;
    padding: 12px;
    text-align: center;
    background: #f2b6c1;
    border-radius: 10px;
    color: #333;
    font-weight: bold;
    text-decoration: none;
}
</style>
</head>

<body>

<div class="card">
    <h2>전체 피부 기록</h2>

    <%
        List<SkinHistoryDTO> list = (List<SkinHistoryDTO>) request.getAttribute("list");

        if (list == null || list.isEmpty()) {
    %>
        <p>피부 분석 기록이 없습니다.</p>

    <%
        } else {
            for (SkinHistoryDTO h : list) {
    %>
        <div class="record">
            <p><b>피부 타입:</b> <%= h.getSkinType() %></p>
            <p>주름: <%= h.getWrinkle() %> / 모공: <%= h.getPore() %> / 홍조: <%= h.getRedness() %></p>
            <p>유분: <%= h.getOil() %> / 톤: <%= h.getTone() %></p>
            <p><small><%= h.getCreatedAt() %></small></p>
        </div>
    <%
            }
        }
    %>

    <a href="mypage" class="btn-back">← 마이페이지로 돌아가기</a>
</div>

</body>
</html>
