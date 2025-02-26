package org.example.cab.Admin.controller;

import jakarta.servlet.annotation.WebServlet;
import org.example.cab.Admin.dao.VehicleDAO;
import org.example.cab.Admin.model.Vehicle;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
@WebServlet({"/Administrator/EditVehicleServlet", "/Administrator/ChangeAvailabilityServlet"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2,  // 2MB threshold
        maxFileSize = 1024 * 1024 * 10,      // 10MB max file size
        maxRequestSize = 1024 * 1024 * 50)   // 50MB max request size
public class VehicleUpdateServlet extends HttpServlet {
    private static final String ADMIN_DASHBOARD = "admin_dashboard.jsp";
    private static final String EDIT_VEHICLE = "editVehicle.jsp";
    private static final String CHANGE_AVAILABILITY = "changeAvailability.jsp";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("updateVehicle".equals(action)) {
            updateVehicle(request, response);
        } else if ("updateAvailability".equals(action)) {
            updateAvailability(request, response);
        } else {
            response.sendRedirect(ADMIN_DASHBOARD + "?error=Invalid Action");
        }
    }

    private void updateVehicle(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String category = request.getParameter("category");
            String vehicleNumber = request.getParameter("vehicle_number");
            String cc = request.getParameter("cc");
            String engineNo = request.getParameter("engine_no");
            String fuelType = request.getParameter("fuel_type");
            int seatCapacity = Integer.parseInt(request.getParameter("seat_capacity"));
            double rentalPrice = Double.parseDouble(request.getParameter("rental_price"));
            int driverId = Integer.parseInt(request.getParameter("driver_id"));

            // Handle file upload
            Part filePart = request.getPart("vehicle_photo");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            String filePath = "";
            if (fileName != null && !fileName.isEmpty()) {
                filePath = uploadPath + File.separator + fileName;
                filePart.write(filePath);
            }

            // Create a Vehicle object with the updated information
            Vehicle vehicle = new Vehicle(id, category, vehicleNumber, cc, engineNo, fuelType, seatCapacity, rentalPrice, driverId, filePath);
            VehicleDAO vehicleDAO = new VehicleDAO();
            boolean success = vehicleDAO.updateVehicle(vehicle); // Call the updateVehicle method in VehicleDAO

            if (success) {
                response.sendRedirect(ADMIN_DASHBOARD + "?msg=Vehicle Updated Successfully");
            } else {
                response.sendRedirect(EDIT_VEHICLE + "?id=" + id + "&error=Update Failed");
            }
        } catch (Exception e) {
            e.printStackTrace(); // Consider using a logger for better error handling
            response.sendRedirect(EDIT_VEHICLE + "?error=Invalid Data");
        }
    }

    private void updateAvailability(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean isAvailable = Boolean.parseBoolean(request.getParameter("available"));

            VehicleDAO vehicleDAO = new VehicleDAO();
            boolean success = vehicleDAO.updateAvailability(id, isAvailable);

            if (success) {
                response.sendRedirect(ADMIN_DASHBOARD + "?msg=Availability Updated Successfully");
            } else {
                response.sendRedirect(CHANGE_AVAILABILITY + "?id=" + id + "&error=Update Failed");
            }
        } catch (Exception e) {
            e.printStackTrace(); // Consider using a logger for better error handling
            response.sendRedirect(CHANGE_AVAILABILITY + "?error=Invalid Data");
        }
    }
}
