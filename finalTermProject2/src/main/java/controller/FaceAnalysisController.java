package controller;

import java.awt.image.BufferedImage;
import java.io.*;
import java.net.HttpURLConnection;
import java.util.*;

import javax.imageio.ImageIO;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import org.json.JSONArray;
import org.json.JSONObject;

import dao.ProductDAO;
import dao.SkinHistoryDAO;
import dto.ProductDTO;
import dto.SkinHistoryDTO;
import dto.UserDTO;
import util.SkinAnalyzer;
import util.SkinResult;

@WebServlet("/faceAnalyze")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 20
)
public class FaceAnalysisController extends HttpServlet {

    private static final String API_KEY = "KQlW1nKQL6fSQ8cVOLInxOjJZRdhuH0K";
    private static final String API_SECRET = "24Hl1uhYvfD62xn2BEl3SSOH1W9_nPjs";
    private static final String DETECT_API =
            "https://api-us.faceplusplus.com/facepp/v3/detect";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        Part filePart = req.getPart("faceImage");

        if (filePart == null || filePart.getSize() == 0) {
            req.setAttribute("error", "이미지를 업로드해주세요.");
            req.getRequestDispatcher("result.jsp").forward(req, resp);
            return;
        }

        // 원본 이미지 저장
        BufferedImage original = ImageIO.read(filePart.getInputStream());

        // Detect API 호출
        JSONObject detectJson = callDetect(filePart);

        if (detectJson == null) {
            req.setAttribute("error", "Face++ 서버 통신 오류");
            req.getRequestDispatcher("result.jsp").forward(req, resp);
            return;
        }

        JSONArray faces = detectJson.optJSONArray("faces");
        if (faces == null || faces.length() == 0) {
            req.setAttribute("error", "얼굴을 인식하지 못했습니다.");
            req.getRequestDispatcher("result.jsp").forward(req, resp);
            return;
        }

        JSONObject rect = faces.getJSONObject(0).getJSONObject("face_rectangle");

        // ==============================
        //  자체 피부 분석 알고리즘 실행
        // ==============================
        SkinAnalyzer analyzer = new SkinAnalyzer();
        SkinResult result = analyzer.analyze(original, rect);

        int wrinkle = result.wrinkle;
        int pore = result.pore;
        int redness = result.redness;
        int oil = result.oil;
        int tone = result.tone;

        // ==============================
        // 피부 타입 판정
        // ==============================
        String skinType;

        if (oil >= 60 || pore >= 60) {
            skinType = "지성";
        } else if (oil <= 30 || wrinkle >= 60) {
            skinType = "건성";
        } else if (oil >= 55 && pore >= 40) {
            skinType = "복합성";
        } else if (redness >= 60) {
            skinType = "민감성";
        } else {
            skinType = "정상";
        }

        // JSP에 전달
        req.setAttribute("wrinkle", wrinkle);
        req.setAttribute("pore", pore);
        req.setAttribute("redness", redness);
        req.setAttribute("oil", oil);
        req.setAttribute("tone", tone);
        req.setAttribute("skinType", skinType);

        // ==============================
        // DB 추천 제품 가져오기
        // ==============================
        ProductDAO dao = new ProductDAO();
        List<ProductDTO> items = dao.findBySkinType(skinType);
        req.setAttribute("items", items);

        // ==============================
        // 로그인 확인 (중요!)
        // ==============================
        HttpSession session = req.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        // ==============================
        // 분석 결과 DB 저장
        // ==============================
        SkinHistoryDTO h = new SkinHistoryDTO();
        h.setUserId(user.getUserId());
        h.setWrinkle(wrinkle);
        h.setPore(pore);
        h.setRedness(redness);
        h.setOil(oil);
        h.setTone(tone);
        h.setSkinType(skinType);

        SkinHistoryDAO historyDAO = new SkinHistoryDAO();
        historyDAO.save(h);

        // ==============================
        // 분석 결과 페이지로 이동
        // ==============================
        req.getRequestDispatcher("result.jsp").forward(req, resp);
    }

    /** Detect API 호출 */
    private JSONObject callDetect(Part imagePart) {

        try {
            String urlStr = DETECT_API
                    + "?api_key=" + API_KEY
                    + "&api_secret=" + API_SECRET
                    + "&return_landmark=1";

            java.net.URL url = new java.net.URL(urlStr);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            String boundary = "----WebKitFormBoundary" + System.currentTimeMillis();

            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            conn.setUseCaches(false);
            conn.setRequestProperty("Content-Type",
                    "multipart/form-data; boundary=" + boundary);

            DataOutputStream dos = new DataOutputStream(conn.getOutputStream());

            // 이미지 파트
            dos.writeBytes("--" + boundary + "\r\n");
            dos.writeBytes("Content-Disposition: form-data; name=\"image_file\"; filename=\"face.jpg\"\r\n");
            dos.writeBytes("Content-Type: application/octet-stream\r\n\r\n");

            InputStream inputStream = imagePart.getInputStream();
            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                dos.write(buffer, 0, bytesRead);
            }
            dos.writeBytes("\r\n");

            dos.writeBytes("--" + boundary + "--\r\n");
            dos.flush();
            dos.close();

            // 응답 읽기
            BufferedReader br = new BufferedReader(
                    new InputStreamReader(conn.getInputStream(), "UTF-8")
            );

            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null)
                sb.append(line);

            br.close();

            return new JSONObject(sb.toString());

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
