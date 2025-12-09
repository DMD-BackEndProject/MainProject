package dto;

public class SkinHistoryDTO {

    private int id;
    private String userId;
    private int wrinkle;
    private int pore;
    private int redness;
    private int oil;
    private int tone;
    private String skinType;
    private String createdAt;

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public String getUserId() {
        return userId;
    }
    public void setUserId(String userId) {
        this.userId = userId;
    }

    public int getWrinkle() {
        return wrinkle;
    }
    public void setWrinkle(int wrinkle) {
        this.wrinkle = wrinkle;
    }

    public int getPore() {
        return pore;
    }
    public void setPore(int pore) {
        this.pore = pore;
    }

    public int getRedness() {
        return redness;
    }
    public void setRedness(int redness) {
        this.redness = redness;
    }

    public int getOil() {
        return oil;
    }
    public void setOil(int oil) {
        this.oil = oil;
    }

    public int getTone() {
        return tone;
    }
    public void setTone(int tone) {
        this.tone = tone;
    }

    public String getSkinType() {
        return skinType;
    }
    public void setSkinType(String skinType) {
        this.skinType = skinType;
    }

    public String getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }
}
