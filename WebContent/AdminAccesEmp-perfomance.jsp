<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Base64" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="org.apache.pdfbox.io.IOUtils" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Employees</title>
    <style>
        body {
            font-family: 'Roboto', serif;
            background: -webkit-linear-gradient(left, #25c481, #25b7c4);
            background: linear-gradient(to right, #25c481, #25b7c4);
            margin: 0;
            padding: 20px;
            display: flex;
            flex-direction: column; /* Added */
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: #000; /* Font color changed to black */
        }
        .header {
            width: 90%; /* Adjusted width */
            display: flex;
            justify-content: space-between; /* Adjusted */
            align-items: center;
            margin-bottom: 20px; /* Added */
            margin-: 20%;
            margin-left: 40%; /* Adjusted */
        }
        .header h1 {
            color: #AD1457;
            transform: scale(1.1);
            outline: 2px solid #fff;
            box-shadow: 4px 5px 17px -4px #fff;
            width: auto; /* Adjusted */
            margin: 0; /* Added */
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
            margin-right: 80%; /* Adjusted */
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
            background-color: #AD1457;
            transform: skewX(45deg);
            z-index: -1;
            transition: width 1000ms;
        }
        .button1:hover::before {
            width: 200%;
        }
        .container {
            width: 90%; /* Adjusted width */
            height: auto; /* Adjusted height */
            overflow: auto; /* Enable both horizontal and vertical scrolling */
            border: 1px solid rgba(0, 0, 0, 0.3); /* Adjusted border color */
            background-color: rgba(255, 255, 255, 0.9); /* Adjusted background color */
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
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
            font-weight: 300;
            font-size: 14px;
            word-wrap: break-word; /* Allow word break for long content */
            border-bottom: 1px solid rgba(0, 0, 0, 0.1); /* Adjusted border color */
        }
        th {
            background-color: #AD1457;
            font-weight: 500;
            text-transform: uppercase;
            position: sticky; /* Sticky header for scrolling */
            top: 0; /* Stick to the top */
            z-index: 1; /* Ensure header is above table content */
            color: #fff; /* Font color for headers */
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
    </style>
</head>

<body>
    <button class="button1" onclick="window.location.href='adminPage.html'">BACK</button>
    <div class="header">
      <h1>PERFORMANCE ANALYST REGISTRATION</h1>
    
      
      
    </div>
     <br><br>
    <div class="container">
        <table>
            <thead>
                <tr>
                    <th>Employee ID</th>
                    <th>Name</th>
                    <th>City</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Gender</th>
                    <th>Age</th>
                    <th>State</th>
                    <th>Address</th>
                    
                    <th>Date of Birth</th>
                    <th>Department</th>
                    <th>Option</th>
                </tr>
            </thead>
            <tbody>
          
                <%
                    final String jdbcUrl = "jdbc:mysql://localhost:3306/ricehuskinsulation";
                    final String dbUser = "root";
                    final String dbPassword = "root";

                    Connection conn = null;
                    PreparedStatement stmt = null;
                    ResultSet rs = null;

                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

                        String sql = "SELECT * FROM performance_efficiency  ";
                        stmt = conn.prepareStatement(sql);
               
                        rs = stmt.executeQuery();

                        while (rs.next()) {
                            %>
                            <tr>
                                <td><%= rs.getString("emp_id") %></td>
                                <td><%= rs.getString("name") %></td>
                                <td><%= rs.getString("city") %></td>
                                <td><%= rs.getString("email") %></td>
                                <td><%= rs.getString("phone") %></td>
                                <td><%= rs.getString("gender") %></td>
                                <td><%= rs.getString("Age") %></td>
                                <td><%= rs.getString("state") %></td>
                                <td><%= rs.getString("address") %></td>
                             
                                <td><%= rs.getString("dob") %></td>
                                <td><%= rs.getString("role") %></td>
                                <td>
                                    <form action="SendEmailServlet" method="post">
                                        <button type="submit"  class="btn-update">Accept</button>
                                        <input type="hidden" name="empId" value="<%= rs.getString("emp_id") %>">
                                        <input type="hidden" name="email" value="<%= rs.getString("email") %>">
                                        <input type="hidden" name="password" value="<%= rs.getString("password") %>">
                                        <input type="hidden" name="role" value="<%= rs.getString("role") %>">
                                    </form>
                                    <br>
                                    <form action="DeleteAccess" method="post">
                                        <input type="hidden" name="empId" value="<%= rs.getString("emp_id") %>">
                                        <input type="hidden" name="role" value="<%= rs.getString("role") %>">
                                        <button type="submit"  class="btn-delete">Deny</button>
                                    </form>
                                </td>
                            </tr>
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
            </tbody>
        </table>
    </div>
</body>
</html>
