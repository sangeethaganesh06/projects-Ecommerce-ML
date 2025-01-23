<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.math.BigDecimal" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Submit Cellulose Test Results</title>
</head>
<body>

<%
    String testType = request.getParameter("testType");
    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        // Load MySQL driver and establish database connection
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ricehuskinsulation", "root", "root");

        String sql = "INSERT INTO CelluloseTestResults (testType, weightCellulose, weightHusk, mixRatio, totalWeight, volume, density) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";

        stmt = conn.prepareStatement(sql);

        // Set values based on the test type
        stmt.setString(1, testType);
        
        if ("Cellulose".equalsIgnoreCase(testType)) {
            BigDecimal weightCellulose = new BigDecimal(request.getParameter("weightCellulose"));
            BigDecimal weightHusk = new BigDecimal(request.getParameter("weightHusk"));
            BigDecimal mixRatio = new BigDecimal(request.getParameter("mixRatio"));

            stmt.setBigDecimal(2, weightCellulose);
            stmt.setBigDecimal(3, weightHusk);
            stmt.setBigDecimal(4, mixRatio);
            stmt.setNull(5, Types.DECIMAL); // totalWeight
            stmt.setNull(6, Types.DECIMAL); // volume
            stmt.setNull(7, Types.DECIMAL); // density
           
            
        } else if ("Density".equalsIgnoreCase(testType)) {
        	String totalWeightStr = request.getParameter("totalWeight");
            String volumeStr = request.getParameter("volume");
            String densityStr = request.getParameter("density");
            
            BigDecimal totalWeight = totalWeightStr != null ? new BigDecimal(totalWeightStr) : null;
            BigDecimal volume = volumeStr != null ? new BigDecimal(volumeStr) : null;
            BigDecimal density = densityStr != null ? new BigDecimal(densityStr) : null;

            stmt.setNull(2, Types.DECIMAL); // weightCellulose
            stmt.setNull(3, Types.DECIMAL); // weightHusk
            stmt.setNull(4, Types.DECIMAL); // mixRatio
            stmt.setBigDecimal(5, totalWeight);
            stmt.setBigDecimal(6, volume);
            stmt.setBigDecimal(7, density);
           
        } 
        // Execute the SQL statement
        int result = stmt.executeUpdate();
        if (result > 0) {
            response.getWriter().print("<html><body><script>alert('Test results submitted successfully!');</script></body></html>");
        } else {
            response.getWriter().print("<html><body><script>alert('Failed to submit test results!');</script></body></html>");
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("material_types.jsp?material=NewsPaper%20Cellulose");
    	dispatcher.include(request, response);

        // Redirect to a results page or another page if needed
   
    } catch (NumberFormatException e) {
        // Handle NumberFormatException specifically
        out.println("<h2>Number Format Error: " + e.getMessage() + "</h2>");
        e.printStackTrace();
    } catch (SQLException e) {
        // Handle SQL exceptions
        out.println("<h2>Database Error: " + e.getMessage() + "</h2>");
        e.printStackTrace();
    } catch (ClassNotFoundException e) {
        // Handle ClassNotFoundException
        out.println("<h2>JDBC Driver not found: " + e.getMessage() + "</h2>");
        e.printStackTrace();
    } catch (Exception e) {
        // Handle other exceptions
        out.println("<h2>Error: " + e.getMessage() + "</h2>");
        e.printStackTrace();
    } finally {
        // Close resources
        try {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

</body>
</html>
