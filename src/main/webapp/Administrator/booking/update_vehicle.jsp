<%@ page import="java.sql.*" %>
<%
  String vehicleId = request.getParameter("vehicle_id");
  String available = request.getParameter("available");

  Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/your_database", "your_username", "your_password");
  PreparedStatement ps = con.prepareStatement("UPDATE vehicle SET available=? WHERE id=?");
  ps.setString(1, available);
  ps.setInt(2, Integer.parseInt(vehicleId));
  ps.executeUpdate();

  ps.close();
  con.close();
%>
