<%@ page import="org.example.cab.Admin.dao.CouponDAO" %>
<%@ page import="org.example.cab.Admin.model.Coupon" %>
<%@ page import="java.sql.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String code = request.getParameter("code");
    double discount = Double.parseDouble(request.getParameter("discount"));
    String expirationDateStr = request.getParameter("expirationDate");
    Date expirationDate = null;

    // Converting string to java.sql.Date
    if (expirationDateStr != null && !expirationDateStr.isEmpty()) {
        expirationDate = Date.valueOf(expirationDateStr);
    }

    boolean isActive = request.getParameter("isActive") != null;

    Coupon coupon = new Coupon();
    coupon.setCode(code);
    coupon.setDiscount(discount);
    coupon.setExpirationDate(expirationDate);
    coupon.setActive(isActive);

    CouponDAO couponDAO = new CouponDAO();
    boolean success = couponDAO.createCoupon(coupon);

    if (success) {
        response.sendRedirect("coupon_management.jsp");
    } else {
        out.println("Failed to create coupon.");
    }
%>
