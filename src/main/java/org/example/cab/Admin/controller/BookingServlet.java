package org.example.cab.Admin.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import org.example.cab.Admin.dao.BookingDao;
import org.example.cab.Admin.model.Booking;

@WebServlet("/customer/submitBooking")
public class BookingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get data from the form (request parameters)

            String pickupLocation = request.getParameter("pickupLocation");
            String dropoffLocation = request.getParameter("dropoffLocation");
            String pickupDateTime = request.getParameter("pickupDateTime");
            String paymentMethod = request.getParameter("paymentMethod");
            String specialRequests = request.getParameter("specialRequests");

            // Retrieve userId and driverId from session
            HttpSession session = request.getSession(false);
            Integer username = (session != null) ? (Integer) session.getAttribute("username") : null;
            Integer driverId = (session != null) ? (Integer) session.getAttribute("driverId") : null;

            // Retrieve and validate vehicleId
            String vehicleIdParam = request.getParameter("vehicleId");
            Integer vehicleId = (vehicleIdParam != null && !vehicleIdParam.isEmpty()) ? Integer.parseInt(vehicleIdParam) : null;

            // Validate required parameters
            if (username == null || driverId == null || vehicleId == null || pickupLocation == null || dropoffLocation == null || pickupDateTime == null || paymentMethod == null) {
                throw new IllegalArgumentException("Missing required booking details.");
            }

            // Create a new Booking object
            Booking booking = new Booking();
            booking.setUsername(String.valueOf(username));
            booking.setVehicleId(vehicleId);
            booking.setDriverId(driverId);
            booking.setPickupLocation(pickupLocation);
            booking.setDropoffLocation(dropoffLocation);
            booking.setPickupDateTime(java.sql.Timestamp.valueOf(pickupDateTime)); // Ensure correct format
            booking.setPaymentMethod(paymentMethod);
            booking.setSpecialRequests(specialRequests);
            booking.setCreatedAt(new java.sql.Timestamp(new java.util.Date().getTime())); // Set current timestamp

            // Create BookingDao object to save the booking
            BookingDao bookingDao = new BookingDao();
            boolean isSuccess = bookingDao.saveBooking(booking); // Call saveBooking with the Booking object

            // Check if the booking was successful and forward the response
            if (isSuccess) {
                response.sendRedirect("customer/welcome.jsp"); // Redirect to confirmation page
            } else {
                request.setAttribute("errorMessage", "There was an issue with your booking.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("bookingPage.jsp");
                dispatcher.forward(request, response);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=Invalid number format. Please check input values.");
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=" + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=An unexpected error occurred.");
        }
    }
}
