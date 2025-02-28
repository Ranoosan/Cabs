package org.example.cab.Admin.dao;

import org.example.cab.Admin.model.Vehicle;
import org.example.cab.Admin.model.Driver;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VehicleDAO {
    private static final String URL = "jdbc:mysql://localhost:3306/cabs";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    // Add a new vehicle
    public boolean addVehicle(Vehicle vehicle) {
        String sql = "INSERT INTO vehicle (category, vehicle_number, cc, engine_no, vehicle_photo, available, fuel_type, seat_capacity, rental_price, vehicle_model_name) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, vehicle.getCategory());
            stmt.setString(2, vehicle.getVehicleNumber());
            stmt.setString(3, vehicle.getCc());
            stmt.setString(4, vehicle.getEngineNo());
            stmt.setString(5, vehicle.getVehiclePhoto());
            stmt.setBoolean(6, vehicle.isAvailable());
            stmt.setString(7, vehicle.getFuelType());
            stmt.setInt(8, vehicle.getSeatCapacity());
            stmt.setDouble(9, vehicle.getRentalPrice());
            stmt.setString(10, vehicle.getVehicle_model_name());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean assignVehicleToDriver(int vehicleId, int driverId) {
        String checkSql = "SELECT COUNT(*) FROM vehicle_assignment WHERE vehicle_id = ?";
        String updateAssignmentSql = "UPDATE vehicle_assignment SET driver_id = ? WHERE vehicle_id = ?";
        String insertAssignmentSql = "INSERT INTO vehicle_assignment (vehicle_id, driver_id) VALUES (?, ?)";
        String updateVehicleSql = "UPDATE vehicle SET driver_id = ? WHERE id = ?";

        // Using try-with-resources for auto-closeable resources
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD)) {
            // Start a transaction to ensure atomic operations
            conn.setAutoCommit(false);

            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                // Check if the vehicle is already assigned
                checkStmt.setInt(1, vehicleId);
                ResultSet rs = checkStmt.executeQuery();
                rs.next();
                int count = rs.getInt(1);

                boolean isSuccess = false;

                // If the vehicle is already assigned, update both tables
                if (count > 0) {
                    try (PreparedStatement updateAssignmentStmt = conn.prepareStatement(updateAssignmentSql);
                         PreparedStatement updateVehicleStmt = conn.prepareStatement(updateVehicleSql)) {

                        // Update the vehicle_assignment table
                        updateAssignmentStmt.setInt(1, driverId);
                        updateAssignmentStmt.setInt(2, vehicleId);

                        // Update the vehicle table
                        updateVehicleStmt.setInt(1, driverId);
                        updateVehicleStmt.setInt(2, vehicleId);

                        // Execute both update queries
                        int assignmentUpdated = updateAssignmentStmt.executeUpdate();
                        int vehicleUpdated = updateVehicleStmt.executeUpdate();

                        // If both are updated successfully, commit the transaction
                        if (assignmentUpdated > 0 && vehicleUpdated > 0) {
                            conn.commit();
                            isSuccess = true;
                        }
                    }
                } else {
                    // If the vehicle is not assigned, insert into vehicle_assignment and update vehicle table
                    try (PreparedStatement insertAssignmentStmt = conn.prepareStatement(insertAssignmentSql);
                         PreparedStatement updateVehicleStmt = conn.prepareStatement(updateVehicleSql)) {

                        // Insert into vehicle_assignment table
                        insertAssignmentStmt.setInt(1, vehicleId);
                        insertAssignmentStmt.setInt(2, driverId);

                        // Update the vehicle table
                        updateVehicleStmt.setInt(1, driverId);
                        updateVehicleStmt.setInt(2, vehicleId);

                        // Execute both insert and update queries
                        int assignmentInserted = insertAssignmentStmt.executeUpdate();
                        int vehicleUpdated = updateVehicleStmt.executeUpdate();

                        // If both are successful, commit the transaction
                        if (assignmentInserted > 0 && vehicleUpdated > 0) {
                            conn.commit();
                            isSuccess = true;
                        }
                    }
                }

                // Return the final success state
                return isSuccess;
            } catch (SQLException e) {
                // Rollback transaction in case of any errors
                conn.rollback();
                e.printStackTrace();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }




    // Update vehicle availability
    public boolean updateAvailability(int id, boolean available) {
        String sql = "UPDATE vehicle SET available=? WHERE id=?";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setBoolean(1, available);
            stmt.setInt(2, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete a vehicle by ID
    public boolean deleteVehicle(int id) {
        String sql = "DELETE FROM vehicle WHERE id=?";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get all vehicles
    public List<Vehicle> getAllVehicles() {
        List<Vehicle> vehicles = new ArrayList<>();
        String sql = "SELECT * FROM vehicle";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                vehicles.add(mapResultSetToVehicle(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return vehicles;
    }

    // Get vehicle by ID
    public Vehicle getVehicleById(int id) {
        String sql = "SELECT * FROM vehicle WHERE id=?";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapResultSetToVehicle(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get vehicles by category
    public List<Vehicle> getVehiclesByCategory(String category) {
        List<Vehicle> vehicles = new ArrayList<>();
        String sql = "SELECT * FROM vehicle WHERE category=?";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, category);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                vehicles.add(mapResultSetToVehicle(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return vehicles;
    }

    // Get total vehicle count
    public int getTotalVehicleCount() {
        String sql = "SELECT COUNT(*) AS total FROM vehicle";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Get all assigned vehicles with driver details
    public List<Vehicle> getAssignedVehicles() {
        List<Vehicle> vehicles = new ArrayList<>();
        String sql = "SELECT v.*, d.fullName FROM vehicle v " +
                "JOIN vehicle_assignment va ON v.id = va.vehicle_id " +
                "JOIN driver d ON va.driver_id = d.id";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Vehicle vehicle = mapResultSetToVehicle(rs);
                vehicle.setDriverName(rs.getString("fullName"));
                vehicles.add(vehicle);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return vehicles;
    }

    // Unassign a vehicle from a driver
    public boolean unassignVehicle(int vehicleId) {
        String sql = "DELETE FROM vehicle_assignment WHERE vehicle_id=?";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, vehicleId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Helper method to map ResultSet to Vehicle object
    private Vehicle mapResultSetToVehicle(ResultSet rs) throws SQLException {
        Vehicle vehicle = new Vehicle();
        vehicle.setId(rs.getInt("id"));
        vehicle.setCategory(rs.getString("category"));
        vehicle.setVehicleNumber(rs.getString("vehicle_number"));
        vehicle.setCc(rs.getString("cc"));
        vehicle.setEngineNo(rs.getString("engine_no"));
        vehicle.setVehiclePhoto(rs.getString("vehicle_photo"));
        vehicle.setAvailable(rs.getBoolean("available"));
        vehicle.setFuelType(rs.getString("fuel_type"));
        vehicle.setSeatCapacity(rs.getInt("seat_capacity"));
        vehicle.setRentalPrice(rs.getDouble("rental_price"));
        vehicle.setDriverId(rs.getInt("driver_id"));
        vehicle.setVehicle_model_name(rs.getString("vehicle_model_name"));
        return vehicle;
    }

    // Update an existing vehicle
    public boolean updateVehicle(Vehicle vehicle) {
        String sql = "UPDATE vehicle SET category=?, vehicle_number=?, cc=?, engine_no=?, vehicle_photo=?, "
                + "available=?, fuel_type=?, seat_capacity=?, rental_price=?, vehicle_model_name=? WHERE id=?";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, vehicle.getCategory());
            stmt.setString(2, vehicle.getVehicleNumber());
            stmt.setString(3, vehicle.getCc());
            stmt.setString(4, vehicle.getEngineNo());
            stmt.setString(5, vehicle.getVehiclePhoto());
            stmt.setBoolean(6, vehicle.isAvailable());
            stmt.setString(7, vehicle.getFuelType());
            stmt.setInt(8, vehicle.getSeatCapacity());
            stmt.setDouble(9, vehicle.getRentalPrice());
            stmt.setString(10, vehicle.getVehicle_model_name());
            stmt.setInt(11, vehicle.getId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
