/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dtos;

/**
 *
 * @author HuynhBao
 */
public class OrderDetailDTO {
    private int orderDetailID;
    private CarDTO car;

    public OrderDetailDTO() {
    }

    public OrderDetailDTO(int orderDetailID, CarDTO car) {
        this.orderDetailID = orderDetailID;
        this.car = car;
    }

    public int getOrderDetailID() {
        return orderDetailID;
    }

    public void setOrderDetailID(int orderDetailID) {
        this.orderDetailID = orderDetailID;
    }

    public CarDTO getCar() {
        return car;
    }

    public void setCar(CarDTO car) {
        this.car = car;
    }
}
