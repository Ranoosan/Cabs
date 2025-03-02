<%@ page import="java.sql.*" %>
<%
    String bookingId = request.getParameter("booking_id");
    String status = request.getParameter("status");

    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/your_database", "your_username", "your_password");
    PreparedStatement ps = con.prepareStatement("UPDATE bookings SET status=? WHERE booking_id=?");
    ps.setString(1, status);
    ps.setInt(2, Integer.parseInt(bookingId));
    ps.executeUpdate();

    ps.close();
    con.close();
%>
