package org.example.cab.Driver.dao;

import java.sql.*;
import org.example.cab.Driver.model.User;
import org.example.cab.Driver.model.Vehicle; // Import the Vehicle model

public class DriverDAO {

    // Validate driver login
    public boolean validateDriver(String username, String password) {
        String query = "SELECT * FROM driversss WHERE username = ? AND password = ?";

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

    // Get driver by username
    public User getDriverByUsername(String username) {
        User driver = null; // Changed variable name from 'Driver' to 'User'
        String query = "SELECT * FROM driversss WHERE username = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setString(1, username);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                // Create a new User object and populate it with data from the ResultSet
                driver = new User();
                driver.setId(resultSet.getInt("id"));
                driver.setUsername(resultSet.getString("username"));
                driver.setPassword(resultSet.getString("password")); // Note: Password should be handled securely
                driver.setFullName(resultSet.getString("fullName"));
                driver.setEmailAddress(resultSet.getString("emailAddress")); // Updated to match your User model
                driver.setContactNumber(resultSet.getString("contactNumber"));
                driver.setResidentialAddress(resultSet.getString("residentialAddress"));
                driver.setLicenseNumber(resultSet.getString("licenseNumber"));
                driver.setLicenseType(resultSet.getString("licenseType"));
                driver.setExpirationDate(resultSet.getString("expirationDate"));
                driver.setBankAccountNumber(resultSet.getString("bankAccountNumber"));
                driver.setMedicalCertificate(resultSet.getString("medicalCertificate"));
                driver.setEmergencyContactDetails(resultSet.getString("emergencyContactDetails"));
                driver.setCopyOfDrivingLicense(resultSet.getString("copyOfDrivingLicense"));
                driver.setProofOfAddress(resultSet.getString("proofOfAddress"));
                driver.setTermsAccepted(resultSet.getBoolean("termsAccepted"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return driver; // Return the driver object (or null if not found)
    }

    // Get vehicle details for a driver based on driver_id
    public Vehicle getVehicleDetailsByDriverId(int driverId) {
        Vehicle vehicle = null;
        String query = "SELECT * FROM vehicle WHERE driver_id = ?"; // Assuming the table name is 'vehicle' and there is a foreign key to 'driversss'

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setInt(1, driverId);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                // Create a new Vehicle object and populate it with data from the ResultSet
                vehicle = new Vehicle();
                vehicle.setId(resultSet.getInt("id"));
                vehicle.setCategory(resultSet.getString("category"));
                vehicle.setVehicleNumber(resultSet.getString("vehicle_number"));
                vehicle.setCc(resultSet.getInt("cc"));
                vehicle.setEngineNo(resultSet.getString("engine_no"));
                vehicle.setVehiclePhoto(resultSet.getString("vehicle_photo"));
                vehicle.setAvailable(resultSet.getBoolean("available"));
                vehicle.setFuelType(resultSet.getString("fuel_type"));
                vehicle.setSeatCapacity(resultSet.getInt("seat_capacity"));
                vehicle.setRentalPrice(resultSet.getDouble("rental_price"));
                vehicle.setDriverId(resultSet.getInt("driver_id"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return vehicle; // Return the vehicle object (or null if not found)
    }

    // Get driver by ID
    public User getDriverById(int driverId) {
        User driver = null;
        String query = "SELECT * FROM driversss WHERE id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setInt(1, driverId);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                // Create a new User object and populate it with data from the ResultSet
                driver = new User();
                driver.setId(resultSet.getInt("id"));
                driver.setUsername(resultSet.getString("username"));
                driver.setPassword(resultSet.getString("password")); // Note: Password should be handled securely
                driver.setFullName(resultSet.getString("full_name"));
                driver.setEmailAddress(resultSet.getString("emailAddress")); // Updated to match your User model
                driver.setContactNumber(resultSet.getString("contactNumber"));
                driver.setResidentialAddress(resultSet.getString("residentialAddress"));
                driver.setLicenseNumber(resultSet.getString("licenseNumber"));
                driver.setLicenseType(resultSet.getString("licenseType"));
                driver.setExpirationDate(resultSet.getString("expirationDate"));
                driver.setBankAccountNumber(resultSet.getString("bankAccountNumber"));
                driver.setMedicalCertificate(resultSet.getString("medicalCertificate"));
                driver.setEmergencyContactDetails(resultSet.getString("emergencyContactDetails"));
                driver.setCopyOfDrivingLicense(resultSet.getString("copyOfDrivingLicense"));
                driver.setProofOfAddress(resultSet.getString("proofOfAddress"));
                driver.setTermsAccepted(resultSet.getBoolean("termsAccepted"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return driver; // Return the driver object (or null if not found)
    }

    // Delete a driver by ID
    public boolean deleteDriver(int driverId) {
        String query = "DELETE FROM driversss WHERE id = ?";

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