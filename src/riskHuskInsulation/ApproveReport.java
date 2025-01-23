package riskHuskInsulation; // Adjust package name as per your project structure

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.mail.Session;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ApproveReport")
public class ApproveReport extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Handle GET request, or redirect to POST handler if appropriate
        response.getWriter().write("GET method is not supported for this endpoint.");
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	HttpSession session = request.getSession();

        String orderId = session.getAttribute("OrderID").toString();
        System.out.println(orderId);
       
        if (orderId != null && !orderId.isEmpty()) {
            // Database connection details
            final String jdbcUrl = "jdbc:mysql://localhost:3306/ricehuskinsulation"; // Update with your database URL
            final String dbUser = "root"; // Update with your database username
            final String dbPassword = "root"; // Update with your database password

            Connection conn = null;
            PreparedStatement stmt = null;

            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

                // SQL query to update the Status column to "Approved"
                String sql = "UPDATE `material_analysis-report` SET Status1 = 'Approved' WHERE OrderID = ? and  Status1 IS NULL OR Status1 != 'approved'";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, orderId);

                int rowsUpdated = stmt.executeUpdate();

                if (rowsUpdated > 0) {
                    // Send a success response
                	 response.getWriter().print("<html><body><script>alert('Report Approved Successfully');</script></body></html>");
                     
                     RequestDispatcher dispatcher = request.getRequestDispatcher("SubmitReportToAdmin.jsp");

                     dispatcher.include(request, response);

                } else {
                    // Send a failure response
                	 response.getWriter().print("<html><body><script>alert('Repoer not Approved');</script></body></html>");
                     
                     RequestDispatcher dispatcher = request.getRequestDispatcher("SubmitReportToAdmin.jsp");

                     dispatcher.include(request, response);

                }

            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
                response.getWriter().write("Error: " + e.getMessage());
            } finally {
                try {
                    if (stmt != null) {
                        stmt.close();
                    }
                    if (conn != null) {
                        conn.close();
                    }
                } catch (SQLException se) {
                    se.printStackTrace();
                }
            }
        } else {
            response.getWriter().write("Invalid parameters");
        }
    }
}
