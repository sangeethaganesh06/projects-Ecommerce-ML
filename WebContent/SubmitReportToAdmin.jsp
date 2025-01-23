   <%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Resource Analyst Report</title>
    <style>
       
            body {
        font-family: Arial, sans-serif;
        background: url('adminPage/img/section-3-bg.jpg') no-repeat center center fixed;
        background-color: #f8f9fa;
        margin: 0;
        padding: 0;
    }
        .container {
            width: 80%;
            margin: auto;
            overflow: hidden;
        }
        header {
            background: #35424a;
            color: #ffffff;
            padding-top: 30px;
            min-height: 70px;
            border-bottom: #e8491d 3px solid;
        }
        header a {
            color: #ffffff;
            text-decoration: none;
            text-transform: uppercase;
            font-size: 16px;
        }
        header ul {
            padding: 0;
            list-style: none;
        }
        header li {
            float: left;
            display: inline;
            padding: 0 20px 0 20px;
        }
        header #branding {
            float: left;
        }
        header #branding h1 {
            margin: 0;
        }
        header nav {
            float: right;
            margin-top: 10px;
        }
        header .highlight, header .current a {
            color: #e8491d;
            font-weight: bold;
        }
        header a:hover {
            color: #cccccc;
            font-weight: bold;
        }
        .report-container {
            background: #ffffff;
            padding: 20px;
            margin-top: 30px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }
        .report-container h2 {
            margin: 0 0 20px 0;
            color: #35424a;
        }
        .order-item {
            margin-bottom: 10px;
            border: 1px solid #ccc;
            padding: 10px;
        }
        .order-item button {
            padding: 10px;
            background: #35424a;
            color: #ffffff;
            border: none;
            cursor: pointer;
            margin-right: 10px;
           
        }
        .order-item button:hover {
            background: #e8491d;
        }
        .report-table {
            width: 100%;
            margin-top: 15px;
            border-collapse: collapse;
            display: none; /* Hide the table by default */
        }
        .report-table th, .report-table td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        .report-table th {
            background-color: #35424a;
            color: white;
        }
        .report-table tr:nth-child(even) {
            background-color: #f2f2f2;
        }
    </style>
    <script>
        function toggleReport(orderId) {
            var reportTable = document.getElementById('report-' + orderId);
            if (reportTable.style.display === 'none') {
                reportTable.style.display = 'table';
            } else {
                reportTable.style.display = 'none';
            }
        }

        
      
    </script>
    
</head>
<body>
    <header>
        <div class="container">
       
            <div id="branding">
           <center><h1>RESOURCE ANALYST REPORT</h1></center>  
            </div>
            <nav>
                <ul>
                    <li class="current"><a href="adminPage.html">Home</a></li>
                 <li class="current"><a href="SubmitReportToAdmin.jsp">View Report</a></li>
                </ul>
            </nav>
        </div>
    </header>
    
    
    
    <div class="container">
     <button style="background-color: #35424a; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; transition: background-color 0.3s ease; margin-top: 20px;" onmouseover="this.style.backgroundColor=' #e8491d';" onmouseout="this.style.backgroundColor='#35424a';" onclick="window.location.href='adminPage.html'">Back</button>
     
    
        <div class="report-container">
       
        
          
            <%
                // Database connection details
                final String jdbcUrl = "jdbc:mysql://localhost:3306/ricehuskinsulation";
                final String dbUser = "root";
                final String dbPassword = "root";

                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

                    // Query to retrieve distinct Order IDs from material_analysis-report table
                    String sql = "SELECT DISTINCT OrderID FROM `material_analysis-report` WHERE Status1 IS NULL OR Status1 != 'approved'";
                    stmt = conn.prepareStatement(sql);
                    rs = stmt.executeQuery();

                    while (rs.next()) {
                        String orderId = rs.getString("OrderID");
                        HttpSession session1 = request.getSession();
                        session.setAttribute("OrderID", orderId);
            %>
            
                        <div class="order-item">
                            <h3>Order ID: <%= orderId %></h3>
                        <button    onclick="toggleReport('<%= orderId %>')">View Report</button> 
                             <br>
                             <br>
                               <form  action="ApproveReport"  method="post">
                             <button type="submit"  >Approve Report</button>
                            </form>

                            <div id="report-<%= orderId %>" class="report-table">
                                <table>
                                    <tr>
                                        <th>Report ID</th>
                                        <th>Total Weight (kg)</th>
                                        <th>Volume (cu.m)</th>
                                        <th>Binder Type</th>
                                        <th>Binder Amount (kg)</th>
                                        <th>Product ID</th>
                                        <th>Product Name</th>
                                    </tr>
                                    <%
                                        // Query to retrieve report details from material_analysis-report table
                                        String reportSql = "SELECT * FROM `material_analysis-report` WHERE OrderID = ?";
                                        PreparedStatement reportStmt = conn.prepareStatement(reportSql);
                                        reportStmt.setString(1, orderId);
                                        ResultSet reportRs = reportStmt.executeQuery();

                                        while (reportRs.next()) {
                                    %>
                                            <tr>
                                                <td><%= reportRs.getString("ReportID") %></td>
                                                <td><%= reportRs.getDouble("TotalWeight") %></td>
                                                <td><%= reportRs.getDouble("volume") %></td>
                                                <td><%= reportRs.getString("Binder_TYPE") %></td>
                                                <td><%= reportRs.getDouble("Binder_Amount") %></td>
                                                <td><%= reportRs.getString("ProductId") %></td>
                                                <td><%= reportRs.getString("ProductName") %></td>
                                            </tr>
                                    <%
                                        }
                                        reportRs.close();
                                        reportStmt.close();
                                    %>
                                </table>
                            </div>
                        </div>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
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
