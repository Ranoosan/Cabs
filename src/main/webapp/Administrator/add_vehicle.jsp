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
            background-color: #f8f9fa; /* Light grey background */
            color: #333333; /* Dark grey text color */

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
        .btn-grey {
            background-color: #6c757d; /* Grey background */
            color: white; /* White text */
            font-weight: bold;
            padding: 10px;
            border: none;
            border-radius: 5px;
            width: 100%; /* Full width */
            transition: all 0.3s ease-in-out;
        }

        .btn-grey:hover {
            background-color: #5a6268; /* Darker grey on hover */
            transform: scale(1.05); /* Slight zoom effect */
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
            <button type="submit" class="btn btn-grey">Add Vehicle</button>

        </form>
    </div>
</div>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const form = document.querySelector("form");
        const vehicleModel = document.getElementById("vehicle_model_name");
        const vehicleNumber = document.getElementById("vehicle_number");
        const cc = document.getElementById("cc");
        const engineNo = document.getElementById("engine_no");
        const seatCapacity = document.getElementById("seat_capacity");
        const rentalPrice = document.getElementById("rental_price");
        const vehiclePhoto = document.getElementById("vehicle_photo");

        function showError(input, message) {
            input.classList.add("is-invalid");
            if (!input.nextElementSibling || !input.nextElementSibling.classList.contains("invalid-feedback")) {
                const errorDiv = document.createElement("div");
                errorDiv.className = "invalid-feedback";
                errorDiv.innerText = message;
                input.parentNode.appendChild(errorDiv);
            } else {
                input.nextElementSibling.innerText = message;
            }
        }

        function clearError(input) {
            input.classList.remove("is-invalid");
            if (input.nextElementSibling && input.nextElementSibling.classList.contains("invalid-feedback")) {
                input.nextElementSibling.remove();
            }
        }

        function validateField(input, regex, message) {
            if (!regex.test(input.value.trim())) {
                showError(input, message);
                return false;
            } else {
                clearError(input);
                return true;
            }
        }

        function validateNotEmpty(input, message) {
            if (input.value.trim() === "") {
                showError(input, message);
                return false;
            } else {
                clearError(input);
                return true;
            }
        }

        vehicleNumber.addEventListener("input", function () {
            validateField(vehicleNumber, /^[A-Z]{2,3}-\d{4}$/i, "Invalid vehicle number format (e.g., ABC-1234)");
        });

        cc.addEventListener("input", function () {
            validateField(cc, /^[0-9]+$/, "CC must be a numeric value");
        });

        seatCapacity.addEventListener("input", function () {
            validateField(seatCapacity, /^[1-9][0-9]*$/, "Seat capacity must be a positive number");
        });

        rentalPrice.addEventListener("input", function () {
            validateField(rentalPrice, /^[1-9][0-9]*$/, "Rental price must be a valid amount");
        });

        vehiclePhoto.addEventListener("change", function () {
            const file = vehiclePhoto.files[0];
            if (file) {
                const fileType = file.type;
                if (!fileType.startsWith("image/")) {
                    showError(vehiclePhoto, "Please upload a valid image file");
                    vehiclePhoto.value = "";
                } else {
                    clearError(vehiclePhoto);
                }
            }
        });

        form.addEventListener("submit", function (e) {
            let isValid = true;

            isValid &= validateNotEmpty(vehicleModel, "Vehicle model name is required");
            isValid &= validateField(vehicleNumber, /^[A-Z]{2,3}-\d{4}$/i, "Invalid vehicle number format");
            isValid &= validateField(cc, /^[0-9]+$/, "CC must be numeric");
            isValid &= validateField(seatCapacity, /^[1-9][0-9]*$/, "Seat capacity must be positive");
            isValid &= validateField(rentalPrice, /^[1-9][0-9]*$/, "Rental price must be valid");

            if (!isValid) {
                e.preventDefault();
            }
        });
    });

</script>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const category = document.getElementById("category");
        const seatCapacity = document.getElementById("seat_capacity");

        function validateSeatCapacity() {
            let selectedCategory = category.value;
            let seatValue = parseInt(seatCapacity.value, 10);
            let min = 0, max = 0, message = "";

            switch (selectedCategory) {
                case "Car":
                    min = 4; max = 8; message = "Car seat capacity must be between 4 and 8.";
                    break;
                case "Van":
                    min = 6; max = 12; message = "Van seat capacity must be between 6 and 12.";
                    break;
                case "Auto":
                    min = 3; max = 5; message = "Auto seat capacity must be between 3 and 5.";
                    break;
                case "Bike":
                    min = 2; max = 3; message = "Bike seat capacity must be 2 or 3.";
                    break;
                default:
                    return;
            }

            if (seatValue < min || seatValue > max || isNaN(seatValue)) {
                seatCapacity.setCustomValidity(message);
                seatCapacity.reportValidity(); // Show validation message
            } else {
                seatCapacity.setCustomValidity("");
            }
        }

        // Event Listeners
        category.addEventListener("change", validateSeatCapacity);
        seatCapacity.addEventListener("input", validateSeatCapacity);
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>