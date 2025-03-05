<%@ page import="java.sql.*" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="org.example.cab.customer.model.User" %>
<%@ page import="org.example.cab.Admin.model.Driver" %>
<%@ page import="org.example.cab.Admin.dao.DriverDAO" %>
<%@ page import="org.example.cab.Admin.model.Vehicle" %>
<%@ page import="org.example.cab.Admin.dao.VehicleDAO" %>
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
    var couponCode = document.getElementById("couponCode").value.trim();

    if (!isNaN(rentalPrice) && couponCode !== "") {
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
            var discountAmount = (rentalPrice * discount) / 100;
            var finalAmount = rentalPrice - discountAmount;

            document.getElementById("discountAmount").innerHTML = "Discount: " + discountAmount.toFixed(2) + " LKR";
            document.getElementById("finalAmount").innerHTML = "Final Price: " + finalAmount.toFixed(2) + " LKR";
          }
        }
      };
      xhr.send();
    } else {
      alert("Please enter a valid rental price and coupon code.");
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



    String sql = "INSERT INTO bookings (username, driver_id, vehicle_id, pickup_location, drop_off_location, special_needs, booking_date, status, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
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
          <option value="Colombo">Colombo</option>
          <option value="Kandy">Kandy</option>
          <option value="Galle">Galle</option>
          <option value="Negombo">Negombo</option>
          <option value="Batticaloa">Batticaloa</option>
          <option value="Kurunegala">Kurunegala</option>
          <option value="Jaffna">Jaffna</option>
        </select>
      </div>

      <div class="mb-3">
        <label for="dropOffLocation" class="form-label">Drop-off Location</label>
        <select id="dropOffLocation" name="dropOffLocation" class="form-control" required>
          <option value="">Select Drop-Off Location</option>
          <option value="Colombo">Colombo</option>
          <option value="Kandy">Kandy</option>
          <option value="Galle">Galle</option>
          <option value="Negombo">Negombo</option>
          <option value="Batticaloa">Batticaloa</option>
          <option value="Kurunegala">Kurunegala</option>
          <option value="Jaffna">Jaffna</option>
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

      <!-- Submit button -->
      <div class="mb-3">
        <input type="submit" value="Book Now">
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

      // // Calculate the bill with discount
      // function calculateBill() {
      //   var rentalPrice = parseFloat(document.getElementById("rentalPrice").value);
      //   var couponCode = document.getElementById("couponCode").value.trim();
      //
      //   if (!isNaN(rentalPrice) && couponCode !== "") {
      //     var xhr = new XMLHttpRequest();
      //     xhr.open("GET", "applyCoupon.jsp?coupon=" + encodeURIComponent(couponCode), true);
      //     xhr.onreadystatechange = function () {
      //       if (xhr.readyState === 4 && xhr.status === 200) {
      //         var discount = parseFloat(xhr.responseText);
      //         if (isNaN(discount)) {
      //           discount = 0;
      //         }
      //         var discountAmount = (rentalPrice * discount) / 100;
      //         var finalAmount = rentalPrice - discountAmount;
      //
      //         document.getElementById("discountAmount").innerHTML = "Discount: " + discountAmount.toFixed(2) + " LKR";
      //         document.getElementById("finalAmount").innerHTML = "Final Price: " + finalAmount.toFixed(2) + " LKR";
      //       }
      //     };
      //     xhr.send();
      //   }
      // }
    </script>

  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
