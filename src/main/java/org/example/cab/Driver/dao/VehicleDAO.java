package org.example.cab.Driver.dao;

import org.example.cab.Driver.model.Vehicle;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VehicleDAO {
    private String dbURL = "jdbc:mysql://localhost:3306/cabs"; // Change to your database URL
    private String dbUser = "root"; // Change to your database username
    private String dbPassword = ""; // Change to your database password

    public List<Vehicle> getVehiclesByDriverId(int driverId) {
        List<Vehicle> vehicles = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Load MySQL JDBC Driver
            Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

            // SQL query to retrieve vehicles for the specified driver
            String sql = "SELECT * FROM vehicle WHERE driver_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, driverId); // Set driver ID

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                // Create Vehicle object and populate it with data from the database
                Vehicle vehicle = new Vehicle();
                vehicle.setId(rs.getInt("id"));
                vehicle.setCategory(rs.getString("category"));
                vehicle.setVehicleNumber(rs.getString("vehicle_number"));
                vehicle.setCc(rs.getInt("cc"));
                vehicle.setEngineNo(rs.getString("engine_no"));
                vehicle.setVehiclePhoto(rs.getString("vehicle_photo"));
                vehicle.setAvailable(rs.getBoolean("available"));
                vehicle.setFuelType(rs.getString("fuel_type"));
                vehicle.setSeatCapacity(rs.getInt("seat_capacity"));
                vehicle.setRentalPrice(rs.getDouble("rental_price"));
                vehicle.setDriverId(rs.getInt("driver_id"));
                vehicles.add(vehicle); // Add vehicle to the list
            }
            conn.close(); // Close the connection
        } catch (Exception e) {
            e.printStackTrace();
        }
        return vehicles;
    }
}
