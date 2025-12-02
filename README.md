# ✨ **Cosméthique – AI 피부 분석 & 맞춤 화장품 추천 서비스**  
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

## 🌸 **프로젝트 소개**

**Cosméthique**는 사용자의 얼굴 사진을 AI로 분석하여  
주름 · 모공 · 홍조 · 유분 · 피부 톤을 진단하고,  
DB의 화장품 데이터를 기반으로 **개인 맞춤 추천**을 제공하는 웹 서비스입니다.

<p align="center">
  <img src="https://img.shields.io/badge/AI Skin Analyzer-Face++-pink?style=flat-square"/>
</p>

---

## 🚩 **주요 기능 (Features)**

### 🔍 **1. AI 피부 분석**
- Face++ API를 활용한 자동 피부 상태 분석
- 5개 지표 점수화  
  ✔ Wrinkle  
  ✔ Pore  
  ✔ Redness  
  ✔ Oiliness  
  ✔ Skin Tone  
- 분석 결과에 따른 설명 텍스트 자동 생성

---

### 🎁 **2. 맞춤 화장품 추천**
- 분석 결과 기반으로 DB에서 화장품 매칭
- 제품 이미지, 사용 효과, 링크까지 제공
- 추천 알고리즘 기반 간단 점수 매칭

---

### 👤 **3. 회원 시스템**
- 회원가입 / 로그인 / 로그아웃
- 개인정보 수정
- 사용자별 분석 결과 제공

---

### 🎨 **4. UI/UX 디자인**
- 파스텔 톤 · 그라데이션 기반
- 카드를 활용한 분석 리포트 UI  
- 부드러운 CSS 애니메이션 적용

---

## 🏗️ **아키텍처 (Architecture)**

```
📦 Cosméthique Project
├── controller      # 모든 요청을 처리하는 Servlet들
├── dao             # DB 조회/삽입/수정
├── dto             # 데이터 전송 객체
├── util            # Face++ API 및 공통 유틸
└── web
    ├── jsp
    ├── css
    ├── js
    └── images
```

---

## ⚙️ **기술 스택 (Tech Stack)**

| Category | Tech |
|---------|------|
| **Language** | Java 8, JSP, JavaScript |
| **Server** | Apache Tomcat 9 |
| **Database** | MySQL 8.0 |
| **Pattern** | MVC |
| **API** | Face++ |
| **IDE** | Eclipse / IntelliJ |
| **Version Control** | Git & GitHub |

---

## 📸 **스크린샷 (Screenshots)**  
> 📌 여기에 UI 캡처 이미지 넣으면 포트폴리오 완성도가 올라갑니다!

```
📍 ![홈 화면](<img width="1917" height="908" alt="Image" src="https://github.com/user-attachments/assets/ee25aa42-ab7a-4d5d-8169-820b33886057" />) 
📍 이미지 업로드 + AI 분석 화면  
📍 분석 결과 리포트  
📍 화장품 추천 목록  
📍 회원 정보 수정 페이지  
```

---

## 📡 **Face++ API 연동 코드 예시**

```java
String url = "https://api-us.faceplusplus.com/facepp/v3/detect";
String apiKey = "YOUR_API_KEY";
String apiSecret = "YOUR_API_SECRET";

// HttpURLConnection 사용하여 multipart 요청 수행
```

---

## 🧪 **프로젝트 실행 방법 (How to Run)**

### 1️⃣ Tomcat 9 설치 후 Eclipse에 등록  
### 2️⃣ MySQL DB 생성 및 테이블 Import  
### 3️⃣ Face++ API 키 입력  
`FaceAPIUtil.java` 또는 환경파일에 KEY/SECRET 등록  
### 4️⃣ 실행  
Eclipse → Run on Server → Tomcat 9 선택  

---

## 👥 **Team Members (7조)**

| 이름 | 역할 |
|------|------|
| 한준탁 | API 연동 · 백엔드 · DB 설계 · 테스트|
| 임성은 | DB 설계 · 백엔드 · 디자인 · 문서|

---

## 🏁 **프로젝트 요약**

✔ AI 기반 피부 분석 기능 구현  
✔ 사용자 맞춤 추천 시스템 개발  
✔ MVC 아키텍처 기반 서버 구축  
✔ 실무 수준의 회원/세션/DB CRUD 구축  
✔ 학습 + 포트폴리오 모두에 적합한 구조  

