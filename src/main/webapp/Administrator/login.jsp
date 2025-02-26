<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #2C3E50; /* Dark blue background */
            color: #ECF0F1; /* Light gray text */
        }
        .container {
            margin-top: 80px;
            border: 1px solid #34495E;
            border-radius: 10px;
            padding: 30px;
            background-color: #34495E;
            max-width: 400px;
            box-shadow: 0 4px 10px rgba(255, 255, 255, 0.1);
        }
        .btn-custom {
            background-color: #3498DB;
            color: #FFFFFF;
            font-weight: bold;
            border: none;
            transition: 0.3s;
        }
        .btn-custom:hover {
            background-color: #2980B9;
            color: #FFFFFF;
        }
        .navbar {
            background-color: #1A252F;
            padding: 15px;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .navbar a {
            color: #ECF0F1;
            font-weight: bold;
            text-decoration: none;
        }
        .navbar a:hover {
            color: #3498DB;
        }
        label {
            font-weight: bold;
        }
        .form-control {
            background-color: #2C3E50;
            color: #ECF0F1;
            border: 1px solid #3498DB;
        }
        .form-control:focus {
            background-color: #2C3E50;
            color: #ECF0F1;
            border: 1px solid #2980B9;
            box-shadow: none;
        }
    </style>
</head>
<body>

<!-- Navigation Bar -->
<nav class="navbar">
    <a href="${pageContext.request.contextPath}/Administrator/admin_dashboard.jsp">Admin Dashboard</a>
</nav>

<div class="container">
    <h2 class="text-center">Admin Login</h2>
    <form action="login" method="post">
        <div class="mb-3">
            <label>Username:</label>
            <input type="text" name="username" class="form-control" required>
        </div>

        <div class="mb-3">
            <label>Password:</label>
            <input type="password" name="password" class="form-control" required>
        </div>

        <button type="submit" class="btn btn-custom w-100">Login</button>
    </form>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
