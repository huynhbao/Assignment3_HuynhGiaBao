/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dtos;

import java.math.BigDecimal;
import java.util.Date;

/**
 *
 * @author HuynhBao
 */
public class CarDTO {
    private int carID;
    private String name;
    private String color;
    private int year;
    private CategoryDTO category;
    private BigDecimal price;
    private int quantity;
    private Date startDate;
    private Date endDate;

    public CarDTO() {
    }

    public CarDTO(int carID, String name, String color, int year, CategoryDTO category, BigDecimal price, int quantity) {
        this.carID = carID;
        this.name = name;
        this.color = color;
        this.year = year;
        this.category = category;
        this.price = price;
        this.quantity = quantity;
    }

    public int getCarID() {
        return carID;
    }

    public void setCarID(int carID) {
        this.carID = carID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public CategoryDTO getCategory() {
        return category;
    }

    public void setCategory(CategoryDTO category) {
        this.category = category;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }
    
    
}
