package riskHuskInsulation;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/PaymentOrder")
public class PaymentOrder extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the session object
        HttpSession session = request.getSession();

        // Get form parameters
        String name = request.getParameter("name");
        String cardNumber = request.getParameter("cardnumber");
        String expiration = request.getParameter("expiration");
        String cvv = request.getParameter("cvv");

        // Get cart items from the session
        List<Product> cart = (List<Product>) session.getAttribute("cart");

        // Database credentials
        String jdbcURL = "jdbc:mysql://localhost:3306/ricehuskinsulation";
        String jdbcUsername = "root";
        String jdbcPassword = "root";

        // SQL INSERT statement
        String sql = "INSERT INTO orders (orderid, userid, username, productname, productid, amount) VALUES (?, ?, ?, ?, ?, ?)";

        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.jdbc.Driver");

            // Establish a connection to the database
            Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

            // Prepare the SQL statement
            PreparedStatement statement = connection.prepareStatement(sql);

            // Iterate through the cart items and insert each product into the database
            for (Product product : cart) {
            	
                String orderId = (String)session.getAttribute("orderId");
                
                String userId = (String) session.getAttribute("userId");
                String email = (String) session.getAttribute("email");
              
                
                double totalAmount =  Double.parseDouble(session .getAttribute("totalCost").toString());
;
                // Set the parameter values
                statement.setString(1, orderId);
                statement.setString(2, userId);
                statement.setString(3, name);
               
                statement.setString(4, product.getProductName());
                statement.setString(5, product.getProductId());
                statement.setDouble(6, totalAmount);
               
                // Execute the SQL statement
                statement.executeUpdate();
            }

            // Redirect to a success page
         response.getWriter().print("<html><body><script>alert('Order placed successfully');</script></body></html>");
         RequestDispatcher dispatcher = request.getRequestDispatcher("product-list.jsp");
         dispatcher.include(request, response);
         
            // Close the connection
            connection.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            // Redirect to an error page
            response.getWriter().print("<html><body><script>alert('Order placed successfully');</script></body></html>");
            response.sendRedirect("cart.jsp");
        }
    }

   
}
