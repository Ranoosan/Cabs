<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.example.cab.Admin.dao.DriverDAO" %>

<%
    String driverIdParam = request.getParameter("driverId");

    if (driverIdParam != null && !driverIdParam.isEmpty()) {
        int driverId = Integer.parseInt(driverIdParam);
        DriverDAO driverDAO = new DriverDAO();
        boolean deleted = driverDAO.deleteDriver(driverId);

        if (deleted) {
            response.sendRedirect("view_drivers.jsp?status=success");
        } else {
            response.sendRedirect("view_drivers.jsp?status=error");
        }
    } else {
        response.sendRedirect("viewDrivers.jsp?status=invalid");
    }
%>
