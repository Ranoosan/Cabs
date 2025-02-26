package org.example.cab.Admin.controller;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.cab.Admin.dao.DriverDAO;
import org.example.cab.Admin.model.Driver;

import java.io.IOException;
import java.util.List;

@WebServlet("/Administrator/view_drivers")
public class ViewDriversController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DriverDAO driverDAO = new DriverDAO();
        List<Driver> driverList = driverDAO.getAllDrivers();

        request.setAttribute("driverList", driverList);
        request.getRequestDispatcher("view_drivers.jsp").forward(request, response);
    }
}
