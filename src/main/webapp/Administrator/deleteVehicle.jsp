<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.example.cab.Admin.dao.VehicleDAO" %>

<%
  String vehicleIdParam = request.getParameter("vehicleId");

  if (vehicleIdParam != null && !vehicleIdParam.isEmpty()) {
    int vehicleId = Integer.parseInt(vehicleIdParam);
    VehicleDAO vehicleDAO = new VehicleDAO();
    boolean deleted = vehicleDAO.deleteVehicle(vehicleId);

    if (deleted) {
      response.sendRedirect("view_vehicles.jsp?status=success");
    } else {
      response.sendRedirect("view_vehicles.jsp?status=error");
    }
  } else {
    response.sendRedirect("view_vehicles.jsp?status=invalid");
  }
%>
