<%@ page import="org.example.cab.Admin.dao.VehicleDAO" %>
<%
    VehicleDAO vehicleDAO = new VehicleDAO();
    int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
    boolean unassigned = vehicleDAO.unassignVehicle(vehicleId);

    if (unassigned) {
        response.sendRedirect("assign_vehicle.jsp?msg=Vehicle unassigned successfully!");
    } else {
        response.sendRedirect("assign_vehicle.jsp?error=Error unassigning vehicle.");
    }
%>
