package org.example.cab.Driver.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DriverDAO {

    // Validate driver login
    public boolean validateDriver(String username, String password) {
        String query = "SELECT * FROM drivers WHERE username = ? AND password = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setString(1, username);
            preparedStatement.setString(2, password);
            ResultSet resultSet = preparedStatement.executeQuery();

            return resultSet.next(); // If record exists, return true
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete a driver by ID
    public boolean deleteDriver(int driverId) {
        String query = "DELETE FROM drivers WHERE id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setInt(1, driverId);
            return preparedStatement.executeUpdate() > 0; // Returns true if at least one record is deleted
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
