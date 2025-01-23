package riskHuskInsulation;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/EmployeeApprovalServlet")
public class EmployeeApprovalServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int employeeId = Integer.parseInt(request.getParameter("employeeId"));
        String password = generateRandomPassword();

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/insulation_db", "root", "password");
            PreparedStatement ps = con.prepareStatement("UPDATE employees SET status_id = (SELECT status_id FROM statuses WHERE status_name = 'Approved'), password = ? WHERE employee_id = ?");
            ps.setString(1, password);
            ps.setInt(2, employeeId);
            ps.executeUpdate();

            // Fetch email to send the password
            ps = con.prepareStatement("SELECT email FROM employees WHERE employee_id = ?");
            ps.setInt(1, employeeId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String email = rs.getString("email");
                sendEmail(email, password); // Implement sendEmail method to send the password via email
            }

            response.sendRedirect("adminDashboard.jsp?approval=success");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private String generateRandomPassword() {
        return java.util.UUID.randomUUID().toString().substring(0, 8);
    }

    private void sendEmail(String email, String password) {
        // Implement email sending functionality here
    }
}
