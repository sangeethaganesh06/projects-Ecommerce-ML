<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.HashSet, java.util.Set" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Orders</title>
    <style>
     body {
        font-family: Arial, sans-serif;
        background: url('adminPage/img/section-3-bg.jpg') no-repeat center center fixed;
        background-color: #f8f9fa;
        margin: 0;
        padding: 0;
    }
   
        .container {
            width: 90%;
            margin: 60px auto;
        }
        .order-section {
            margin-bottom: 30px;
            padding: 10px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .order-details {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .order-table {
            width: 100%;
            margin-top: 10px;
            border-collapse: collapse;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .order-table th, .order-table td {
            padding: 12px;
            text-align: left;
            font-weight: 300;
            font-size: 14px;
            word-wrap: break-word;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
        }
        .order-table th {
            background-color: #28a745;
            font-weight: 500;
            text-transform: uppercase;
            color: #fff;
        }
        /* Custom scrollbar for webkit browser */
        ::-webkit-scrollbar {
            width: 6px;
        }
        ::-webkit-scrollbar-track {
            -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);
            border-radius: 10px;
        }
        ::-webkit-scrollbar-thumb {
            -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);
            border-radius: 10px;
        }
        /* Button styling */
        .calculate-button {
            margin-top: 10px;
            background-color: #28a745;
            color: #fff;
            border: none;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            cursor: pointer;
            border-radius: 5px;
        }
        .calculate-button:hover {
            background-color: #52b769c7;
        }

.button1 {
  padding: 1em 2em;
  border: none;
  border-radius: 5px;
  font-weight: bold;
  letter-spacing: 5px;
  text-transform: uppercase;
  cursor: pointer;
  color: #28a745;
  transition: all 1000ms;
  font-size: 15px;
  position: relative;
  overflow: hidden;
  outline: 2px solid #28a745;
  margin-left: 9%;
  margin-top: -45%;
}

button:hover {
  color: #ffffff;
  transform: scale(1.1);
  outline: 2px solid #70bdca;
  box-shadow: 4px 5px 17px -4px #28a745;
  
}

button::before {
  content: "";
  position: absolute;
  left: -50px;
  top: 0;
  width: 0;
  height: 100%;
  background-color:#28a745;
  transform: skewX(45deg);
  z-index: -1;
  transition: width 1000ms;
  
}

button:hover::before {
  width: 200%;
}
 
    </style>
</head>
<body>
<br><br>
 <button class="button1" onclick="window.location.href='ResourceAnalystPage.html'" >BACK</button>
       <center><h1 style="color: #28a745;">  RESOURCE CALCULATIONS
        </h1></center>
    <div class="container">
        
        <% 
            final String jdbcUrl = "jdbc:mysql://localhost:3306/ricehuskinsulation";
            final String dbUser = "root";
            final String dbPassword = "root";

            Connection conn = null;
            PreparedStatement stmtOrders = null;
            ResultSet rsOrders = null;

            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

                String sqlOrders = "SELECT DISTINCT orderId, username FROM orders ORDER BY orderId";
                stmtOrders = conn.prepareStatement(sqlOrders);
              //  stmtOrders.setString(1, "deny");
                rsOrders = stmtOrders.executeQuery();

                while (rsOrders.next()) {
                    String orderId = rsOrders.getString("orderId");
                    String username = rsOrders.getString("username");
        %>
         
        <div class="order-section">
       
            <div class="order-details">User: <%= username %>, Order ID: <%= orderId %></div>
            <table class="order-table">
                        <thead>
                    <tr>
                        <th>Order NO</th>
                        <th>Product Name</th>
                        <th>Product ID</th>
                        <th>Quantity(sqft)</th>
                        <th>Density (g/m³)</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        PreparedStatement stmtProducts = null;
                        ResultSet rsProducts = null;
                        String sqlProducts = "SELECT om.Orderno, o.productname, o.productid, om.quantity, pc.density " +
                                            "FROM orders o " +
                                            "INNER JOIN product_catalog pc ON o.productid = pc.ProductID " +
                                            "INNER JOIN ordermanagement om ON o.orderId = om.orderId " +
                                            "WHERE o.orderId = ? ORDER BY om.Orderno"; // Order by Orderno to ensure consistent order

                        stmtProducts = conn.prepareStatement(sqlProducts);
                        stmtProducts.setString(1, orderId);
                        rsProducts = stmtProducts.executeQuery();

                        // Track order numbers that have been displayed
                        Set<String> displayedOrderNumbers = new HashSet<>();

                        while (rsProducts.next()) {
                            String orderNo = rsProducts.getString("Orderno");

                            // Display each order number only once
                            if (!displayedOrderNumbers.contains(orderNo)) {
                    %>
                    <tr>
                        <td><%= orderNo %></td>
                        <td><%= rsProducts.getString("productname") %></td>
                        <td><%= rsProducts.getString("productid") %></td>
                        <td><%= rsProducts.getString("quantity") %></td>
                        <td><%= rsProducts.getString("density") %></td>
                    </tr>
                    <% 
                                displayedOrderNumbers.add(orderNo); // Mark order number as displayed
                            }
                        }
                        rsProducts.close();
                        stmtProducts.close();
                    %> 
                </tbody>
            </table>
           
            <form action="calculateResource.jsp" method="GET"> <!-- Ensure method is GET to pass parameters via URL -->
                <input type="hidden" name="orderId" value="<%= orderId %>">
                <input type="submit" class="calculate-button" value="Calculate Resource">
            </form>
        </div>
        <% 
                }
            } catch (SQLException se) {
                se.printStackTrace();
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if (rsOrders != null) rsOrders.close();
                    if (stmtOrders != null) stmtOrders.close();
                    if (conn != null) conn.close();
                } catch (SQLException se) {
                    se.printStackTrace();
                }
            }
        %>
    </div>
</body>
</html>
