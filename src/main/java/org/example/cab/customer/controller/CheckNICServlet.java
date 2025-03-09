package org.example.cab.customer.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.cab.customer.dao.UserDAO;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/customer/check-nic")
public class CheckNICServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO customerDAO;

    @Override
    public void init() {
        customerDAO = new UserDAO(); // Initialize DAO instance
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nic = request.getParameter("nic");
        boolean exists = customerDAO.isNICExists(nic); // Check NIC existence

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print("{\"exists\": " + exists + "}");
        out.flush();
    }
}
