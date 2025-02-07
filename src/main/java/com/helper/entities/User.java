package com.helper.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(length = 10)
    private int userId;

    @Column(length = 200)
    private String userName;

    @Column(length = 1000, unique = true)
    private String userEmail;

    @Column(length = 255)
    private String userPassword;

    @Column(length = 10)
    private String userPhone;

    private String userPic;

    @Column(length = 1000)
    private String userAddress;

    @Column(length = 20, nullable = false)
    private String userType = "normal"; // Default value is "normal"

    // Constructors
    public User(int userId, String userName, String userEmail, String userPassword, String userPhone, String userPic, String userAddress, String userType) {
        this.userId = userId;
        this.userName = userName;
        this.userEmail = userEmail;
        this.userPassword = userPassword;
        this.userPhone = userPhone;
        this.userPic = userPic;
        this.userAddress = userAddress;
        this.userType = userType;
    }

    public User(String userName, String userEmail, String userPassword, String userPhone, String userPic, String userAddress) {
        this.userName = userName;
        this.userEmail = userEmail;
        this.userPassword = userPassword;
        this.userPhone = userPhone;
        this.userPic = userPic;
        this.userAddress = userAddress;
        this.userType = "normal"; // Ensure "normal" is set in constructor
    }

    public User() {
        this.userType = "normal"; // Default userType for new users
    }

    // Getters and Setters
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getUserPassword() {
        return userPassword;
    }

    public void setUserPassword(String userPassword) {
        this.userPassword = userPassword;
    }

    public String getUserPhone() {
        return userPhone;
    }

    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }

    public String getUserPic() {
        return userPic;
    }

    public void setUserPic(String userPic) {
        this.userPic = userPic;
    }

    public String getUserAddress() {
        return userAddress;
    }

    public void setUserAddress(String userAddress) {
        this.userAddress = userAddress;
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

    @Override
    public String toString() {
        return "User [userId=" + userId + ", userName=" + userName + ", userEmail=" + userEmail + ", userPassword="
                + userPassword + ", userPhone=" + userPhone + ", userPic=" + userPic + ", userAddress=" + userAddress
                + ", userType=" + userType + "]";
    }
}
