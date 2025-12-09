<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="dto.ProductDTO" %>

<%
    String ctx = request.getContextPath();

    // 컨트롤러에서 넘어온 값들
    Integer wrinkle = (Integer)request.getAttribute("wrinkle");
    Integer pore = (Integer)request.getAttribute("pore");
    Integer redness = (Integer)request.getAttribute("redness");
    Integer oil = (Integer)request.getAttribute("oil");
    Integer tone = (Integer)request.getAttribute("tone");
    String error = (String)request.getAttribute("error");
    String skinType = (String)request.getAttribute("skinType");

    // DB 추천 제품 리스트
    List<ProductDTO> items = (List<ProductDTO>) request.getAttribute("items");

    // 설명 생성
    String wrinkleDesc="", poreDesc="", rednessDesc="", oilDesc="", toneDesc="";

    if (error == null) {
        wrinkleDesc = (wrinkle <= 30) ? "주름이 적고 탄력이 좋습니다."
                    : (wrinkle <= 60) ? "보통 수준의 탄력입니다."
                    : "탄력이 떨어져 관리가 필요합니다.";

        poreDesc = (pore <= 30) ? "모공이 작고 깔끔합니다."
                 : (pore <= 60) ? "보통 수준의 모공입니다."
                 : "모공이 넓어 관리가 필요합니다.";

        rednessDesc = (redness <= 30) ? "홍조가 거의 없고 안정적입니다."
                    : (redness <= 60) ? "약간의 홍조가 있습니다."
                    : "홍조가 강해 진정 케어가 필요합니다.";

        oilDesc = (oil <= 30) ? "피부가 건조한 편입니다. 수분 공급이 필요합니다."
                : (oil <= 60) ? "유수분 밸런스가 좋습니다."
                : "유분이 많은 편입니다. 산뜻한 케어가 필요합니다.";

        toneDesc = (tone <= 30) ? "칙칙한 편이며 브라이트닝이 필요합니다."
                 : (tone <= 60) ? "보통 밝기의 피부입니다."
                 : "피부 톤이 밝고 생기 있습니다.";
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>AI 피부 분석 결과</title>

    <style>
        :root {
            --bg: #f9f4f7;
            --card: #ffffff;
            --accent: #f2b6c1;
            --accent-deep: #eb7f98;
            --text: #2c2025;
            --muted: #8a7a83;
        }

        body {
            background: radial-gradient(circle at 20% 10%, #fff8fb 0%, #fbe9f1 45%, #f2d7e5 100%);
            font-family: "Noto Sans KR", sans-serif;
            display:flex;
            justify-content:center;
            padding:40px 20px;
            backdrop-filter: blur(8px);
        }

        .container {
            width:100%;
            max-width:860px;
            background:var(--card);
            padding:34px 38px 46px;
            border-radius:28px;
            box-shadow:0 18px 40px rgba(15,23,42,0.12),
                       0 10px 25px rgba(235,127,152,0.18);
            animation: fadeIn 0.6s ease;
        }

        @keyframes fadeIn {
            from { opacity:0; transform:translateY(10px); }
            to   { opacity:1; transform:translateY(0); }
        }

        h2 {
            font-size:26px;
            font-weight:700;
            color:var(--text);
            margin-bottom:20px;
        }

        h3 {
            font-size:18px;
            color:var(--accent-deep);
            margin-bottom:12px;
            font-weight:600;
        }

        .box {
            background:#fff7fa;
            padding:20px 24px;
            border-radius:18px;
            box-shadow:0 6px 18px rgba(235, 127, 152, 0.10);
            margin-bottom:20px;
            line-height:1.55;
            color:var(--text);
        }

        .product-item {
            display:flex;
            align-items:center;
            gap:16px;
            padding:16px 0;
            border-bottom:1px solid #f3d9e4;
        }
        .product-item:last-child { border-bottom:none; }

        .product-img {
            width:85px;
            height:85px;
            border-radius:14px;
            object-fit:cover;
            box-shadow:0 6px 14px rgba(0,0,0,0.15);
        }

        .product-name {
            font-size:16px;
            font-weight:700;
            color:var(--text);
        }

        .product-desc {
            font-size:13px;
            color:var(--muted);
            margin-top:5px;
        }

        .btn-back {
            display:inline-block;
            margin-top:25px;
            padding:12px 22px;
            border-radius:999px;
            background:linear-gradient(135deg, var(--accent-deep), var(--accent));
            color:#fff;
            font-size:14px;
            font-weight:600;
            text-decoration:none;
            box-shadow:0 10px 18px rgba(235,127,152,0.35);
            transition:0.25s ease;
        }
        .btn-back:hover {
            transform:translateY(-2px);
            box-shadow:0 14px 22px rgba(235,127,152,0.45);
        }

        .error-box {
            background:#ffe2e9;
            color:#a12d48;
            padding:16px;
            border-radius:16px;
            margin-bottom:20px;
        }

    </style>
</head>

<body>
<div class="container">

    <h2>AI 피부 분석 결과</h2>

    <% if (error != null) { %>
        <div class="error-box"><%= error %></div>
    <% } else { %>

        <!-- 수치 결과 -->
        <div class="box">
            <p><strong>주름:</strong> <%= wrinkle %></p>
            <p><strong>모공:</strong> <%= pore %></p>
            <p><strong>홍조:</strong> <%= redness %></p>
            <p><strong>유분:</strong> <%= oil %></p>
            <p><strong>톤 밝기:</strong> <%= tone %></p>
        </div>

        <!-- 피부 타입 -->
        <h3>피부 타입</h3>
        <div class="box"><strong><%= skinType %></strong></div>

        <!-- 상세 설명 -->
        <h3>분석 설명</h3>
        <div class="box">
            <p>• <%= wrinkleDesc %></p>
            <p>• <%= poreDesc %></p>
            <p>• <%= rednessDesc %></p>
            <p>• <%= oilDesc %></p>
            <p>• <%= toneDesc %></p>
        </div>

        <!-- 바르는 순서 -->
        <h3>바르는 순서 (스킨케어 루틴)</h3>
        <div class="box">
            <% if (skinType.contains("지성")) { %>
                <p>1. 약산성 클렌저</p>
                <p>2. 모공 수축 토너</p>
                <p>3. 진정 세럼</p>
                <p>4. 산뜻한 젤 크림</p>
                <p>5. 선크림</p>
            <% } else if (skinType.contains("건성")) { %>
                <p>1. 크림 클렌저</p>
                <p>2. 수분 진정 토너</p>
                <p>3. 히알루론산 세럼</p>
                <p>4. 고보습 크림</p>
                <p>5. 선크림</p>
            <% } else if (skinType.contains("민감")) { %>
                <p>1. 저자극 클렌저</p>
                <p>2. 진정 토너</p>
                <p>3. 병풀 세럼</p>
                <p>4. 진정 크림</p>
                <p>5. 무기자차</p>
            <% } else { %>
                <p>1. 데일리 클렌저</p>
                <p>2. 보습 토너</p>
                <p>3. 데일리 세럼</p>
                <p>4. 수분 크림</p>
                <p>5. 선크림</p>
            <% } %>
        </div>

        <!-- 추천 화장품 -->
        <h3>추천 화장품</h3>
        <div class="box">

        <% if (items != null && !items.isEmpty()) { %>
            <% for (ProductDTO p : items) { %>
                <div class="product-item">
                    <%-- ★ 수정된 이미지 경로 (이미지 정상 출력) ★ --%>
                    <img src="<%= ctx + p.getImageUrl() %>" class="product-img">

                    <div>
                        <div class="product-name"><%= p.getName() %></div>
                        <div class="product-desc"><%= p.getInfo() %></div>
                    </div>
                </div>
            <% } %>
        <% } else { %>
            <p style="color:var(--muted);">등록된 추천 화장품이 없습니다.</p>
        <% } %>

        </div>

        <div style="text-align:center;">
            <a href="<%= ctx %>/mypage" class="btn-back">← 마이페이지</a>
        </div>

    <% } %>

</div>
</body>
</html>
