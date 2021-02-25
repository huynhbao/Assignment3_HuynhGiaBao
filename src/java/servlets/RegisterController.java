/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import daos.UserDAO;
import dtos.UserDTO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import utils.MyUtils;

/**
 *
 * @author HuynhBao
 */
@WebServlet(name = "RegisterController", urlPatterns = {"/RegisterController"})
public class RegisterController extends HttpServlet {

    private static final String ERROR = "register.jsp";
    private static final String SUCCESS = "login.jsp";
    private final Logger LOG = Logger.getLogger(RegisterController.class);

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
            String email = request.getParameter("txtEmail");
            String name = request.getParameter("txtName");
            String phone = request.getParameter("txtPhone");
            String address = request.getParameter("txtAddress");
            String password = request.getParameter("txtPassword");
            String confirm = request.getParameter("txtConfirm");

            boolean check = true;

            if (email == null && name == null && password == null && confirm == null && phone == null && address == null) {
                check = false;
            } else {

                if (email.isEmpty()) {
                    request.setAttribute("ERROR_EMAIL", "Email cannot empty");
                    check = false;
                } else {
                    if (!email.matches(MyUtils.EMAIL_PATTERN)) {
                        request.setAttribute("ERROR_EMAIL", "Email is wrong format!");
                        check = false;
                    }
                }

                if (name.isEmpty()) {
                    request.setAttribute("ERROR_NAME", "Name cannot empty");
                    check = false;
                } else {
                    name = MyUtils.capitalFullName(name);
                    String newFullName = MyUtils.removeAccent(name);
                    if (!newFullName.matches(MyUtils.FULLNAME_PATTERN)) {
                        request.setAttribute("ERROR_NAME", "FullName must not contain special characters");
                        check = false;
                    }
                }

                if (phone.isEmpty()) {
                    request.setAttribute("ERROR_PHONE", "Phone cannot empty");
                    check = false;
                } else {
                    if (!phone.matches(MyUtils.PHONE_PATTERN)) {
                        request.setAttribute("ERROR_PHONE", "Phone must is 10 numbers");
                        check = false;
                    }
                }

                if (address.isEmpty()) {
                    request.setAttribute("ERROR_ADDRESS", "Address cannot empty");
                    check = false;
                }

                if (password.equals("") || confirm.equals("")) {
                    request.setAttribute("ERROR_PASSWORD", "Password cannot empty");
                    check = false;
                } else {
                    if (!password.equals(confirm)) {
                        request.setAttribute("ERROR_PASSWORD", "Confirm password not mismatch");
                        check = false;
                    } else {
                        if (password.length() < 6) {
                            request.setAttribute("ERROR_PASSWORD", "Password length must greater or equal 6 characters");
                            check = false;
                        }
                    }
                }
            }

            if (check) {
                UserDAO dao = new UserDAO();

                UserDTO user = new UserDTO(email, name, password, phone, address, false);
                dao.register(user);
                request.setAttribute("LOGIN_MSG", "Register successful! Please check your email to active your account!");
                url = SUCCESS;
            }

        } catch (Exception e) {
            if (e.toString().contains("duplicate")) {
                request.setAttribute("ERROR_EMAIL", "Email was existed!");
            } else {
                LOG.error(e.toString());
            }
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
