package org.example.cab.Admin.controller;


import org.example.cab.Admin.dao.VehicleDAO;
import org.example.cab.Admin.dao.DriverDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/Administrator/booking/AssignDriverServlet")
public class AssignDriverServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final VehicleDAO vehicleDAO = new VehicleDAO();
    private final DriverDAO driverDAO = new DriverDAO(); // Added DriverDAO

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
            int driverId = Integer.parseInt(request.getParameter("driverId"));

            boolean assigned = vehicleDAO.assignVehicleToDriver(vehicleId, driverId);

            if (assigned) {
                // Update pending bookings for the driver
                boolean updated = driverDAO.updatePendingBookings(vehicleId, driverId);

                if (updated) {
                    response.sendRedirect("assignVehicle.jsp?message=Vehicle assigned successfully, and pending bookings updated!&status=success");
                } else {
                    response.sendRedirect("assignVehicle.jsp?message=Vehicle assigned, but failed to update pending bookings!&status=warning");
                }
            } else {
                response.sendRedirect("assignVehicle.jsp?message=Error assigning vehicle!&status=error");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("assignVehicle.jsp?message=Invalid data!&status=error");
        }
    }
}
