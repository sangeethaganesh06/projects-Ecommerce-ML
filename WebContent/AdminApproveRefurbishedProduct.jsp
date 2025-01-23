<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Refurbished Insulation Panels</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="adminPage/css/bootstrap.min.css" type="text/css" />
    <link rel="stylesheet" href="adminPage/css/style.css" type="text/css" /> <!-- Custom CSS -->
    <style>
        body {
            font-family: 'Roboto', serif;
            background: -webkit-linear-gradient(left, #25c481, #25b7c4);
            background: linear-gradient(to right, #25c481, #25b7c4);
            margin: 0;
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
            height: 100vh;
            color: #000; /* Font color changed to black */
            background: url('adminPage/img/section-3-bg.jpg') no-repeat center center fixed;
        }
        .header {
            width: 100%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px; /* Added */
             margin-: 20%;
            margin-left: 60%; /* Adjusted */
        }
        .header h1 {
             color: #AD1457;
            transform: scale(1.1);
            outline: 2px solid #AD1457;
            box-shadow: 4px 5px 17px -4px #AD1457;
            width: auto; /* Adjusted */
            margin: 0; /* Added */
          
             
        }
        .container {
            width: 95%; /* Fixed width */
            height: 70%; /* Adjusted height */
            overflow: auto; /* Enable both horizontal and vertical scrolling */
            border: 1px solid rgba(0, 0, 0, 0.3); /* Adjusted border color */
            background-color: rgba(255, 255, 255, 0.9); /* Adjusted background color */
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-top: 20px; /* Add some margin to separate from header */
        }
        table {
            width: 100%;
            table-layout: auto; /* Adjusted table layout to auto */
            border-collapse: collapse;
            background-color: rgba(255, 255, 255, 0.9); /* Adjusted background color */
        }
        th, td {
            padding: 12px;
            text-align: left;
            font-weight: 200;
            font-size: 15px;
            word-wrap: break-word; /* Allow word break for long content */
            border-bottom: 1px solid rgba(0, 0, 0, 0.1); /* Adjusted border color */
        }
        th {
            background-color: #AD1457;
            font-weight: 500;
            text-transform: uppercase;
            position: sticky;
            top: 0;
            z-index: 1;
            color: #fff;
        }
        td img {
            max-width: 100px;
            max-height: 100px;
            display: block;
            margin: auto;
            cursor: pointer; /* Cursor pointer for clickable image */
        }
        .btn-group {
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .btn-group button {
            margin: 5px;
            padding: 8px 12px;
            border: none;
            cursor: pointer;
        }
        .btn-update {
            background-color: #4CAF50;
            color: white;
        }
        .btn-delete {
            background-color: #f44336;
            color: white;
        }
        .btn-download {
            background-color: #f44336;
            color: white;
        }
        /* Custom scrollbar for webkit browser */
        ::-webkit-scrollbar {
            width: 6px;
        }
        ::-webkit-scrollbar-track {
            -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
            border-radius: 10px;
        }
        ::-webkit-scrollbar-thumb {
            -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
            border-radius: 10px;
        }
        /* Modal styles */
        .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0, 0, 0); /* Fallback color */
            background-color: rgba(0, 0, 0, 0.9); /* Black w/ opacity */
        }
        .modal-content {
            margin: auto;
            display: block;
            width: 80%;
            max-width: 700px;
        }
        .modal-content,
        .close {
            animation-name: zoom;
            animation-duration: 0.6s;
        }
        @keyframes zoom {
            from {
                transform: scale(0)
            }

            to {
                transform: scale(1)
            }
        }
        .close {
            position: absolute;
            top: 15px;
            right: 35px;
            color: #f1f1f1;
            font-size: 40px;
            font-weight: bold;
            transition: 0.3s;
        }
        .close:hover,
        .close:focus {
            color: #bbb;
            text-decoration: none;
            cursor: pointer;
        }
        .approve-btn, .deny-btn {
            padding: 8px 12px;
            border: none;
            border-radius: 4px;
            color: white;
            cursor: pointer;
            font-weight: normal;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            margin: 2px;
        }
        .approve-btn {
            background-color: #4CAF50;
        }
        .deny-btn {
            background-color: #f44336;
        }
        .approve-btn:hover, .deny-btn:hover {
            opacity: 0.8;
        }
        .actions {
            display: flex;
            gap: 10px;
        }
        .button1 {
            padding: 1em 2em;
            border: none;
            border-radius: 5px;
            font-weight: bold;
            letter-spacing: 5px;
            text-transform: uppercase;
            cursor: pointer;
            color: #AD1457;
            transition: all 1000ms;
            font-size: 15px;
            position: relative;
            overflow: hidden;
            outline: 2px solid #AD1457;
             margin-right: 90%; /* Adjusted */
        }
        .button1:hover {
            color: #ffffff;
            transform: scale(1.1);
            outline: 2px solid #70bdca;
            box-shadow: 4px 5px 17px -4px #AD1457;
        }
        .button1::before {
            content: "";
            position: absolute;
            left: -50px;
            top: 0;
            width: 0;
            height: 100%;
            background-color:#AD1457;
            transform: skewX(45deg);
            z-index: -1;
            transition: width 1000ms;
        }
        .button1:hover::before {
            width: 200%;
        }
    </style>
</head>
<body>
 <button1 class="button1" onclick="window.location.href='adminPage.html'" >BACK</button1>
    
    
     <div class="header">
      <h1>REFURBISHED PRODUCT LIST</h1>
    
      
      
    </div>
 
     <div class="container">
 
        <table >
            <thead>
                <tr>
                    <th>ProductID</th>
                    <th>ProductName</th>
                    <th>RefurbishmentDate</th>
                    <th>OriginalManufactureDate</th>
                    <th>Refurbisher</th>
                    <th>Thickness</th>
                    <th>Density</th>
                    <th>ThermalConductivity</th>
                    <th>InspectionStatus</th>
                    <th>CleaningMethod</th>
                    <th>RepairDetails</th>
                    <th>PreTestThermalConductivity</th>
                    <th>PostTestThermalConductivity</th>
                    <th>PreTestDensity</th>
                    <th>PostTestDensity</th>
                    <th>PreTestMoistureContent</th>
                    <th>PostTestMoistureContent</th>
                    <th>WarrantyPeriod</th>
                    <th>PackagingType</th>
                    <th>Notes</th>
                    <th>Option</th>
                </tr>
            </thead>
            <tbody>
                <% 
                // Database connection parameters
                String jdbcURL = "jdbc:mysql://localhost:3306/ricehuskinsulation";
                String jdbcUsername = "root";
                String jdbcPassword = "root";

                Connection connection = null;
                Statement statement = null;
                ResultSet resultSet = null;

                try {
                    // Load JDBC driver
                    Class.forName("com.mysql.jdbc.Driver");

                    // Establish database connection
                    connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
                    statement = connection.createStatement();

                    // Execute SQL query
                    String sql = "SELECT * FROM refurbishedinsulationpanels where Status1= "+"'not approved'";
                    resultSet = statement.executeQuery(sql);
                 
                    // Iterate through the result set
                    while (resultSet.next()) {
                %>
                    <tr>
                        <td><%= resultSet.getInt("ProductID") %></td>
                        <td><%= resultSet.getString("ProductName") %></td>
                        <td><%= resultSet.getDate("RefurbishmentDate") %></td>
                        <td><%= resultSet.getDate("OriginalManufactureDate") %></td>
                        <td><%= resultSet.getString("Refurbisher") %></td>
                        <td><%= resultSet.getString("Thickness") %></td>
                        <td><%= resultSet.getString("Density") %></td>
                        <td><%= resultSet.getString("ThermalConductivity") %></td>
                        <td><%= resultSet.getString("InspectionStatus") %></td>
                        <td><%= resultSet.getString("CleaningMethod") %></td>
                        <td><%= resultSet.getString("RepairDetails") %></td>
                        <td><%= resultSet.getString("PreTestThermalConductivity") %></td>
                        <td><%= resultSet.getString("PostTestThermalConductivity") %></td>
                        <td><%= resultSet.getString("PreTestDensity") %></td>
                        <td><%= resultSet.getString("PostTestDensity") %></td>
                        <td><%= resultSet.getString("PreTestMoistureContent") %></td>
                        <td><%= resultSet.getString("PostTestMoistureContent") %></td>
                        <td><%= resultSet.getString("WarrantyPeriod") %></td>
                        <td><%= resultSet.getString("PackagingType") %></td>
                        <td><%= resultSet.getString("Notes") %></td>
                         <td>
                            <form action="RefurbishmentproductApproval" method="post" style="display: inline;">
                                <input type="hidden" name="ProductID" value="<%= resultSet.getInt("ProductID") %>" />
                                <button type="submit" name="action" value="approve" class="btn-approve" style="background-color: green;">Approve</button>
                             <br> <br>
                             
                                <button type="submit" name="action" value="deny" class="btn-deny" style="background-color: red;">Deny</button>
                           <br>
                            </form>
                        </td>
                    </tr>
                <% 
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    // Clean up resources
                    try {
                        if (resultSet != null) resultSet.close();
                        if (statement != null) statement.close();
                        if (connection != null) connection.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
                %>
            </tbody>
        </table>
    </div>
    <script src="adminPage/js/jquery-3.3.1.min.js"></script>
    <script src="adminPage/js/bootstrap.bundle.min.js"></script>
</body>
</html>
