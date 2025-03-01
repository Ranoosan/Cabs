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

        // Assuming the date is sent in yyyy-mm-dd format
        String dobString = request.getParameter("date_of_birth");
        Date dateOfBirth = Date.valueOf(dobString); // Convert String to java.sql.Date

        User user = new User(0, username, password, email, contactNumber, address, gender, nic, dateOfBirth); // Use 0 or default value for id
        UserDAO userDAO = new UserDAO();


        if (userDAO.registerUser(user)) {
            request.setAttribute("user", user);
            request.getRequestDispatcher("/customer/welcome.jsp").forward(request, response);
        } else {
            response.getWriter().println("Registration failed. Try again!");
        }
    }
}
