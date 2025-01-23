package riskHuskInsulation;

import java.io.IOException;
import java.sql.DriverManager;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;

@WebServlet("/RefurbishmentproductApproval")
public class RefurbishmentproductApproval extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Database connection parameters
	    String jdbcURL = "jdbc:mysql://localhost:3306/ricehuskinsulation";
	    String jdbcUsername = "root";
	    String jdbcPassword = "root";
	    Connection connection = null;
	    PreparedStatement pstmt = null;
	    
	    try {
	        // Load JDBC driver
	        Class.forName("com.mysql.jdbc.Driver");
	        connection = (Connection) DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
	        
	        // Get the action and ProductID from the request
	        String action = request.getParameter("action");
	        int productID = Integer.parseInt(request.getParameter("ProductID"));

	        // SQL statement based on action
	        String sql = "";
	        if ("approve".equals(action)) {
	        	 response.getWriter().println("<html><body><script>alert('Refurbished product approved successfully');</script></body></html>");
	             RequestDispatcher dispatcher = request.getRequestDispatcher("AdminApproveRefurbishedProduct.jsp");
	             dispatcher.include(request, response);
	            sql = "UPDATE refurbishedinsulationpanels SET Status1 = 'approved' WHERE ProductID = ?";
	        } else if ("deny".equals(action)) {
	        	 response.getWriter().println("<html><body><script>alert('Refurbished product denied successfully');</script></body></html>");
	             RequestDispatcher dispatcher = request.getRequestDispatcher("AdminApproveRefurbishedProduct.jsp");
	             dispatcher.include(request, response);
	            sql = "UPDATE refurbishedinsulationpanels SET Status1 = 'not approved' WHERE ProductID = ?";
	        }

	        pstmt = (PreparedStatement) connection.prepareStatement(sql);
	        pstmt.setInt(1, productID);
	        pstmt.executeUpdate();
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        // Clean up resources
	        try {
	            if (pstmt != null) pstmt.close();
	            if (connection != null) connection.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	}

}
