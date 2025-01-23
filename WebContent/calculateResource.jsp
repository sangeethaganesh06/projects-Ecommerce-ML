<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.HashSet, java.util.Set" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Calculate Volume, Weight, and Binder Amount</title>
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
            margin-left: 50%; /* Adjusted */
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
        
         .btn-animated {
            display: inline-block;
            padding: 10px 40px;
            margin: 10px;
            border: none;
           background-color: #AD1457;
            color: white;
            border-radius: 5px;
            cursor: pointer;
            transition: transform 0.2s;
            margin-left: 80%;
        }
        .btn-animated:hover {
            transform: scale(1.1);
        }
        .btn-animated:active {
            transform: scale(1);
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
<br>
   <button1 class="button1" onclick="window.location.href='ResourceAllocate.jsp';" >BACK</button1>
    <div class="header">
      <h1>RESOURCE CALCULATION FOR ORDERS</h1>
  </div>
     <br><br>
     
  <div class="container">
  
    <table>
        <thead>
            <tr>
        
                          <th>Product</th>
                          <th>Quantity (sqft)</th>
                          <th>Thickness (m)</th>
                          <th>Density (kg/m³)</th>
                          <th>Volume (m³)</th>
                          <th>Weight (kg)</th>
                          <th>Binder Type</th>
                          <th>Binder Amount (kg)</th>
                          <th>Anti-Bacterial (kg)</th>
                          <th>Fungal Resist (kg)</th>
                          <th>Moisture Content (kg)</th>
                          <th>Thermal Conductivity Enhancer (kg)</th>
                          </tr>
                          </thead>
            <% 
            String orderId = request.getParameter("orderId");
            double totalWeight = 0; 
            double totalThermalConductivityEnhancer = 0;
            double totalMoistureContent = 0;
            double totalAntiFungal = 0;
            double totalAntiBacterial = 0;
            double thicknessM = 0.0;  
            String binderType = ""; 
            double binderAmount = 0.0;
            double weightKg = 0; 
            double volumeCuM = 0;
            String thermalConductivityEnhancerType = "";
            String moistureAgentType = "";
            String antiFungalResistType = "";
            String antiBacterialResistType = "";
                if (orderId != null && !orderId.isEmpty()) {
                    // Database connection details
                    final String jdbcUrl = "jdbc:mysql://localhost:3306/ricehuskinsulation";
                    final String dbUser = "root";
                    final String dbPassword = "root";

                    Connection conn = null;
                    PreparedStatement stmtProducts = null;
                    ResultSet rsProducts = null;

                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

                        // Query to retrieve products in the order
                        String sqlProducts = "SELECT om.Orderno, pc.ProductID, pc.ProductName, om.quantity, pc.`Thickness(mm)`, pc.density, pc.`BinderType`, pc.`binder_amount(kg)`, pc.`AntiBacterial(g)`, pc.`FungalResist(g)`,"+ 
                               " pc.`MoistureContent(g)`, pc.`ThermalConductivityEnhancer_amount(kg)`, "+
                               " pc.`ThermalConductivityEnhancer`, pc.`MoistureAgent`, "+
                                "pc.`AntifungalResistType(g)`, pc.`AntibacterialResistType`"+
                               "FROM product_catalog pc " +
                                "INNER JOIN orders o ON pc.ProductID = o.productid " +
                                "INNER JOIN ordermanagement om ON o.orderId = om.orderId " +
                                "WHERE o.orderId = ? ORDER BY om.Orderno";

                        stmtProducts = conn.prepareStatement(sqlProducts);
                        stmtProducts.setString(1, orderId);
                        rsProducts = stmtProducts.executeQuery();

                        // Track order numbers that have been displayed
                        Set<String> displayedOrderNumbers = new HashSet<>();

                        // Display results for each product in the order
                        if (rsProducts.isBeforeFirst()) {
                          %>
         
                          <%  
                            while (rsProducts.next()) {
                                String orderNo = rsProducts.getString("Orderno");

                                // Display each order number only once
                                if (!displayedOrderNumbers.contains(orderNo)) {
                                    String productId = rsProducts.getString("ProductID");
                                    String productName = rsProducts.getString("ProductName");
                                    int quantity = rsProducts.getInt("quantity");
                                    int thicknessMm = rsProducts.getInt("Thickness(mm)");
                                    double density = rsProducts.getDouble("density");
                                    binderType = rsProducts.getString("BinderType");
                                    binderAmount = rsProducts.getDouble("binder_amount(kg)");
                                    double antiBacterial = rsProducts.getDouble("AntiBacterial(g)");
                                    double fungalResist = rsProducts.getDouble("FungalResist(g)");
                                    double moistureContent = rsProducts.getDouble("MoistureContent(g)");
                                    double thermalConductivityEnhancer = rsProducts.getDouble("ThermalConductivityEnhancer_amount(kg)");
                                    thermalConductivityEnhancerType = rsProducts.getString("ThermalConductivityEnhancer");
                                    moistureAgentType = rsProducts.getString("MoistureAgent");
                                    antiFungalResistType = rsProducts.getString("AntifungalResistType(g)");
                                    antiBacterialResistType = rsProducts.getString("AntibacterialResistType");

                                    // Convert thickness from mm to meters
                                    thicknessM = thicknessMm / 100.0;

                                    // Calculate volume in cubic meters
                                    volumeCuM = quantity * thicknessM; // Assuming 1 sqft area for simplicity
                                
                                    // Calculate weight in kilograms
                                    weightKg = volumeCuM * density;

                                    // Calculate total amounts for each material
                                    totalAntiBacterial += antiBacterial * quantity * 100;
                                    totalAntiFungal += fungalResist * quantity * 100;
                                    totalMoistureContent += moistureContent * quantity * 100;
                                    totalThermalConductivityEnhancer += thermalConductivityEnhancer * quantity * 100;

                                    // Round off values to 3 decimal places
                                    double thicknessM_rounded = Math.round(thicknessM * 1000.0) / 1000.0;
                                    double density_rounded = Math.round(density * 1000.0) / 1000.0;
                                    double volumeCuM_rounded = Math.round(volumeCuM * 1000.0) / 1000.0;
                                    double weightKg_rounded = Math.round(weightKg * 1000.0) / 1000.0;
                                    double binderAmount_rounded = Math.round(binderAmount * 1000.0) / 1000.0;
                                    double antiBacterial_rounded = Math.round(antiBacterial * 1000.0) / 1000.0;
                                    double fungalResist_rounded = Math.round(fungalResist * 1000.0) / 1000.0;
                                    double moistureContent_rounded = Math.round(moistureContent * 1000.0) / 1000.0;
                                    double thermalConductivityEnhancer_rounded = Math.round(thermalConductivityEnhancer * 1000.0) / 1000.0;

                                    out.println("<tr>");
                                    out.println("<td>" + productName + "</td>");
                                    out.println("<td>" + quantity + "</td>");
                                    out.println("<td>" + thicknessM_rounded + "</td>");
                                    out.println("<td>" + density_rounded + "</td>");
                                    out.println("<td>" + volumeCuM_rounded + "</td>");
                                    out.println("<td>" + weightKg_rounded + "</td>");
                                    out.println("<td>" + binderType + "</td>");
                                    out.println("<td>" + binderAmount_rounded + "</td>");
                                    out.println("<td>" + antiBacterial_rounded + "</td>");
                                    out.println("<td>" + fungalResist_rounded + " </td>");
                                    out.println("<td>" + moistureContent_rounded + " </td>");
                                    out.println("<td>" + thermalConductivityEnhancer_rounded + "</td>");
                                    out.println("</tr>");

                                    totalWeight += weightKg;
                                    displayedOrderNumbers.add(orderNo);
                                }
                            }
                            out.println("</table>");
                        } else {
                            out.println("<p>No products found for the given Order ID.</p>");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        // Close resources
                        try {
                            if (rsProducts != null) rsProducts.close();
                            if (stmtProducts != null) stmtProducts.close();
                            if (conn != null) conn.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                } else {
                    out.println("<p>Please provide a valid Order ID.</p>");
                }
                
            %>
          
        <form action="SubmitReportByResource" method="post">
            <input type="hidden" name="orderId" value="<%= orderId %>">
            <input type="hidden" name="totalWeight" value="<%= totalWeight %>">
            <input type="hidden" name="totalAntiBacterial" value="<%= totalAntiBacterial %>">
            <input type="hidden" name="totalAntiFungal" value="<%= totalAntiFungal %>">
            <input type="hidden" name="totalMoistureContent" value="<%= totalMoistureContent %>">
            <input type="hidden" name="totalThermalConductivityEnhancer" value="<%= totalThermalConductivityEnhancer %>">
            <input type="hidden" name="binderType" value="<%= binderType %>">
            <input type="hidden" name="binderAmount" value="<%= binderAmount %>">
           <button class="btn-animated" type="submit">Submit Report</button>
        </form>
        
          </table>
        </div>
        
   </div>
</body>
</html>
