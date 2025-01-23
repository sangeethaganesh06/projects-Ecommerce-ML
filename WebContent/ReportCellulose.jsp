<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Binder Report</title>
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
        }
        .back-button {
            margin-top: 20px;
              background-color: #007bff;
              border: none;
              margin-left: 6%;
        }
        .btn-animated {
            display: inline-block;
            padding: 10px 20px;
            margin: 10px;
            border: none;
            background-color:#007bff;
            color: white;
            border-radius: 5px;
            cursor: pointer;
            transition: transform 0.2s;
        }
        .btn-animated:hover {
            transform: scale(1.1);
        }
        .btn-animated:active {
            transform: scale(1);
        }
    </style>
</head>
<body>
 <button class="btn-animated" onclick="window.location.href='PerformanaceEfficiencyPage.jsp'">back</button>
    <div class="container">
       <center>   <h1>NEWS PAPER CELLULOSE ANALYSIS REPORT</h1> </center>
        
        <div class="table-container">
            <h2>Cellulose Ratio</h2>
            <table class="table table-striped">
                <thead>
                    <tr>
                        
                        <th>Weight Cellulose</th>
                        <th>Weight Husk</th>
                        <th>Mix Ratio</th>
                         <th>Submission Date</th>
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
                            String sql = "SELECT * FROM cellulosetestresults WHERE testType='Cellulose Ratio'";
                            pstmt = conn.prepareStatement(sql);
                            rs = pstmt.executeQuery();
                            
                            while (rs.next()) {
                                out.println("<tr>");
                              
                                out.println("<td>" + rs.getDouble("weightCellulose") + "</td>");
                                out.println("<td>" + rs.getDouble("weightHusk") + "</td>");
                                out.println("<td>" + rs.getDouble("mixRatio") + "</td>");
                            
                                out.println("<td>" + rs.getTimestamp("submissionDate") + "</td>");
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
        
        <div class="table-container">
            <h2>Density</h2>
            <table class="table table-striped">
                <thead>
                    <tr>
                    
                        <th>Total Weight</th>
                        <th>Volume</th>
                        <th>Density</th>
                        <th>Submission Date</th>
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
                            String sql2 = "SELECT * FROM cellulosetestresults WHERE testType='Density'";
                            pstmt2 = conn2.prepareStatement(sql2);
                            rs2 = pstmt2.executeQuery();
                            
                            while (rs2.next()) {
                                out.println("<tr>");
                             
                                out.println("<td>" + rs2.getDouble("totalWeight") + "</td>");
                                out.println("<td>" + rs2.getDouble("volume") + "</td>");
                                out.println("<td>" + rs2.getDouble("density") + "</td>");
                                out.println("<td>" + rs2.getTimestamp("submissionDate") + "</td>");
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
        
           <button class="btn-animated" onclick="handleButtonClick()">Get Approve</button>
    
    </div>
      <script>
function handleButtonClick() {
    alert('Successfully Cellulose Report submitted');
    window.location.href = 'PerformanaceEfficiencyPage.jsp';
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
