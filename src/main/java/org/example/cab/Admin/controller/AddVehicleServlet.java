package org.example.cab.Admin.controller;

import org.example.cab.Admin.dao.VehicleDAO;
import org.example.cab.Admin.model.Vehicle;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@WebServlet("/Administrator/AddVehicleServlet")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1MB
        maxFileSize = 10 * 1024 * 1024, // 10MB
        maxRequestSize = 50 * 1024 * 1024 // 50MB
)
public class AddVehicleServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String category = request.getParameter("category");
            String vehicleNumber = request.getParameter("vehicle_number");
            String cc = request.getParameter("cc");
            String engineNo = request.getParameter("engine_no");
            boolean available = Boolean.parseBoolean(request.getParameter("available"));
            String fuelType = request.getParameter("fuel_type");
            int seatCapacity = Integer.parseInt(request.getParameter("seat_capacity"));
            double rentalPrice = Double.parseDouble(request.getParameter("rental_price"));
            int driverId = Integer.parseInt(request.getParameter("driver_id"));
            String vehicle_model_name = request.getParameter("vehicle_model_name");

            VehicleDAO dao = new VehicleDAO();
            if (dao.isDriverAssigned(driverId, category)) {
                request.setAttribute("errorMessage", "This driver is already assigned to a " + category + ". Please choose another driver.");
                request.getRequestDispatcher("add_vehicle.jsp").forward(request, response);
                return;
            }

            Part filePart = request.getPart("vehicle_photo"); // Make sure this matches the input field name
            if (filePart == null) {
                throw new IllegalArgumentException("File part is null");
            }

            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // Extract filename
            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            String filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath);

            Vehicle vehicle = new Vehicle();
            vehicle.setCategory(category);
            vehicle.setVehicleNumber(vehicleNumber);
            vehicle.setCc(cc);
            vehicle.setEngineNo(engineNo);
            vehicle.setAvailable(available);
            vehicle.setFuelType(fuelType);
            vehicle.setSeatCapacity(seatCapacity);
            vehicle.setRentalPrice(rentalPrice);
            vehicle.setVehiclePhoto("uploads/" + fileName);
            vehicle.setDriverId(driverId);
            vehicle.setVehicle_model_name(vehicle_model_name);

            if (dao.addVehicle(vehicle)) {
                response.sendRedirect("view_vehicles.jsp"); // Redirect to the vehicle list page
            } else {
                request.setAttribute("errorMessage", "This driver is already assigned to a " + category + ". Please choose another driver.");
                request.getRequestDispatcher("add_vehicle.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error processing request: " + e.getMessage());
            request.getRequestDispatcher("add_vehicle.jsp").forward(request, response);
        }
    }
}
