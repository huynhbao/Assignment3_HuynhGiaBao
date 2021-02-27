/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dtos;

import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author HuynhBao
 */
public class CartDTO {
    private String userID;
    private Map<Integer, CarDTO> cart;

    public CartDTO() {
    }

    public CartDTO(String userID, Map<Integer, CarDTO> cart) {
        this.userID = userID;
        this.cart = cart;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public Map<Integer, CarDTO> getCart() {
        return cart;
    }

    public void setCart(Map<Integer, CarDTO> cart) {
        this.cart = cart;
    }
    
    public void add(CarDTO car) {
        if (this.cart == null) {
            this.cart = new HashMap<>();
        }
        if (this.cart.containsKey(car.getCarID())) {
            int quantity = this.cart.get(car.getCarID()).getQuantity();
            car.setQuantity(quantity + car.getQuantity());
        }
        this.cart.put(car.getCarID(), car);
    }
    
    public void delete(int id) {
        if (this.cart == null) {
            return;
        }
        if (this.cart.containsKey(id)) {
            this.cart.remove(id);
        }
    }
    
    public void update(CarDTO car) {
        if (this.cart != null) {
            if (this.cart.containsKey(car.getCarID())) {
                this.cart.replace(car.getCarID(), car);
            }
        }
    }
    
}
