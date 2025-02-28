package org.example.cab.Admin.controller;

import jakarta.servlet.annotation.WebServlet;
import org.example.cab.Admin.dao.DriverDAO;
import org.example.cab.Admin.dao.VehicleDAO;
import org.example.cab.Admin.model.Driver;
import org.example.cab.Admin.model.Vehicle;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet("/Administrator/vehicleList")
public class VehicleListServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        VehicleDAO vehicleDAO = new VehicleDAO();
        DriverDAO driverDAO = new DriverDAO();

        List<Vehicle> vehicles = vehicleDAO.getAllVehicles();
        List<Driver> drivers = driverDAO.getAllDrivers();

        request.setAttribute("vehicles", vehicles);
        request.setAttribute("drivers", drivers);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/vehicleList.jsp");
        dispatcher.forward(request, response);
    }
}
