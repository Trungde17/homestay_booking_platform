package model;

public class Img {
    private int img_id;
    private String img_url;

    public Img() {
    }

    public Img(int img_id, String img_url) {
        this.img_id = img_id;
        this.img_url = img_url;
    }

    public int getImg_id() {
        return img_id;
    }

    public void setImg_id(int img_id) {
        this.img_id = img_id;
    }

    public String getImg_url() {
        return img_url;
    }

    public void setImg_url(String img_url) {
        this.img_url = img_url;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final Img other = (Img) obj;
        return this.img_id == other.img_id;
    }

    
    
    
}
