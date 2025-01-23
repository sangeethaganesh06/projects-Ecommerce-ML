package riskHuskInsulation;

import java.io.*;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;

@WebServlet("/ContinueShoppingServlet")
public class ContinueShoppingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // Generate random 5-digit order ID
    static String orderId = generateOrderId();
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<Product> cart = (List<Product>) session.getAttribute("cart");
        String userId = (String) session.getAttribute("userId"); 
       String formattedtotalCost="";
        // Calculate total cost based on user input
        double totalCost = 0.0;
        for (Product product : cart) {
            // Retrieve sqftParam for each product
            String sqftParam = request.getParameter("sqft_" + product.getProductId());
            if (sqftParam != null && !sqftParam.isEmpty()) {
                int sqft = Integer.parseInt(sqftParam);
                double costPerUnit = product.getCostPerUnit();
                double productTotalCost = sqft * costPerUnit;
                totalCost += productTotalCost;
                formattedtotalCost = String.format("%.3f", totalCost);
                // Insert order details into orderManagement table
                insertOrderDetails(orderId, product.getProductId(), product.getProductName(), sqft, costPerUnit, productTotalCost, userId);
            }
        }

        // Set total cost in session or request attribute
        session.setAttribute("totalCost", formattedtotalCost);
        session.setAttribute("userId", userId);
        session.setAttribute("orderId", orderId);
        // Forward to continueShopping.jsp
        RequestDispatcher dispatcher = request.getRequestDispatcher("continueShopping.jsp");
        dispatcher.forward(request, response);
    }

    // Method to insert order details into orderManagement table
    private void insertOrderDetails(String orderId, String productId, String productName, int quantity, double costPerUnit, double totalCost, String userId) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // Establish database connection
            conn = getConnection();

            // SQL query to insert order details
            String sql = "INSERT INTO orderManagement (orderId, productId, productName, quantity, costPerUnit, totalCost, userId) VALUES (?, ?, ?, ?, ?, ?, ?)";
            stmt = (PreparedStatement) conn.prepareStatement(sql);
            stmt.setString(1, orderId);
            stmt.setString(2, productId);
            stmt.setString(3, productName);
            stmt.setInt(4, quantity);
            stmt.setDouble(5, costPerUnit);
            stmt.setDouble(6, totalCost);
            stmt.setString(7, userId);

            // Execute the query
            stmt.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            // Handle exceptions appropriately (logging, error messages, etc.)
        } finally {
            // Close resources
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Method to establish database connection
    private Connection getConnection() throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/ricehuskinsulation";
        String username = "root";
        String password = "root";
        return (Connection) DriverManager.getConnection(url, username, password);
    }

    // Method to generate a random 5-digit order ID

    private static String generateOrderId() {
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder orderId = new StringBuilder();
        Random rnd = new Random();
        while (orderId.length() < 10) { // length of the random string.
            int index = (int) (rnd.nextFloat() * characters.length());
            orderId.append(characters.charAt(index));
        }
        return orderId.toString();
    }
}
