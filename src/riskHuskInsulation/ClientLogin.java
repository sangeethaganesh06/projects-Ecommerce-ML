package riskHuskInsulation;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ClientLogin")
public class ClientLogin extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String usernameEmail = request.getParameter("usernameEmail");
        String password = request.getParameter("password");

        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.jdbc.Driver");

            // Establish a connection
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ricehuskinsulation", "root", "root");
            // Create a SQL SELECT statement to check the credentials
            String sql = "SELECT userId FROM users WHERE (username = ? OR email = ?) AND password = ?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, usernameEmail);
            statement.setString(2, usernameEmail);
            statement.setString(3, password);

            // Execute the query
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                // If credentials are valid, get the userId
                String userId = resultSet.getString("userId");

                // Store the userId in the session
             
                // Redirect to the productlistout.jsp file
            	response.getWriter().print("<html><body><script>alert('User login successful');</script></body></html>");
            	   HttpSession session = request.getSession();
                   session.setAttribute("userId", userId);
                   session.setAttribute("userName", usernameEmail);
                   RequestDispatcher dispatcher = request.getRequestDispatcher("product-list.jsp");

                   dispatcher.include(request, response);
            } else {
                // If credentials are invalid, redirect to login page with an error message
            	response.getWriter().print("<html><body><script>alert(' Invalid user credentials');</script></body></html>");
            	 RequestDispatcher dispatcher = request.getRequestDispatcher("index.html");

                 dispatcher.include(request, response);
            	
              
            }

            // Close the connection
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("An error occurred while processing the login request.");
        }
    }
}

