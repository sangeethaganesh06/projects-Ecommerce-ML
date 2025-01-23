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
        }
        .back-button {
            margin-top: 20px;
            background-color: #007bff;
            border: none;
            margin-left: 6%;
        }
    </style>
</head>
<body>
    <button class="back-button" onclick="window.location.href='adminPage.html'">Back</button>
    <div class="container">
      <center>   <h1>PERFORMANCE ANALYSIS REPORT</h1> </center>

        <!-- Heat Flow Rate Test Table -->
        <div class="table-container">
            <h2>Thermal Conductivity Test</h2>
            <table class="table table-striped">
                <thead>
                    <tr>
                       
                        <th>HeatFlowRate</th>
                        <th>Thickness</th>
                        <th>Area</th>
                        <th>TempDifference</th>

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
                            String sql = "SELECT * FROM thermalconductivityenhancertests where testType ='ThermalConductivity'";
                            pstmt = conn.prepareStatement(sql);
                            rs = pstmt.executeQuery();
                            
                            while (rs.next()) {
                                out.println("<tr>");
                               
                                out.println("<td>" + rs.getDouble("HeatFlowRate") + "</td>");
                                out.println("<td>" + rs.getDouble("Thickness") + "</td>");
                                out.println("<td>" + rs.getDouble("Area") + "</td>");
                                out.println("<td>" + rs.getDouble("TempDifference") + "</td>");
                                
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

        <!-- Thermal Expansion Test Table -->
        <div class="table-container">
            <h2>Thermal Expansion Test</h2>
            <table class="table table-striped">
                <thead>
                    <tr>
                      
                        <th>ChangeInLength</th>
                        <th>OriginalLength</th>
                        <th>TempChange</th>
                        <th>ThermalExpansion</th>
                   
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
                            String sql2 = "SELECT * FROM thermalconductivityenhancertests where testType ='ThermalExpansion'";
                            pstmt2 = conn2.prepareStatement(sql2);
                            rs2 = pstmt2.executeQuery();
                            
                            while (rs2.next()) {
                                out.println("<tr>");
                              
                                out.println("<td>" + rs2.getDouble("ChangeInLength") + "</td>");
                                out.println("<td>" + rs2.getDouble("OriginalLength") + "</td>");
                                out.println("<td>" + rs2.getDouble("TempChange") + "</td>");
                                out.println("<td>" + rs2.getDouble("ThermalExpansion") + "</td>");
                               
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

        <!-- Conductivity Test Table -->
        <div class="table-container">
            <h2>Thermal Conductivity Enhancement Ratio</h2>
            <table class="table table-striped">
                <thead>
                    <tr>
                   
                   
                        <th>EnhancedConductivity</th>
                        <th>BaselineConductivity</th>
                        
                        <th>EnhancementRatio</th>
         
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
                            String sql3 = "SELECT * FROM thermalconductivityenhancertests where testType ='EnhancementRatio'";
                            pstmt3 = conn3.prepareStatement(sql3);
                            rs3 = pstmt3.executeQuery();
                            
                            while (rs3.next()) {
                                out.println("<tr>");
                              
                              
                                out.println("<td>" + rs3.getDouble("EnhancedConductivity") + "</td>");
                                out.println("<td>" + rs3.getDouble("BaselineConductivity") + "</td>");
                         
                                out.println("<td>" + rs3.getDouble("EnhancementRatio") + "</td>");
                    
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

        <!-- Heat Transfer Rate Test Table -->
        <div class="table-container">
            <h2>Heat Transfer Rate Test</h2>
            <table class="table table-striped">
                <thead>
                    <tr>
                       
                          <th>Heat Transferred</th>
                        <th>Temparature Different</th>
                        <th>HeatTransferRate</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Connection conn4 = null;
                        PreparedStatement pstmt4 = null;
                        ResultSet rs4 = null;
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            conn4 = DriverManager.getConnection("jdbc:mysql://localhost:3306/ricehuskinsulation", "root", "root");
                            String sql4 = "SELECT * FROM thermalconductivityenhancertests where testType ='HeatTransferRate'";
                            pstmt4 = conn4.prepareStatement(sql4);
                            rs4 = pstmt4.executeQuery();
                            
                            while (rs4.next()) {
                                out.println("<tr>");
                                out.println("<td>" + rs4.getDouble("HeatTransferred") + "</td>");
                                out.println("<td>" + rs4.getDouble("TempDifferenceHeat") + "</td>");
                                out.println("<td>" + rs4.getDouble("HeatTransferRate") + "</td>");
                              
                                out.println("</tr>");
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            if (rs4 != null) try { rs4.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (pstmt4 != null) try { pstmt4.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (conn4 != null) try { conn4.close(); } catch (SQLException e) { e.printStackTrace(); }
                        }
                    %>
                </tbody>
            </table>
        </div>
        
                <div class="table-container">
            <h2>Stability Test</h2>
            <table class="table table-striped">
                <thead>
                    <tr>
                       
                          <th>InitialWeight</th>
                        <th>FinalWeight</th>
                        <th>WeightLoss</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    
                        Connection conn5 = null;
                        PreparedStatement pstmt5 = null;
                        ResultSet rs5 = null;
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            conn5 = DriverManager.getConnection("jdbc:mysql://localhost:3306/ricehuskinsulation", "root", "root");
                            String sql = "SELECT * FROM thermalconductivityenhancertests where testType ='ThermalStability' ";
                            
                            pstmt5 = conn5.prepareStatement(sql);
                         
                            rs5 = pstmt5.executeQuery();
                          
                            while (rs5.next()) {
                                out.println("<tr>");
                                out.println("<td>" + rs5.getDouble("InitialWeight") + "</td>");
                              
                                out.println("<td>" + rs5.getDouble("FinalWeight") + "</td>");
                                out.println("<td>" + rs5.getDouble("WeightLoss") + "</td>");
                              
                                out.println("</tr>");
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            if (rs5 != null) try { rs5.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (pstmt5 != null) try { pstmt5.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (conn5 != null) try { conn5.close(); } catch (SQLException e) { e.printStackTrace(); }
                        }
                    %>
                </tbody>
            </table>
        </div> <button class="back-button" onclick="handleButtonClick()"> Approve</button>
         <button class="back-button" onclick="handleButton()">Deny</button>
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
    
    <script src="adminPage/js/jquery.min.js"></script>
    <script src="adminPage/js/bootstrap.bundle.min.js"></script>
    <script src="adminPage/js/jquery.singlePageNav.min.js"></script>
    <script src="adminPage/js/slick.js"></script>
    <script src="adminPage/js/parallax.min.js"></script>
    <script src="adminPage/js/templatemo-script.js"></script>
</body>
</html>
