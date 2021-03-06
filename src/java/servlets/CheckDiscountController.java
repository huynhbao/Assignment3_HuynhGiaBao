/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import com.google.gson.Gson;
import daos.UserDAO;
import dtos.DiscountDTO;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

/**
 *
 * @author HuynhBao
 */
@WebServlet(name = "CheckDiscountController", urlPatterns = {"/CheckDiscountController"})
public class CheckDiscountController extends HttpServlet {

    //private final static String ERROR = "cart.jsp";
    //private final static String SUCCESS = "cart.jsp";
    private static final Logger LOGGER = Logger.getLogger(CheckDiscountController.class);

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
        //String url = ERROR;
        try {
            String discountID = request.getParameter("txtDiscount");
            Gson gson = new Gson();
            String json = gson.toJson("Empty");
            if (!"".equals(discountID)) {
                json = gson.toJson("NotFound");
                UserDAO dao = new UserDAO();
                DiscountDTO discount = dao.checkDiscount(discountID);
                if (discount != null) {
                    DateFormat df = new SimpleDateFormat("dd-MM-yyyy");
                    Date now = df.parse(df.format(new Date()));
                    if (now.compareTo(discount.getStartDate()) >= 0 && now.compareTo(discount.getEndDate()) <= 0) {
                        double total = Double.parseDouble(request.getParameter("txtTotal"));
                        dao.calculateDiscount(discount, total);
                        json = gson.toJson(discount);
                    } else {
                        json = gson.toJson("Expired");
                    }
                }

            }
            response.setContentType("application/json");
            response.getWriter().write(json);

        } catch (Exception e) {
            LOGGER.error(e.toString());
        } finally {
            //request.getRequestDispatcher(url).forward(request, response);
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
