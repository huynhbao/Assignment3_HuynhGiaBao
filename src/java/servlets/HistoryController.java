/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import daos.UserDAO;
import dtos.OrderDTO;
import dtos.SearchDTO;
import dtos.UserDTO;
import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;
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
@WebServlet(name = "HistoryController", urlPatterns = {"/HistoryController"})
public class HistoryController extends HttpServlet {

    private static final String ERROR = "invalid.jsp";
    private static final String SUCCESS = "history.jsp";

    private static final Logger LOGGER = Logger.getLogger(HistoryController.class);

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
            String searchName = request.getParameter("txtSearchName");
            String searchDate = request.getParameter("txtSearchDate");
            String page = request.getParameter("page");

            int currentPage = 1;

            if (page != null) {
                if ("".equals(page)) {
                    currentPage = 1;
                } else {
                    currentPage = Integer.parseInt(page);
                    if (currentPage == 0) {
                        currentPage = 1;
                    }
                }
            }
            if (searchName == null) {
                searchName = "";
            }
            if (searchDate == null) {
                searchDate = "";
            }
            UserDAO dao = new UserDAO();
            SearchDTO search = new SearchDTO();
            boolean searching = !searchName.isEmpty() || !searchDate.isEmpty();
            search.setName(searchName);
            if (searching) {
                if (!searchDate.isEmpty()) {
                    DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
                    try {
                        search.setStartDate(df.parse(searchDate));
                    } catch (ParseException ex) {
                        request.setAttribute("MSG", "Date wrong format!");
                    }

                }

            }

            Map<Integer, List<OrderDTO>> listSearch = dao.searchOrderHistory(currentPage, user.getEmail(), search);

            int rows = listSearch.keySet().stream().findFirst().get();
            int nOfPages = (int) Math.ceil(rows / (double) MyUtils.recordPerPage);
            request.setAttribute("LIST", listSearch.get(rows));
            request.setAttribute("noOfPages", nOfPages);
            request.setAttribute("currentPage", currentPage);
            String msg = (String) request.getAttribute("SUCCESS");
            if (msg != null) {
                request.setAttribute("SUCCESS", Boolean.parseBoolean(msg));
            }
            
            url = SUCCESS;
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
