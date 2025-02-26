package org.example.cab.Admin.dao;

import org.example.cab.Admin.model.Admin;
import java.sql.*;

public class AdminDAO {
    private static final String URL = "jdbc:mysql://localhost:3306/cabs";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    public boolean validateAdmin(String username, String password) {
        boolean isValid = false;
        String sql = "SELECT * FROM admin WHERE username=? AND password=?";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
                 PreparedStatement stmt = conn.prepareStatement(sql)) {

                stmt.setString(1, username);
                stmt.setString(2, password);
                try (ResultSet rs = stmt.executeQuery()) {
                    isValid = rs.next(); // If a record is found, credentials are valid
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isValid;
    }
}
