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
    <!-- FontAwesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body {
            background-color: #f8f9fa; /* Light grey background */
            color: #333333; /* Dark grey text color */

        }
        .container {
            margin-top: 50px;
            background-color: #f8f9fa; /* Slightly lighter background for the container */
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(255, 255, 255, 0.1);
        }
        .sidebar {
            width: 250px;
            height: 100vh;
            position: fixed;
            background: linear-gradient(180deg, #d3d3d3, #b0b0b0); /* Light to medium grey gradient */
            padding-top: 20px;
            box-shadow: 4px 0 10px rgba(0, 0, 0, 0.1);
        }

        .sidebar a {
            display: block;
            color: #333333; /* Dark grey text */
            padding: 12px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease-in-out;
        }

        .sidebar a:hover {
            background: #bbbbbb; /* Slightly darker grey on hover */
            color: #000000; /* Black text */
            transform: scale(1.05);
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

<div class="sidebar">
    <h4 class="text-center">Admin Panel</h4>
    <a href="${pageContext.request.contextPath}/Administrator/admin_dashboard.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
    <a href="${pageContext.request.contextPath}/Administrator/view_drivers.jsp"><i class="fas fa-user"></i> View Drivers</a>
    <a href="${pageContext.request.contextPath}/Administrator/add_driver.jsp"><i class="fas fa-user-plus"></i> Add Driver</a>
    <a href="${pageContext.request.contextPath}/Administrator/view_vehicles.jsp"><i class="fas fa-car"></i> View Vehicles</a>
    <a href="${pageContext.request.contextPath}/Administrator/add_vehicle.jsp"><i class="fas fa-plus"></i> Add Vehicle</a>
    <a href="${pageContext.request.contextPath}/Administrator/assign_vehicle.jsp"><i class="fas fa-random"></i> Assign Vehicles</a>
    <a href="${pageContext.request.contextPath}/Administrator/booking/manage_booking_vehicle.jsp"><i class="fas fa-calendar-check"></i> Manage Bookings</a>
    <a href="${pageContext.request.contextPath}/Administrator/booking/adminBookedRides.jsp"><i class="fas fa-ban"></i> Manage Rejections</a>
    <a href="${pageContext.request.contextPath}/Administrator/coupon/manage_coupon.jsp"><i class="fas fa-tags"></i> Manage Discounts</a>
    <a href="${pageContext.request.contextPath}/Administrator/login.jsp" class="text-danger"><i class="fas fa-sign-out-alt"></i> Logout</a>
</div>

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
            <label for="vehicleType" class="form-label">Vehicle Type:</label>
            <select class="form-control" id="vehicleType" name="vehicleType" required>
                <option value="">Select Vehicle Type</option>
                <option value="Car">Car</option>
                <option value="Van">Van</option>
                <option value="Bike">Bike</option>
                <option value="Auto">Auto</option>

            </select>
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
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const form = document.querySelector("form");

        function validateUsername() {
            const username = document.getElementById("username");
            const regex = /^\S{4,}$/; // No spaces, at least 4 chars
            return showValidation(username, regex.test(username.value), "Username must be at least 4 characters long with no spaces.");
        }

        function validatePassword() {
            const password = document.getElementById("password");
            const regex = /^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$/;
            return showValidation(password, regex.test(password.value), "Password must be at least 6 chars with an uppercase, a number, and a special character.");
        }

        function validateFullName() {
            const fullName = document.getElementById("full_Name");
            const regex = /^[A-Za-z\s]+$/;
            return showValidation(fullName, regex.test(fullName.value), "Full name must contain only letters and spaces.");
        }

        function validateContactNumber() {
            const contactNumber = document.getElementById("contact_Number");
            const regex = /^\d{10}$/;
            return showValidation(contactNumber, regex.test(contactNumber.value), "Contact number must be exactly 10 digits.");
        }

        function validateEmail() {
            const email = document.getElementById("email_Address");
            const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            return showValidation(email, regex.test(email.value), "Enter a valid email address.");
        }

        function validateResidentialAddress() {
            const address = document.getElementById("residential_Address");
            return showValidation(address, address.value.length >= 5, "Address must be at least 5 characters long.");
        }

        function validateVehicleType() {
            const vehicleType = document.getElementById("vehicleType");
            return showValidation(vehicleType, vehicleType.value !== "", "Please select a vehicle type.");
        }

        function validateLicenseType() {
            const licenseType = document.getElementById("license_Type");
            return showValidation(licenseType, licenseType.value !== "", "Please select a license type.");
        }

        function validateExpirationDate() {
            const expirationDate = document.getElementById("expiration_Date");
            const selectedDate = new Date(expirationDate.value);
            const today = new Date();
            return showValidation(expirationDate, selectedDate > today, "Expiration date cannot be in the past.");
        }

        function validateBankAccount() {
            const bankAccount = document.getElementById("bank_Account_Number");
            const regex = /^\d{8,12}$/; // Allows 8 to 12 digits
            return showValidation(bankAccount, regex.test(bankAccount.value), "Bank account number must be between 8 and 12 digits.");
        }

        function validateFileInput(id, message) {
            const fileInput = document.getElementById(id);
            return showValidation(fileInput, fileInput.files.length > 0, message);
        }

        function validateEmergencyContact() {
            const emergencyContact = document.getElementById("emergency_Contact_Details");
            const regex = /^\d{10}$/;
            return showValidation(emergencyContact, regex.test(emergencyContact.value), "Emergency contact must be exactly 10 digits.");
        }

        function validateTermsAccepted() {
            const terms = document.getElementById("terms_Accepted");
            return showValidation(terms, terms.checked, "You must accept the terms and conditions.");
        }

        function showValidation(input, isValid, message) {
            const errorSpan = input.nextElementSibling;
            if (!errorSpan || !errorSpan.classList.contains("error-message")) {
                const newSpan = document.createElement("span");
                newSpan.classList.add("error-message");
                newSpan.style.color = "red";
                newSpan.style.fontSize = "12px";
                input.parentElement.appendChild(newSpan);
            }
            input.nextElementSibling.textContent = isValid ? "" : message;
            return isValid;
        }

        form.addEventListener("submit", function (e) {
            e.preventDefault();

            const isValidForm =
                validateUsername() &&
                validatePassword() &&
                validateFullName() &&
                validateContactNumber() &&
                validateEmail() &&
                validateResidentialAddress() &&
                validateVehicleType() &&
                validateLicenseType() &&
                validateExpirationDate() &&
                validateBankAccount() &&
                validateFileInput("medical_Certificate", "Upload your medical certificate.") &&
                validateEmergencyContact() &&
                validateFileInput("copy_Of_Driving_License", "Upload a copy of your driving license.") &&
                validateFileInput("proof_Of_Address", "Upload proof of address.") &&
                validateTermsAccepted();

            if (isValidForm) {
                form.submit();
            }
        });

        document.getElementById("username").addEventListener("input", validateUsername);
        document.getElementById("password").addEventListener("input", validatePassword);
        document.getElementById("full_Name").addEventListener("input", validateFullName);
        document.getElementById("contact_Number").addEventListener("input", validateContactNumber);
        document.getElementById("email_Address").addEventListener("input", validateEmail);
        document.getElementById("residential_Address").addEventListener("input", validateResidentialAddress);
        document.getElementById("vehicleType").addEventListener("change", validateVehicleType);
        document.getElementById("license_Type").addEventListener("change", validateLicenseType);
        document.getElementById("expiration_Date").addEventListener("change", validateExpirationDate);
        document.getElementById("bank_Account_Number").addEventListener("input", validateBankAccount);
        document.getElementById("medical_Certificate").addEventListener("change", () => validateFileInput("medical_Certificate", "Upload your medical certificate."));
        document.getElementById("emergency_Contact_Details").addEventListener("input", validateEmergencyContact);
        document.getElementById("copy_Of_Driving_License").addEventListener("change", () => validateFileInput("copy_Of_Driving_License", "Upload a copy of your driving license."));
        document.getElementById("proof_Of_Address").addEventListener("change", () => validateFileInput("proof_Of_Address", "Upload proof of address."));
        document.getElementById("terms_Accepted").addEventListener("change", validateTermsAccepted);
    });
</script>


<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
