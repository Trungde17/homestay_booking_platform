/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ASUS
 */
public class ImageHost extends Img{
    private int roles;// role 1 is cccd role 2 is the file of homestay 
    //constructor

    public ImageHost() {
    }

   
    
    public ImageHost(int roles, int img_id, String img_url) {
        super(img_id, img_url);
        this.roles = roles;
    }

    public int getRoles() {
        return roles;
    }

    public void setRoles(int roles) {
        this.roles = roles;
    }

    @Override
    public String toString() {
        return "ImageHost{" + "roles=" + roles + '}';
    }
    
}
