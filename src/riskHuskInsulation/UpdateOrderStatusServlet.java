package riskHuskInsulation;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Properties;

@WebServlet("/UpdateOrderStatusServlet")
public class UpdateOrderStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderId = request.getParameter("orderId");
        String action = request.getParameter("action");
        String productname = request.getParameter("productname");

        if (orderId != null && !orderId.isEmpty() && action != null && !action.isEmpty()) {
            updateOrderStatus(orderId, action, productname, request, response);
        } else {
            response.getWriter().print("<html><body><script>alert('Credentials missed');</script></body></html>");
            RequestDispatcher rd = request.getRequestDispatcher("OrderManagement.jsp");
            rd.include(request, response);
            return; // Early return to prevent further execution
        }

        if ("accept".equals(action)) {
            response.getWriter().print("<html><body><script>alert('Order Accepted');</script></body></html>");
        } else {
            response.getWriter().print("<html><body><script>alert('Order Denied and the user notified through email');</script></body></html>");
        }
        RequestDispatcher rd = request.getRequestDispatcher("OrderManagement.jsp");
        rd.include(request, response);
    }

    private void updateOrderStatus(String orderId, String action, String productname, HttpServletRequest request, HttpServletResponse response) throws IOException {
        final String jdbcUrl = "jdbc:mysql://localhost:3306/ricehuskinsulation";
        final String dbUser = "root";
        final String dbPassword = "root";

        try {
            // Load the JDBC driver
            Class.forName("com.mysql.jdbc.Driver");

            try (Connection conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword)) {
                String sql = "UPDATE orders SET Status = ? WHERE orderId = ? AND productname = ?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, action.equals("accept") ? "accept" : "deny");
                    stmt.setString(2, orderId);
                    stmt.setString(3, productname);
                    stmt.executeUpdate();

                    // If status is 'deny', send an email
                    if ("deny".equals(action)) {
                        sendEmail(conn, request, response);
                    }
                }
            }
        } catch (ClassNotFoundException e) {
            System.out.println("MySQL JDBC Driver not found.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("Connection failed.");
            e.printStackTrace();
        }
    }

    private void sendEmail(Connection conn, HttpServletRequest request, HttpServletResponse response) throws IOException {
        final String jdbcUrl = "jdbc:mysql://localhost:3306/ricehuskinsulation";
        final String dbUser = "root";
        final String dbPassword = "root";
        
        try {
            // Retrieve user email
            String orderId = request.getParameter("orderId");
            String emailQuery = "SELECT userId FROM orders WHERE orderId = ?";
            String userId = "";
            
            try (PreparedStatement emailStmt = conn.prepareStatement(emailQuery)) {
                emailStmt.setString(1, orderId);
                ResultSet emailRs = emailStmt.executeQuery();
                if (emailRs.next()) {
                    userId = emailRs.getString("userId");
                }
            }
            
            String userEmailQuery = "SELECT email FROM users WHERE userId = ?";
            String userEmail = "";

            try (PreparedStatement userEmailStmt = conn.prepareStatement(userEmailQuery)) {
                userEmailStmt.setString(1, userId);
                ResultSet emailRs = userEmailStmt.executeQuery();
                if (emailRs.next()) {
                    userEmail = emailRs.getString("email");
                }
            }

            // Email setup
            final String username = "sangeethamathim.surya@gmail.com"; // Replace with your email
            final String password = "nhfhwbucoelkdhgt"; // Replace with your email password

            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", "smtp.gmail.com"); // Replace with your SMTP server
            props.put("mail.smtp.port", "587");

            Session mailSession = Session.getInstance(props,
                new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(username, password);
                    }
                });

            try {
                Message message = new MimeMessage(mailSession);
                message.setFrom(new InternetAddress("your-email@example.com")); // Replace with your email
                message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(userEmail));
                message.setSubject("Order Status Update");
                message.setText("Dear User,\n\nYour order has been denied. Please contact support for further assistance.\n\nBest regards,\n Eco-Shield: rice husk insulation");

                Transport.send(message);
                response.getWriter().print("<html><body><script>alert('Order Denied and the user notified through email');</script></body></html>");
                System.out.println("Email sent successfully to " + userEmail);
            } catch (MessagingException e) {
                throw new RuntimeException(e);
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving email.");
            e.printStackTrace();
        }
    }
}
