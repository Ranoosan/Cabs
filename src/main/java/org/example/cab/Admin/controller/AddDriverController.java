package org.example.cab.Admin.controller;

import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import org.example.cab.Admin.dao.DriverDAO;
import org.example.cab.Admin.model.Driver;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

@WebServlet("/Administrator/add_driver")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1MB
        maxFileSize = 1024 * 1024 * 5,   // 5MB
        maxRequestSize = 1024 * 1024 * 20 // 20MB
)
public class AddDriverController extends HttpServlet {
    private static final String UPLOAD_DIRECTORY = "uploads";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fullName = request.getParameter("full_Name");
        String contactNumber = request.getParameter("contact_Number");
        String emailAddress = request.getParameter("email_Address");
        String residentialAddress = request.getParameter("residential_Address");
        String vehicleType = request.getParameter("vehicleType");
        String licenseType = request.getParameter("license_Type");
        String expirationDateStr = request.getParameter("expiration_Date");
        String bankAccountNumber = request.getParameter("bank_Account_Number");
        String emergencyContactDetails = request.getParameter("emergency_Contact_Details");
        boolean termsAccepted = request.getParameter("terms_Accepted") != null;

        // Parse expiration date
        LocalDate expirationDate = null;
        if (expirationDateStr != null && !expirationDateStr.isEmpty()) {
            try {
                expirationDate = LocalDate.parse(expirationDateStr, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            } catch (DateTimeParseException e) {
                e.printStackTrace();
            }
        }

        // Handle file uploads
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        String medicalCertificate = saveUploadedFile(request.getPart("medical_Certificate"), uploadPath);
        String copyOfDrivingLicense = saveUploadedFile(request.getPart("copy_Of_Driving_License"), uploadPath);
        String proofOfAddress = saveUploadedFile(request.getPart("proof_Of_Address"), uploadPath);

        // Create Driver object
        Driver driver = new Driver();
        driver.setUsername(username);
        driver.setPassword(password);
        driver.setFullName(fullName);
        driver.setContactNumber(contactNumber);
        driver.setEmailAddress(emailAddress);
        driver.setResidentialAddress(residentialAddress);
        driver.setVehicleType(vehicleType);
        driver.setLicenseType(licenseType);
        driver.setExpirationDate(expirationDate);
        driver.setBankAccountNumber(bankAccountNumber);
        driver.setEmergencyContactDetails(emergencyContactDetails);
        driver.setMedicalCertificate(medicalCertificate);
        driver.setCopyOfDrivingLicense(copyOfDrivingLicense);
        driver.setProofOfAddress(proofOfAddress);
        driver.setTermsAccepted(termsAccepted);

        // Save driver using DAO
        DriverDAO driverDAO = new DriverDAO();
        boolean success = driverDAO.addDriver(driver);

        if (success) {
            response.sendRedirect("/Administrator/admin_dashboard.jsp");
        } else {
            request.setAttribute("errorMessage", "Failed to add driver.");
            request.getRequestDispatcher("/Administrator/admin_dashboard.jsp").forward(request, response);
        }
    }

    private String saveUploadedFile(Part filePart, String uploadPath) throws IOException {
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = new File(filePart.getSubmittedFileName()).getName();
            String filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath);
            return UPLOAD_DIRECTORY + "/" + fileName;
        }
        return null;
    }
}