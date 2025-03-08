<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Vehicle</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <!-- FontAwesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background-color: #2C3E50;
            color: #ECF0F1;
        }
        .container {
            max-width: 1600px;
            margin: auto;
            padding-top: 50px;
            padding-left: 250px;
        }

        .sidebar {
            width: 250px;
            height: 100vh;
            position: fixed;
            background: #1A252F;
            padding-top: 20px;
        }
        .sidebar a {
            display: block;
            color: #ECF0F1;
            padding: 12px;
            text-decoration: none;
            transition: 0.3s;
        }
        .sidebar a:hover {
            background: #3498DB;
            color: white;
        }
    </style>
</head>
<body>
<div class="d-flex">
    <div class="sidebar">
        <h4 class="text-center text-white">Admin Panel</h4>
        <a href="${pageContext.request.contextPath}/Administrator/admin_dashboard.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
        <a href="${pageContext.request.contextPath}/Administrator/view_drivers.jsp"><i class="fas fa-user"></i> View Drivers</a>
        <a href="${pageContext.request.contextPath}/Administrator/add_driver.jsp"><i class="fas fa-user-plus"></i> Add Driver</a>
        <a href="${pageContext.request.contextPath}/Administrator/view_vehicles.jsp"><i class="fas fa-car"></i> View Vehicles</a>
        <a href="${pageContext.request.contextPath}/Administrator/add_vehicle.jsp" class="active"><i class="fas fa-plus"></i> Add Vehicle</a>
        <a href="${pageContext.request.contextPath}/Administrator/assign_vehicle.jsp"><i class="fas fa-random"></i> Assign Vehicles</a>
        <a href="${pageContext.request.contextPath}/Administrator/booking/manage_booking_vehicle.jsp"><i class="fas fa-calendar-check"></i> Manage Bookings</a>
        <a href="${pageContext.request.contextPath}/Administrator/booking/adminBookedRides.jsp"><i class="fas fa-ban"></i> Manage Rejections</a>
        <a href="${pageContext.request.contextPath}/Administrator/coupon/manage_coupon.jsp"><i class="fas fa-tags"></i> Manage Discounts</a>
        <a href="${pageContext.request.contextPath}/Administrator/login.jsp" class="text-danger"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>
    <div class="container mt-5 ms-5">
        <h2 class="text-center">Add New Vehicle</h2>
        <form action="AddVehicleServlet" method="post" enctype="multipart/form-data" class="p-4 bg-light text-dark rounded shadow">
            <div class="mb-3">
                <label for="category" class="form-label">Vehicle Category:</label>
                <select class="form-select" id="category" name="category" required>
                    <option value="Car">Car</option>
                    <option value="Van">Van</option>
                    <option value="Auto">Auto</option>
                    <option value="Bike">Bike</option>
                </select>
            </div>
            <div class="mb-3">
                <label for="vehicle_model_name" class="form-label">Vehicle Model Name:</label>
                <input type="text" class="form-control" id="vehicle_model_name" name="vehicle_model_name" required>
            </div>
            <div class="mb-3">
                <label for="vehicle_number" class="form-label">Vehicle Number:</label>
                <input type="text" class="form-control" id="vehicle_number" name="vehicle_number" required>
            </div>
            <div class="mb-3">
                <label for="cc" class="form-label">CC:</label>
                <input type="text" class="form-control" id="cc" name="cc" required>
            </div>
            <div class="mb-3">
                <label for="engine_no" class="form-label">Engine Number:</label>
                <input type="text" class="form-control" id="engine_no" name="engine_no" required>
            </div>
            <div class="mb-3">
                <label for="fuel_type" class="form-label">Fuel Type:</label>
                <select class="form-select" id="fuel_type" name="fuel_type" required>
                    <option value="Petrol">Petrol</option>
                    <option value="Diesel">Diesel</option>
                    <option value="Electric">Electric</option>
                    <option value="Hybrid">Hybrid</option>
                </select>
            </div>
            <div class="mb-3">
                <label for="seat_capacity" class="form-label">Seat Capacity:</label>
                <input type="number" class="form-control" id="seat_capacity" name="seat_capacity" required>
            </div>
            <div class="mb-3">
                <label for="rental_price" class="form-label">Rental Price (LKR):</label>
                <input type="text" class="form-control" id="rental_price" name="rental_price" required>
            </div>
            <div class="mb-3">
                <label for="available" class="form-label">Available:</label>
                <select class="form-select" id="available" name="available">
                    <option value="true">Yes</option>
                    <option value="false">No</option>
                </select>
            </div>
            <div class="mb-3">
                <label for="vehicle_photo" class="form-label">Vehicle Photo:</label>
                <input type="file" class="form-control" id="vehicle_photo" name="vehicle_photo" accept="image/*" required>
            </div>
            <button type="submit" class="btn btn-success w-100">Add Vehicle</button>
        </form>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>