package org.example.cab.customer.controller;

import org.example.cab.customer.dao.UserDAO;
import org.example.cab.customer.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/customer/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UserDAO userDAO = new UserDAO();
        User user = userDAO.validateUser(username, password);

        if (user != null) {
            // Create session and store user data
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("username", user.getUsername());

            // Redirect to dashboard after login
            response.sendRedirect(request.getContextPath() + "/customer/welcome.jsp");
        } else {
            // Set error message and forward back to login page
            request.setAttribute("errorMessage", "Invalid username or password!");
            request.getRequestDispatcher("/customer/login.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/customer/login.jsp").forward(request, response);
    }
}
