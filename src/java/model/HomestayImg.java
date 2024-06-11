
package model;

public class HomestayImg extends Img{
    private int img_role;
    public HomestayImg() {
    }

    public HomestayImg(int img_id, String img_url,int img_role) {
        super(img_id, img_url);
        this.img_role = img_role;
    }

    
    public int getImg_role() {
        return img_role;
    }

    public void setImg_role(int img_role) {
        this.img_role = img_role;
    } 
    
    
}
