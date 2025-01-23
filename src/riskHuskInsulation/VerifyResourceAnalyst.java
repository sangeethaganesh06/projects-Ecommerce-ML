package riskHuskInsulation;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/VerifyResourceAnalyst")
public class VerifyResourceAnalyst extends HttpServlet {
	private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("Username");
        String password = request.getParameter("password");

        // Database credentials
        final String jdbcUrl = "jdbc:mysql://localhost:3306/ricehuskinsulation";
        final String dbUser = "root";
        final String dbPassword = "root";

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

            String sql = "SELECT * FROM resource_analyst WHERE name = ? AND password = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            rs = stmt.executeQuery();


            if (rs.next()) {
                // Credentials are correct, forward to designSupport.jsp
            	response.getWriter().print("<html><body><script>alert('Resource analyst login successfully');</script></body></html>");
                RequestDispatcher dispatcher = request.getRequestDispatcher("ResourceAnalystPage.html");
                dispatcher.include(request, response);
            } else {
                // Credentials are incorrect, redirect back to login page with error message
            	response.getWriter().print("<html><body><script>alert('Resource analyst login invalid ');</script></body></html>");
                RequestDispatcher dispatcher = request.getRequestDispatcher("EmpLogIn-ResourceAnalyst.html");
                dispatcher.include(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
