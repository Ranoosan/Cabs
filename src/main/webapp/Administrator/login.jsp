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
            background: linear-gradient(135deg, #ECECEC, #DADADA); /* Light Grey Gradient */
            color: #2C3E50;
            font-family: 'Poppins', sans-serif;
        }
        .container {
            margin-top: 80px;
            border-radius: 12px;
            padding: 30px;
            background: rgba(255, 255, 255, 0.95); /* Light glass effect */
            max-width: 400px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(10px);
        }
        .btn-custom {
            background: linear-gradient(135deg, #7F8C8D, #566573);
            color: #FFFFFF;
            font-weight: bold;
            border: none;
            transition: 0.3s ease-in-out;
            border-radius: 6px;
        }
        .btn-custom:hover {
            background: linear-gradient(135deg, #566573, #2C3E50);
            transform: scale(1.05);
            box-shadow: 0 0 10px rgba(44, 62, 80, 0.5);
        }
        .navbar {
            background: rgba(236, 240, 241, 0.9);
            padding: 15px;
            display: flex;
            justify-content: center;
            align-items: center;
            border-bottom: 2px solid #BDC3C7;
        }
        .navbar a {
            color: #2C3E50;
            font-weight: bold;
            text-decoration: none;
            font-size: 18px;
            transition: 0.3s;
        }
        .navbar a:hover {
            color: #566573;
            text-shadow: 0 0 5px rgba(86, 101, 115, 0.5);
        }
        label {
            font-weight: bold;
        }
        .form-control {
            background: rgba(250, 250, 250, 0.8);
            color: #2C3E50;
            border: 1px solid #BDC3C7;
            border-radius: 6px;
            transition: 0.3s ease-in-out;
        }
        .form-control:focus {
            background: rgba(255, 255, 255, 0.9);
            color: #2C3E50;
            border: 1px solid #566573;
            box-shadow: 0 0 10px rgba(86, 101, 115, 0.4);
        }
        h2 {
            text-align: center;
            font-weight: bold;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
    </style>
</head>
<body>

<!-- Navigation Bar -->
<nav class="navbar">
    <a href="${pageContext.request.contextPath}/Administrator/admin_dashboard.jsp">Admin Dashboard</a>
</nav>

<div class="container">
    <h2>Admin Login</h2>
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
