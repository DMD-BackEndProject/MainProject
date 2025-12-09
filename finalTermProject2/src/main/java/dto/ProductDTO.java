package dto;

public class ProductDTO {
    private int productId;
    private String name;
    private String category;
    private String skinType;
    private String imageUrl;
    private String info;

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getSkinType() { return skinType; }
    public void setSkinType(String skinType) { this.skinType = skinType; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public String getInfo() { return info; }
    public void setInfo(String info) { this.info = info; }
}
