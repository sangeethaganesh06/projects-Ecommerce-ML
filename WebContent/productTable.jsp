<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Base64" %>
<%@ page import="java.io.InputStream" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Product Details</title>
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
        margin: 20px auto;
        background: #fff;
        padding: 20px;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }
    h1 {
        text-align: center;
        color: #333;
    }
    .product-table {
        width: 100%;
        border-collapse: collapse;
        margin: 20px 0;
    }
    .product-table th, .product-table td {
        border: 1px solid #ddd;
        padding: 12px;
        text-align: left;
    }
    .product-table th {
        background-color: #4CAF50;
        color: white;
    }
    .product-table tr:nth-child(even) {
        background-color: #f2f2f2;
    }
    .product-table tr:hover {
        background-color: #ddd;
    }
    .product-table td strong {
        color: #333;
    }
     .button1 {
            padding: 1em 2em;
            border: none;
            border-radius: 5px;
            font-weight: bold;
            letter-spacing: 5px;
            text-transform: uppercase;
            cursor: pointer;
            color: #0091cd;
            transition: all 1000ms;
            font-size: 15px;
            position: relative;
            overflow: hidden;
            outline: 2px solid #0091cd;
            margin-left: -51%;
            margin-bottom: -75%;
        }

        .button1:hover {
            color: #ffffff;
            transform: scale(1.1);
            outline: 2px solid #0091cd;
            box-shadow: 4px 5px 17px -4px #0091cd;
        }

        .button1::before {
            content: "";
            position: absolute;
            left: -50px;
            top: 0;
            width: 0;
            height: 100%;
            background-color: #28a745;
            transform: skewX(45deg);
            z-index: -1;
            transition: width 1000ms;
        }

        .button1:hover::before {
            width: 200%;
        }
        .back-button {
            position: absolute;
            top: 10px;
            left: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            transition: transform 0.2s;
        }
        .back-button:hover {
            transform: scale(1.1);
        }
</style>
<script type="text/javascript">
function goBack() {
    window.history.back();
}
</script>
</head>
<body>
<button class="back-button" onclick="window.location.href='product-list.jsp';">Back</button>

<section class="shop_section layout_padding">
    <div class="container">
        <h1>Product Details</h1>
        <%
            Connection connection = null;
            Statement statement = null;
            ResultSet resultSet = null;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                String key = request.getParameter("productId");
                connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/ricehuskinsulation", "root", "root");
                String query = "SELECT * FROM product_catalog WHERE ProductID = '" + key + "'";
                statement = connection.createStatement();
                resultSet = statement.executeQuery(query);
                if (resultSet.next()) {
                    String productId = resultSet.getString("ProductID");
                    String productName = resultSet.getString("ProductName");
                    int thickness = resultSet.getInt("Thickness(mm)");
                    String description = resultSet.getString("Description");
                    int tensileStrength = resultSet.getInt("TensileStrength");
                    float NewspaperCellulose = resultSet.getFloat("NewspaperCellulose(kg)");
                   
                    float antiBacterial = resultSet.getFloat("AntiBacterial(g)");
                    float fungalResist = resultSet.getFloat("FungalResist(g)");
                 
                    float moistureContent = resultSet.getFloat("MoistureContent(g)");
                  
                    String material1 = resultSet.getString("BinderType");
                    String material2 = resultSet.getString("AntibacterialResistType");
                    String material3 = resultSet.getString("AntifungalResistType(g)");
                  
                    String image = resultSet.getString("Image");
                    float costPerUnit = resultSet.getFloat("CostPerUnit");
        %>
        <div class="box">
            <div>
            
                <table class="product-table">
                    <tr>
                        <th>Field</th>
                        <th>Details</th>
                    </tr>
                    <tr>
                        <td><strong>Product ID:</strong></td>
                        <td><%= productId %></td>
                    </tr>
                    <tr>
                        <td><strong>Name:</strong></td>
                        <td><%= productName %></td>
                    </tr>
                    <tr>
                        <td><strong>Thickness:</strong></td>
                        <td><%= thickness %> mm</td>
                    </tr>
                    <tr>
                        <td><strong>Description:</strong></td>
                        <td><%= description %></td>
                    </tr>
                    <tr>
                        <td><strong>Tensile Strength:</strong></td>
                        <td><%= tensileStrength %> MPa</td>
                    </tr>
                    <tr>
                        <td><strong>NewspaperCellulose:</strong></td>
                        <td><%= NewspaperCellulose %> %</td>
                    </tr>
                    <tr>
                        <td><strong>Anti-Bacterial:</strong></td>
                        <td><%= antiBacterial %> %</td>
                    </tr>
                    <tr>
                        <td><strong>Fungal Resistance:</strong></td>
                        <td><%= fungalResist %> %</td>
                    </tr>
                   
                   
                    <tr>
                        <td><strong>Moisture Content:</strong></td>
                        <td><%= moistureContent %> %</td>
                    </tr>
                 
                    <tr>
                        <td><strong>BinderType :</strong></td>
                        <td><%= material1 %></td>
                    </tr>
                    <tr>
                        <td><strong> AntibacterialResistType:</strong></td>
                        <td><%= material2 %></td>
                    </tr>
                    <tr>
                        <td><strong>AntifungalResistType :</strong></td>
                        <td><%= material3 %></td>
                    </tr>
                   
                    <tr>
                        <td><strong>Cost Per Unit:</strong></td>
                        <td>Rs.<%= costPerUnit %></td>
                    </tr>
                </table>
            </div>
        </div>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (resultSet != null) {
                    try { resultSet.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
                if (statement != null) {
                    try { statement.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
                if (connection != null) {
                    try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            }
        %>
    </div>
</section>
</body>
</html>
