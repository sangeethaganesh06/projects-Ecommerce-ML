<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="riskHuskInsulation.Product" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Your Cart</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
       
         body {
        font-family: Arial, sans-serif;
        background: url('adminPage/img/section-3-bg.jpg') no-repeat center center fixed;
        background-color: #f8f9fa;
        margin: 0;
        padding: 0;
    }
        .cart-container {
            margin: 50px auto;
            padding: 20px;
            background: rgba(255, 255, 255, 0.8);
            border-radius: 10px;
            box-shadow: 0px 0px 10px 2px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            margin-bottom: 20px;
            font-size: 2.5em;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        th, td {
            padding: 15px;
            text-align: left;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .empty-cart {
            text-align: center;
            font-size: 1.5em;
            color: #ff0000;
        }
        .cart-actions {
            text-align: center;
            margin-top: 20px;
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
        }
        .total-cost {
            text-align: right;
            font-size: 1.2em;
            margin-top: 10px;
        }

         .btn-animated {
            display: inline-block;
            padding: 10px 40px;
            margin: 10px;
            border: none;
           background-color: green;
            color: white;
            border-radius: 5px;
            cursor: pointer;
            transition: transform 0.2s;
            margin-left: 3%;
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
    <div class="container cart-container">
    <button class="btn-animated"  style="background-color:green;" onclick="window.location.href='product-list.jsp'" >BACK</button>
    <% HttpSession session1 = request.getSession();
    String userId = (String) session1.getAttribute("userId");
    String formattedtotalCost = "";
   %>
   
        <h1>YOUR CART</h1>
        <%
            HttpSession session3 = request.getSession();
            List<Product> cart = (List<Product>) session3.getAttribute("cart");
            session3.setAttribute("cart", cart);
            double totalCost = 0.0;
            if (cart == null || cart.isEmpty()) {
                out.println("<p class='empty-cart'>Your cart is empty</p>");
            } else {
            	session1.setAttribute("userId", userId);
            	session1.setAttribute("cart", cart);
        %>
        <form id="cartForm" action="ContinueShoppingServlet" method="post">
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Product ID</th>
                    <th>Product Name</th>
                    <th>required material(sqft)</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (Product product : cart) {
                        totalCost += product.getCostPerUnit();
                        formattedtotalCost = String.format("%.2f", totalCost);
                %>
                <tr id="product_<%= product.getProductId() %>">
                    <td><%= product.getProductId() %></td>
                    <td><%= product.getProductName() %></td>
                    <td ><input type='text' name="sqft_<%= product.getProductId() %>" required="required"></td>
                    <td><button  type="submit" class="btn-animated" style="background-color:red " onclick="removeProduct('<%= product.getProductId() %>')">Remove</button></td>
                </tr>  </form>
                <%
                    }
                %>
            </tbody>
        </table>
        
        <div class="total-cost">
            <strong>Total Cost per sqft : <span id="totalCost">Rs.<%= formattedtotalCost %></span></strong>
        </div>
        <div class="cart-actions">
          
            <button type="submit" class="btn-animated"  style="background-color:green">Continue Shopping</button>
        </div>
        </form>
        <%
            }
        %>
    </div>
    <script>
        function removeProduct(productId) {
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "RemoveProductServlet", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.onreadystatechange = function() {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    var data = JSON.parse(xhr.responseText);
                    if (data.success) {
                        var row = document.getElementById('product_' + productId);
                        if (row) {
                            row.remove();
                        }
                        document.getElementById('totalCost').innerText = data.totalCost;
                    } else {
                        alert('Failed to remove product');
                    }
                }
            };
            xhr.send("productId=" + productId);
        }

        function checkout() {
            alert("Proceeding to checkout...");
        }

        function continueShopping() {
            window.location.href = 'product-1.0.0/shop.html';
        }
    </script>
</body>
</html>
