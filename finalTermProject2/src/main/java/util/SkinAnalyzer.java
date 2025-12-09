package util;

import org.json.JSONObject;
import java.awt.image.BufferedImage;

public class SkinAnalyzer {

    public SkinResult analyze(BufferedImage img, JSONObject rect) {

        int x = rect.getInt("left");
        int y = rect.getInt("top");
        int w = rect.getInt("width");
        int h = rect.getInt("height");

        BufferedImage faceCrop = img.getSubimage(
                Math.max(0, x),
                Math.max(0, y),
                Math.min(w, img.getWidth() - x),
                Math.min(h, img.getHeight() - y)
        );

        SkinResult result = new SkinResult();

        // ====== 기본 분석 (임시 알고리즘) ======
        result.wrinkle = (int)(Math.random() * 100);
        result.pore = (int)(Math.random() * 100);
        result.redness = (int)(Math.random() * 100);
        result.oil = (int)(Math.random() * 100);
        result.tone = (int)(Math.random() * 100);

        return result;
    }
}
