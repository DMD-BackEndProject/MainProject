<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String ctx = request.getContextPath();

    dto.UserDTO user = (dto.UserDTO) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Cosméthique - AI 피부 분석</title>

    <style>
        :root {
            --bg: #f9f4f7;
            --card: #ffffff;
            --accent: #f2b6c1;
            --accent-deep: #eb7f98;
            --text: #2c2025;
            --muted: #8a7a83;
        }
        * { box-sizing:border-box; margin:0; padding:0; }

        body {
            font-family:"Noto Sans KR",-apple-system,BlinkMacSystemFont,system-ui;
            background:radial-gradient(circle at top,#fff9fb 0,#f9f4f7 45%,#f2e4ee 100%);
            min-height:100vh;
            display:flex;
            flex-direction:column;
            align-items:center;
        }

        .page {
            width:100%;
            max-width:780px;
            padding:24px 32px 40px;
        }

        /* 헤더 */
        .header {
            width:100%;
            display:flex;
            justify-content:space-between;
            align-items:center;
            margin-bottom:28px;
        }
        .logo {
            font-family:"Playfair Display",serif;
            font-size:28px;
            font-weight:700;
            letter-spacing:.08em;
            color:var(--text);
        }
        .header-menu a {
            margin-left:18px;
            font-size:14px;
            text-decoration:none;
            color:var(--muted);
        }
        .header-menu a:hover { color:var(--text); }

        /* 메인 */
        .main {
            display:flex;
            flex-direction:column;
            align-items:center;
        }

        .card {
            background:var(--card);
            border-radius:24px;
            box-shadow:0 18px 40px rgba(15,23,42,0.16);
            padding:24px 24px 28px;
            width:100%;
            max-width:520px;
            display:flex;
            flex-direction:column;
            align-items:center;
            animation:floating 5s ease-in-out infinite;
        }

        @keyframes floating {
            0%,100% { transform:translateY(0); }
            50% { transform:translateY(-6px); }
        }

        .scanner-title {
            font-size:18px;
            font-weight:600;
            margin-bottom:8px;
            color:var(--text);
        }
        .scanner-sub {
            font-size:13px;
            color:var(--muted);
            margin-bottom:18px;
            text-align:center;
        }

        /* 스캐너 크기 확대 */
        .scanner-wrap {
            position:relative;
            width:340px;
            height:340px;
            margin-bottom:18px;
        }

        .scanner-ring {
            position:absolute;
            inset:0;
            border-radius:50%;
            background:conic-gradient(from 0deg,#ffe6f0,#f2bdd0,#e8a6c3,#cf7fa0,#ffe6f0);
            box-shadow:0 18px 40px rgba(0,0,0,0.18);
            display:flex;
            align-items:center;
            justify-content:center;

            /* ★ 회전 애니메이션 제거됨 */
        }

        .scanner-lens {
            width:78%;
            height:78%;
            border-radius:50%;
            background:radial-gradient(circle at 30% 20%,#ffffff 0,#f6f6f8 45%,#d5d8e5 100%);
            overflow:hidden;
            display:flex;
            align-items:center;
            justify-content:center;
            position:relative;
            box-shadow:inset 0 0 12px rgba(0,0,0,0.25);
        }
        .scanner-lens img {
            width:100%;
            height:100%;
            object-fit:cover;
        }

        .scanner-placeholder {
            font-size:14px;
            color:var(--muted);
            text-align:center;
            line-height:1.5;
            padding:0 10px;
        }

        .scanner-lens.drag-over {
            outline:2px dashed var(--accent-deep);
            outline-offset:4px;
        }

        /* 스캔 라인 */
        .scan-line {
            position:absolute;
            left:0;
            right:0;
            height:30%;
            background:linear-gradient(to bottom,
                    rgba(242,182,193,0) 0,
                    rgba(242,182,193,0.5) 50%,
                    rgba(242,182,193,0) 100%);
            transform:translateY(-120%);
            opacity:0;
        }
        .scanner-wrap.scanning .scan-line {
            animation:scan 1.6s ease-in-out infinite;
        }
        @keyframes scan {
            0%   { transform:translateY(-130%); opacity:0; }
            10%  { opacity:1; }
            50%  { transform:translateY(60%); opacity:1; }
            90%  { opacity:1; }
            100% { transform:translateY(130%); opacity:0; }
        }

        /* 퍼센트 원 */
        .percent-circle {
            position:absolute;
            inset:22%;
            border-radius:50%;
            border:3px solid rgba(255,255,255,0.7);
            display:flex;
            align-items:center;
            justify-content:center;
        }
        .percent-text {
            font-size:22px;
            font-weight:600;
            color:var(--text);
        }
        .percent-hidden { opacity:0; }

        /* 버튼 */
        .btn-row {
            display:flex;
            justify-content:center;   /* ★ 버튼 가운데 정렬 */
            gap:14px;
            margin-top:10px;
            width:100%;
        }
        .btn {
            border:none;
            border-radius:999px;
            padding:11px 20px;
            font-size:14px;
            cursor:pointer;
            transition:0.15s;
        }
        .btn-primary {
            background:linear-gradient(135deg,var(--accent-deep),var(--accent));
            color:#fff;
            box-shadow:0 10px 18px rgba(235,127,152,0.4);
        }
        .btn-primary:hover { transform:translateY(-1px); }
        .btn-sub {
            background:#fff;
            color:var(--accent-deep);
            border:1px solid var(--accent);
        }
        .btn-sub:hover { background:#fff4f7; }

        .scan-status {
            margin-top:10px;
            font-size:13px;
            color:var(--muted);
            min-height:18px;
        }
    </style>
</head>
<body>

<div class="page">

    <!-- 헤더 -->
    <header class="header">
        <div class="logo">Cosméthique</div>
        <nav class="header-menu">
            <a href="<%=ctx%>/mypage">마이페이지</a>
            <a href="<%=ctx%>/logout">로그아웃</a>
        </nav>
    </header>

    <!-- 중앙 정렬된 스캐너 -->
    <main class="main">

        <section class="card">

            <div class="scanner-title">AI 피부 스캐너</div>
            <div class="scanner-sub">
                얼굴 사진을 업로드하면 AI가 피부타입을 분석해드립니다.<br>
                (사진 선택 또는 렌즈 위로 드래그&드롭)
            </div>

            <form id="faceForm"
                  action="<%=ctx%>/faceAnalyze"
                  method="POST"
                  enctype="multipart/form-data">

                <div id="scanner" class="scanner-wrap">
                    <div class="scanner-ring">
                        <div id="lens" class="scanner-lens">
                            <div class="scan-line"></div>
                            <div class="percent-circle percent-hidden" id="percentCircle">
                                <span class="percent-text" id="percentText">0%</span>
                            </div>
                            <div id="lensContent" class="scanner-placeholder">
                                얼굴이 나온 이미지를 추가하세요.
                            </div>
                        </div>
                    </div>
                </div>

                <div class="btn-row">
                    <button type="button" class="btn btn-sub" id="uploadBtn">사진 선택</button>
                    <button type="button" class="btn btn-primary" id="analyzeBtn">분석 시작</button>
                </div>

                <div id="scanStatus" class="scan-status"></div>

                <input type="file" id="faceInput" name="faceImage"
                       accept="image/*" style="display:none;">
            </form>

        </section>

    </main>
</div>

<!-- JS (그대로) -->
<script>
    const faceInput   = document.getElementById("faceInput");
    const uploadBtn   = document.getElementById("uploadBtn");
    const analyzeBtn  = document.getElementById("analyzeBtn");
    const lens        = document.getElementById("lens");
    const lensContent = document.getElementById("lensContent");
    const scanner     = document.getElementById("scanner");
    const percentCircle = document.getElementById("percentCircle");
    const percentText   = document.getElementById("percentText");
    const scanStatus    = document.getElementById("scanStatus");

    let selectedFile = null;

    uploadBtn.onclick = () => faceInput.click();
    faceInput.onchange = (e) => loadImage(e.target.files[0]);

    ["dragenter","dragover"].forEach(ev => {
        lens.addEventListener(ev, (e)=>{ 
            e.preventDefault();
            lens.classList.add("drag-over");
        });
    });
    ["dragleave","drop"].forEach(ev => {
        lens.addEventListener(ev, (e)=>{ 
            e.preventDefault();
            lens.classList.remove("drag-over");
        });
    });
    lens.addEventListener("drop", (e)=>{
        e.preventDefault();
        loadImage(e.dataTransfer.files[0]);
    });

    function loadImage(file){
        if (!file) return;
        selectedFile = file;

        let reader = new FileReader();
        reader.onload = (evt)=>{
            lensContent.innerHTML = "";
            let img = document.createElement("img");
            img.src = evt.target.result;
            lensContent.appendChild(img);
        };
        reader.readAsDataURL(file);

        faceInput.files = createFileList(file);
    }

    function createFileList(file){
        const dataTransfer = new DataTransfer();
        dataTransfer.items.add(file);
        return dataTransfer.files;
    }

    analyzeBtn.onclick = () => {
        if (!selectedFile) {
            alert("이미지를 먼저 선택해주세요!");
            return;
        }

        startScanAnimation();

        setTimeout(()=>{
            document.getElementById("faceForm").submit();
        }, 900);
    };

    function startScanAnimation(){
        scanner.classList.add("scanning");
        percentCircle.classList.remove("percent-hidden");
        percentText.textContent = "0%";
        scanStatus.textContent = "피부 분석 중…";

        let percent = 0;
        const timer = setInterval(()=>{
            percent += 3 + Math.random()*4;
            if (percent >= 100) {
                percent = 100;
                clearInterval(timer);
            }
            percentText.textContent = Math.round(percent) + "%";
        }, 120);
    }
</script>

</body>
</html>
