package riskHuskInsulation;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.Random;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Registeration")
public class ClientRegistration extends HttpServlet {
   
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	System.out.println("entered");
        String username = request.getParameter("usernameReg");
        String password = request.getParameter("passwordReg");
        String email = request.getParameter("emailReg");
        String phone = request.getParameter("phone");
        String userId = generateUserId();

        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.jdbc.Driver");

            // Establish a connection
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ricehuskinsulation", "root", "root");

            // Create a SQL INSERT statement
            String sql = "INSERT INTO users (userId, username, password, email, phone) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, userId);
            statement.setString(2, username);
            statement.setString(3, password);
            statement.setString(4, email);
            statement.setString(5, phone);

            // Execute the statement
            int rowsInserted = statement.executeUpdate();
            if (rowsInserted > 0) {
                response.getWriter().println("<html><body><script>alert('User Registered Successfully');</script></body></html>");
                RequestDispatcher dispatcher = request.getRequestDispatcher("index.html");
                dispatcher.include(request, response);
            }
            
            // Close the connection
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<html><body><script>alert('User Registered not complete');</script></body></html>");
            RequestDispatcher dispatcher = request.getRequestDispatcher("client.html");
            dispatcher.include(request, response);
        }
    }
    
 private static final long serialVersionUID = 1L;
    
    // Method to generate random alphanumeric userId
    private String generateUserId() {
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*";
        StringBuilder userId = new StringBuilder();
        Random rnd = new Random();
        while (userId.length() < 10) { // length of the random string.
            int index = (int) (rnd.nextFloat() * characters.length());
            userId.append(characters.charAt(index));
        }
        return userId.toString();
    }
}
