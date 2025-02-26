package org.example.cab.customer.controller;



import org.example.cab.customer.model.User;


import org.example.cab.customer.dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/customer/register")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");

        User user = new User(username, password, email);
        UserDAO userDAO = new UserDAO();

        if (userDAO.registerUser(user)) {
            request.setAttribute("user", user);
            request.getRequestDispatcher("/customer/register-success.jsp").forward(request, response);
        } else {
            response.getWriter().println("Registration failed. Try again!");
        }
    }
}
