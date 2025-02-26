package org.example.cab.Admin.controller;

import org.example.cab.Admin.dao.DriverDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/Administrator/delete_driver")
public class DeleteDriverController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String driverIdParam = request.getParameter("driverId");

        if (driverIdParam == null || driverIdParam.isEmpty()) {
            request.setAttribute("errorMessage", "Invalid driver ID.");
            request.getRequestDispatcher("/Administrator/view_drivers.jsp").forward(request, response);
            return;
        }

        int driverId;
        try {
            driverId = Integer.parseInt(driverIdParam);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid driver ID format.");
            request.getRequestDispatcher("/Administrator/view_drivers.jsp").forward(request, response);
            return;
        }

        DriverDAO driverDAO = new DriverDAO();
        boolean isDeleted = driverDAO.deleteDriver(driverId);

        if (isDeleted) {
            // Redirect to view_drivers.jsp with alert
            response.setContentType("text/html");
            response.getWriter().println("<html><body>");
            response.getWriter().println("<script type='text/javascript'>");
            response.getWriter().println("alert('Driver deleted successfully!');");
            response.getWriter().println("window.location.href = '" + request.getContextPath() + "/Administrator/view_drivers.jsp';");
            response.getWriter().println("</script>");
            response.getWriter().println("</body></html>");
        } else {
            request.setAttribute("errorMessage", "Error deleting driver.");
            request.getRequestDispatcher("/Administrator/view_drivers.jsp").forward(request, response);
        }
    }
}
