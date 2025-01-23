package riskHuskInsulation;

		import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.servlet.ServletException;
		import javax.servlet.annotation.WebServlet;
		import javax.servlet.http.HttpServlet;
		import javax.servlet.http.HttpServletRequest;
		import javax.servlet.http.HttpServletResponse;


import com.mysql.jdbc.PreparedStatement;
import com.mysql.jdbc.ResultSet;

		@WebServlet("/DeleteAccess")
		public class DeleteAccess extends HttpServlet {
		    private static final long serialVersionUID = 1L;

		    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		        doPost(request, response);
		    }

		    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		        // JDBC connection parameters
		        String jdbcUrl = "jdbc:mysql://localhost:3306/ricehuskinsulation";
		        String dbUser = "root";
		        String dbPassword = "root";

		        java.sql.Connection conn = null;
		       
		        ResultSet rs = null;

		        try {
		            // Establish connection to database
		            try {
						Class.forName("com.mysql.jdbc.Driver");
					} catch (ClassNotFoundException e2) {
						// TODO Auto-generated catch block
						e2.printStackTrace();
					}
		            try {
						conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
					} catch (SQLException e1) {
						// TODO Auto-generated catch block
						e1.printStackTrace();
					}
		           
		            String empId = request.getParameter("empId");
		           String dest = request.getParameter("role");
		            String deleteQuery = "DELETE FROM "+dest+" WHERE emp_id = ?";
		            PreparedStatement ps = null;
					try {
						ps = (PreparedStatement) conn.prepareStatement(deleteQuery);
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
		           try {
					ps .setString(1, empId);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		            try {
		            	
		            	PrintWriter ou = response.getWriter();
		            
		            	int rs11 = ps.executeUpdate();
		            	if(rs11>0){
		            		ou.print("<html><body><script>alert('Employee registration denied succesfully');</script></body></html>");
		            		
		            	}
		            	else {
		            		ou.print("<html><body><script>alert('Delete Unsuccessful');</script></body></html>");	
		            		
		            	}
		            	}catch(Exception e3){
		            		e3.printStackTrace();
		            	}
		        }finally {
		            try {
		                if (rs != null) rs.close();
		              
		                if (conn != null) conn.close();
		            } catch (SQLException se) {
		                se.printStackTrace();
		            }
		        }
	}

}
