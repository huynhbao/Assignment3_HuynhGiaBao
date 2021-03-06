/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import daos.ProductDAO;
import dtos.CarDTO;
import dtos.CategoryDTO;
import dtos.SearchDTO;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
@WebServlet(name = "ShoppingController", urlPatterns = {"/ShoppingController"})
public class ShoppingController extends HttpServlet {

    private static final String ERROR = "invalid.jsp";
    private static final String SUCCESS = "shopping.jsp";

    private static final Logger LOGGER = Logger.getLogger(ShoppingController.class);

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
            ProductDAO pDAO = new ProductDAO();

            String searchName = request.getParameter("txtSearchCarName");
            String searchStartDate = request.getParameter("txtStartDate");
            String searchEndDate = request.getParameter("txtEndDate");
            String searchCategory = request.getParameter("cbCategory");
            String searchQuantity = request.getParameter("txtQuantity");

            String currentPageParam = request.getParameter("page");
            int currentPage = 1;
            if (currentPageParam != null) {
                if ("".equals(currentPageParam)) {
                    currentPage = 1;
                } else {
                    currentPage = Integer.parseInt(currentPageParam);

                    if (currentPage == 0) {
                        currentPage = 1;
                    }
                }
            }

            if (searchCategory == null) {
                searchCategory = "";
            }
            if (searchName == null) {
                searchName = "";
            }
            if (searchQuantity == null) {
                searchQuantity = "";
            }
            if (searchStartDate == null) {
                searchStartDate = "";
            }
            if (searchEndDate == null) {
                searchEndDate = "";
            }

            Map<Integer, List<CarDTO>> productList = new HashMap<>();
            productList.put(0, null);
            boolean emptySearch = searchCategory.isEmpty() && searchName.isEmpty() && searchQuantity.isEmpty() && searchStartDate.isEmpty() && searchEndDate.isEmpty();
            if (!emptySearch) {
                boolean hasRequiredField = true;
                SearchDTO search = new SearchDTO();
                DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
                Date startDate = null;
                Date endDate = null;
                
                if (searchName.isEmpty() && searchCategory.isEmpty()) {
                    hasRequiredField = false;
                    request.setAttribute("ERROR_NAME", "Name is empty!");
                    request.setAttribute("ERROR_CATEGORY", "Category is empty!");
                }
                
                if (searchStartDate.isEmpty()) {
                    hasRequiredField = false;
                    request.setAttribute("ERROR_START_DATE", "Start Date is empty!");
                } else {
                    startDate = df.parse(searchStartDate);
                }

                if (searchEndDate.isEmpty()) {
                    hasRequiredField = false;
                    request.setAttribute("ERROR_END_DATE", "End Date is empty!");
                } else {
                    endDate = df.parse(searchEndDate);
                }

                if (startDate != null && endDate != null) {
                    Date now = df.parse(df.format(new Date()));
                    if (startDate.after(endDate)) {
                        hasRequiredField = false;
                        request.setAttribute("ERROR_END_DATE", "End Date must greater or equal start date!");
                    } else if (startDate.compareTo(now) < 0) {
                        hasRequiredField = false;
                        request.setAttribute("ERROR_START_DATE", "The rental date must be greater than the current date!");
                    } else {
                        search.setStartDate(startDate);
                        search.setEndDate(endDate);
                    }
                } else {
                    hasRequiredField = false;
                }

                if (searchQuantity.isEmpty()) {
                    hasRequiredField = false;
                    request.setAttribute("ERROR_QUANTITY", "Quantity is empty!");
                } else {
                    try {
                        int quantity = Integer.parseInt(searchQuantity);
                        if (quantity <= 0) {
                            hasRequiredField = false;
                            request.setAttribute("ERROR_QUANTITY", "Quantity must greater or equal 0!");
                        } else {
                            search.setQuantity(quantity);
                        }
                    } catch (NumberFormatException ex) {
                        hasRequiredField = false;
                        request.setAttribute("ERROR_QUANTITY", "Quantity must be integer number!");
                        LOGGER.error(ex.toString());
                    }
                }

                if (hasRequiredField) {

                    if (!searchName.isEmpty()) {
                        search.setName(searchName);
                    }
                    
                    if (!searchCategory.isEmpty()) {
                        search.setCategoryID(searchCategory);
                    }

                    productList = pDAO.searchProduct(currentPage, search);
                }

            }

            List<CategoryDTO> categoryList = pDAO.getCategories();
            int rows = productList.keySet().stream().findFirst().get();

            int nOfPages = (int) Math.ceil(rows / (double) MyUtils.recordPerPage);
            request.setAttribute("PRODUCT_LIST", productList.get(rows));
            request.setAttribute("CATEGORY_LIST", categoryList);
            request.setAttribute("noOfPages", nOfPages);
            request.setAttribute("currentPage", currentPage);
            if (request.getAttribute("SUCCESS") != null) {
                request.setAttribute("SUCCESS" , true);
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
