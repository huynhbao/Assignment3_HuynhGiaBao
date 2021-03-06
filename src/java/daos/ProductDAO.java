/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import dtos.CarDTO;
import dtos.CategoryDTO;
import dtos.SearchDTO;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.log4j.Logger;
import utils.DBUtils;
import utils.MyUtils;

/**
 *
 * @author HuynhBao
 */
public class ProductDAO {

    private static final Logger LOGGER = Logger.getLogger(ProductDAO.class);

    public Map<Integer, List<CarDTO>> searchProduct(int currentPage, SearchDTO search) throws SQLException {
        Map<Integer, List<CarDTO>> result = new HashMap<>();
        List<CarDTO> carList = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                int start = currentPage * MyUtils.recordPerPage - MyUtils.recordPerPage;;
                /*String sql = "SELECT carID, c.name, color, year, cat.categoryID, cat.name, price, quantity, COUNT(*) OVER() FROM tblCars c "
                        + "JOIN tblCategory cat ON cat.categoryID = c.categoryID "
                        + "WHERE carID NOT IN (SELECT carID FROM tblOrders O "
                        + "JOIN tblOrderDetails D ON O.orderID = D.orderID "
                        + "WHERE ((startDate BETWEEN ? AND ?) OR (endDate BETWEEN ? AND ?))) AND quantity >= ? OR c.name LIKE ?";*/
                
                String sql = "SELECT c.carID, c.name, color, year, cat.categoryID, cat.name, price, quantity, COUNT(*) OVER() FROM tblCars c "
                        + "		JOIN tblCategory cat ON cat.categoryID = c.categoryID "
                        + "		WHERE carID NOT IN ("
                        + "				SELECT c.carID FROM ("
                        + "                                                 SELECT c.carID, SUM(od.quantity) AS [total] FROM tblCars c"
                        + "                                                 JOIN tblOrderDetails od ON od.carID = c.carID"
                        + "                                                 JOIN tblOrders o ON o.orderID = od.orderID WHERE o.status = 1 AND ((startDate BETWEEN ? AND ?) OR (endDate BETWEEN ? AND ?))"
                        + "                                                 GROUP BY c.carID"
                        + "                                             ) AS a JOIN tblCars c ON a.carID = c.carID"
                        + "						WHERE quantity - total < ?)"
                        + "		AND quantity >= ? ";

                if (!search.getName().isEmpty()) {
                    sql = sql.concat(" AND c.name LIKE ?");
                } else if (!search.getCategoryID().isEmpty()) {
                    sql = sql.concat(" AND cat.categoryID = ?");
                }
                
                sql = sql.concat(" ORDER BY createDate DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

                stm = conn.prepareStatement(sql);

                stm.setDate(1, new java.sql.Date(search.getStartDate().getTime()));
                stm.setDate(2, new java.sql.Date(search.getEndDate().getTime()));
                stm.setDate(3, new java.sql.Date(search.getStartDate().getTime()));
                stm.setDate(4, new java.sql.Date(search.getEndDate().getTime()));
                stm.setInt(5, search.getQuantity());
                stm.setInt(6, search.getQuantity());
                
                int count = 7;
                if (search.getName() != null) {
                    stm.setString(count++, "%" + search.getName() + "%");
                } else if (search.getCategoryID() != null) {
                    stm.setString(count++, search.getCategoryID());
                }

                stm.setInt(count++, start);
                stm.setInt(count++, MyUtils.recordPerPage);

                rs = stm.executeQuery();

                int totalProduct = 0;
                while (rs.next()) {
                    if (carList == null) {
                        carList = new ArrayList<>();
                    }
                    if (totalProduct == 0) {
                        totalProduct = rs.getInt(9);
                    }
                    int carID = rs.getInt("carID");
                    String name = rs.getString(2);
                    String color = rs.getString("color");
                    int year = rs.getInt("year");
                    String categoryID = rs.getString(5);
                    String categoryName = rs.getString(6);
                    BigDecimal price = rs.getBigDecimal("price");
                    int quantity = rs.getInt("quantity");

                    CategoryDTO category = new CategoryDTO(categoryID, categoryName);
                    CarDTO car = new CarDTO(carID, name, color, year, category, price, quantity);
                    carList.add(car);
                }

                result.put(totalProduct, carList);

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

    public boolean checkCarAvailable(CarDTO car) throws SQLException {
        boolean result = false;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT carID FROM tblCars "
                        + "WHERE carID "
                        + "NOT IN (SELECT carID FROM tblOrders O "
                        + "        JOIN tblOrderDetails D ON O.orderID = D.orderID "
                        + "        WHERE ((startDate BETWEEN ? AND ?) OR (endDate BETWEEN ? AND ?))) "
                        + "AND carID = ? AND quantity <= ?";

                stm = conn.prepareStatement(sql);

                stm.setDate(1, new java.sql.Date(car.getStartDate().getTime()));
                stm.setDate(2, new java.sql.Date(car.getEndDate().getTime()));
                stm.setDate(3, new java.sql.Date(car.getStartDate().getTime()));
                stm.setDate(4, new java.sql.Date(car.getEndDate().getTime()));
                stm.setInt(5, car.getCarID());
                stm.setInt(6, car.getQuantity());

                rs = stm.executeQuery();

                if (rs.next()) {
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

    public CarDTO getCarDTO(int carID) throws SQLException {
        CarDTO result = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT carID, c.name, color, year, cat.categoryID, cat.name, price, quantity, COUNT(*) OVER() FROM tblCars c JOIN tblCategory cat ON cat.categoryID = c.categoryID WHERE carID = ?";
                stm = conn.prepareStatement(sql);
                stm.setInt(1, carID);
                rs = stm.executeQuery();
                if (rs.next()) {
                    String name = rs.getString(2);
                    String color = rs.getString("color");
                    int year = rs.getInt("year");
                    String categoryID = rs.getString(5);
                    String categoryName = rs.getString(6);
                    BigDecimal price = rs.getBigDecimal("price");
                    int quantity = rs.getInt("quantity");

                    CategoryDTO category = new CategoryDTO(categoryID, categoryName);
                    result = new CarDTO(carID, name, color, year, category, price, quantity);
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

    public List<CategoryDTO> getCategories() throws SQLException {
        List<CategoryDTO> result = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT categoryID, name FROM tblCategory";
                stm = conn.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    if (result == null) {
                        result = new ArrayList<>();
                    }
                    String categoryID = rs.getString("categoryID");
                    String name = rs.getString("name");

                    CategoryDTO category = new CategoryDTO(categoryID, name);
                    result.add(category);
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

    public int checkCarAvailableQuantity(int carID) throws SQLException {
        int result = -1;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT quantity FROM tblCars WHERE carID = ?";
                stm = conn.prepareStatement(sql);
                stm.setInt(1, carID);
                rs = stm.executeQuery();
                if (rs.next()) {
                    result = rs.getInt("quantity");
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

}
