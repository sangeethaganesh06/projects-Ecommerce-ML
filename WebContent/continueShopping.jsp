<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.*" %>
<%@ page import="riskHuskInsulation.Product" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Continue Shopping</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
     body {
        font-family: Arial, sans-serif;
        background: url('adminPage/img/section-3-bg.jpg') no-repeat center center fixed;
        background-color: #f8f9fa;
        margin: 0;
        padding: 0;
    }.container {
            width: 90%;
            height: 80vh; /* Adjusted height */
            overflow: auto; /* Enable scrolling */
        margin-bottom:10%;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .btn-animated {
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
        }/* Your CSS styles here */
        .button1 {
  padding: 1em 2em;
  border: none;
  top:10;
  border-radius: 5px;
  font-weight: bold;
  letter-spacing: 5px;
  text-transform: uppercase;
  cursor: pointer;
  color: #2caf38;
  transition: all 1000ms;
  font-size: 15px;
  position: relative;
  overflow: hidden;
  outline: 2px solid #2caf38;
   margin-left: 3%;
  margin-top: 2%;
}



    </style>
</head>
<body>
<%String orderId = session.getAttribute("orderId").toString(); %>
<button class="button1" onclick="window.location.href='deleteOrder.jsp?orderId=<%=orderId %> '" >BACK</button>
<br>
    <div class="container">
       
        <h1>CONTINUE SHOPPING</h1>
        
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Product ID</th>
                    <th>Product Name</th>
                    <th>Quantity (sqft)</th>
                    <th>Cost Per Unit</th>
                    <th>Total Cost</th>
                </tr>
            </thead>
            <tbody>
                <%-- Iterate over products from session or request attribute --%>
                <%
                List<Product> cart = (List<Product>) session.getAttribute("cart");
                String  formattedtotalCost="";  String costPerUnit="";
                		
                double costperproduct= Double.parseDouble(session.getAttribute("totalCost").toString());
                    double totalAmount = 0.0;
                    for (Product product : cart) {
                        String sqftParam = request.getParameter("sqft_" + product.getProductId());
                        int sqft = Integer.parseInt(sqftParam);
                        double cost = product.getCostPerUnit();
                         costPerUnit=  String.format("%.2f", cost);
                        double productTotal = sqft * cost;
                        totalAmount += productTotal;
                  formattedtotalCost = String.format("%.2f", totalAmount);
                %>
                <tr>
                    <td><%= product.getProductId() %></td>
                    <td><%= product.getProductName() %></td>
                    <td><%= sqft %></td>
                    <td><%= costPerUnit %></td>
                    <td><%= formattedtotalCost %></td>
                </tr>
                <% } %>
                <tr>
                    <td colspan="4" align="right"><strong>Total Amount:</strong></td>
                    <td>Rs.<%= formattedtotalCost %></td>
                </tr>
            </tbody>
        </table>
        
        <div class="payment-actions">
        <%session.setAttribute("totalamount",formattedtotalCost );
        String orderid=(String)session.getAttribute("orderId");
        session.setAttribute("orderId",orderid );
        session.setAttribute("costperproduct",costperproduct );
        %>
            <button class="btn-animated" onclick ="window.location.href='Payment.jsp?Total Amount=<%= formattedtotalCost %>' ">Proceed to Payment</button>
        </div>
    </div>
</body>
</html>
