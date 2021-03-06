/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import daos.ProductDAO;
import daos.UserDAO;
import dtos.CarDTO;
import dtos.CartDTO;
import dtos.DiscountDTO;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import utils.MyUtils;

/**
 *
 * @author HuynhBao
 */
@WebServlet(name = "CheckoutController", urlPatterns = {"/CheckoutController"})
public class CheckoutController extends HttpServlet {

    private static final String ERROR = "cart.jsp";
    private static final String SUCCESS = "checkout.jsp";

    private static final Logger LOGGER = Logger.getLogger(CheckoutController.class);

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        String url = ERROR;
        try {
            CartDTO cart = (CartDTO) session.getAttribute("CART");

            if (cart != null) {
                ProductDAO pDAO = new ProductDAO();
                List<CarDTO> outOfStockList = new ArrayList<>();
                for (CarDTO car1 : cart.getCart().values()) {
                    int totalQuantity = car1.getQuantity();
                    for (CarDTO car2 : cart.getCart().values()) {
                        if (!cart.getKey(car1).equals(cart.getKey(car2))) {
                            if (car1.getStartDate().compareTo(car2.getEndDate()) <= 0 && car2.getStartDate().compareTo(car1.getEndDate()) <= 0) {
                                int getQuantityDB = pDAO.checkCarAvailableQuantity(car1.getCarID());
                                totalQuantity += car2.getQuantity();
                                if (totalQuantity > getQuantityDB) {
                                    CarDTO car = new CarDTO(car1);
                                    car.setQuantity(getQuantityDB);
                                    outOfStockList.add(car);
                                }
                            }
                        }
                    }
                }

                if (outOfStockList.isEmpty()) {
                    String discountID = request.getParameter("txtDiscountID");
                    DiscountDTO discount = null;
                    UserDAO dao = new UserDAO();
                    double total = 0;
                    for (CarDTO car : cart.getCart().values()) {
                        total += car.getQuantity() * car.getPrice().floatValue() * car.getDays();
                    }

                    if (!"".equals(discountID)) {
                        discount = dao.checkDiscount(discountID);
                        if (discount != null) {
                            dao.calculateDiscount(discount, total);
                        }
                    }

                    boolean checkout = dao.checkout(cart, discount, new BigDecimal(total));
                    if (checkout) {
                        session.setAttribute("CART", null);
                        url = SUCCESS;
                    }
                } else {
                    request.setAttribute("OUT_OF_STOCK_LIST", outOfStockList);
                    url = ERROR;
                }

            }
        } catch (Exception e) {
            LOGGER.error(e.toString());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
