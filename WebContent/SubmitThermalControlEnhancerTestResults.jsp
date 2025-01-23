<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.math.BigDecimal" %>
<%@ page import="riskHuskInsulation.*" %>
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
        // Load MySQL driver and establish database connection
        Class.forName("com.mysql.jdbc.Driver"); // Use com.mysql.cj.jdbc.Driver for MySQL Connector/J 8.x
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ricehuskinsulation", "root", "root");

        // SQL query to insert data into the ThermalConductivityEnhancerTests table
        String sql = "INSERT INTO ThermalConductivityEnhancerTests " +
                     "(TestType, HeatFlowRate, Thickness, Area, TempDifference, ChangeInLength, OriginalLength, " +
                     "TempChange, HeatTransferred, TempDifferenceHeat, InitialWeight, FinalWeight, InitialConductivity, " +
                     "FinalConductivity, EnhancedConductivity, BaselineConductivity, ThermalConductivity, ThermalExpansion, " +
                     "HeatTransferRate, WeightLoss, ChangeInConductivity, EnhancementRatio) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,  ?)";

        stmt = conn.prepareStatement(sql);
        stmt.setString(1, testType);

        // Set parameters based on testType
        if ("ThermalConductivity".equalsIgnoreCase(testType)) {
            stmt.setBigDecimal(2, BigDecimalUtil.getBigDecimal(request.getParameter("heatFlowRate")));
            stmt.setBigDecimal(3, BigDecimalUtil.getBigDecimal(request.getParameter("thickness")));
            stmt.setBigDecimal(4, BigDecimalUtil.getBigDecimal(request.getParameter("area")));
            stmt.setBigDecimal(5, BigDecimalUtil.getBigDecimal(request.getParameter("tempDifference")));
            stmt.setBigDecimal(6, null);
            stmt.setBigDecimal(7, null);
            stmt.setBigDecimal(8, null);
            stmt.setBigDecimal(9, null);
            stmt.setBigDecimal(10, null);
            stmt.setBigDecimal(11, null);
            stmt.setBigDecimal(12, null);
            stmt.setBigDecimal(13, null);
            stmt.setBigDecimal(14, null);
            stmt.setBigDecimal(15, null);
            stmt.setBigDecimal(16, null);
            stmt.setBigDecimal(17, BigDecimalUtil.getBigDecimal(request.getParameter("ThermalConductivity")));
            stmt.setBigDecimal(18, null);
            stmt.setBigDecimal(19, null);
            stmt.setBigDecimal(20, null);
            stmt.setBigDecimal(21, null);
            stmt.setBigDecimal(22, null);
        }  else if ("ThermalExpansion".equalsIgnoreCase(testType)) {
            stmt.setBigDecimal(2, null);
            stmt.setBigDecimal(3, null);
            stmt.setBigDecimal(4, null);
            stmt.setBigDecimal(5, null);
            stmt.setBigDecimal(6, BigDecimalUtil.getBigDecimal(request.getParameter("changeInLength")));
            stmt.setBigDecimal(7, BigDecimalUtil.getBigDecimal(request.getParameter("originalLength")));
            stmt.setBigDecimal(8, BigDecimalUtil.getBigDecimal(request.getParameter("tempChange")));
            stmt.setBigDecimal(9, null);
            stmt.setBigDecimal(10, null);
            stmt.setBigDecimal(11, null);
            stmt.setBigDecimal(12, null);
            stmt.setBigDecimal(13, null);
            stmt.setBigDecimal(14, null);
            stmt.setBigDecimal(15, null);
            stmt.setBigDecimal(16, null);
            stmt.setBigDecimal(17, null);
            stmt.setBigDecimal(18, BigDecimalUtil.getBigDecimal(request.getParameter("thermalExpansion")));
            stmt.setBigDecimal(19, null);
            stmt.setBigDecimal(20, null);
            stmt.setBigDecimal(21, null);
            stmt.setBigDecimal(22, null);
        } else if ("HeatTransferRate".equalsIgnoreCase(testType)) {
            stmt.setBigDecimal(2, null);
            stmt.setBigDecimal(3, null);
            stmt.setBigDecimal(4, null);
            stmt.setBigDecimal(5, null);
            stmt.setBigDecimal(6, null);
            stmt.setBigDecimal(7, null);
            stmt.setBigDecimal(8, null);
            stmt.setBigDecimal(11, null);
            stmt.setBigDecimal(9, BigDecimalUtil.getBigDecimal(request.getParameter("heatTransferred")));
            stmt.setBigDecimal(10, BigDecimalUtil.getBigDecimal(request.getParameter("tempDifference")));
            stmt.setBigDecimal(12,  null);
            stmt.setBigDecimal(13,  null);
            stmt.setBigDecimal(14, null);
            stmt.setBigDecimal(15, null);
            stmt.setBigDecimal(16,  null);
            stmt.setBigDecimal(17, null);
            stmt.setBigDecimal(18, null);
            stmt.setBigDecimal(19, BigDecimalUtil.getBigDecimal(request.getParameter("heatTransferRate")));
            stmt.setBigDecimal(20,  null);
            stmt.setBigDecimal(21,  null);
            stmt.setBigDecimal(22,  null);
        } 
        else if ("ThermalStability".equalsIgnoreCase(testType)) {
            stmt.setBigDecimal(2, null);
            stmt.setBigDecimal(3, null);
            stmt.setBigDecimal(4, null);
            stmt.setBigDecimal(5, null);
            stmt.setBigDecimal(6, null);
            stmt.setBigDecimal(7, null);
            stmt.setBigDecimal(8, null);
            stmt.setBigDecimal(9, null);
            stmt.setBigDecimal(10, null);
            stmt.setBigDecimal(11, BigDecimalUtil.getBigDecimal(request.getParameter("initialWeight")));
            stmt.setBigDecimal(12, BigDecimalUtil.getBigDecimal(request.getParameter("finalWeight")));
            stmt.setBigDecimal(13, null);
            stmt.setBigDecimal(14, null);
            stmt.setBigDecimal(15, null);
            stmt.setBigDecimal(16, null);
            stmt.setBigDecimal(17, null);
            stmt.setBigDecimal(18, null);
            stmt.setBigDecimal(19, BigDecimalUtil.getBigDecimal(request.getParameter("weightLoss")));
            stmt.setBigDecimal(20, null);
            stmt.setBigDecimal(21, null);
            stmt.setBigDecimal(22, null);
        } else if ("EnhancementRatio".equalsIgnoreCase(testType)) {
            stmt.setBigDecimal(2, null);
            stmt.setBigDecimal(3, null);
            stmt.setBigDecimal(4, null);
            stmt.setBigDecimal(5, null);
            stmt.setBigDecimal(6, null);
            stmt.setBigDecimal(7, null);
            stmt.setBigDecimal(8, null);
            stmt.setBigDecimal(9, null);
            stmt.setBigDecimal(10, null);
            stmt.setBigDecimal(11, null);
            stmt.setBigDecimal(12, null);
            stmt.setBigDecimal(13, null);
            stmt.setBigDecimal(14, null);
            stmt.setBigDecimal(15, BigDecimalUtil.getBigDecimal(request.getParameter("enhancedConductivity")));
            stmt.setBigDecimal(16, BigDecimalUtil.getBigDecimal(request.getParameter("baselineConductivity")));
            stmt.setBigDecimal(17, null);
            stmt.setBigDecimal(18, null);
            stmt.setBigDecimal(19, null);
            stmt.setBigDecimal(20, null);
            stmt.setBigDecimal(21, null);
            stmt.setBigDecimal(22, BigDecimalUtil.getBigDecimal(request.getParameter("enhancementRatio")));
        }
        else {
            out.println("<h2>Unknown test type: " + testType + "</h2>");
            return;
        }

        // Execute the SQL statement
        int result = stmt.executeUpdate();
        if (result > 0) {
            response.getWriter().print("<html><body><script>alert('Test results submitted successfully!');</script></body></html>");
        } else {
            response.getWriter().print("<html><body><script>alert('Failed to submit test results!');</script></body></html>");
        }

        // Redirect to the results page
        RequestDispatcher dispatcher = request.getRequestDispatcher("material_types.jsp?material=ThermalConductivityEnhancer");
        dispatcher.include(request, response);

    } catch (NumberFormatException e) {
        // Handle NumberFormatException specifically
        out.println("<h2>Number Format Error: " + e.getMessage() + "</h2>");
        e.printStackTrace();
    } catch (SQLException e) {
        // Handle SQL exceptions
        out.println("<h2>SQL Error: " + e.getMessage() + "</h2>");
        e.printStackTrace();
    } catch (Exception e) {
        // Handle general exceptions
        out.println("<h2>Error: " + e.getMessage() + "</h2>");
        e.printStackTrace();
    } finally {
        // Close resources
        if (stmt != null) try { stmt.close(); } catch (Exception e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
    }
%>
</body>
</html>
