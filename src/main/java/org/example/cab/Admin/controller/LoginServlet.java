package org.example.cab.Admin.controller;

import org.example.cab.Admin.dao.AdminDAO;
import org.example.cab.Admin.model.Admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/Administrator/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        AdminDAO adminDAO = new AdminDAO();

        // Validate Admin Credentials
        if (adminDAO.validateAdmin(username, password)) {
            HttpSession session = request.getSession(false);

            if (session != null) {
                session.invalidate(); // Prevent session fixation
            }

            session = request.getSession(true);
            session.setAttribute("admin", username);
            session.setMaxInactiveInterval(30 * 60); // Session expires after 30 minutes of inactivity

            response.sendRedirect("admin_dashboard.jsp");
        } else {
            request.setAttribute("errorMessage", "Invalid username or password!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
