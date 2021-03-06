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
public class DiscountDTO {
    private String discountID;
    private String name;
    private Date startDate;
    private Date endDate;
    private int value;
    private BigDecimal discountValue;
    private BigDecimal newTotal;

    public DiscountDTO() {
    }

    public DiscountDTO(String discountID, String name, Date startDate, Date endDate, int value, BigDecimal discountValue, BigDecimal newTotal) {
        this.discountID = discountID;
        this.name = name;
        this.startDate = startDate;
        this.endDate = endDate;
        this.value = value;
        this.discountValue = discountValue;
        this.newTotal = newTotal;
    }

    public String getDiscountID() {
        return discountID;
    }

    public void setDiscountID(String discountID) {
        this.discountID = discountID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    public int getValue() {
        return value;
    }

    public void setValue(int value) {
        this.value = value;
    }

    public BigDecimal getNewTotal() {
        return newTotal;
    }

    public void setNewTotal(BigDecimal newTotal) {
        this.newTotal = newTotal;
    }

    public BigDecimal getDiscountValue() {
        return discountValue;
    }

    public void setDiscountValue(BigDecimal discountValue) {
        this.discountValue = discountValue;
    }
    
    
    
}
