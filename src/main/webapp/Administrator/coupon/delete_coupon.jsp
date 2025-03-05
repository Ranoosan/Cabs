<%@ page import="org.example.cab.Admin.dao.CouponDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  int couponId = Integer.parseInt(request.getParameter("id"));
  CouponDAO couponDAO = new CouponDAO();
  boolean success = couponDAO.deleteCoupon(couponId);
  if (success) {
    response.sendRedirect("coupon_management.jsp");
  } else {
    out.println("Failed to delete coupon.");
  }
%>
