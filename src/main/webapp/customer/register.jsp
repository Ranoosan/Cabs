<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.cab.customer.controller.RegisterServlet" %>
<%@ page import="org.example.cab.customer.dao.UserDAO" %>
<%@ page import="org.example.cab.customer.model.User" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <title>User Registration</title>
  <style>
    /* Background with lighter gradient */
    body {
      background-color: #e0f0f6;
      color: #fff; /* Light text color */
      overflow: hidden;
      position: relative;
      font-family: 'Arial', sans-serif;
      height: 100vh; /* Full viewport height */
      display: flex;
      justify-content: center;
      align-items: center;
   ;
      margin: 0;
    }

    /* Bolder moving star effect */
    .stars {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: url('https://www.transparenttextures.com/patterns/stardust.png') repeat;
      animation: moveStars 40s linear infinite;
      z-index: -1;
      opacity: 0.9; /* Increased opacity for bolder stars */
      transform: scale(2); /* Make the stars bigger */
    }

    /* Keyframes for smooth star movement */
    @keyframes moveStars {
      0% {
        transform: translate(0, 0) scale(2);
      }
      100% {
        transform: translate(-1000px, -1000px) scale(2);
      }
    }

    .container {
      max-width: 800px;
      background: linear-gradient(to right, #6a9bb7, #ff8b8b); /* Lighter gradient for a softer, modern look */
      border-radius: 10px;
      padding: 30px;
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
      margin-top: 50px;
      position: relative;
      z-index: 1; /* Ensure the form is on top of the stars */
    }

    .form-group label {
      font-weight: bold;
      color: #333;
    }

    .form-group input {
      border-radius: 5px;
      padding: 10px;
      border: 1px solid #ddd;
      width: 100%;
    }

    .btn-primary {
      background-color: #007BFF;
      border-color: #007BFF;
      border-radius: 5px;
      padding: 10px 20px;
      transition: background-color 0.3s ease;
    }

    .btn-primary:hover {
      background-color: #0056b3;
    }

    .alert-danger {
      font-size: 14px;
      padding: 10px;
    }

    .mt-3 a {
      color: #007BFF;
      text-decoration: none;
    }

    .mt-3 a:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>
<div class="stars"></div> <!-- Stars background effect -->
<div class="container mt-5">
  <h2 class="text-center">User Registration</h2>

  <%-- Show registration error if needed --%>
  <% String errorMessage = (String) request.getAttribute("errorMessage");
    if (errorMessage != null) { %>
  <div class="alert alert-danger">
    <%= errorMessage %>
  </div>
  <% } %>

  <form action="register" method="post" class="mt-4">
    <div class="form-group">
      <label for="username">Username:</label>
      <input type="text" class="form-control" id="username" name="username" required>
    </div>
    <div class="form-group">
      <label for="password">Password:</label>
      <input type="password" class="form-control" id="password" name="password" required>
    </div>
    <div class="form-group">
      <label for="email">Email:</label>
      <input type="email" class="form-control" id="email" name="email" required>
    </div>
    <div class="form-group">
      <label for="contact_number">Contact Number:</label>
      <input type="text" class="form-control" id="contact_number" name="contact_number" required>
    </div>
    <div class="form-group">
      <label for="address">Address:</label>
      <input type="text" class="form-control" id="address" name="address" required>
    </div>
    <div class="form-group">
      <label for="gender">Gender:</label>
      <select class="form-control" id="gender" name="gender" required>
        <option value="" disabled selected>Select your gender</option>
        <option value="Male">Male</option>
        <option value="Female">Female</option>
        <option value="Other">Other</option>
      </select>
    </div>
    <div class="form-group">
      <label for="nic">NIC:</label>
      <input type="text" class="form-control" id="nic" name="nic" required>
    </div>
    <div class="form-group">
      <label for="date_of_birth">Date of Birth:</label>
      <input type="date" class="form-control" id="date_of_birth" name="date_of_birth" required>
    </div>
    <button type="submit" class="btn btn-primary">Register</button>
  </form>

  <p class="mt-3">Already have an account? <a href="login.jsp">Login Here</a></p>
</div>

<script>
  document.addEventListener("DOMContentLoaded", function () {
    const form = document.querySelector("form");

    // Input fields
    const username = document.getElementById("username");
    const password = document.getElementById("password");
    const email = document.getElementById("email");
    const contactNumber = document.getElementById("contact_number");
    const address = document.getElementById("address");
    const gender = document.getElementById("gender");
    const nic = document.getElementById("nic");
    const dob = document.getElementById("date_of_birth");

    function showError(input, message) {
      let parent = input.parentElement;
      let error = parent.querySelector(".error-message");
      if (!error) {
        error = document.createElement("small");
        error.className = "error-message text-danger";
        parent.appendChild(error);
      }
      error.innerText = message;
    }

    function clearError(input) {
      let parent = input.parentElement;
      let error = parent.querySelector(".error-message");
      if (error) {
        parent.removeChild(error);
      }
    }

    function validateEmail(email) {
      const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
      return regex.test(email);
    }

    function validateNIC(nic) {
      const regex = /^([0-9]{9}[vVxX]|[0-9]{12})$/;
      return regex.test(nic);
    }

    function validatePhoneNumber(number) {
      const regex = /^[0-9]{10}$/;
      return regex.test(number);
    }

    function validateUsername(name) {
      return name.length >= 4;
    }

    function validatePassword(password) {
      const regex = /^(?=.*[A-Z])(?=.*[@$!%*?&])(?=.*\d).{6,}$/;
      return regex.test(password);
    }

    function validateDOB(date) {
      let today = new Date();
      let birthDate = new Date(date);
      let age = today.getFullYear() - birthDate.getFullYear();
      return age >= 18;
    }

    function validateField(input, validator, message) {
      if (!validator(input.value.trim())) {
        showError(input, message);
      } else {
        clearError(input);
      }
    }

    username.addEventListener("input", () => validateField(username, validateUsername, "Username must be at least 4 characters"));
    password.addEventListener("input", () => validateField(password, validatePassword, "Password must have 1 uppercase, 1 number, 1 special character"));
    email.addEventListener("input", () => validateField(email, validateEmail, "Invalid email format"));
    contactNumber.addEventListener("input", () => validateField(contactNumber, validatePhoneNumber, "Enter a valid 10-digit phone number"));
    nic.addEventListener("input", () => validateField(nic, validateNIC, "Invalid NIC format"));
    dob.addEventListener("change", () => validateField(dob, validateDOB, "You must be at least 18 years old"));

    // ✅ Check NIC availability using AJAX
    nic.addEventListener("blur", function () {
      let nicValue = nic.value.trim();
      if (validateNIC(nicValue)) {
        fetch(`/customer/check-nic?nic=${nicValue}`)
                .then(response => response.json())
                .then(data => {
                  if (data.exists) {
                    showError(nic, "This NIC is already registered. Registration not allowed.");
                  } else {
                    clearError(nic);
                  }
                })
                .catch(error => console.error("Error checking NIC:", error));
      }
    });

    form.addEventListener("submit", function (event) {
      let valid = true;

      if (!validateUsername(username.value)) {
        showError(username, "Username must be at least 4 characters");
        valid = false;
      }

      if (!validatePassword(password.value)) {
        showError(password, "Password must have 1 uppercase, 1 number, 1 special character");
        valid = false;
      }

      if (!validateEmail(email.value)) {
        showError(email, "Invalid email format");
        valid = false;
      }

      if (!validatePhoneNumber(contactNumber.value)) {
        showError(contactNumber, "Enter a valid 10-digit phone number");
        valid = false;
      }

      if (address.value.trim() === "") {
        showError(address, "Address is required");
        valid = false;
      }

      if (gender.value === "") {
        showError(gender, "Please select a gender");
        valid = false;
      }

      if (!validateNIC(nic.value)) {
        showError(nic, "Invalid NIC format");
        valid = false;
      }

      if (!validateDOB(dob.value)) {
        showError(dob, "You must be at least 18 years old");
        valid = false;
      }

      // Prevent form submission if there are errors
      if (!valid) {
        event.preventDefault();
      }
    });
  });
</script>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
