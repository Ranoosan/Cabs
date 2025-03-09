package org.example.cab.Driver.controller;

import org.example.cab.Driver.dao.DriverDAO;
import org.example.cab.Driver.model.User;
import jakarta.servlet.http.HttpSession;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/driver/login")
public class LoginController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        DriverDAO driverDAO = new DriverDAO();
        boolean isValidUser = driverDAO.validateDriver(username, password);

        if (isValidUser) {
            // Fetch the driver details using the username
            User driver = driverDAO.getDriverByUsername(username);
            if (driver != null) {
                HttpSession session = request.getSession();
                session.setAttribute("users", driver);
                session.setAttribute("driverId", driver.getId()); // Store the entire User object in the session

                // Redirect to dashboard inside the 'driver' folder
                response.sendRedirect("dashboard.jsp");
            } else {
                // If the driver is not found, show an error
                request.setAttribute("errorMessage", "Driver details not found.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } else {
            // Show error message and stay on login page
            request.setAttribute("errorMessage", "Invalid username or password.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
