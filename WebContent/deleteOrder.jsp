<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
<title>Insert title here</title>
</head>
<body>
<%
Connection connection = null;
ResultSet rs = null;

try {
    Class.forName("com.mysql.jdbc.Driver");
    String key = request.getParameter("orderId");
    System.out.println(key);
    connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/ricehuskinsulation", "root", "root");
    String query = "DELETE FROM  ordermanagement WHERE orderId = '" + key + "'";
    PreparedStatement ps = null;
	try {
		ps = (PreparedStatement) connection.prepareStatement(query);
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	  try {
      	
      	
      
      	int rs11 = ps.executeUpdate();
      	if(rs11>0){
      		// response.getWriter().print("<html><body><script>alert('order removed ');</script></body></html>");
      		 RequestDispatcher dispatcher = request.getRequestDispatcher("cart.jsp");

             dispatcher.include(request, response);
      		
      	}
      	else {
      		// response.getWriter().print("<html><body><script>alert('Delete Unsuccessful');</script></body></html>");	
      		
      	}
      	}catch(Exception e3){
      		e3.printStackTrace();
      	}
  }finally {
      try {
          if (rs != null) rs.close();
        
          if (connection != null) connection.close();
      } catch (SQLException se) {
          se.printStackTrace();
      }
  }
%>
</body>
</html>