package org.example.cab.Admin.controller;

import jakarta.servlet.annotation.WebServlet;
import org.example.cab.Admin.dao.VehicleDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
@WebServlet("/Administrator/ChangeAvailabilityServlet")


public class ChangeAvailabilityServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean isAvailable = Boolean.parseBoolean(request.getParameter("available"));

            VehicleDAO vehicleDAO = new VehicleDAO();
            boolean success = vehicleDAO.updateAvailability(id, isAvailable);

            if (success) {
                response.sendRedirect("view_vehicles.jsp?msg=Availability Updated Successfully");
            } else {
                response.sendRedirect("changeAvailability.jsp?id=" + id + "&error=Update Failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("changeAvailability.jsp?error=Invalid Data");
        }
    }
}
