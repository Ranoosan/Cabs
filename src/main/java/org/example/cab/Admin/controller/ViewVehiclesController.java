package org.example.cab.Admin.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.cab.Admin.dao.VehicleDAO;
import org.example.cab.Admin.model.Vehicle;

import java.io.IOException;
import java.util.List;

@WebServlet("/Administrator/view_vehicles")
public class ViewVehiclesController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        VehicleDAO vehicleDAO = new VehicleDAO();
        List<Vehicle> vehicleList = vehicleDAO.getAllVehicles();

        request.setAttribute("vehicleList", vehicleList);
        request.getRequestDispatcher("view_vehicles.jsp").forward(request, response);
    }
}
