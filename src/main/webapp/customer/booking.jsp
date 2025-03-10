<%@ page import="java.sql.*" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="org.example.cab.customer.model.User" %>
<%@ page import="org.example.cab.Admin.model.Driver" %>
<%@ page import="org.example.cab.Admin.dao.DriverDAO" %>
<%@ page import="org.example.cab.Admin.model.Vehicle" %>
<%@ page import="org.example.cab.Admin.dao.VehicleDAO" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Vehicle Booking</title>
  <link rel="stylesheet" type="text/css" href="styles.css">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    /* Custom hover effect for booking form container */
    .booking-form-container {
      transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .booking-form-container:hover {
      transform: scale(1.05);
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
    }

    .booking-form-card {
      padding: 30px;
      border-radius: 8px;
      background-color: #f9f9f9;
      border: 1px solid #ddd;
    }

    .booking-form-header {
      margin-bottom: 20px;
      text-align: center;
    }
  </style>
</head>
<body>
<%
  // Retrieve customer session
  HttpSession sessionObj = request.getSession(false);
  User user = null;

  if (sessionObj != null) {
    user = (User) sessionObj.getAttribute("user");
  }

  // Retrieve vehicle ID from request parameter
  String vehicleIdParam = request.getParameter("vehicleId");

  // Fetch vehicle details using DAO
  VehicleDAO vehicleDAO = new VehicleDAO();
  Vehicle vehicle = vehicleDAO.getVehicleById(Integer.parseInt(vehicleIdParam));

  // Fetch driver details using DAO (as per your existing code)
  DriverDAO driverDAO = new DriverDAO();
  Driver driver = driverDAO.getDriverByVehicleId(vehicleIdParam);

  // Store the driver ID in the session if driver is found
  if (driver != null) {
    sessionObj.setAttribute("driverId", driver.getId());
  } else {
    response.sendRedirect(request.getContextPath() + "/customer/view_cus_vehicle.jsp");
    return;
  }
%>
<script>
  function calculateBill() {
    var rentalPrice = parseFloat(document.getElementById("rentalPrice").value);
    var fare = parseFloat(document.getElementById("fare").value);
    var couponCode = document.getElementById("couponCode").value.trim();

    // Ensure both rental price and fare are available
    if (!isNaN(rentalPrice) && !isNaN(fare) && couponCode !== "") {
      var xhr = new XMLHttpRequest();
      xhr.open("GET", "applyCoupon.jsp?coupon=" + encodeURIComponent(couponCode), true);
      xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
          var response = xhr.responseText.trim();
          if (response === "Invalid or expired coupon code.") {
            alert(response);
          } else if (response === "Coupon code is required.") {
            alert(response);
          } else {
            var discount = parseFloat(response);
            var discountAmount = (rentalPrice + fare) * discount / 100; // Apply discount to total amount (Rental + Fare)
            var finalAmount = (rentalPrice + fare) - discountAmount;

            // Update the UI with discount and final amount
            document.getElementById("discountAmount").innerHTML = "Discount: " + discountAmount.toFixed(2) + " LKR";
            document.getElementById("finalAmount").innerHTML = "Final Price: " + finalAmount.toFixed(2) + " LKR";
          }
        }
      };
      xhr.send();
    } else {
      alert("Please enter a valid rental price, fare, and coupon code.");
    }
  }
</script>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container">
    <a class="navbar-brand" href="customer_dashboard.jsp">Cab Services</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
            aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item">
          <a class="nav-link" href="view_cus_vehicle.jsp">Vehicles</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="customer_bookings.jsp">My Bookings</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="customer_profile.jsp">Profile</a>
        </li>
        <% if (user != null) { %>
        <li class="nav-item">
          <a class="nav-link" href="#">Welcome, <%= user.getUsername() %></a>
        </li>
        <li class="nav-item">
          <a class="nav-link btn btn-danger btn-sm" href="logout.jsp">Logout</a>
        </li>
        <% } else { %>
        <li class="nav-item">
          <a class="nav-link btn btn-primary btn-sm" href="login.jsp">Login</a>
        </li>
        <% } %>
      </ul>
    </div>
  </div>
