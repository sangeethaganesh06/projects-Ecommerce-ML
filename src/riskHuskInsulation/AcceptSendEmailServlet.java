package riskHuskInsulation;

import java.io.IOException;
import java.sql.DriverManager;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mysql.jdbc.PreparedStatement;

@WebServlet("/SendEmailServlet")
public class AcceptSendEmailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
     
    	String empId = request.getParameter("empId");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String dest = request.getParameter("role");
    
        // Update employee status in the database
        final String jdbcUrl = "jdbc:mysql://localhost:3306/ricehuskinsulation";
        final String dbUser = "root";
        final String dbPassword = "root";

        java.sql.Connection conn = null;
        PreparedStatement stmt = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
            String updateStatusSql =" ";
        	if (dest==" performance_efficiency") {
        		 updateStatusSql = "UPDATE  " +dest+" SET Status = 'approved' WHERE emp_id = ?";
        		
        	}
        	else {
             updateStatusSql = "UPDATE  " +dest+" SET Status1 = 'approved' WHERE emp_id = ?";
        	}
            stmt = (PreparedStatement) conn.prepareStatement(updateStatusSql);
            stmt.setString(1, empId);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

   // Email settings
        String host = "smtp.gmail.com";
        final String username = "sangeethamathim.surya@gmail.com"; // Your email
        final String emailPassword = "nhfhwbucoelkdhgt"; // Your app password

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, emailPassword);
            }
        });

        session.setDebug(true); // Enable debug output

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
            message.setSubject("Employee Registration Details");
            message.setText("Dear Employee,\n\n" +
                    "Your registration was successful. Here are your credentials:\n\n" +
                    "Employee ID: " + empId + "\n" +
                    "Password: " + password + "\n\n" +
                    "Please keep this information secure.\n\n" +
                    "Best Regards,\n" +
                    "Eco-Shield: rice husk insulation");

            Transport.send(message);

            response.getWriter().print("<html><body><script>alert('Successfully accept the registration request and notified to the employee');</script></body></html>");
       
            RequestDispatcher dispatcher = request.getRequestDispatcher("adminPage.html");

            dispatcher.include(request, response);

            
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }
}
