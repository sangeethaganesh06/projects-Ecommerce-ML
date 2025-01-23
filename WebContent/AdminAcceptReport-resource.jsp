<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Accept Report</title>
    <!-- Include necessary CSS stylesheets or link to a stylesheet -->
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 800px;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            text-align: center;
            color: #333;
        }
        .result {
            margin-top: 20px;
            padding: 10px;
            border: 1px solid #ccc;
            background-color: #f2f2f2;
        }
        form {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Admin Accept Report</h1>
        <div class="result">
            <% 
                Connection conn = null;
                PreparedStatement stmtReport = null;
                ResultSet rsReport = null;

                try {
                    // Database connection details
                    final String jdbcUrl = "jdbc:mysql://localhost:3306/ricehuskinsulation";
                    final String dbUser = "root";
                    final String dbPassword = "root";

                    // Establishing database connection
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

                    // Query to retrieve report details for the given order ID
                    String sqlReport = "SELECT * FROM material_requirement_report";
                    stmtReport = conn.prepareStatement(sqlReport);

                    rsReport = stmtReport.executeQuery();

                    // Display order details and report
                    while (rsReport.next()) {
                        // Retrieve data from the result set
                        String orderID = rsReport.getString("OrderID");

            %>
          
            <!-- List products associated with the order -->
            <h2>Products in Order:</h2>
            <ul>
                <% 
                    // Query to retrieve products for the given order ID
                    String sqlProducts = "SELECT * FROM material_requirement_report WHERE OrderID = ?";
                    PreparedStatement stmtProducts = conn.prepareStatement(sqlProducts);
                    stmtProducts.setString(1, orderID);
                    ResultSet rsProducts = stmtProducts.executeQuery();

                    while (rsProducts.next()) {
                        String productID = rsProducts.getString("ProductID");
                        String productName = rsProducts.getString("ProductName");
                        double totalWeight = rsProducts.getDouble("TotalWeight");
                        double volume = rsProducts.getDouble("Volume");
                        String binderType = rsProducts.getString("Binder_TYPE");
                        double binderAmount = rsProducts.getDouble("Binder_Amount");
                        // Adjust as per your column names

                %>
                <li>
                    <p><strong>Product ID:</strong> <%= productID %></p>
                    <p><strong>Product Name:</strong> <%= productName %></p>
                    <p><strong>Total Weight:</strong> <%= totalWeight %> kg</p>
                    <p><strong>Volume:</strong> <%= volume %> m³</p>
                    <p><strong>Binder Type:</strong> <%= binderType %></p>
                    <p><strong>Binder Amount:</strong> <%= binderAmount %> kg</p>
                    <!-- Add more product details as needed -->
                </li>
                <% 
                    }
                    rsProducts.close();
                    stmtProducts.close();
                %>
            </ul>
            <!-- End product list -->

            <!-- Example form for admin actions -->
            <form action="admin_action_handler.jsp" method="post">
                <!-- Add fields for admin actions here -->
                <input type="hidden" name="orderId" value="<%= orderID %>">
                <button type="submit">Approve Report</button>
                <!-- Add more actions like approve, reject, etc. -->
            </form>
            <% 
                    }
                } catch (ClassNotFoundException | SQLException e) {
                    e.printStackTrace();
                } finally {
                    // Closing resources in finally block
                    try {
                        if (rsReport != null) rsReport.close();
                        if (stmtReport != null) stmtReport.close();
                        if (conn != null) conn.close();
                    } catch (SQLException se) {
                        se.printStackTrace();
                    }
                }
            %>
        </div>
    </div>
</body>
</html>
