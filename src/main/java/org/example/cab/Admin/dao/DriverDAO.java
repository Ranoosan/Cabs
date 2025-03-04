package org.example.cab.Admin.dao;

import org.example.cab.Admin.model.Driver;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DriverDAO {

    // Add new driver
    public boolean addDriver(Driver driver) {
        String sql = "INSERT INTO driversss (username, password, fullname, contactnumber, emailaddress, residentialaddress, vehicleType, licensetype, expirationdate, bankaccountnumber, emergencycontactdetails, medicalcertificate, copyofdrivinglicense, proofofaddress, termsaccepted) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            // Set parameters from the driver object
            stmt.setString(1, driver.getUsername());
            stmt.setString(2, driver.getPassword());
            stmt.setString(3, driver.getFullName());
            stmt.setString(4, driver.getContactNumber());
            stmt.setString(5, driver.getEmailAddress());
            stmt.setString(6, driver.getResidentialAddress());
            stmt.setString(7, driver.getvehicleType());
            stmt.setString(8, driver.getLicenseType());

            // Ensure proper date handling
            stmt.setDate(9, driver.getExpirationDate() != null ? Date.valueOf(driver.getExpirationDate()) : null);
            stmt.setString(10, driver.getBankAccountNumber());
            stmt.setString(11, driver.getEmergencyContactDetails());
            stmt.setString(12, driver.getMedicalCertificate());
            stmt.setString(13, driver.getCopyOfDrivingLicense());
            stmt.setString(14, driver.getProofOfAddress());
            stmt.setBoolean(15, driver.isTermsAccepted());

            // Execute update and return true if a record was inserted
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            // Log error with more context
            System.err.println("SQL error during driver insertion: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    public boolean updatePendingBookings(int vehicleId, int newDriverId) {
        String updateQuery = "UPDATE bookings SET driver_id = ? WHERE vehicle_id = ? AND status = 'pending'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement updateStmt = conn.prepareStatement(updateQuery)) {

            updateStmt.setInt(1, newDriverId);
            updateStmt.setInt(2, vehicleId);
            int rowsUpdated = updateStmt.executeUpdate();

            return rowsUpdated > 0;

        } catch (SQLException e) {
            System.err.println("SQL error in updating pending bookings: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    // Get all drivers
    public List<Driver> getAllDrivers() {
        List<Driver> drivers = new ArrayList<>();
        String sql = "SELECT * FROM driversss";

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Driver driver = new Driver();
                driver.setId(rs.getInt("id"));
                driver.setUsername(rs.getString("username"));
                driver.setPassword(rs.getString("password"));
                driver.setFullName(rs.getString("fullname"));
                driver.setContactNumber(rs.getString("contactnumber"));
                driver.setEmailAddress(rs.getString("emailaddress"));
                driver.setResidentialAddress(rs.getString("residentialaddress"));
                driver.setVehicleType(rs.getString("vehicleType"));
                driver.setLicenseType(rs.getString("licensetype"));
                driver.setExpirationDate(rs.getDate("expirationdate").toLocalDate());
                driver.setBankAccountNumber(rs.getString("bankaccountnumber"));
                driver.setEmergencyContactDetails(rs.getString("emergencycontactdetails"));
                driver.setMedicalCertificate(rs.getString("medicalcertificate"));
                driver.setCopyOfDrivingLicense(rs.getString("copyofdrivinglicense"));
                driver.setProofOfAddress(rs.getString("proofofaddress"));
                driver.setTermsAccepted(rs.getBoolean("termsaccepted"));
                drivers.add(driver);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return drivers;
    }


    // Get drivers by vehicle type
    public List<Driver> getDriversByVehicleType(String vehicleType) {
        List<Driver> drivers = new ArrayList<>();
        String sql = "SELECT * FROM driversss WHERE vehicleType = ? OR vehicleType = 'all'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, vehicleType);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Driver driver = new Driver();
                driver.setId(rs.getInt("id"));
                driver.setUsername(rs.getString("username"));
                driver.setPassword(rs.getString("password"));
                driver.setFullName(rs.getString("fullname"));
                driver.setContactNumber(rs.getString("contactnumber"));
                driver.setEmailAddress(rs.getString("emailaddress"));
                driver.setResidentialAddress(rs.getString("residentialaddress"));
                driver.setVehicleType(rs.getString("vehicleType"));
                driver.setLicenseType(rs.getString("licensetype"));
                driver.setExpirationDate(rs.getDate("expirationdate").toLocalDate());
                driver.setBankAccountNumber(rs.getString("bankaccountnumber"));
                driver.setEmergencyContactDetails(rs.getString("emergencycontactdetails"));
                driver.setMedicalCertificate(rs.getString("medicalcertificate"));
                driver.setCopyOfDrivingLicense(rs.getString("copyofdrivinglicense"));
                driver.setProofOfAddress(rs.getString("proofofaddress"));
                driver.setTermsAccepted(rs.getBoolean("termsaccepted"));
                drivers.add(driver);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return drivers;
    }

    // Delete driver by ID
    public boolean deleteDriver(int driverId) {
        String sql = "DELETE FROM driversss WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, driverId);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("SQL error during driver deletion: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    public Driver getDriverByVehicleId(String vehicleIdParam) {
        Driver driver = null;
        String query = "SELECT d.* FROM driversss d " +
                "JOIN vehicle v ON d.id = v.driver_id " +
                "WHERE v.id = ?"; // Assuming vehicle ID is used for the vehicle table

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setString(1, vehicleIdParam);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                driver = new Driver();
                driver.setId(resultSet.getInt("id"));
                driver.setFullName(resultSet.getString("fullname"));
                driver.setContactNumber(resultSet.getString("contactnumber"));
                driver.setEmailAddress(resultSet.getString("emailAddress"));
                driver.setResidentialAddress(resultSet.getString("residentialAddress"));
                driver.setVehicleType(resultSet.getString("vehicleType"));
                driver.setLicenseType(resultSet.getString("licenseType"));
                driver.setExpirationDate(resultSet.getDate("expirationDate").toLocalDate());
                // Set other attributes as necessary
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return driver;
    }

    // Get drivers by vehicle category
    public List<Driver> getDriversByVehicleCategory(String category) {
        List<Driver> drivers = new ArrayList<>();
        String sql = "SELECT * FROM driversss WHERE vehicleType = ? ";  // Adjust column name if necessary

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, category);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Driver driver = new Driver();
                driver.setId(rs.getInt("id"));
                driver.setUsername(rs.getString("username"));
                driver.setPassword(rs.getString("password"));
                driver.setFullName(rs.getString("fullname"));
                driver.setContactNumber(rs.getString("contactnumber"));
                driver.setEmailAddress(rs.getString("emailaddress"));
                driver.setResidentialAddress(rs.getString("residentialaddress"));
                driver.setVehicleType(rs.getString("vehicleType"));
                driver.setLicenseType(rs.getString("licensetype"));
                driver.setExpirationDate(rs.getDate("expirationdate").toLocalDate());
                driver.setBankAccountNumber(rs.getString("bankaccountnumber"));
                driver.setEmergencyContactDetails(rs.getString("emergencycontactdetails"));
                driver.setMedicalCertificate(rs.getString("medicalcertificate"));
                driver.setCopyOfDrivingLicense(rs.getString("copyofdrivinglicense"));
                driver.setProofOfAddress(rs.getString("proofofaddress"));
                driver.setTermsAccepted(rs.getBoolean("termsaccepted"));
                drivers.add(driver);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return drivers;
    }


}