</nav>

<!-- Display driver and vehicle details side by side -->
<div class="container my-4">
  <h3>Booking Details</h3>
  <div class="row">
    <!-- Driver Details -->
    <div class="col-md-6">
      <div class="card">
        <div class="card-header">
          <button class="btn btn-link" type="button" data-bs-toggle="collapse" data-bs-target="#driverDetails" aria-expanded="false" aria-controls="driverDetails">
            View Driver Details
          </button>
        </div>
        <div id="driverDetails" class="collapse">
          <div class="card-body">
            <p><strong>Full Name:</strong> <%= driver.getFullName() %></p>
            <p><strong>Email Address:</strong> <%= driver.getEmailAddress() %></p>
            <p><strong>Contact Number:</strong> <%= driver.getContactNumber() %></p>
          </div>
        </div>
      </div>
    </div>

    <!-- Vehicle Details -->
    <div class="col-md-6">
      <div class="card">
        <div class="card-header">
          <button class="btn btn-link" type="button" data-bs-toggle="collapse" data-bs-target="#vehicleDetails" aria-expanded="false" aria-controls="vehicleDetails">
            View Vehicle Details
          </button>
        </div>
        <div id="vehicleDetails" class="collapse">
          <div class="card-body">
            <p><strong>Category:</strong> <%= vehicle.getCategory() %></p>
            <p><strong>Vehicle Number:</strong> <%= vehicle.getVehicleNumber() %></p>
            <p><strong>Engine Capacity:</strong> <%= vehicle.getCc() %> CC</p>
            <p><strong>Seat Capacity:</strong> <%= vehicle.getSeatCapacity() %></p>
            <p><strong>Rental Price:</strong> LKR <%= vehicle.getRentalPrice() %></p>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<%
  Connection conn = null;
  try {
    String dbURL = "jdbc:mysql://localhost:3306/cabs?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    String dbUser = "root";
    String dbPassword = ""; // Change if needed

    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
//    out.println("<div class='alert alert-success'>Database connected successfully!</div>");
  } catch (Exception e) {
    out.println("<div class='alert alert-danger'>Database connection failed: " + e.getMessage() + "</div>");
    e.printStackTrace();
  }

  if (request.getMethod().equalsIgnoreCase("POST")) {
    String username = request.getParameter("username");
    int driverId = Integer.parseInt(request.getParameter("driverId"));
    int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
    String pickupLocation = request.getParameter("pickupLocation");
    String dropOffLocation = request.getParameter("dropOffLocation");
    String specialNeeds = request.getParameter("specialNeeds");
    String bookingDate = request.getParameter("pickupDateTime").replace("T", " ") + ":00";
    String status = "Pending";
    String createdAt = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    String paymentMethod = request.getParameter("paymentMethod");



    String sql = "INSERT INTO bookings (username, driver_id, vehicle_id, pickup_location, drop_off_location, special_needs, booking_date, status, created_at,payment_type ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    PreparedStatement pstmt = null;
    try {
      pstmt = conn.prepareStatement(sql);
      pstmt.setString(1, username);
      pstmt.setInt(2, driverId);
      pstmt.setInt(3, vehicleId);
      pstmt.setString(4, pickupLocation);
      pstmt.setString(5, dropOffLocation);
      pstmt.setString(6, specialNeeds);
      pstmt.setString(7, bookingDate);
      pstmt.setString(8, status);
      pstmt.setString(9, createdAt);
      pstmt.setString(10,paymentMethod);
           // Set the final amount



      int rows = pstmt.executeUpdate();
      if (rows > 0) {
        out.println("<div class='alert alert-success'>Booking successful!</div>");
      } else {
        out.println("<div class='alert alert-danger'>Booking failed. Please try again.</div>");
      }
    } catch (SQLException e) {
      out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
      e.printStackTrace();
    } finally {
      if (pstmt != null) pstmt.close();
      if (conn != null) conn.close();
    }
  }
%>


