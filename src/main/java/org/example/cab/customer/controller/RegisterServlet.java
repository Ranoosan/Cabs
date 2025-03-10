package org.example.cab.customer.controller;

import org.example.cab.customer.model.User;
import org.example.cab.customer.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Date;
import java.util.regex.Pattern;

@WebServlet("/customer/register")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String contactNumber = request.getParameter("contact_number");
        String address = request.getParameter("address");
        String gender = request.getParameter("gender");
        String nic = request.getParameter("nic");
        String dobString = request.getParameter("date_of_birth");

        // Convert date string to java.sql.Date
        Date dateOfBirth = Date.valueOf(dobString);

        UserDAO userDAO = new UserDAO();

        // ✅ Validate user inputs
        if (!isValidEmail(email)) {
            request.setAttribute("errorMessage", "Invalid email format!");
            request.getRequestDispatcher("/customer/register.jsp").forward(request, response);
            return;
        }

        if (!isValidPhoneNumber(contactNumber)) {
            request.setAttribute("errorMessage", "Invalid phone number format!");
            request.getRequestDispatcher("/customer/register.jsp").forward(request, response);
            return;
        }

        if (!isValidNIC(nic)) {
            request.setAttribute("errorMessage", "Invalid NIC format!");
            request.getRequestDispatcher("/customer/register.jsp").forward(request, response);
            return;
        }

        // ✅ Check if NIC already exists in the database
        if (userDAO.isNICExists(nic)) {
            request.setAttribute("errorMessage", "Error: NIC already registered! Registration not allowed.");
            request.getRequestDispatcher("/customer/register.jsp").forward(request, response);
            return;
        }

        // ✅ If NIC is unique, proceed with registration
        User user = new User(0, username, password, email, contactNumber, address, gender, nic, dateOfBirth);

        if (userDAO.registerUser(user)) {
            request.setAttribute("user", user);
            request.getRequestDispatcher("/customer/welcome.jsp").forward(request, response);
        } else {
            response.getWriter().println("Registration failed. Try again!");
        }
    }

    // ✅ Static method to validate email format
    public static boolean isValidEmail(String email) {
        String emailRegex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";
        return email != null && email.matches(emailRegex);
    }

    // ✅ Static method to validate phone number (Sri Lankan format)
    public static boolean isValidPhoneNumber(String phoneNumber) {
        String phoneRegex = "^(07[01245678])[0-9]{7}$"; // Matches 10-digit numbers starting with 07X
        return phoneNumber != null && phoneNumber.matches(phoneRegex);
    }

    // ✅ Static method to validate NIC (Sri Lankan format)
    public static boolean isValidNIC(String nic) {
        String oldNICRegex = "^[0-9]{9}[vVxX]$";  // e.g., 923456789V
        String newNICRegex = "^[0-9]{12}$";      // e.g., 200012345678
        return nic != null && (nic.matches(oldNICRegex) || nic.matches(newNICRegex));
    }
}
