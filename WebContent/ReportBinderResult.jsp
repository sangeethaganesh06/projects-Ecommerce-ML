<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Test Report</title>
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
            background-color: #007bff;
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
    <center>   <h1>BINDER ANALYSIS REPORT</h1> </center>
     
        
        <div class="table-container">
            <h2>Density</h2>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Mass</th>
                        <th>Volume</th>
                        <th>Density</th>
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
                            String sql = "SELECT * FROM bindertestresults WHERE testType='Density'";
                            pstmt = conn.prepareStatement(sql);
                            rs = pstmt.executeQuery();
                            
                            boolean showTable = false;
                            while (rs.next()) {
                                if (rs.getObject("Mass") != null || rs.getObject("Volume") != null || rs.getObject("Density") != null) {
                                    showTable = true;
                                    out.println("<tr>");
                                    out.println("<td>" + rs.getDouble("Mass") + "</td>");
                                    out.println("<td>" + rs.getDouble("Volume") + "</td>");
                                    out.println("<td>" + rs.getDouble("Density") + "</td>");
                                    out.println("</tr>");
                                }
                            }
                            if (!showTable) {
                                out.println("<tr><td colspan='3'>No data available</td></tr>");
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
            <h2>Flexural Strength</h2>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Load1</th>
                        <th>Span Length</th>
                        <th>Width</th>
                        <th>Depth</th>
                        <th>Flexural Strength</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ricehuskinsulation", "root", "root");
                            String sql = "SELECT * FROM bindertestresults WHERE testType='FlexuralStrength'";
                            pstmt = conn.prepareStatement(sql);
                            rs = pstmt.executeQuery();
                            
                            boolean showTable = false;
                            while (rs.next()) {
                                if (rs.getObject("Load1") != null || rs.getObject("SpanLength") != null || rs.getObject("Width") != null || rs.getObject("Depth") != null || rs.getObject("FlexuralStrength") != null) {
                                    showTable = true;
                                    out.println("<tr>");
                                    out.println("<td>" + rs.getDouble("Load1") + "</td>");
                                    out.println("<td>" + rs.getDouble("SpanLength") + "</td>");
                                    out.println("<td>" + rs.getDouble("Width") + "</td>");
                                    out.println("<td>" + rs.getDouble("Depth") + "</td>");
                                    out.println("<td>" + rs.getDouble("FlexuralStrength") + "</td>");
                                    out.println("</tr>");
                                }
                            }
                            if (!showTable) {
                                out.println("<tr><td colspan='5'>No data available</td></tr>");
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
            <h2>Durability</h2>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Initial Mass</th>
                        <th>Final Mass</th>
                        <th>Durability Loss</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ricehuskinsulation", "root", "root");
                            String sql = "SELECT * FROM bindertestresults WHERE testType='Durability'";
                            pstmt = conn.prepareStatement(sql);
                            rs = pstmt.executeQuery();
                            
                            boolean showTable = false;
                            while (rs.next()) {
                                if (rs.getObject("InitialMass") != null || rs.getObject("FinalMass") != null || rs.getObject("DurabilityLoss") != null) {
                                    showTable = true;
                                    out.println("<tr>");
                                    out.println("<td>" + rs.getDouble("InitialMass") + "</td>");
                                    out.println("<td>" + rs.getDouble("FinalMass") + "</td>");
                                    out.println("<td>" + rs.getDouble("DurabilityLoss") + "</td>");
                                    out.println("</tr>");
                                }
                            }
                            if (!showTable) {
                                out.println("<tr><td colspan='3'>No data available</td></tr>");
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
     <button class="btn-animated" onclick="handleButtonClick()">Get Approve</button>
    </div>
    <script>
function handleButtonClick() {
    alert('Successfully submitted');
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
