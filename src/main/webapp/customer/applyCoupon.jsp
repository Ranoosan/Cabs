<%@ page import="java.sql.*" %>
<%@ page contentType="text/plain; charset=UTF-8" %>
<%
    String couponCode = request.getParameter("coupon");
    double discount = 0; // Default discount

    if (couponCode != null && !couponCode.isEmpty()) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // Load database driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cabs", "root", ""); // Adjust DB credentials accordingly

            // Check if the coupon code exists and is active
            String query = "SELECT discount FROM coupons WHERE code = ? AND is_active = 1"; // Assuming active coupons
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, couponCode);
            rs = pstmt.executeQuery();

            // If coupon is found, fetch the discount percentage
            if (rs.next()) {
                discount = rs.getDouble("discount"); // Fetch discount percentage
            } else {
                // Coupon not found or inactive, return an error message
                out.print("Invalid or expired coupon code.");
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.print("Error: " + e.getMessage());
            return;
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    } else {
        out.print("Coupon code is required.");
        return;
    }

    // Output the discount percentage to the front-end (for use in JavaScript)
    out.print(discount); // Send discount percentage as response
%>
