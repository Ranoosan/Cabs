<%@ page import="org.example.cab.Admin.dao.CouponDAO" %>
<%@ page import="org.example.cab.Admin.model.Coupon" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    try {
        int id = Integer.parseInt(request.getParameter("id"));
        String code = request.getParameter("code");
        double discount = Double.parseDouble(request.getParameter("discount"));
        String expirationDate = request.getParameter("expirationDate");
        boolean isActive = request.getParameter("isActive") != null;

        Coupon coupon = new Coupon();
        coupon.setId(id);
        coupon.setCode(code);
        coupon.setDiscount(discount);
        coupon.setExpirationDate(java.sql.Date.valueOf(expirationDate));
        coupon.setActive(isActive);

        CouponDAO couponDAO = new CouponDAO();
        boolean success = couponDAO.updateCoupon(coupon);

        if (success) {
            response.sendRedirect("manage_coupon.jsp?success=Coupon updated successfully");
        } else {
            response.sendRedirect("edit_coupon.jsp?id=" + id + "&error=Failed to update coupon");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("edit_coupon.jsp?id=" + request.getParameter("id") + "&error=Invalid input");
    }
%>
