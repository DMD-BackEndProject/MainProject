<!-- 헤더 타이틀 -->
<h1 align="center">✨ Cosméthique – AI 피부 분석 & 맞춤 화장품 추천 서비스 ✨</h1>

<p align="center">
  <img src="https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white"/>
  <img src="https://img.shields.io/badge/Tomcat-FF9900?style=for-the-badge&logo=apachetomcat&logoColor=white"/>
  <img src="https://img.shields.io/badge/MySQL-00758F?style=for-the-badge&logo=mysql&logoColor=white"/>
  <img src="https://img.shields.io/badge/MVC-6A5ACD?style=for-the-badge"/>
  <img src="https://img.shields.io/badge/Face++ API-1E90FF?style=for-the-badge"/>
</p>

<p align="center">
  <strong>AI 피부 분석 → 개인 맞춤 화장품 추천까지!</strong><br>
  Tomcat 9 + Java MVC + MySQL 기반 백엔드 프로젝트
</p>

---

## 🌸 프로젝트 소개

**Cosméthique**는 사용자의 얼굴 사진을 AI로 분석하여  
주름 · 모공 · 홍조 · 유분 · 피부 톤을 측정하고,  
이를 기반으로 **가장 적합한 화장품을 추천하는 웹 서비스**입니다.

<p align="center">
  <img src="https://img.shields.io/badge/AI Skin Analyzer-Face++-pink?style=flat-square"/>
</p>

---

## 🚩 주요 기능 (Features)

### 🔍 1. **AI 피부 분석**
- Face++ API 기반 정밀 분석
- 5개 피부 지표 자동 평가  
  ✔ Wrinkle (주름)  
  ✔ Pore (모공)  
  ✔ Redness (홍조)  
  ✔ Oiliness (유분)  
  ✔ Skin Tone (톤)
- 분석 점수에 따른 자동 설명 생성

---

### 🎁 2. **맞춤형 화장품 추천**
- 피부 분석 데이터를 기반으로 DB 매칭
- 카테고리별 추천 알고리즘 적용
- 제품 이미지 / 상세 설명 / 링크 제공

---

### 👤 3. **회원 시스템**
- 회원가입 · 로그인 · 로그아웃
- 개인별 분석 기록 제공
- 회원 정보 수정 가능

---

### 🎨 4. **UI/UX 디자인**
- 따뜻한 파스텔 톤 UI
- 카드형 분석 리포트
- CSS 애니메이션을 통한 부드러운 모션

---

## 🏗️ 아키텍처 (Architecture)

```plaintext
📦 Cosméthique Project
├── controller      # Servlet 요청 처리
├── dao             # DB CRUD
├── dto             # 데이터 전달 객체
├── util            # Face++ API 유틸
└── web
    ├── jsp
    ├── css
    ├── js
    └── images
```

---

## ⚙️ 기술 스택 (Tech Stack)

| Category | Tech |
|---------|------|
| **Language** | Java 8, JSP, JavaScript |
| **Server** | Apache Tomcat 9 |
| **Database** | MySQL 8.0 |
| **Pattern** | MVC |
| **API** | Face++ 검사 API |
| **IDE** | Eclipse / IntelliJ |
| **Version Control** | Git & GitHub |

---

# 📸 Screenshots (UI 미리보기)

## 🏠 홈 화면
<p align="center">
  <img src="https://github.com/user-attachments/assets/ee25aa42-ab7a-4d5d-8169-820b33886057" width="900"/>
</p>

---

## 📤 AI 분석 업로드 화면
<p align="center">
  <img src="https://github.com/user-attachments/assets/991ba636-e8e4-4242-ab02-054f801cb4a1" width="900"/>
</p>

---

## 📊 피부 분석 결과 화면
<p align="center">
  <img src="https://github.com/user-attachments/assets/cd7516d0-3ec9-4606-b981-bccda5132977" width="900"/>
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/871d1931-91e4-433c-b255-998a1ffe8fa2" width="900"/>
</p>

---

## 🎁 추천 제품 화면
<p align="center">
  <img src="https://github.com/user-attachments/assets/eb28c266-0965-4185-b1fe-bcfbf5b1e765" width="900"/>
</p>

---

## 📡 Face++ API 연동 코드 예시

```java
String url = "https://api-us.faceplusplus.com/facepp/v3/detect";
String apiKey = "YOUR_API_KEY";
String apiSecret = "YOUR_API_SECRET";

// HttpURLConnection을 통한 multipart 요청 전송
```

---

## 🧪 실행 방법 (How to Run)

1️⃣ Tomcat 9 설치 후 Eclipse에 연동  
2️⃣ MySQL DB 생성 및 테이블 Import  
3️⃣ Face++ API Key·Secret 입력  
4️⃣ Run on Server → Tomcat 9 선택  

---

## 👥 Team Members (7조)

| 이름 | 역할 |
|------|------|
| **한준탁** | API 연동 · 백엔드 · DB 설계 · 테스트 |
| **임성은** | DB 설계 · 백엔드 · 디자인 · 문서 |

---

## 🏁 프로젝트 요약

✔ AI 기반 피부 분석 기능 구현  
✔ 맞춤형 화장품 추천 알고리즘 개발  
✔ Java MVC 구조 기반 백엔드 설계  
✔ 회원·세션·DB CRUD 포함 실무형 기능 완성  
✔ 포트폴리오로 활용할 만한 전체 웹 서비스 구축  

---

<p align="center">
  Made with ❤️ by Team 7  
  <br>
  Your Skin, Your Beauty — <strong>Cosméthique</strong>
</p>