<!-- Booking Form Section -->
<div class="container my-4 booking-form-container">
  <div class="card booking-form-card">
    <div class="booking-form-header">
      <h2>Booking Form</h2>
    </div>
    <form method="post">
      <div class="mb-3">
        <label for="username" class="form-label">Username</label>
        <input type="text" id="username" name="username" class="form-control"
               value="<%= user != null ? user.getUsername() : "" %>" required readonly>
      </div>
      <div class="mb-3">
        <input type="hidden" id="driverId" name="driverId" value="<%= driver != null ? driver.getId() : "" %>" required>
      </div>

      <div class="mb-3">
        <input type="hidden" id="vehicleId" name="vehicleId" value="<%= vehicleIdParam != null ? vehicleIdParam : "" %>" required>
      </div>

      <div class="mb-3">
        <label for="pickupLocation" class="form-label">Pickup Location</label>
        <select id="pickupLocation" name="pickupLocation" class="form-control" required>
          <option value="">Select Pickup Location</option>
          <!-- Colombo Zones -->
          <option value="Wellawatta">Wellawatta</option>
          <option value="Fort">Fort</option>
          <option value="Borella">Fort</option>
          <option value="Dematagoda">Fort</option>
          <option value="Maradana">Fort</option>
          <option value="Pettah">Fort</option>
          <option value="Hulftsdorp">Fort</option>
          <option value="Kotahena">Fort</option>
          <option value="Grandpass">Fort</option>
          <option value="Bambalapitiya">Fort</option>
          <option value="Kollupitiya ">Fort</option>
          <!-- Other Cities -->

        </select>
      </div>

      <div class="mb-3">
        <label for="dropOffLocation" class="form-label">Drop-off Location</label>
        <select id="dropOffLocation" name="dropOffLocation" class="form-control" required>
          <option value="">Select Drop-Off Location</option>
          <!-- Same Locations for Drop-Off -->
          <option value="Wellawatta">Wellawatta</option>
          <option value="Fort">Fort</option>
          <option value="Borella">Fort</option>
          <option value="Dematagoda">Fort</option>
          <option value="Maradana">Fort</option>
          <option value="Pettah">Fort</option>
          <option value="Hulftsdorp">Fort</option>
          <option value="Kotahena">Fort</option>
          <option value="Grandpass">Fort</option>
          <option value="Bambalapitiya">Fort</option>
          <option value="Kollupitiya ">Fort</option>


          <!-- Other Cities -->

        </select>
      </div>



      <div class="mb-3">
        <label for="specialNeeds" class="form-label">Special Needs (Optional)</label>
        <textarea id="specialNeeds" name="specialNeeds" class="form-control"></textarea>
      </div>

      <div class="mb-3">
        <label for="pickupDateTime" class="form-label">Pickup Date & Time</label>
        <input type="datetime-local" id="pickupDateTime" name="pickupDateTime" class="form-control" required>
      </div>

      <div class="mb-3">
        <label for="rentalPrice" class="form-label">Rental Price</label>
        <input type="text" id="rentalPrice" name="rentalPrice" class="form-control" value="<%= vehicle.getRentalPrice() %>" readonly>
      </div>

      <!-- Ask if they have a discount -->
      <div class="mb-3">
        <label for="discountCheckbox" class="form-label">Do you have a discount code?</label>
        <input type="checkbox" id="discountCheckbox" name="discountCheckbox" onclick="toggleCouponInput()">
      </div>

      <!-- Coupon code section, initially hidden -->
      <div class="mb-3" id="couponSection" style="display: none;">
        <label for="couponCode" class="form-label">Enter Coupon Code</label>
        <input type="text" id="couponCode" name="couponCode" class="form-control">
        <button type="button" onclick="calculateBill()">Apply Coupon</button><br>
        <div id="discountAmount"></div>
        <div id="finalAmount"></div>
      </div>

      <!-- Fare display field -->
      <div class="mb-3">
        <label for="fare" class="form-label">Fare</label>
        <input type="text" id="fare" name="fare" class="form-control" readonly>
      </div>

      <!-- Total Amount Display -->
      <div class="mb-3">
        <label for="totalAmount" class="form-label">Total Amount (Rental + Fare)</label>
        <input type="text" id="totalAmount" class="form-control" readonly>
      </div>




      <div class="mb-3">
        <label for="paymentMethod" class="form-label">Payment Method</label>
        <select id="paymentMethod" name="paymentMethod" class="form-control" required onchange="checkPaymentMethod()">
          <option value="">Select Payment Method</option>
          <option value="cash">Cash</option>
          <option value="card">Card</option>
        </select>
      </div>

      <script>
        // Predefined fare rates for different pickup and drop-off locations
        const fareRates = {
          "Wellawatta": {
            "Wellawatta": 800, // Fare from Wellawatta to Wellawatta
            "Fort": 1000, // Fare from Wellawatta to Fort
            "Borella": 1200,
            "Dematagoda": 1300,
            "Maradana": 1400,
            "Pettah": 1100,
            "Hulftsdorp": 1150,
            "Kotahena": 1250,
            "Grandpass": 1350,
            "Bambalapitiya": 900,
            "Kollupitiya": 950
          },
          "Fort": {
            "Wellawatta": 1000, // Fare from Fort to Wellawatta
            "Fort": 800, // Fare from Fort to Fort
            "Borella": 1100,
            "Dematagoda": 1200,
            "Maradana": 1300,
            "Pettah": 900,
            "Hulftsdorp": 1000,
            "Kotahena": 1150,
            "Grandpass": 1250,
            "Bambalapitiya": 1000,
            "Kollupitiya": 1050
          },
          "Borella": {
            "Wellawatta": 1200,
            "Fort": 1100,
            "Borella": 800,
            "Dematagoda": 900,
            "Maradana": 1000,
            "Pettah": 1100,
            "Hulftsdorp": 1150,
            "Kotahena": 1200,
            "Grandpass": 1300,
            "Bambalapitiya": 1300,
            "Kollupitiya": 1250
          },
          "Dematagoda": {
            "Wellawatta": 1300,
            "Fort": 1200,
            "Borella": 900,
            "Dematagoda": 800,
            "Maradana": 1000,
            "Pettah": 1050,
            "Hulftsdorp": 1100,
            "Kotahena": 1150,
            "Grandpass": 1250,
            "Bambalapitiya": 1300,
            "Kollupitiya": 1250
          },
          "Maradana": {
            "Wellawatta": 1400,
            "Fort": 1300,
            "Borella": 1000,
            "Dematagoda": 1000,
            "Maradana": 800,
            "Pettah": 1100,
            "Hulftsdorp": 1200,
            "Kotahena": 1250,
            "Grandpass": 1350,
            "Bambalapitiya": 1400,
            "Kollupitiya": 1300
          },
          "Pettah": {
            "Wellawatta": 1100,
            "Fort": 900,
            "Borella": 1100,
            "Dematagoda": 1050,
            "Maradana": 1100,
            "Pettah": 800,
            "Hulftsdorp": 950,
            "Kotahena": 1000,
            "Grandpass": 1100,
            "Bambalapitiya": 1200,
            "Kollupitiya": 1150
          },
          "Hulftsdorp": {
            "Wellawatta": 1150,
            "Fort": 1000,
            "Borella": 1150,
            "Dematagoda": 1100,
            "Maradana": 1200,
            "Pettah": 950,
            "Hulftsdorp": 800,
            "Kotahena": 1050,
            "Grandpass": 1100,
            "Bambalapitiya": 1250,
            "Kollupitiya": 1200
          },
          "Kotahena": {
            "Wellawatta": 1250,
            "Fort": 1150,
            "Borella": 1200,
            "Dematagoda": 1150,
            "Maradana": 1250,
            "Pettah": 1000,
            "Hulftsdorp": 1050,
            "Kotahena": 800,
            "Grandpass": 1100,
            "Bambalapitiya": 1300,
            "Kollupitiya": 1250
          },
          "Grandpass": {
            "Wellawatta": 1350,
            "Fort": 1250,
            "Borella": 1300,
            "Dematagoda": 1250,
            "Maradana": 1350,
            "Pettah": 1100,
            "Hulftsdorp": 1100,
            "Kotahena": 1100,
            "Grandpass": 800,
            "Bambalapitiya": 1400,
            "Kollupitiya": 1300
          },
          "Bambalapitiya": {
            "Wellawatta": 900,
            "Fort": 1000,
            "Borella": 1300,
            "Dematagoda": 1300,
            "Maradana": 1400,
            "Pettah": 1200,
            "Hulftsdorp": 1250,
            "Kotahena": 1300,
            "Grandpass": 1400,
            "Bambalapitiya": 800,
            "Kollupitiya": 1100
          },
          "Kollupitiya": {
            "Wellawatta": 950,
            "Fort": 1050,
            "Borella": 1250,
            "Dematagoda": 1250,
            "Maradana": 1300,
            "Pettah": 1150,
            "Hulftsdorp": 1200,
            "Kotahena": 1250,
            "Grandpass": 1300,
            "Bambalapitiya": 1100,
            "Kollupitiya": 800
          }
        };


        // Listen for changes on the pickup and drop-off location dropdowns
        document.getElementById('pickupLocation').addEventListener('change', updateFare);
        document.getElementById('dropOffLocation').addEventListener('change', updateFare);

        function updateFare() {
          const pickupLocation = document.getElementById('pickupLocation').value;
          const dropOffLocation = document.getElementById('dropOffLocation').value;

          // Ensure both locations are selected before proceeding
          if (pickupLocation && dropOffLocation) {
            // Check if the fare for the selected locations exists in the predefined fareRates object
            const fare = fareRates[pickupLocation] && fareRates[pickupLocation][dropOffLocation];

            // If a fare is found, update the fare input, otherwise show 'N/A'
            if (fare) {
              document.getElementById('fare').value = fare;
            } else {
              document.getElementById('fare').value = 'N/A'; // No fare found
            }
          } else {
            // Clear the fare if either location is not selected
            document.getElementById('fare').value = '';
          }

          // Calculate total amount (Rental + Fare) whenever fare changes
          calculateTotalAmount();
        }

        function calculateTotalAmount() {
          const rentalPrice = parseFloat(document.getElementById('rentalPrice').value) || 0;
          const fare = parseFloat(document.getElementById('fare').value) || 0;

          // If a fare is not 'N/A', calculate the total amount
          if (fare !== 'N/A') {
            const totalAmount = rentalPrice + fare;
            document.getElementById('totalAmount').value = totalAmount.toFixed(2); // Round to 2 decimal places
          } else {
            document.getElementById('totalAmount').value = ''; // If no valid fare, clear the total
          }
        }
      </script>
      <!-- Card Details Section -->


      <script>
        function checkPaymentMethod() {
          const paymentMethod = document.getElementById("paymentMethod").value;
          const cardDetails = document.getElementById("cardDetails");

          // Show or hide the card details input fields
          if (paymentMethod === "card") {
            cardDetails.style.display = "block";  // Show the card details section
          } else {
            cardDetails.style.display = "none";   // Hide the card details section
            clearErrors(); // Clear errors when switching back to cash
          }
        }

        function validateCardNumber() {
          const cardNumber = document.getElementById("cardNumber").value;
          const cardNumberError = document.getElementById("cardNumberError");

          // Validate card number (simple 16-digit check)
          const cardNumberPattern = /^[0-9]{16}$/;
          if (!cardNumberPattern.test(cardNumber)) {
            cardNumberError.style.display = "block";
          } else {
            cardNumberError.style.display = "none";
          }
        }

        function validateExpiryDate() {
          const expiryDate = document.getElementById("expiryDate").value;
          const expiryDateError = document.getElementById("expiryDateError");

          // Validate expiry date (must not be empty)
          if (!expiryDate) {
            expiryDateError.style.display = "block";
          } else {
            expiryDateError.style.display = "none";
          }
        }

        function validateCVV() {
          const cvv = document.getElementById("cvv").value;
          const cvvError = document.getElementById("cvvError");

          // Validate CVV (simple 3-digit check)
          const cvvPattern = /^[0-9]{3}$/;
          if (!cvvPattern.test(cvv)) {
            cvvError.style.display = "block";
          } else {
            cvvError.style.display = "none";
          }
        }

        function clearErrors() {
          document.getElementById("cardNumberError").style.display = "none";
          document.getElementById("expiryDateError").style.display = "none";
          document.getElementById("cvvError").style.display = "none";
        }

      </script>


      <!-- Submit button -->
      <div class="mb-3">

        <button type="submit" class="btn btn-primary w-100">Submit Booking</button>
      </div>
    </form>

    <script>
      // Toggle the coupon code section
      function toggleCouponInput() {
        var discountCheckbox = document.getElementById("discountCheckbox");
        var couponSection = document.getElementById("couponSection");

        if (discountCheckbox.checked) {
          couponSection.style.display = "block";
        } else {
          couponSection.style.display = "none";
          document.getElementById("discountAmount").innerHTML = "";
          document.getElementById("finalAmount").innerHTML = "";
        }
      }
    </script>
    <script>
      document.addEventListener("DOMContentLoaded", function () {
        const pickupLocation = document.getElementById("pickupLocation");
        const dropOffLocation = document.getElementById("dropOffLocation");
        const pickupDateTime = document.getElementById("pickupDateTime");
        const specialNeeds = document.getElementById("specialNeeds");
        const couponCheckbox = document.getElementById("discountCheckbox");
        const couponSection = document.getElementById("couponSection");
        const couponCode = document.getElementById("couponCode");
        const bookingForm = document.querySelector("form");

        // Prevent same pickup & drop-off location
        function validateLocations() {
          if (pickupLocation.value && dropOffLocation.value && pickupLocation.value === dropOffLocation.value) {
            alert("Pickup and drop-off locations cannot be the same. Please select different locations.");
            dropOffLocation.value = ""; // Reset drop-off selection
          }
        }

        pickupLocation.addEventListener("change", validateLocations);
        dropOffLocation.addEventListener("change", validateLocations);

        // Validate booking date to be in the future but within 2 days
        function validateDateTime() {
          const now = new Date();
          const selectedDateTime = new Date(pickupDateTime.value);

          // Calculate max allowed date (2 days from now)
          const maxDate = new Date();
          maxDate.setDate(maxDate.getDate() + 2);

          if (selectedDateTime <= now) {
            alert("Pickup date and time must be in the future. Please select a valid time.");
            pickupDateTime.value = "";
          } else if (selectedDateTime > maxDate) {
            alert("You can only book a ride within the next 2 days. Please select a valid date.");
            pickupDateTime.value = "";
          }
        }

        pickupDateTime.addEventListener("change", validateDateTime);

        // Alert user for special needs input
        function validateSpecialNeeds() {
          const invalidWords = ["random", "unnecessary", "anything", "nothing", "idk"];
          let inputText = specialNeeds.value.toLowerCase();

          for (let word of invalidWords) {
            if (inputText.includes(word)) {
              alert("Please enter only specific special needs. Avoid unnecessary details.");
              specialNeeds.value = "";
              return;
            }
          }
        }

        specialNeeds.addEventListener("input", validateSpecialNeeds);

        // Show/hide coupon input field
        function toggleCouponInput() {
          if (couponCheckbox.checked) {
            couponSection.style.display = "block";
          } else {
            couponSection.style.display = "none";
            couponCode.value = "";
          }
        }

        couponCheckbox.addEventListener("change", toggleCouponInput);

        // Final validation before form submission
        bookingForm.addEventListener("submit", function (event) {
          const paymentMethod = document.getElementById("paymentMethod").value;  // Get the selected payment method
          let confirmPayment;

          if (paymentMethod === "cash") {
            confirmPayment = confirm("You must pay by cash to the driver. Do you want to proceed?");
          } else if (paymentMethod === "card") {
            confirmPayment = confirm("You will pay by card. Do you want to proceed?");

            // If user selects "card", redirect to the card details form
            if (confirmPayment) {
              window.location.href = "card-details.jsp";  // Redirect to another page with the card details form
            }
          }

          if (!confirmPayment) {
            event.preventDefault();  // Prevent form submission if user cancels the payment confirmation
          }
        });


      });
    </script>


  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
