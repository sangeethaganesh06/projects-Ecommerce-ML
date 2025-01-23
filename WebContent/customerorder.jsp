<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Order List</title>
    <link rel="stylesheet" href="styles.css">
    <script src="scripts.js" defer></script>
    <style>
    body {
        font-family: Arial, sans-serif;
        background: url('adminPage/img/section-3-bg.jpg') no-repeat center center fixed;
        background-color: #f8f9fa;
        margin: 0;
        padding: 0;
    }

    h1 {
        text-align: center;
        padding: 20px;
        color: #343a40;
    }

    .order-container {
        max-width: 800px;
        margin: 50px auto;
        background: #fff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    table {
        width: 100%;
        border-collapse: collapse;
    }

    table, th, td {
        border: 1px solid #ddd;
    }

    th, td {
        padding: 12px;
        text-align: left;
    }

    th {
        background-color: #f2f2f2;
    }

    tr:hover {
        background-color: #f1f1f1;
    }      .button1 {
  padding: 1em 2em;
  border: none;
  border-radius: 5px;
  font-weight: bold;
  letter-spacing: 5px;
  text-transform: uppercase;
  cursor: pointer;
  color: #595861b5;
  transition: all 1000ms;
  font-size: 15px;
  position: relative;
  overflow: hidden;
  outline: 2px solid #8f868a;
  margin-left: 5%;
  margin-bottom: 65%;
}

button1:hover {
  color: #ff;
  transform: scale(1.1);
  outline: 2px solid #70bdca;
  box-shadow: 4px 5px 17px -4px #AD1457;
  
}

button1::before {
  content: "";
  position: absolute;
  left: -50px;
  top: 0;
  width: 0;
  height: 100%;
  background-color:#d7ced2;
  transform: skewX(45deg);
  z-index: -1;
  transition: width 1000ms;
  
}


 
    </style>
</head>
<body>
<div>
 <h1> YOUR ORDER STATUS </h1>
    <button1 class="button1" onclick="window.location.href='product-list.jsp'" >BACK</button1>
   
    </div>
    <div class="order-container">
        <table>
            <thead>
                <tr>
                    <th>Product Name</th>
                    <th>Product ID</th>
                    <th>Amount</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <%
                    String userId = (String) session.getAttribute("userId");
                    if (userId == null) {
                        userId = "c0ymbP!PGc"; // Fallback for testing
                    }
                    System.out.println("userId: " + userId); // Debugging

                    Connection conn = null;
                    Statement stmt = null;
                    ResultSet rs = null;
                    try {
                    	 Class.forName("com.mysql.jdbc.Driver");
                       
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ricehuskinsulation", "root", "root");
                        stmt = conn.createStatement();
                        String sql = "SELECT productname, productid, amount, Status FROM orders WHERE userId = '" + userId + "'";
                        System.out.println("Executing query: " + sql); // Debugging
                        rs = stmt.executeQuery(sql);
                        while (rs.next()) {
                            String productName = rs.getString("productname");
                            int productId = rs.getInt("productid");
                            double amount = rs.getDouble("amount");
                            String status = rs.getString("Status");
                    
                         // Replace null status with "Not Yet Approved"
                            if (status == null) {
                              status = "Not Yet Approved";
                            }

                       
                           
                %>
                <tr>
                    <td><%= productName %></td>
                    <td><%= productId %></td>
                    <td><%= amount %></td>
                    <td><%= status %></td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<tr><td colspan='4'>Error: " + e.getMessage() + "</td></tr>"); // Display error message in table
                    } finally {
                        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
                        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                    }
                %>
            </tbody>
        </table>
    </div>
</body>

</html>
