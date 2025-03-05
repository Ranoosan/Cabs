<%@ page import="org.example.cab.Admin.dao.CouponDAO" %>
<%@ page import="org.example.cab.Admin.model.Coupon" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  int couponId = Integer.parseInt(request.getParameter("id"));
  CouponDAO couponDAO = new CouponDAO();
  Coupon coupon = couponDAO.getCouponById(couponId);
%>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Edit Coupon</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
  <h2>Edit Coupon</h2>
  <form action="update_coupon.jsp" method="post">
    <input type="hidden" name="id" value="<%= coupon.getId() %>">
    <div class="mb-3">
      <label for="code" class="form-label">Coupon Code</label>
      <input type="text" class="form-control" id="code" name="code" value="<%= coupon.getCode() %>" required>
    </div>
    <div class="mb-3">
      <label for="discount" class="form-label">Discount (%)</label>
      <input type="number" class="form-control" id="discount" name="discount" value="<%= coupon.getDiscount() %>" required>
    </div>
    <div class="mb-3">
      <label for="expirationDate" class="form-label">Expiration Date</label>
      <input type="date" class="form-control" id="expirationDate" name="expirationDate" value="<%= coupon.getExpirationDate() %>" required>
    </div>
    <div class="mb-3">
      <label for="isActive" class="form-label">Is Active</label>
      <input type="checkbox" id="isActive" name="isActive" <%= coupon.isActive() ? "checked" : "" %>>
    </div>
    <button type="submit" class="btn btn-primary">Update Coupon</button>
  </form>
</div>
</body>
</html>
