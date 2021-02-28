/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import daos.ProductDAO;
import dtos.CarDTO;
import dtos.CartDTO;
import dtos.UserDTO;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
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
@WebServlet(name = "AddCarController", urlPatterns = {"/AddCarController"})
public class AddCarController extends HttpServlet {

    private static final String ERROR = "invalid.jsp";
    private static final String SUCCESS = "ShoppingController";

    private static final Logger LOGGER = Logger.getLogger(AddCarController.class);

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
            UserDTO user = (UserDTO) session.getAttribute("LOGIN_USERDTO");

            String carID = request.getParameter("txtCarID");
            String startDateStr = request.getParameter("txtStartDate");
            String endDateStr = request.getParameter("txtEndDate");

            CartDTO cart = (CartDTO) session.getAttribute("CART");
            if (cart == null) {
                cart = new CartDTO(user.getEmail(), null);
            }

            try {
                ProductDAO dao = new ProductDAO();
                CarDTO car = dao.getCarDTO(Integer.parseInt(carID));
                if (car != null) {
                    DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
                    Date startDate = null;
                    Date endDate = null;
                    if (startDateStr.isEmpty()) {
                        request.setAttribute("MSG", "Start Date is empty!");
                    } else {
                        startDate = df.parse(startDateStr);
                    }

                    if (endDateStr.isEmpty()) {
                        request.setAttribute("MSG", "End Date is empty!");
                    } else {
                        endDate = df.parse(endDateStr);
                    }

                    if (startDate != null && endDate != null) {
                        Date now = df.parse(df.format(new Date()));
                        if (startDate.after(endDate)) {
                            request.setAttribute("MSG", "End Date must greater or equal start date!");
                        } else if (startDate.compareTo(now) < 0) {
                            request.setAttribute("ERROR_START_DATE", "The rental date must be greater than the current date!");
                        } else if (endDate.compareTo(startDate) <= 0) {
                            request.setAttribute("MSG", "You must rent a minimum of 1 day!");
                        } else {
                            car.setStartDate(startDate);
                            car.setEndDate(endDate);
                            car.setQuantity(1);
                            cart.add(car);
                            session.setAttribute("CART", cart);
                            request.setAttribute("SUCCESS", true);
                            url = SUCCESS;
                        }
                    }

                } else {
                    request.setAttribute("MSG", "Car not found");
                }
            } catch (NumberFormatException ex) {
                request.setAttribute("MSG", "Car not found");
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
