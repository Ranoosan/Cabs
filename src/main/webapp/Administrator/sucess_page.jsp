<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Success</title>

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
    </style>
</head>
<body>

<div class="container">
    <h2>Driver Added Successfully!</h2>
    <p>The driver has been added to the system successfully.</p>
    <a href="${pageContext.request.contextPath}/Administrator/admin_dashboard.jsp" class="btn btn-primary">Back to Dashboard</a>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
