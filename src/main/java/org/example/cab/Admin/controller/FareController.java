package org.example.cab.Admin.controller;

import org.example.cab.Admin.dao.FareDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/customer/getFare")
public class FareController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get parameters from the request
        String pickupLocation = request.getParameter("pickupLocation");
        String dropOffLocation = request.getParameter("dropOffLocation");

        // Debugging: Log the incoming locations
        System.out.println("Received pickupLocation: " + pickupLocation);
        System.out.println("Received dropOffLocation: " + dropOffLocation);

        // Set response type
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        // If locations are selected, get fare
        if (pickupLocation != null && dropOffLocation != null) {
            Double fare = FareDAO.getFare(pickupLocation, dropOffLocation);

            // Debugging: Log the fare value from the database
            System.out.println("Fare fetched from DB: " + fare);

            // Prepare the JSON response
            if (fare != null) {
                out.write("{\"fare\": " + fare + "}");
            } else {
                out.write("{\"fare\": null}");
            }
        } else {
            out.write("{\"fare\": null}");
        }

        out.close();
    }
}
