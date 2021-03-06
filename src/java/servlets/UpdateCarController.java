/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import daos.ProductDAO;
import dtos.CarDTO;
import dtos.CartDTO;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;

/**
 *
 * @author HuynhBao
 */
@WebServlet(name = "UpdateCarController", urlPatterns = {"/UpdateCarController"})
public class UpdateCarController extends HttpServlet {

    private final static String ERROR = "cart.jsp";
    private final static String SUCCESS = "cart.jsp";

    private static final Logger LOGGER = Logger.getLogger(UpdateCarController.class);

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
        String url = ERROR;
        try {
            HttpSession session = request.getSession();

            String key = request.getParameter("txtKey");
            int quantity = Integer.parseInt(request.getParameter("txtQuantity"));

            if (quantity > 0) {
                CartDTO cart = (CartDTO) session.getAttribute("CART");
                if (cart != null) {
                    CarDTO currentCarDTO = new CarDTO(cart.getCart().get(key));
                    boolean overlap = false;
                    int totalQuantity = quantity;
                    ProductDAO dao = new ProductDAO();
                    for (CarDTO value : cart.getCart().values()) {
                        if (!cart.getKey(value).equals(cart.getKey(currentCarDTO))) {
                            if (currentCarDTO.getStartDate().compareTo(value.getEndDate()) <= 0 && value.getStartDate().compareTo(currentCarDTO.getEndDate()) <= 0) {
                                totalQuantity += value.getQuantity();
                                overlap = true;
                            }
                        }
                    }

                    /*if (overlap) {
                        int getQuantityDB = dao.checkCarAvailableQuantity(currentCarDTO.getCarID());
                        if (getQuantityDB >= totalQuantity) {
                            cart.getCart().get(key).setQuantity(quantity);
                            cart.update(cart.getCart().get(key));
                            request.setAttribute("SUCCESS", true);
                            session.setAttribute("CART", cart);
                        } else {
                            List<CarDTO> outOfStockList = new ArrayList<>();
                            currentCarDTO.setQuantity(getQuantityDB - (totalQuantity - quantity));
                            outOfStockList.add(currentCarDTO);
                            request.setAttribute("OUT_OF_STOCK_LIST", outOfStockList);
                        }
                    } else {
                        cart.getCart().get(key).setQuantity(quantity);
                        cart.update(cart.getCart().get(key));
                        request.setAttribute("SUCCESS", true);
                        session.setAttribute("CART", cart);
                    }*/

                    cart.getCart().get(key).setQuantity(quantity);
                    cart.update(cart.getCart().get(key));
                    request.setAttribute("SUCCESS", true);
                    session.setAttribute("CART", cart);

                    url = SUCCESS;

                }
            }

        } catch (Exception e) {
            LOGGER.error(e.toString());
            request.setAttribute("ERROR_QUANTITY", "Quantity must be integer number!");
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
