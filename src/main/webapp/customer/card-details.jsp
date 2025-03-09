<%@ page import="java.sql.*, java.time.LocalDateTime, java.time.format.DateTimeFormatter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Card Payment Details</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script>
    // Real-time validation for card number
    function validateCardNumber() {
      const cardNumber = document.getElementById('cardNumber').value;
      const cardNumberError = document.getElementById('cardNumberError');
      const cardNumberPattern = /^[0-9]{16}$/;

      if (!cardNumberPattern.test(cardNumber)) {
        cardNumberError.style.display = 'block';
      } else {
        cardNumberError.style.display = 'none';
      }
    }

    // Real-time validation for CVV
    function validateCVV() {
      const cvv = document.getElementById('cvv').value;
      const cvvError = document.getElementById('cvvError');
      const cvvPattern = /^[0-9]{3}$/;

      if (!cvvPattern.test(cvv)) {
        cvvError.style.display = 'block';
      } else {
        cvvError.style.display = 'none';
      }
    }

    // Real-time validation for expiry date
    function validateExpiryDate() {
      const expiryDate = document.getElementById('expiryDate').value;
      const expiryDateError = document.getElementById('expiryDateError');
      const currentDate = new Date();
      const [year, month] = expiryDate.split('-');
      const expiryDateObj = new Date(year, month - 1);

      if (expiryDateObj < currentDate) {
        expiryDateError.style.display = 'block';
      } else {
        expiryDateError.style.display = 'none';
      }
    }
  </script>
</head>
<body>
<div class="container mt-5">
  <h2>Enter Card Payment Details</h2>

  <%
    // Database connection
    Connection conn = null;
    PreparedStatement pstmt = null;
    String message = "";

    try {
      // Handle form submission
      if (request.getMethod().equalsIgnoreCase("POST")) {
        // Get form data
        String userId = request.getParameter("user_id");
        String paymentMethod = request.getParameter("paymentMethod");
        String cardNumber = request.getParameter("cardNumber");
        String expiryDate = request.getParameter("expiryDate");
        String cvv = request.getParameter("cvv");

        // Convert expiryDate to appropriate format
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM");
        LocalDateTime expiryDateTime = LocalDateTime.parse(expiryDate + "-01", formatter);

        // Database connection details
        String dbURL = "jdbc:mysql://localhost:3306/cabs?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
        String dbUser = "root";
        String dbPassword = "";

        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // Create SQL to insert payment details into database
        String sql = "INSERT INTO PaymentDetails (user_id, payment_method, card_number, expiry_date, cvv, created_at) VALUES (?, ?, ?, ?, ?, NOW())";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, Integer.parseInt(userId));  // Assuming user_id is passed as a parameter
        pstmt.setString(2, paymentMethod);
        pstmt.setString(3, cardNumber);  // Store a masked or encrypted card number if necessary
        pstmt.setDate(4, java.sql.Date.valueOf(expiryDateTime.toLocalDate()));  // Convert LocalDateTime to SQL Date
        pstmt.setString(5, cvv);  // Store a masked or encrypted CVV if necessary

        // Execute the query
        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
          message = "Payment details saved successfully!";
        } else {
          message = "Failed to save payment details. Please try again.";
        }
      }
    } catch (Exception e) {
      message = "Error: " + e.getMessage();
      e.printStackTrace();
    } finally {
      if (pstmt != null) pstmt.close();
      if (conn != null) conn.close();
    }
  %>

  <!-- Show success or error message -->
  <div class="alert <%= message.contains("Error") ? "alert-danger" : "alert-success" %>">
    <%= message %>
  </div>

  <!-- Payment Form -->
  <form action="card-details.jsp" method="POST" id="cardPaymentForm">
    <!-- Hidden User ID Field -->
    <input type="hidden" name="user_id" value="<%= session.getAttribute("user_id") != null ? session.getAttribute("user_id") : "" %>" /> <!-- Assuming user_id is passed from session -->

    <div class="mb-3">
      <label for="paymentMethod" class="form-label">Payment Method</label>
      <input type="text" id="paymentMethod" name="paymentMethod" value="card" class="form-control" readonly>
    </div>

    <div class="mb-3">
      <label for="cardNumber" class="form-label">Card Number</label>
      <input type="text" id="cardNumber" name="cardNumber" class="form-control" required oninput="validateCardNumber()">
      <div id="cardNumberError" style="color: red; display: none;">Please enter a valid card number (16 digits).</div>
    </div>

    <div class="mb-3">
      <label for="expiryDate" class="form-label">Expiry Date</label>
      <input type="month" id="expiryDate" name="expiryDate" class="form-control" required oninput="validateExpiryDate()">
      <div id="expiryDateError" style="color: red; display: none;">Please enter a valid expiry date (future date).</div>
    </div>

    <div class="mb-3">
      <label for="cvv" class="form-label">CVV</label>
      <input type="text" id="cvv" name="cvv" class="form-control" required oninput="validateCVV()">
      <div id="cvvError" style="color: red; display: none;">Please enter a valid CVV (3 digits).</div>
    </div>

    <button type="submit" class="btn btn-primary">Submit Payment</button>
  </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
