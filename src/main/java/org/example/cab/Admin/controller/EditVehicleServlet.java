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

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2,  // 2MB threshold
        maxFileSize = 1024 * 1024 * 10,      // 10MB max file size
        maxRequestSize = 1024 * 1024 * 50)   // 50MB max request size
public class EditVehicleServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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

            // Handle file upload for vehicle photo
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

            // Create vehicle object and update details
            Vehicle vehicle = new Vehicle(id, category, vehicleNumber, cc, engineNo, fuelType, seatCapacity, rentalPrice, driverId, uploadPath);
            VehicleDAO vehicleDAO = new VehicleDAO();
            boolean success = vehicleDAO.updateVehicle(vehicle);

            if (success) {
                response.sendRedirect("view_vehicle.jsp?msg=Vehicle Updated Successfully");
            } else {
                response.sendRedirect("editVehicle.jsp?id=" + id + "&error=Update Failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("editVehicle.jsp?error=Invalid Data");
        }
    }
}
