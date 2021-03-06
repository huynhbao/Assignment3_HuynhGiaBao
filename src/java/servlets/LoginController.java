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
import dtos.UserDTO;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
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
@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {

    private static final String ERROR = "login.jsp";
    private static final String SUCCESS = "ShoppingController";
    private static final Logger LOGGER = Logger.getLogger(LoginController.class);

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
            UserDTO userSs = (UserDTO) session.getAttribute("LOGIN_USERDTO");

            if (userSs != null) {

            } else {
                String email = request.getParameter("txtEmail");
                String password = request.getParameter("txtPassword");

                if (email != null || password != null) {
                    UserDAO dao = new UserDAO();

                    UserDTO user = dao.checkLogin(email, password);
                    if (user != null) {
                        if (user.getStatus()) {
                            session.setAttribute("LOGIN_USERDTO", user);
                            url = SUCCESS;
                            CartDTO cart = (CartDTO) session.getAttribute("CART");
                            if (cart == null) {
                                cart = new CartDTO(user.getEmail(), null);
                            }
                            
                            ProductDAO pdao = new ProductDAO();
                            
                            DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
                            CarDTO car1 = pdao.getCarDTO(1);
                            car1.setStartDate(df.parse("2021-03-05"));
                            car1.setEndDate(df.parse("2021-03-07"));
                            car1.setQuantity(1);
                            int days1 = MyUtils.getDays(car1.getStartDate(), car1.getEndDate());
                            car1.setDays(days1);
                            cart.add(car1);
                            
                            CarDTO car2 = pdao.getCarDTO(1);
                            car2.setStartDate(df.parse("2021-03-06"));
                            car2.setEndDate(df.parse("2021-03-08"));
                            car2.setQuantity(1);
                            int days2 = MyUtils.getDays(car2.getStartDate(), car2.getEndDate());
                            car2.setDays(days2);
                            cart.add(car2);
                            
                            session.setAttribute("CART", cart);
                        } else {
                            request.setAttribute("LOGIN_MSG", "Your account has not been activated!");
                        }
                    } else {
                        request.setAttribute("LOGIN_MSG", "Email or Password incorrect!");
                    }
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
