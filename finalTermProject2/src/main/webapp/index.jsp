<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Cosméthique</title>
<style>
:root {--bg: #f9f4f7;--pink1: #f2b6c1;--pink2: #e7c4d5;--text: #2C2025FF;}

body {
    margin: 0;
    font-family: "Noto Sans KR", sans-serif;
    background: var(--bg);
    height: 100vh;
    overflow: hidden;
    display: flex;
    flex-direction: column;
    align-items: center;
    position: relative;
}

/* === 감성 배경 이미지 === */
body::before {
    content: "";
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: url("/finalTermProject2/img/background.png") no-repeat center/cover;
    filter: brightness(0.92) blur(2px);
    z-index: -1;
}


/* 중앙 콘텐츠 */
.main-wrapper {
    margin-top: calc(50vh - 180px);
    text-align: center;
    animation: fadeIn 1.2s ease;
}

/* 로고 */
.logo {
    font-family: 'Didot','Playfair Display',serif;
    font-size: 46px;
    font-weight: 700;
    color: var(--text);
    letter-spacing: 1.5px;
    margin-bottom: 15px;
}

/* 설명 문장 */
.sub-text {
    font-size: 16px;
    color: #5b4b52;
    line-height: 1.6;
    margin-bottom: 35px;
}

/* 버튼 컨테이너 */
.btn-group {
    display: flex;
    justify-content: center;
    gap: 20px;
}

/* 로그인/회원가입 버튼 */
.main-btn {
    width: 150px;
    padding: 14px 0;
    border-radius: 14px;
    border: none;
    background: linear-gradient(135deg, var(--pink1), var(--pink2));
    color: var(--text);
    font-size: 17px;
    font-weight: 600;
    cursor: pointer;
    box-shadow: 0 4px 14px rgba(0,0,0,0.15);
    transition: 0.35s ease;
}

/* 호버 애니메이션 */
.main-btn:hover {
    transform: translateY(-6px) scale(1.05);
    box-shadow: 0 10px 22px rgba(0,0,0,0.25);
}

/* 등장 애니메이션 */
@keyframes fadeIn {
    from { opacity: 0; transform: translateY(25px);}
    to { opacity: 1; transform: translateY(0);}
}
</style>
</head>

<body>
<div class="main-wrapper">
    
    <!-- 로고 -->
    <div class="logo">Cosméthique</div>

    <!-- 설명 문구 -->
    <div class="sub-text">
        코스메띠끄는 얼굴 분석 기술로<br>
        피부의 필요와 어울림의 기준을 단순하고 명확하게 제시합니다.<br>
        당신에게 맞는 화장품 선택, 그 시작을 더 스마트하게.
    </div>

    <!-- 버튼 -->
    <div class="btn-group">
        <button class="main-btn" onclick="location.href='login.jsp'">로그인</button>
        <button class="main-btn" onclick="location.href='signup.jsp'">회원가입</button>
    </div>

</div>
</body>
</html>
