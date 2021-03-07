/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import dtos.CartDTO;
import dtos.CarDTO;
import dtos.DiscountDTO;
import dtos.OrderDTO;
import dtos.OrderDetailDTO;
import dtos.SearchDTO;
import dtos.UserDTO;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.naming.NamingException;
import org.apache.log4j.Logger;
import utils.DBUtils;
import utils.MyUtils;

/**
 *
 * @author HuynhBao
 */
public class UserDAO {

    private static final Logger LOGGER = Logger.getLogger(UserDAO.class);

    public UserDTO checkLogin(String email, String password) throws SQLException {
        UserDTO result = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT name, phone, address, status, code FROM tblUsers WHERE email = ? AND password = ?";
                stm = conn.prepareStatement(sql);
                stm.setString(1, email);
                stm.setString(2, password);
                rs = stm.executeQuery();

                if (rs.next()) {
                    String name = rs.getString("name");
                    String phone = rs.getString("phone");
                    String address = rs.getString("address");
                    String code = rs.getString("code");
                    boolean status = rs.getBoolean("status");
                    result = new UserDTO(email, name, "", phone, address, code, status);
                }
            }
        } catch (Exception e) {
            LOGGER.error(e.toString());
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return result;
    }

    public DiscountDTO checkDiscount(String discountID) throws SQLException {
        DiscountDTO result = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT name, startDate, endDate, value FROM tblDiscount WHERE discountID = ?";
                stm = conn.prepareStatement(sql);
                stm.setString(1, discountID);
                rs = stm.executeQuery();

                if (rs.next()) {
                    String name = rs.getString("name");
                    java.sql.Date startDate = rs.getDate("startDate");
                    java.sql.Date endDate = rs.getDate("endDate");
                    int value = rs.getInt("value");
                    result = new DiscountDTO(discountID, name, new Date(startDate.getTime()), new Date(endDate.getTime()), value, null, null);
                }
            }
        } catch (Exception e) {
            LOGGER.error(e.toString());
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return result;
    }

    public void register(UserDTO user) throws SQLException, ClassNotFoundException, NamingException {
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "INSERT INTO tblUsers(email, name, password, status, phone, address) VALUES(?,?,?,?,?)";
                stm = conn.prepareStatement(sql);
                stm.setString(1, user.getEmail());
                stm.setString(2, user.getName());
                stm.setString(3, user.getPassword());
                stm.setBoolean(4, user.getStatus());
                stm.setString(5, user.getPhone());
                stm.setString(6, user.getAddress());
                stm.executeUpdate();
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }

    public void calculateDiscount(DiscountDTO discount, double total) {
        double discountValue = total * ((double) discount.getValue() / 100);
        total = total - discountValue;
        BigDecimal newTotal = new BigDecimal(total);
        BigDecimal newDiscountValue = new BigDecimal(discountValue);
        discount.setNewTotal(newTotal);
        discount.setDiscountValue(newDiscountValue);
    }

    public boolean checkout(CartDTO cart, DiscountDTO discount, BigDecimal total) throws SQLException {
        boolean result = false;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String orderIdArr[] = {"orderID"};
                String sql = "INSERT INTO tblOrders(email, date, total, discountID) VALUES(?,?,?,?)";
                Date date = new Date();
                stm = conn.prepareStatement(sql, orderIdArr);
                stm.setString(1, cart.getUserID());
                Timestamp time = new Timestamp(date.getTime());
                stm.setTimestamp(2, time);
                stm.setBigDecimal(3, total);
                if (discount != null) {
                    stm.setString(4, discount.getDiscountID());
                } else {
                    stm.setNull(4, java.sql.Types.NULL);
                }

                stm.executeUpdate();
                rs = stm.getGeneratedKeys();
                if (rs.next()) {
                    String sqlOrderDetail = "INSERT INTO tblOrderDetails(carID, quantity, price, startDate, endDate, days, orderID) VALUES(?,?,?,?,?,?,?)";
                    int orderID = rs.getInt(1);
                    for (CarDTO car : cart.getCart().values()) {
                        stm = conn.prepareStatement(sqlOrderDetail, orderID);
                        stm.setInt(1, car.getCarID());
                        stm.setInt(2, car.getQuantity());
                        stm.setBigDecimal(3, car.getPrice());
                        stm.setDate(4, new java.sql.Date(car.getStartDate().getTime()));
                        stm.setDate(5, new java.sql.Date(car.getEndDate().getTime()));
                        stm.setInt(6, car.getDays());
                        stm.setInt(7, rs.getInt(1));
                        stm.executeUpdate();
                    }
                    result = true;
                }
            }
        } catch (Exception e) {
            LOGGER.error(e.toString());
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return result;
    }
   

    public List<OrderDetailDTO> getListOrderDetail(int orderID) throws SQLException {
        List<OrderDetailDTO> list = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT orderDetailID, carID, quantity, price, startDate, endDate, days FROM tblOrderDetails WHERE orderID = ?";
                stm = conn.prepareStatement(sql);
                stm.setInt(1, orderID);
                rs = stm.executeQuery();

                ProductDAO dao = new ProductDAO();
                while (rs.next()) {
                    if (list == null) {
                        list = new ArrayList<>();
                    }

                    int orderDetailID = rs.getInt("orderDetailID");
                    int carID = rs.getInt("carID");
                    int quantity = rs.getInt("quantity");
                    float price = rs.getFloat("price");
                    Date startDate = rs.getDate("startDate");
                    Date endDate = rs.getDate("endDate");
                    int days = rs.getInt("days");

                    CarDTO car = dao.getCarDTO(carID);
                    car.setQuantity(quantity);
                    car.setPrice(BigDecimal.valueOf(price));
                    car.setStartDate(startDate);
                    car.setEndDate(endDate);
                    car.setDays(days);
                    OrderDetailDTO orderDetail = new OrderDetailDTO(orderDetailID, car);

                    list.add(orderDetail);
                }

            }
        } catch (Exception e) {
            LOGGER.error(e.toString());
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return list;
    }
    
    public Map<Integer, List<OrderDTO>> searchOrderHistory(int currentPage, String email, SearchDTO search) throws SQLException {
        Map<Integer, List<OrderDTO>> result = new HashMap<>();
        List<OrderDTO> listOrder = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                int start = currentPage * MyUtils.recordPerPage - MyUtils.recordPerPage;

                String sql = "SELECT COUNT(*) OVER(), orderID, date, total, discountID, status FROM tblOrders o "
                        + "WHERE o.orderID IN (SELECT od.orderID FROM tblOrderDetails od JOIN tblCars c ON od.carID = c.carID  WHERE c.name LIKE ?) OR CAST(date AS Date) = ? AND email = ? "
                        + "ORDER BY date DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
                stm = conn.prepareStatement(sql);

                stm.setString(1, "%" + search.getName() + "%");

                if (search.getStartDate() == null) {
                    stm.setString(2, "");
                } else {
                    java.sql.Date date = new java.sql.Date(search.getStartDate().getTime());
                    stm.setDate(2, date);
                }

                stm.setString(3, email);
                stm.setInt(4, start);
                stm.setInt(5, MyUtils.recordPerPage);
                rs = stm.executeQuery();

                int totalRow = 0;
                while (rs.next()) {
                    if (totalRow == 0) {
                        totalRow = rs.getInt(1);
                    }
                    if (listOrder == null) {
                        listOrder = new ArrayList<>();
                    }
                    int orderID = rs.getInt(2);
                    Timestamp timestamp = rs.getTimestamp("date");
                    Date date = new Date(timestamp.getTime());
                    float total = rs.getFloat("total");
                    String discountID = rs.getString("discountID");
                    boolean status = rs.getBoolean("status");
                    
                    OrderDTO order = new OrderDTO(orderID, email, date, BigDecimal.valueOf(total), null, status, null);
                    if (discountID != null) {
                        DiscountDTO discount = checkDiscount(discountID);
                        calculateDiscount(discount, total);
                        order.setDiscount(discount);
                    }
                    
                    order.setOrderDetail(getListOrderDetail(orderID));
                    listOrder.add(order);
                }

                result.put(totalRow, listOrder);
            }
        } catch (Exception e) {
            LOGGER.error(e.toString());
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return result;
    }

    public void setStatusOrder(int orderID, boolean status) throws SQLException {
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "UPDATE tblOrders SET status = ? WHERE orderID = ?";
                stm = conn.prepareStatement(sql);
                stm.setBoolean(1, status);
                stm.setInt(2, orderID);
                stm.executeUpdate();
            }
        } catch (Exception e) {
            LOGGER.error(e.toString());
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

    }
}
