<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.example.cab.Admin.dao.DBConnection" %>
<%@ page import="org.example.cab.Admin.dao.DriverDAO" %>
<%@ page import="org.example.cab.Admin.controller.LoginServlet" %>
<%@ page import="org.example.cab.Admin.model.Driver" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Driver</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #2C3E50; /* Dark blue background */
            color: #ECF0F1; /* Light gray text */
        }
        .container {
            margin-top: 50px;
            background-color: #34495E; /* Slightly lighter background for the container */
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(255, 255, 255, 0.1);
        }
        .btn-custom {
            background-color: #3498DB; /* Blue button */
            color: #FFFFFF; /* White text */
            font-weight: bold;
            border: none;
            transition: 0.3s;
        }
        .btn-custom:hover {
            background-color: #2980B9; /* Darker blue on hover */
            color: #FFFFFF; /* Keep text white */
        }
        .btn-back {
            background-color: #E74C3C; /* Red button for back */
            color: #FFFFFF; /* White text */
            font-weight: bold;
            border: none;
            transition: 0.3s;
        }
        .btn-back:hover {
            background-color: #C0392B; /* Darker red on hover */
            color: #FFFFFF; /* Keep text white */
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Add New Driver</h2>
    <form action="add_driver" method="post" enctype="multipart/form-data">
        <div class="mb-3">
            <label for="username" class="form-label">Username:</label>
            <input type="text" class="form-control" id="username" name="username" required>
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Password:</label>
            <input type="password" class="form-control" id="password" name="password" required>
        </div>
        <div class="mb-3">
            <label for="full_Name" class="form-label">Full Name:</label>
            <input type="text" class="form-control" id="full_Name" name="full_Name" required>
        </div>
        <div class="mb-3">
            <label for="contact_Number" class="form-label">Contact Number:</label>
            <input type="text" class="form-control" id="contact_Number" name="contact_Number" required>
        </div>
        <div class="mb-3">
            <label for="email_Address" class="form-label">Email Address:</label>
            <input type="email" class="form-control" id="email_Address" name="email_Address" required>
        </div>
        <div class="mb-3">
            <label for="residential_Address" class="form-label">Residential Address:</label>
            <input type="text" class="form-control" id="residential_Address" name="residential_Address" required>
        </div>
        <div class="mb-3">
            <label for="license_Number" class="form-label">License Number:</label>
            <input type="text" class="form-control" id="license_Number" name="license_Number" required>
        </div>
        <div class="mb-3">
            <label for="license_Type" class="form-label">License Type:</label>
            <select class="form-select" id="license_Type" name="license_Type" required>
                <option value="Private">Private</option>
                <option value="Commercial">Commercial</option>
            </select>
        </div>
        <div class="mb-3">
            <label for="expiration_Date" class="form-label">Expiration Date:</label>
            <input type="date" class="form-control" id="expiration_Date" name="expiration_Date" required>
        </div>
        <div class="mb-3">
            <label for="bank_Account_Number" class="form-label">Bank Account Number:</label>
            <input type="text" class="form-control" id="bank_Account_Number" name="bank_Account_Number" required>
        </div>
        <div class="mb-3">
            <label for="medical_Certificate" class="form-label">Medical Certificate:</label>
            <input type="file" class="form-control" id="medical_Certificate" name="medical_Certificate" required>
        </div>
        <div class="mb-3">
            <label for="emergency_Contact_Details" class="form-label">Emergency Contact Details:</label>
            <input type="text" class="form-control" id="emergency_Contact_Details" name="emergency_Contact_Details" required>
        </div>
        <div class="mb-3">
            <label for="copy_Of_Driving_License" class="form-label">Copy of Driving License:</label>
            <input type="file" class="form-control" id="copy_Of_Driving_License" name="copy_Of_Driving_License" required>
        </div>
        <div class="mb-3">
            <label for="proof_Of_Address" class="form-label">Proof of Address:</label>
            <input type="file" class="form-control" id="proof_Of_Address" name="proof_Of_Address" required>
        </div>
        <div class="mb-3">
            <input type="checkbox" id="terms_Accepted" name="terms_Accepted" required>
            <label for="terms_Accepted" class="form-check-label">I accept Mega City Cab’s Terms and Conditions</label>
        </div>
        <button type="submit" class="btn btn-custom w-100">Add Driver</button>
        <a href="${pageContext.request.contextPath}/Administrator/admin_dashboard.jsp" class="btn btn-back w-100 mt-3">Back to Home</a>
    </form>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
