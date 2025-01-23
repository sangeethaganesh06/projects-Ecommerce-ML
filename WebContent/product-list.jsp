<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Base64" %>
<%@ page import="java.io.InputStream" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="author" content="Untree.co">
  <link rel="shortcut icon" href="favicon.png">

  <meta name="description" content="" />
  <meta name="keywords" content="bootstrap, bootstrap4" />

		<!-- Bootstrap CSS -->
		<link href="product-1.0.0/css/bootstrap.min.css" rel="stylesheet">
		<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/product-1.0.0/css/all.min.css" rel="stylesheet">
		<link href="product-1.0.0/css/tiny-slider.css" rel="stylesheet">
		<link href="product-1.0.0/css/style.css" rel="stylesheet">
		<title>Ricehusk insulation</title>
		
		<style>
		.btn {
  width: 10rem;
  height: 3rem;
  border-radius: 1 rem;
  box-shadow: $shadow;
  justify-self: center;
  display: flex;
  align-items: right;
  justify-content: right;
  cursor: pointer;
  transition: .3s ease;


  &__secondary {
    grid-column: 1 / 3;
    grid-row: 5 / 6;
    color: green;
    &:hover { color: green; }
    &:active {
      box-shadow: green;
    }
  }

  p { 
    font-size: 1.6rem;
  }
}
 .button-container {
      display: flex;
      justify-content: space-between;
      margin-top: 10px;
    }

    .button-container .btn {
      flex: 1;
      margin: 0 10px;
      }
      .nav-link.active {
  background-color: #4CAF50; /* Green background */
  color: white; /* White text color */
  font-weight: bold; /* Make the text bold */
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
            margin-left: 30%;
        }
        .btn-animated:hover {
            transform: scale(1.1);
        }
        .btn-animated:active {
            transform: scale(1);
        }

		</style>
	</head>
	
	<!-- Start Header/Navigation -->\
	
		<nav class="custom-navbar navbar navbar navbar-expand-md navbar-dark bg-dark" arial-label="Furni navigation bar">

			<div class="container">
	<%  HttpSession session1 = request.getSession();
    String userId = (String) session1.getAttribute("userId");
    session.setAttribute("userId", userId);
    String userName = (String) session1.getAttribute("userName");
    
    { %>
    	<a class="navbar-brand" href="index.html"><span><%out.println(" WELCOME " +" "+ userName.toUpperCase()); %></span></a>   
       
  <%   } %>
				

				<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarsFurni" aria-controls="navbarsFurni" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>

				<div class="collapse navbar-collapse" id="navbarsFurni">
					      <ul class="custom-navbar-nav navbar-nav ms-auto mb-2 mb-md-0">
       

        <li class="nav-item"><a class="nav-link" href="customerorder.jsp" id="order-nav">Order Management</a></li>      
        <li class="nav-item"><a class="nav-link" href="cart.jsp" id="cart-nav"><img src="product-1.0.0/images/cart.svg" alt="Cart"></a></li>
        <li class="nav-item"><a class="nav-link" href="index.html" id="logout-nav">Log out</a></li>
      </ul>
					

			
				</div>
			</div>
				
		</nav>
		<!-- End Header/Navigation -->
		
		
		
		
		
	
		 <%
		
		
                            Connection connection = null;
                            Statement statement = null;
                            ResultSet resultSet = null;
                            try {
                                Class.forName("com.mysql.jdbc.Driver");
                                connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/ricehuskinsulation", "root", "root");
                                String query = "SELECT * FROM product_catalog";
                                statement = connection.createStatement();
                                resultSet = statement.executeQuery(query);%>
                                
                            	<div class="untree_co-section product-section before-footer-section">
                    		    <div class="container">
                    		      	<div class="row">
                            
                            
                            <%     while (resultSet.next()) {
                                    String productId = resultSet.getString("ProductID");
                                    String productName = resultSet.getString("ProductName");
                                   
                                    float costPerUnit = resultSet.getFloat("CostPerUnit");
                                    
                                    String image = resultSet.getString("Image");
                        %>
		
		<div class="col-12 col-md-4 col-lg-3 mb-5">
						<a class="product-item" href="#">
							<img src="<%= image %>" alt="<%= productId %>"class="img-fluid">
							<h3 class="product-title"><%= productName %></h3>
							<strong class="product-price"><%="Price: Rs."+ costPerUnit %></strong>
                            <div class ="button-container">
							
   
   <button class="btn-animated" style="background-color:green " onclick="window.location.href='CartServlet?productId=<%= productId %>&productName=<%= productName %>&costPerUnit=<%= costPerUnit %> &userId=<%=userId %>'">
   Add Cart</button></div>
							<span class="icon-cross">
								<img src="product-1.0.0/images/cross.svg" class="img-fluid" onclick="window.location.href='productTable.jsp?productId=<%= productId %>'">
							</span>
						</a>
					</div>
		
		
		 <%
                                }
                            
                            %>
                            </div></div></div>
                            <% } catch (Exception e) {
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
		
			

		<script src="product-1.0.0/js/bootstrap.bundle.min.js"></script>
		<script src="product-1.0.0/js/tiny-slider.js"></script>
		<script src="product-1.0.0/js/custom.js"></script>
		<script type="text/javascript">
		
		<script>
		  document.addEventListener('DOMContentLoaded', function() {
		    // Get the current page URL
		    var currentUrl = window.location.pathname.split('/').pop();

		    // Get all navigation links
		    var navLinks = document.querySelectorAll('.nav-link');

		    // Loop through each navigation link
		    navLinks.forEach(function(link) {
		      // Get the href attribute of the link
		      var href = link.getAttribute('href').split('/').pop();

		      // Check if the href matches the current page URL
		      if (currentUrl === href) {
		        // Add 'active' class to the matched link
		        link.classList.add('active');
		      }
		    });
		  });
		</script>

		</script>
	</body>

</html>
		
		
		
		
		
		
		
		