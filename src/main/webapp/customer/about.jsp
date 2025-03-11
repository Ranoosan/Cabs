<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>About Us - Mega City Cab</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <style>
    body {
      background-color: #e0f0f6;
      color: #fff;
      font-family: 'Arial', sans-serif;
      margin: 0;
    }
    .navbar {
      position: sticky;
      top: 0;
      background: linear-gradient(to right, #1d72b8, #ff5f6d);
      padding: 15px 20px;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }
    .navbar a {
      color: white;
      padding: 12px 20px;
      font-size: 16px;
      text-decoration: none;
      margin: 0 10px;
    }
    .navbar a:hover {
      background-color: #222;
      border-radius: 5px;
      transition: background-color 0.3s ease;
    }

    .stars {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: url('https://www.transparenttextures.com/patterns/stardust.png') repeat;
      animation: moveStars 40s linear infinite;
      z-index: -1;
      opacity: 0.9;
      transform: scale(2);
    }

    @keyframes moveStars {
      0% {
        transform: translate(0, 0) scale(2);
      }
      100% {
        transform: translate(-1000px, -1000px) scale(2);
      }
    }

    .container {
      max-width: 1900px;
      background: linear-gradient(to right, #6a9bb7, #ff8b8b);
      border-radius: 10px;
      padding: 30px;
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
      margin-top: 50px;
      position: static;
      z-index: 1;
      max-height: 180vh;
      overflow-y: auto;
    }

    h1 {
      color: #333;
    }

    h2 {
      color: #333;
    }

    .text-dark {
      color: #333;
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

    .location-item {
      padding: 10px 0;
      color: #333;
    }

    .location-item h4 {
      margin-bottom: 5px;
    }

    .location-item p {
      margin: 0;
    }
  </style>
</head>
<body>
<div class="navbar">
  <h2>Cab Service Dashboard</h2>
  <div>
    <a href="welcome.jsp">Home</a>
    <a href="about.jsp">About Us</a>
    <%--        <a href="#">Book a Ride</a>--%>
    <%--        <a href="#">Ride History</a>--%>
    <%--        <a href="profile.jsp">Profile</a>--%>
    <a class="btn logout" href="<%= request.getContextPath() %>/customer/login.jsp">Logout</a>
  </div>
</div>
<div class="stars"></div>

<div class="container">
  <h1 class="text-center">About Mega City Cab</h1>
  <p class="text-dark">Mega City Cab is one of Colombo's leading cab services, providing fast, reliable, and affordable transportation to thousands of customers across the city. Established with the goal of making city travel easier, safer, and more convenient, we have become the go-to choice for people looking for a reliable and professional cab service in Colombo.</p>

  <h2 class="mt-4">Our Services</h2>
  <p class="text-dark">Mega City Cab offers 24/7 cab services across Colombo, ensuring that you have access to a ride whenever you need it. We take pride in our fleet of modern vehicles, including sedans, SUVs, and luxury cars, ensuring a comfortable and enjoyable journey for every passenger. Whether you're heading to work, going out for a night on the town, or need a ride to the airport, Mega City Cab is here for you.</p>

  <p class="text-dark">Booking a cab with us is easy. Simply use our user-friendly mobile app or website to schedule your ride within Colombo. We offer multiple payment options, including cash, card payments, and e-wallets, ensuring that you can pay for your ride in a way that is most convenient for you.</p>

  <h2 class="mt-4">Our Locations</h2>
  <p class="text-dark">Mega City Cab is proud to have three key showrooms strategically located across Colombo. These showrooms serve as hubs for our drivers and customers, ensuring a seamless experience for both. Visit any of our showrooms for bookings, inquiries, and more.</p>

  <div class="location-item">
    <h4>1. Colombo 1 - Fort</h4>
    <p>Located in the heart of Colombo, our Fort showroom is easily accessible for customers in the central area. Whether you're traveling for business or leisure, our showroom in Fort is the perfect place to book your next ride.</p>
  </div>

  <div class="location-item">
    <h4>2. Colombo 3 - Kollupitiya</h4>
    <p>Our Kollupitiya showroom is located near some of Colombo’s busiest business districts. It’s a central location for those looking to book a ride or for drivers to pick up passengers quickly. Our Kollupitiya location is perfect for both residential and commercial clients.</p>
  </div>

  <div class="location-item">
    <h4>3. Colombo 7 - Borella</h4>
    <p>Located in the vibrant Borella area, this showroom is ideal for customers living in the northern part of Colombo. Whether you're a local or a tourist, our Borella showroom is a convenient point to start your journey across the city.</p>
  </div>

  <h2 class="mt-4">Why Choose Mega City Cab?</h2>
  <ul class="text-dark">
    <li><strong>24/7 Availability:</strong> Our services are available round the clock, ensuring that you can travel whenever you need to.</li>
    <li><strong>Modern Fleet:</strong> We offer a wide range of vehicles, from economy cars to luxury sedans, all equipped with modern amenities.</li>
    <li><strong>Professional Drivers:</strong> Our drivers are highly trained, courteous, and committed to providing you with a safe and pleasant ride.</li>
    <li><strong>Easy Booking:</strong> Book your ride easily through our app or website, and track your ride in real-time.</li>
    <li><strong>Affordable Rates:</strong> We offer competitive and transparent pricing, with no hidden charges.</li>
  </ul>

  <h2 class="mt-4">Join the Mega City Cab Family</h2>
  <p class="text-dark">We are always looking for talented and passionate individuals to join our team. If you are interested in becoming a driver or part of our growing support team, feel free to reach out to us. We offer competitive pay, flexible working hours, and a dynamic work environment.</p>

  <p class="text-center mt-4">
    <a href="contactus.jsp" class="btn btn-primary">Contact Us</a>
  </p>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
