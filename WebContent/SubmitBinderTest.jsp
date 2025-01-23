<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.math.BigDecimal" %>
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
        Class.forName("com.mysql.jdbc.Driver"); // Updated for MySQL Connector/J 8.x
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ricehuskinsulation", "root", "root");

        String sql = "INSERT INTO BinderTestResults (TestType, InitialMass, FinalMass, DurabilityLoss, Mass, Volume, Density, Load1, SpanLength, Width, Depth, FlexuralStrength) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        stmt = conn.prepareStatement(sql);

        // Set test type
        stmt.setString(1, testType);

        // Set values based on the test type
        if ("Durability".equalsIgnoreCase(testType)) {
            BigDecimal initialMass = new BigDecimal(request.getParameter("initialMass"));
            BigDecimal finalMass = new BigDecimal(request.getParameter("finalMass"));
            BigDecimal durabilityLoss = new BigDecimal(request.getParameter("durabilityLoss"));

            stmt.setBigDecimal(2, initialMass);
            stmt.setBigDecimal(3, finalMass);
            stmt.setBigDecimal(4, durabilityLoss);
            stmt.setNull(5, Types.DECIMAL); // Mass
            stmt.setNull(6, Types.DECIMAL); // Volume
            stmt.setNull(7, Types.DECIMAL); // Density
            stmt.setNull(8, Types.DECIMAL); // Load
            stmt.setNull(9, Types.DECIMAL); // SpanLength
            stmt.setNull(10, Types.DECIMAL); // Width
            stmt.setNull(11, Types.DECIMAL); // Depth
            stmt.setNull(12, Types.DECIMAL); // FlexuralStrength
        } else if ("Density".equalsIgnoreCase(testType)) {
            BigDecimal mass = new BigDecimal(request.getParameter("mass"));
            BigDecimal volume = new BigDecimal(request.getParameter("volume"));
            BigDecimal density = new BigDecimal(request.getParameter("density"));

            stmt.setNull(2, Types.DECIMAL); // InitialMass
            stmt.setNull(3, Types.DECIMAL); // FinalMass
            stmt.setNull(4, Types.DECIMAL); // DurabilityLoss
            stmt.setBigDecimal(5, mass);
            stmt.setBigDecimal(6, volume);
            stmt.setBigDecimal(7, density);
            stmt.setNull(8, Types.DECIMAL); // Load
            stmt.setNull(9, Types.DECIMAL); // SpanLength
            stmt.setNull(10, Types.DECIMAL); // Width
            stmt.setNull(11, Types.DECIMAL); // Depth
            stmt.setNull(12, Types.DECIMAL); // FlexuralStrength
        } else if ("FlexuralStrength".equalsIgnoreCase(testType)) {
            BigDecimal load = new BigDecimal(request.getParameter("load"));
            BigDecimal spanLength = new BigDecimal(request.getParameter("spanLength"));
            BigDecimal width = new BigDecimal(request.getParameter("width"));
            BigDecimal depth = new BigDecimal(request.getParameter("depth"));
            BigDecimal flexuralStrength = new BigDecimal(request.getParameter("flexuralStrength"));

            stmt.setNull(2, Types.DECIMAL); // InitialMass
            stmt.setNull(3, Types.DECIMAL); // FinalMass
            stmt.setNull(4, Types.DECIMAL); // DurabilityLoss
            stmt.setNull(5, Types.DECIMAL); // Mass
            stmt.setNull(6, Types.DECIMAL); // Volume
            stmt.setNull(7, Types.DECIMAL); // Density
            stmt.setBigDecimal(8, load);
            stmt.setBigDecimal(9, spanLength);
            stmt.setBigDecimal(10, width);
            stmt.setBigDecimal(11, depth);
            stmt.setBigDecimal(12, flexuralStrength);
        }

        // Execute the SQL statement
        int result = stmt.executeUpdate();
        if (result > 0) {
            response.getWriter().print("<html><body><script>alert('Test results submitted successfully!');</script></body></html>");
        } else {
            response.getWriter().print("<html><body><script>alert('Failed to submit test results!');</script></body></html>");
        }
        // Redirect to the results page
        RequestDispatcher dispatcher = request.getRequestDispatcher("material_types.jsp?material=Binder");
        dispatcher.include(request, response);
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
