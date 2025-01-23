<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Materials List</title>
     <style>
         body {
        font-family: Arial, sans-serif;
        background: url('adminPage/img/section-3-bg.jpg') no-repeat center center fixed;
        background-color: #f8f9fa;
        margin: 0;
        padding: 0;
    }
       
        h1 {
            color: #333;
            text-align: center;
        }
        table {
            width: 70%;
            border-collapse: collapse;
            margin: 20px 0;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            background-color: #fff;
            margin-left: 15%;
         
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #ddd;
        }
        button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 8px 16px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            cursor: pointer;
            border-radius: 4px;
            transition: background-color 0.3s ease;
            margin-left: 10%;
            margin-top: 5%;
        }
        button:hover {
            background-color: #45a049;
        }.btn-animated {
            display: inline-block;
            padding: 10px 20px;
            margin: 10px;
            border: none;
            background-color: #4CAF50;
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
 <button class="btn-animated" onclick="window.location.href='durabilityTestResults.jsp'">Back</button>
           
    <h1>Materials List</h1>
    <table>
        <thead>
            <tr>
                <th>Material Name</th>
                <th>Type of Material</th>
               
            </tr>
        </thead>
        <tbody>
           <%
                String material = request.getParameter("material");
                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ricehuskinsulation", "root", "root");

                    String sql = "SELECT  Type_of_Material FROM material_requirement where Material = ? ";
                    stmt = conn.prepareStatement(sql);
                    stmt.setString(1, material);
                    rs = stmt.executeQuery();

                    while (rs.next()) {
                       
                        String typeOfMaterial = rs.getString("Type_of_Material");
                        %>
                        <tr>
                          
                            <td><%= typeOfMaterial %></td>
                            <td>
                                <form action="calculate_tests.jsp" method="post" style="display:inline;">
                                    <input type="hidden" name="material" value="<%= material %>">
                                    <input type="hidden" name="typeOfMaterial" value="<%= typeOfMaterial %>">
                                    <button class="btn-animated" type="submit">Take Test</button>
                                </form>
                            </td>
                        </tr>
                        <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            %>
        </tbody>
    </table>
</body>
</html>
