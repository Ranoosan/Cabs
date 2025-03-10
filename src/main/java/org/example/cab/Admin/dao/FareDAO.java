package org.example.cab.Admin.dao;

import java.sql.*;

public class FareDAO {

    public static Double getFare(String pickupLocation, String dropOffLocation) {
        Double fare = null;

        // Check that the values received in the parameters are correct
        System.out.println("Fetching fare for pickup: " + pickupLocation + ", dropoff: " + dropOffLocation);

        // Database connection and query to fetch fare
        String query = "SELECT fare FROM cityfares WHERE from_city = ? AND to_city = ?";

        try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/cabs", "root", "");
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setString(1, pickupLocation);
            stmt.setString(2, dropOffLocation);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    fare = rs.getDouble("fare");
                    System.out.println("Fare found: " + fare);
                } else {
                    System.out.println("No fare found for this route.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Return fare
        return fare;
    }
}
