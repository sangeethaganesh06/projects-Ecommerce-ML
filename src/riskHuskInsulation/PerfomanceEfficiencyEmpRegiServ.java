package riskHuskInsulation;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class PerfomanceEfficiencyEmpRegiServ
 */
@WebServlet("/PerfomanceEfficiencyEmpRegiServ")
public class PerfomanceEfficiencyEmpRegiServ extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String firstName = request.getParameter("name");
        String age = request.getParameter("Age");
        String email = request.getParameter("email");
       String phoneNo = request.getParameter("phone");
        String gender = request.getParameter("gender");
        String EmpId = generateRandomEmp(5);
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String country = request.getParameter("country");
        String dateOfBirthStr = request.getParameter("Date"); // mm/dd/yyyy format
        // Convert date of birth to yyyy/MM/dd format
        String dateOfBirth = convertDate(dateOfBirthStr);
        // Generate a random password
        String password = generateRandomPassword(6);
System.out.println(EmpId);
       
        final String jdbcUrl = "jdbc:mysql://localhost:3306/ricehuskinsulation";
        final String dbUser = "root";
        final String dbPassword = "root";

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // Register JDBC driver
            Class.forName("com.mysql.jdbc.Driver");
           
            // Open a connection
            conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

            // SQL query to insert data
            String sql = "INSERT INTO performance_efficiency (name, city, email,phone, gender, Age, state, address, country, dob,emp_id,password) "
                       + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?)";

            // Create prepared statement
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, firstName);
            stmt.setString(2, city);
            stmt.setString(3, email);
            stmt.setString(4, phoneNo);
            stmt.setString(5, gender );
            stmt.setString(6, age);
            stmt.setString(7, state );
            stmt.setString(8, address );
            stmt.setString(9, country );
            stmt.setString(10, dateOfBirth);
            stmt.setString(11,EmpId ); // Handle potential null value
            stmt.setString(12,password );
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {

                response.getWriter().print("<html><body><script>alert('Performance Analyst registered successfully ');</script></body></html>");
				RequestDispatcher rs1 = request.getRequestDispatcher("index.html");
				rs1.include(request, response); 
            } else {
            	  response.getWriter().print("<html><body><script>alert(' Performance Analyst invalid registered');</script></body></html>");
  				RequestDispatcher rs1 = request.getRequestDispatcher("EmpLogIn-PerformanceEfficiency.html");
  				rs1.include(request, response); 
            }

        } catch (ClassNotFoundException | SQLException e) {
            // Handle errors
            e.printStackTrace();
        } finally {
            // Close resources
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
    }

    private String convertDate(String inputDate) {
        SimpleDateFormat inputFormat = new SimpleDateFormat("MM/dd/yyyy");
        SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy/MM/dd");

        try {
            Date date = inputFormat.parse(inputDate);
            return outputFormat.format(date);
        } catch (ParseException e) {
            e.printStackTrace();
            return null; // Return null or handle the error as needed
        }
    
} private String generateRandomPassword(int length) {
    String charSet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    String empId="1234567890-";
    StringBuilder password = new StringBuilder();
    StringBuilder EmpId = new StringBuilder();
    Random random = new Random();
    for (int i = 0; i < length; i++) {
        int index = random.nextInt(charSet.length());
        password.append(charSet.charAt(index));
    }
    for (int i = 0; i < length; i++) {
        int index1 = random.nextInt(empId.length());
        EmpId.append(charSet.charAt(index1));
    }
    return password.toString();
}
private String generateRandomEmp(int length) {
	 String str1="";
    String empId="1234567890-";
   
    StringBuilder EmpId = new StringBuilder();
    Random random = new Random();
    for (int i = 0; i < length; i++) {
        int index1 = random.nextInt(empId.length());
       
     StringBuilder str=  EmpId.append(empId.charAt(index1));
     str1 ="emp-"+ str;
        
    }
    return str1;
}
	}

