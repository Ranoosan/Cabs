<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.example.cab.Admin.dao.BookingDao" %>
<%@ page import="org.example.cab.Admin.model.Booking" %>

<%
  String status = request.getParameter("status");
  int bookingId = Integer.parseInt(request.getParameter("bookingId"));

  BookingDao bookingDAO = new BookingDao();
  boolean isUpdated = bookingDAO.updateBookingStatuss(bookingId, status);

  String statusMessage = "";
  if (isUpdated) {
    statusMessage = "Booking status updated successfully!";
  } else {
    statusMessage = "Error updating booking status.";
  }

  response.sendRedirect("rides.jsp?statusMessage=" + statusMessage);
%>
