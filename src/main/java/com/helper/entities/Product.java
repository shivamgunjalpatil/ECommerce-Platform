package com.helper.entities;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;

@Entity
public class Product {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public int pId;
	public String pName;
	public String pPhoto;
	public String pDesciption;
	public int pPrice;
	public int pDiscount;
	public int pQuantity;
	@ManyToOne
	public Category category;
	@Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Product product = (Product) o;
        return pId == product.pId;
    }

    @Override
    public int hashCode() {
        return pId;
    }
	
	
	public Product(int pId, String pName, String pPhoto, String pDesciption, int pPrice, int pDiscount, int pQuantity) {
		super();
		this.pId = pId;
		this.pName = pName;
		this.pPhoto = pPhoto;
		this.pDesciption = pDesciption;
		this.pPrice = pPrice;
		this.pDiscount = pDiscount;
		this.pQuantity = pQuantity;
	}
	public Product(String pName, String pPhoto, String pDesciption, int pPrice, int pDiscount, int pQuantity,Category category) {
		super();
		this.pName = pName;
		this.pPhoto = pPhoto;
		this.pDesciption = pDesciption;
		this.pPrice = pPrice;
		this.pDiscount = pDiscount;
		this.pQuantity = pQuantity;
		this.category = category;
	}
	public Product() {
		super();
		// TODO Auto-generated constructor stub
	}
	public int getpId() {
		return pId;
	}
	public void setpId(int pId) {
		this.pId = pId;
	}
	public String getpName() {
		return pName;
	}
	public void setpName(String pName) {
		this.pName = pName;
	}
	public String getpPhoto() {
		return pPhoto;
	}
	public void setpPhoto(String pPhoto) {
		this.pPhoto = pPhoto;
	}
	public String getpDesciption() {
		return pDesciption;
	}
	public void setpDesciption(String pDesciption) {
		this.pDesciption = pDesciption;
	}
	public int getpPrice() {
		return pPrice;
	}
	public void setpPrice(int pPrice) {
		this.pPrice = pPrice;
	}
	public int getpDiscount() {
		return pDiscount;
	}
	public void setpDiscount(int pDiscount) {
		this.pDiscount = pDiscount;
	}
	public int getpQuantity() {
		return pQuantity;
	}
	public void setpQuantity(int pQuantity) {
		this.pQuantity = pQuantity;
	}
	
	public Category getCategory() {
		return category;
	}
	public void setCategory(Category category) {
		this.category = category;
	}
	@Override
	public String toString() {
		return "Product [pId=" + pId + ", pName=" + pName + ", pPhoto=" + pPhoto + ", pDesciption=" + pDesciption
				+ ", pPrice=" + pPrice + ", pDiscount=" + pDiscount + ", pQuantity=" + pQuantity + "]";
	}
	

}
