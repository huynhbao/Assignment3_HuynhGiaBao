/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dtos;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 *
 * @author HuynhBao
 */
public class OrderDTO {
    private int orderID;
    private String email;
    private Date date;
    private BigDecimal total;
    private DiscountDTO discount;
    private boolean status;
    private List<OrderDetailDTO> orderDetail;
    
    public OrderDTO() {
    }

    public OrderDTO(int orderID, String email, Date date, BigDecimal total, DiscountDTO discount, boolean status, List<OrderDetailDTO> orderDetail) {
        this.orderID = orderID;
        this.email = email;
        this.date = date;
        this.total = total;
        this.discount = discount;
        this.status = status;
        this.orderDetail = orderDetail;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public BigDecimal getTotal() {
        return total;
    }

    public void setTotal(BigDecimal total) {
        this.total = total;
    }

    public DiscountDTO getDiscount() {
        return discount;
    }

    public void setDiscount(DiscountDTO discount) {
        this.discount = discount;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public List<OrderDetailDTO> getOrderDetail() {
        return orderDetail;
    }

    public void setOrderDetail(List<OrderDetailDTO> orderDetail) {
        this.orderDetail = orderDetail;
    }

    

    
    
}
