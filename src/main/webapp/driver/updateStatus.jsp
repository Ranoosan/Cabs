<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, jakarta.servlet.http.HttpSession" %>
<%@ page import="org.example.cab.Driver.model.User" %>

<%
  HttpSession sessiono = request.getSession(false);
  if (sessiono == null || sessiono.getAttribute("users") == null) {
    response.sendRedirect("login.jsp");
    return;
  }

  User driver = (User) sessiono.getAttribute("users");
  String newStatus = request.getParameter("status");

  try {
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cabs", "root", "");
    PreparedStatement stmt = conn.prepareStatement("UPDATE driversss SET status = ? WHERE id = ?");
    stmt.setString(1, newStatus);
    stmt.setInt(2, driver.getId());
    stmt.executeUpdate();
    conn.close();
  } catch (SQLException e) {
    e.printStackTrace();
  }
%>
