<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Test Results</title>
    <link rel="stylesheet" href="adminPage/css/bootstrap.min.css" type="text/css" />
    <link rel="stylesheet" href="adminPage/fontawesome/css/all.min.css" type="text/css" />
    <link rel="stylesheet" href="adminPage/css/slick.css" type="text/css" />
    <link rel="stylesheet" href="adminPage/css/tooplate-simply-amazed.css" type="text/css" />
    <style>
       body {
        font-family: Arial, sans-serif;
        background: url('adminPage/img/section-3-bg.jpg') no-repeat center center fixed;
        background-color: #f8f9fa;
        margin: 0;
        padding: 0;
    }
        .table-container {
            margin-top: 20px;
        }
        .table thead th {
            background-color: #007bff;
            color: white;
        }
        .table tbody tr:hover {
            background-color: #f1f1f1;
        } .back-button {
            margin-top: 20px;
            background-color: #007bff;
            border: none;
            margin-left: 6%;
        }
    </style>
</head>
<body>
 <button class="back-button" onclick="window.location.href='adminPage.html'">back</button>
    <div class="container">
    
        <center>   <h1>PERFORMANCE ANALYSIS REPORT</h1> </center>
        <!-- Moisture Absorption Table -->
        <div class="table-container">
            <h2>Moisture Absorption</h2>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Initial Weight</th>
                        <th>Final Weight</th>
                        <th>Moisture Absorption</th>
                        <th>Submission Time</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Connection conn = null;
                        PreparedStatement pstmt = null;
                        ResultSet rs = null;
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ricehuskinsulation", "root", "root");
                            String sql = "SELECT * FROM moisture_control_tests  WHERE testType='MoistureAbsorption'";
                            pstmt = conn.prepareStatement(sql);
                            rs = pstmt.executeQuery();
                            
                            while (rs.next()) {
                                out.println("<tr>");
                                out.println("<td>" + rs.getDouble("initialWeight") + "</td>");
                                out.println("<td>" + rs.getDouble("finalWeight") + "</td>");
                                out.println("<td>" + rs.getDouble("moistureAbsorption") + "</td>");
                                out.println("<td>" + rs.getTimestamp("submissionTime") + "</td>");
                                out.println("</tr>");
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                        }
                    %>
                </tbody>
            </table>
        </div>
        
        <!-- WVTR Table -->
        <div class="table-container">
            <h2>WVTR</h2>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Change in Mass</th>
                        <th>Area</th>
                        <th>Time</th>
                        <th>WVTR</th>
                        <th>Submission Time</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Connection conn2 = null;
                        PreparedStatement pstmt2 = null;
                        ResultSet rs2 = null;
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            conn2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/ricehuskinsulation", "root", "root");
                            String sql2 = "SELECT * FROM moisture_control_tests WHERE testType='WVTR'";
                            pstmt2 = conn2.prepareStatement(sql2);
                            rs2 = pstmt2.executeQuery();
                            
                            while (rs2.next()) {
                                out.println("<tr>");
                                out.println("<td>" + rs2.getDouble("changeInMass") + "</td>");
                                out.println("<td>" + rs2.getDouble("area") + "</td>");
                                out.println("<td>" + rs2.getDouble("time") + "</td>");
                                out.println("<td>" + rs2.getDouble("wvtr") + "</td>");
                                out.println("<td>" + rs2.getTimestamp("submissionTime") + "</td>");
                                out.println("</tr>");
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            if (rs2 != null) try { rs2.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (pstmt2 != null) try { pstmt2.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (conn2 != null) try { conn2.close(); } catch (SQLException e) { e.printStackTrace(); }
                        }
                    %>
                </tbody>
            </table>
        </div>
        
        <!-- Shrinkage Table -->
        <div class="table-container">
            <h2>Shrinkage</h2>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th> OriginalDimension</th>\
                         <th>FinalDimension</th>
                        <th>Shrinkage Percentage</th>
                        <th>Submission Time</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Connection conn3 = null;
                        PreparedStatement pstmt3 = null;
                        ResultSet rs3 = null;
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            conn3 = DriverManager.getConnection("jdbc:mysql://localhost:3306/ricehuskinsulation", "root", "root");
                            String sql3 = "SELECT * FROM moisture_control_tests WHERE testType='Shrinkage'";
                            pstmt3 = conn3.prepareStatement(sql3);
                            rs3 = pstmt3.executeQuery();
                            
                            while (rs3.next()) {
                                out.println("<tr>");
                                out.println("<td>" + rs3.getDouble("originalDimension") + "</td>");
                                out.println("<td>" + rs3.getDouble("finalDimension") + "</td>");
                                out.println("<td>" + rs3.getDouble("shrinkagePercentage") + "</td>");
                                out.println("<td>" + rs3.getTimestamp("submissionTime") + "</td>");
                                out.println("</tr>");
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            if (rs3 != null) try { rs3.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (pstmt3 != null) try { pstmt3.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (conn3 != null) try { conn3.close(); } catch (SQLException e) { e.printStackTrace(); }
                        }
                    %>
                </tbody>
            </table>
        </div>
          <button class="back-button" onclick="handleButtonClick()"> Approve</button>
          <button class="back-button" onclick="handleButton()"> Deny</button>
    </div>
      <script>
function handleButtonClick() {
    alert('Successfully Approved');
    window.location.href = 'adminPage.html';
}
function handleButton() {
    alert('Successfully Denied');
    window.location.href = 'adminPage.html';
}
</script>
    <script src="adminPage/js/jquery-3.3.1.min.js"></script>
    <script src="adminPage/js/bootstrap.bundle.min.js"></script>
    <script src="adminPage/js/jquery.singlePageNav.min.js"></script>
    <script src="adminPage/js/slick.js"></script>
    <script src="adminPage/js/parallax.min.js"></script>
    <script src="adminPage/js/templatemo-script.js"></script>
</body>
</html>
