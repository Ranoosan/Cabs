package org.example.cab.Admin.dao;

import org.example.cab.Admin.model.Coupon;
import java.sql.*;
import java.util.*;

public class CouponDAO {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/cabs";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    // Utility method to establish a database connection
    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

    // Method to get all coupons
    public List<Coupon> getAllCoupons() {
        List<Coupon> coupons = new ArrayList<>();
        String query = "SELECT * FROM coupons";

        try (Connection connection = getConnection();
             Statement statement = connection.createStatement();
             ResultSet rs = statement.executeQuery(query)) {

            while (rs.next()) {
                Coupon coupon = new Coupon();
                coupon.setId(rs.getInt("id"));
                coupon.setCode(rs.getString("code"));
                coupon.setDiscount(rs.getDouble("discount"));
                coupon.setExpirationDate(rs.getDate("expiration_date"));
                coupon.setActive(rs.getBoolean("is_active"));
                coupons.add(coupon);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return coupons;
    }

    // Method to create a new coupon
    public boolean createCoupon(Coupon coupon) {
        String query = "INSERT INTO coupons (code, discount, expiration_date, is_active) VALUES (?, ?, ?, ?)";
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setString(1, coupon.getCode());
            ps.setDouble(2, coupon.getDiscount());
            ps.setDate(3, coupon.getExpirationDate());
            ps.setBoolean(4, coupon.isActive());
            int result = ps.executeUpdate();

            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Method to update an existing coupon
    public boolean updateCoupon(Coupon coupon) {
        String query = "UPDATE coupons SET code = ?, discount = ?, expiration_date = ?, is_active = ? WHERE id = ?";
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setString(1, coupon.getCode());
            ps.setDouble(2, coupon.getDiscount());
            ps.setDate(3, coupon.getExpirationDate());
            ps.setBoolean(4, coupon.isActive());
            ps.setInt(5, coupon.getId());
            int result = ps.executeUpdate();

            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Method to delete a coupon
    public boolean deleteCoupon(int id) {
        String query = "DELETE FROM coupons WHERE id = ?";
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setInt(1, id);
            int result = ps.executeUpdate();

            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Coupon getCouponById(int couponId) {
        Coupon coupon = null;
        String query = "SELECT * FROM coupons WHERE id = ?";

        try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/cabs", "root", "");
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setInt(1, couponId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                coupon = new Coupon();
                coupon.setId(rs.getInt("id"));
                coupon.setCode(rs.getString("code"));
                coupon.setDiscount(rs.getDouble("discount"));
                coupon.setExpirationDate(rs.getDate("expiration_date"));
                coupon.setActive(rs.getBoolean("is_active"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return coupon;
    }

}
