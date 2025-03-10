package org.example.cab.customer.dao;

import jakarta.servlet.http.HttpSession;
import org.example.cab.customer.model.User;

import java.sql.*;

public class UserDAO {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/cabs";
    private static final String JDBC_USER = "root";  // Change if needed
    private static final String JDBC_PASSWORD = "";  // Change if needed

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }



    public boolean registerUser(User user) {
        String sql = "INSERT INTO users (username, password, email, contact_number, address, gender, nic, date_of_birth) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getPassword()); // Consider hashing passwords
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getContactNumber());
            stmt.setString(5, user.getAddress());
            stmt.setString(6, user.getGender());
            stmt.setString(7, user.getNic());
            stmt.setDate(8, new java.sql.Date(user.getDateOfBirth().getTime())); // Convert java.util.Date to java.sql.Date

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    public boolean isNICExists(String nic) {
        boolean exists = false;
        String sql = "SELECT COUNT(*) FROM users WHERE nic = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, nic);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                exists = resultSet.getInt(1) > 0; // If count > 0, NIC exists
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return exists;
    }


    public User validateUser(String username, String password) {
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";

        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            stmt.setString(2, password); // 🔴 Consider hashing the password before checking!

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new User(rs.getInt("id"), rs.getString("username"), rs.getString("password"),
                        rs.getString("email"), rs.getString("contact_number"), rs.getString("address"),
                        rs.getString("gender"), rs.getString("nic"), rs.getDate("date_of_birth"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;  // Return null if login fails
    }


    public User getUserBySession(HttpSession session) {
        User user = null;

        // Retrieve user from session
        if (session != null) {
            user = (User) session.getAttribute("user");
        }

        // If no user is found in session, return null
        if (user == null) {
            return null;
        }

        int userId = user.getId(user); // Get user ID from session

        String query = "SELECT * FROM users WHERE id = ?"; // Query to get user details

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setInt(1, userId);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                user = new User();
                user.setId(resultSet.getInt("id"));

                user.setEmail(resultSet.getString("email"));
                user.setContactNumber(resultSet.getString("contactnumber"));

                // Add other attributes as needed
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }


}
