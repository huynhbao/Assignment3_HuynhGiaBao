/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dtos;

import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Map;
import utils.MyUtils;

/**
 *
 * @author HuynhBao
 */
public class CartDTO {
    private String userID;
    private Map<String, CarDTO> cart;

    public CartDTO() {
    }

    public CartDTO(String userID, Map<String, CarDTO> cart) {
        this.userID = userID;
        this.cart = cart;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public Map<String, CarDTO> getCart() {
        return cart;
    }

    public void setCart(Map<String, CarDTO> cart) {
        this.cart = cart;
    }
    
    public String getKey(CarDTO car) throws NoSuchAlgorithmException {
        String key = car.getCarID() + car.getStartDate().toString() + car.getEndDate().toString();
        key = MyUtils.toHexString(MyUtils.getSHA(key));
        return key;
    }
    
    public void add(CarDTO car) throws NoSuchAlgorithmException {
        if (this.cart == null) {
            this.cart = new HashMap<>();
        }
        String key = getKey(car);
        if (this.cart.containsKey(key)) {
            int quantity = this.cart.get(key).getQuantity();
            car.setQuantity(quantity + car.getQuantity());
        }
        this.cart.put(key, car);
    }
    
    public void delete(String key) {
        if (this.cart == null) {
            return;
        }
        if (this.cart.containsKey(key)) {
            this.cart.remove(key);
        }
    }
    
    public void update(CarDTO car) throws NoSuchAlgorithmException {
        if (this.cart != null) {
            String key = getKey(car);
            if (this.cart.containsKey(key)) {
                this.cart.replace(key, car);
            }
        }
    }
    
}
