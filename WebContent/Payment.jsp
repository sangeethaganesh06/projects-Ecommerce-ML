<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.io.*"%>

<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.PreparedStatement" %> 
<%@ page import="java.sql.Blob" %>
<%@ page import="java.util.Random" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="keywords" content="Credit Card Validation Form Responsive, Login Form Web Template, Flat Pricing Tables, Flat Drop-Downs, Sign-Up Web Templates, Flat Web Templates, Login Sign-up Responsive Web Template, Smartphone Compatible Web Template, Free Web Designs for Nokia, Samsung, LG, Sony Ericsson, Motorola Web Design" />
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
<link rel="stylesheet" href="amount/css/bootstrap.css"	type="text/css" media="all">
<link rel="stylesheet" href="amount/css/style.css" 	type="text/css" media="all">
<link rel="stylesheet" href="//fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900" type="text/css" media="all">
<link rel="stylesheet" href="//fonts.googleapis.com/css?family=Montserrat:400,700"			   type="text/css" media="all">
<title>Payment Field</title>
<style type="text/css">
.center {
    border: 2px solid #007BFF;
    font-weight: 600;
    display: inline-block;
    font-size: 16px;
 	color: #007BFF;
  	background: transparent;
    text-align: center;
    padding: 12px 18px;
    margin-top: 2em;
    box-shadow: none;
    text-decoration: none;
    border-radius: 5px;
    cursor: pointer;
    border: none;
}
.button-container {
    display: flex;
    justify-content: space-between; 
    margin-top: 20px; 
}

.button-container .btn {
    width: 45%; /* Adjust width as needed */
}

.transparent-bg {
    background: transparent;
}
button.center {
    border: none;
}
body {
    margin: 0;  
     font-family: Arial, sans-serif;
    }
	/*.wrap {
		max-width: 980px;
		margin: 10px auto 0;
	}*/
	#steps {
		margin: 80px 0 0 0;
	}
	.commands {
		overflow: hidden;
		margin-top: 30px;
	}
	.prev {
		float:left
	}

	.error {
		color: #FFC107;
	}
	.next, .submit {
		float:right
	}
	#progress {
		position: relative;
		height: 5px;
		background-color: #eee;
		margin-bottom: 50px;
	}
	#progress-complete {
		border: 0;
		position: absolute;
		height: 5px;
		min-width: 10px;
		background-color: #F44336;
		transition: width .2s ease-in-out;
	}
	
	.containerw3layouts-agileits {
    margin-top: 2em; 
            max-width: 600px; 
            margin-left: auto;
            margin-right: auto;
}
 .form-group label {
            margin-bottom: 0.5em; 
            display: block; 
        }

 .form-control {
            width: 100%;
            box-sizing: border-box; 
        }

        .form-group .col-sm-10 {
            padding-left: 0;
        }
	 @media screen and (max-width: 768px) {
            .containerw3layouts-agileits {
                width: 90%; 
            }
	}
		.btn-cancel {
    margin-right: 70px; /* Adjust spacing between buttons */
}
        .button {
  padding: 1em 2em;
  border: none;
  border-radius: 5px;
  font-weight: bold;
  letter-spacing: 5px;
  text-transform: uppercase;
  cursor: pointer;
  color: #2c6bafe8;
  transition: all 1000ms;
  font-size: 15px;
  position: relative;
  overflow: hidden;
  outline: 2px solid #2c6bafe8;
  margin-right: 60%;
  margin-top: 10%;
}

button:hover {
  color: #ffffff;
  transform: scale(1.1);
  outline: 2px solid #70bdca;
  box-shadow: 4px 5px 17px -4px #2c6bafe8;
  
}

button::before {
  content: "";
  position: absolute;
  left: -50px;
  top: 0;
  width: 0;
  height: 100%;
  background-color: #2c6bafe8;
  transform: skewX(45deg);
  z-index: -1;
  transition: width 1000ms;
  
}

button:hover::before {
  width: 200%;
}
</style>


</head>
<body>
<%


double totalCost =  Double.parseDouble(session.getAttribute("totalamount").toString());
String userId = (String)session.getAttribute("userId");
String orderid=(String)session.getAttribute("orderId");

session.setAttribute("totalCost",totalCost);
session.setAttribute("userId",userId);
session.setAttribute("orderId",orderid);
String orderId = session.getAttribute("orderId").toString(); 
%>>
  <button class="button"  onclick="window.location.href='deleteOrder.jsp?orderId=<%=orderId %> '" >BACK</button>
<h1>PAYMENT DETAILS</h1>

		<div class="containerw3layouts-agileits">
		<form action="PaymentOrder" method="post" id="Payment" action="PaymentOrder">

				<fieldset>
					<legend>Account Details :</legend>
					<div class="form-group agileinfo">
						<label for="Name">Name</label>
						<input id="Name" name="name" type="text"  autocomplete="off" pattern="[A-Za-z .]+" class="form-control" placeholder="Name" required>
					</div>
				
					<div class="form-group">
						<label for="CardNumber"  >Card Number</label>
						
							<input id="CardNumber" type="text" class="form-control" autocomplete="off" name="cardnumber" pattern="[0-9]{16}" title="Enter 16 digit number" placeholder="Card Number" required>
					</div>
		
<div class="form-group">
    <label for="Expiration" class="control-label">Expiration</label>
    <input id="Expiration" type="text" name="expiration" autocomplete="off" class="form-control" pattern="(0[1-9]|1[0-2])\/(20[2-3][0-9])" placeholder="MM / YYYY" required>
</div>

					<div class="form-group"><br>
						<label for="cvv" class="col-sm-2 agileits-w3layouts control-label">CVV</label>
							<input id="cvv" type="password" pattern="[0-9]{3}" autocomplete="off" title="Enter 3 digit number" placeholder="CVV Number" required class="form-control">
						</div>
		<div>			
<div class="form-group ">
    <label for="CardNumber">Total Amount </label>
    <input id="TotalAmount" type="text" style=" background: transparent;" class="form-control custom-input transparent-bg" value=" <%= "Rs. " + session.getAttribute("totalamount") %>" readonly>
</div>

</div>

        <div class="center" >
    <a href="cart.jsp" class="btn btn-primary custom-btn" style="border: none; margin-right: 100px;">Cancel</a>
    <input type="submit" value="Pay Amount" class="btn btn-primary custom-btn" style="border: none; margin-left: 290px;">
</div>
</fieldset>
</form>
</div>
<script>
document.getElementById('CreditcardMonth').addEventListener('input', function() {
    var month = parseInt(this.value);
    if (isNaN(month) || month < 1 || month > 12) {
        this.setCustomValidity('Please enter a valid month (1-12).');
    } else {
        this.setCustomValidity('');
    }
});

document.getElementById('CreditcardYear').addEventListener('input', function() {
    var year = parseInt(this.value);
    if (isNaN(year) || year < 2024 || year > 2034) {
        this.setCustomValidity('Please enter a valid year (2024-2034).');
    } else {
        this.setCustomValidity('');
    }
});
</script>
</body>
</html>