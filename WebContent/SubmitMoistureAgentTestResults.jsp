<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.math.BigDecimal" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Submit Test Results</title>
</head>
<body>
<%
    String testType = request.getParameter("testType");
    Connection conn = null;
    PreparedStatement stmt = null;
    
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ricehuskinsulation", "root", "root");
        
        String sql = "INSERT INTO moisture_control_tests (testType, initialWeight, finalWeight, changeInMass, area, time, initialThickness, finalThickness, originalDimension, finalDimension, moistureAbsorption, wvtr, swellingPercentage, shrinkagePercentage) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, testType);
        
        if ("MoistureAbsorption".equals(testType)) {
            stmt.setBigDecimal(2, new BigDecimal(request.getParameter("initialWeight")));
            stmt.setBigDecimal(3, new BigDecimal(request.getParameter("finalWeight")));
            stmt.setBigDecimal(10, null);
            stmt.setBigDecimal(11, new BigDecimal(request.getParameter("moistureAbsorption")));
            stmt.setBigDecimal(4, null);
            stmt.setBigDecimal(5, null);
            stmt.setBigDecimal(6, null);
            stmt.setBigDecimal(7, null);
            stmt.setBigDecimal(8, null);
            stmt.setBigDecimal(9, null);
            stmt.setBigDecimal(12, null);
            stmt.setBigDecimal(13, null);
            stmt.setBigDecimal(14, null);
        } else if ("WVTR".equals(testType)) {
            stmt.setBigDecimal(2, null);
            stmt.setBigDecimal(3, null);
            stmt.setBigDecimal(4, new BigDecimal(request.getParameter("changeInMass")));
            stmt.setBigDecimal(5, new BigDecimal(request.getParameter("area")));
            stmt.setBigDecimal(6, new BigDecimal(request.getParameter("time")));
            stmt.setBigDecimal(11, null);
            stmt.setBigDecimal(7, null);
            stmt.setBigDecimal(8, null);
            stmt.setBigDecimal(9, null);
            stmt.setBigDecimal(10, null);
            stmt.setBigDecimal(12, new BigDecimal(request.getParameter("wvtr")));
            stmt.setBigDecimal(13, null);
            stmt.setBigDecimal(14, null);
        } else if ("Swelling".equals(testType)) {
            stmt.setBigDecimal(2, null);
            stmt.setBigDecimal(3, null);
            stmt.setBigDecimal(10, null);
            stmt.setBigDecimal(11, null);
            stmt.setBigDecimal(4, null);
            stmt.setBigDecimal(5, null);
            stmt.setBigDecimal(6, null);
            stmt.setBigDecimal(7, new BigDecimal(request.getParameter("initialThickness")));
            stmt.setBigDecimal(8, new BigDecimal(request.getParameter("finalThickness")));
            stmt.setBigDecimal(9, null);
            stmt.setBigDecimal(12, null);
            stmt.setBigDecimal(13, new BigDecimal(request.getParameter("swellingPercentage")));
            stmt.setBigDecimal(14, null);
        } else if ("Shrinkage".equals(testType)) {
            stmt.setBigDecimal(2, null);
            stmt.setBigDecimal(3, null);
            stmt.setBigDecimal(4, null);
            stmt.setBigDecimal(5, null);
            stmt.setBigDecimal(6, null);
            stmt.setBigDecimal(7, null);
            stmt.setBigDecimal(8, null);
            stmt.setBigDecimal(9, new BigDecimal(request.getParameter("originalDimension")));
            stmt.setBigDecimal(10,new BigDecimal(request.getParameter("finalDimension")));
            stmt.setBigDecimal(11, null);
            stmt.setBigDecimal(12, null);
            stmt.setBigDecimal(13, null);
            stmt.setBigDecimal(14, new BigDecimal(request.getParameter("shrinkagePercentage")));
        }
        
        int result = stmt.executeUpdate();
        if (result > 0) {
           
       	 response.getWriter().print("<html><body><script>alert('Test results submitted successfully! ');</script></body></html>");
  		 RequestDispatcher dispatcher = request.getRequestDispatcher("MoistureControlAgentCalculation.jsp");

         dispatcher.include(request, response);
        } else {
           
       	 response.getWriter().print("<html><body><script>alert('Test results are not submitted!');</script></body></html>");
  		 RequestDispatcher dispatcher = request.getRequestDispatcher("MoistureControlAgentCalculation.jsp");

         dispatcher.include(request, response);
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h2>Error: " + e.getMessage() + "</h2>");
    } finally {
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
</body>
</html>
