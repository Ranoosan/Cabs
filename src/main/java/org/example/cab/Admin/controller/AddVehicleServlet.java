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

@WebServlet("/Administrator/AddVehicleServlet")
@MultipartConfig
public class AddVehicleServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String category = request.getParameter("category");
        String vehicleNumber = request.getParameter("vehicle_number");
        String cc = request.getParameter("cc");
        String engineNo = request.getParameter("engine_no");
        boolean available = Boolean.parseBoolean(request.getParameter("available"));
        String fuelType = request.getParameter("fuel_type");
        int seatCapacity = Integer.parseInt(request.getParameter("seat_capacity"));
        double rentalPrice = Double.parseDouble(request.getParameter("rental_price"));
        int driverId = Integer.parseInt(request.getParameter("driver_id"));

        Part filePart = request.getPart("vehicle_photo"); // Retrieves <input type="file" name="vehicle_photo">
        String fileName = filePart.getSubmittedFileName();
        String uploadPath = getServletContext().getRealPath("/uploads") + File.separator + fileName;
        filePart.write(uploadPath); // Save file to the specified location

        Vehicle vehicle = new Vehicle();
        vehicle.setCategory(category);
        vehicle.setVehicleNumber(vehicleNumber);
        vehicle.setCc(cc);
        vehicle.setEngineNo(engineNo);
        vehicle.setAvailable(available);
        vehicle.setFuelType(fuelType);
        vehicle.setSeatCapacity(seatCapacity);
        vehicle.setRentalPrice(rentalPrice);
        vehicle.setVehiclePhoto(fileName);
        vehicle.setDriverId(driverId); // Set the driver ID

        VehicleDAO dao = new VehicleDAO();
        if (dao.addVehicle(vehicle)) {
            response.sendRedirect("view_vehicles.jsp"); // Redirect to the vehicle list page
        } else {
            request.setAttribute("errorMessage", "Failed to add vehicle.");
            request.getRequestDispatcher("add_vehicle.jsp").forward(request, response);
        }
    }
}
