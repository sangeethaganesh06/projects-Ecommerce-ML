package riskHuskInsulation;

import java.io.IOException;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SubmitReportByResource")
public class SubmitReportByResource extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String orderId = request.getParameter("orderId");
        if (orderId != null && !orderId.isEmpty()) {
            // Database connection details
            final String jdbcUrl = "jdbc:mysql://localhost:3306/ricehuskinsulation";
            final String dbUser = "root";
            final String dbPassword = "root";

            java.sql.Connection conn = null;
            java.sql.PreparedStatement stmtProducts = null;
            java.sql.PreparedStatement stmtReport = null;
            java.sql.ResultSet rsProducts = null;

            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

                // Set to store unique Orderno
                Set<Integer> uniqueOrdernos = new HashSet<>();

                // Query to retrieve products in the order
                String sqlProducts = "SELECT om.Orderno, pc.ProductID, pc.ProductName, om.quantity, pc.`Thickness(mm)`, pc.density, " +
                                     "pc.`BinderType`, pc.`binder_amount(kg)` " +
                                     "FROM product_catalog pc " +
                                     "INNER JOIN orders o ON pc.ProductID = o.productid " +
                                     "INNER JOIN ordermanagement om ON o.orderId = om.orderId " +
                                     "WHERE o.orderId = ? ORDER BY om.Orderno";

                stmtProducts = conn.prepareStatement(sqlProducts);
                stmtProducts.setString(1, orderId);
                rsProducts = stmtProducts.executeQuery();

                // Insert report into the Material_analysis-report table
                String sqlReport = "INSERT INTO `material_analysis-report` (OrderID, TotalWeight, volume, Binder_TYPE, Binder_Amount,ProductId,ProductName) " +
                                   "VALUES (?, ?, ?, ?, ?, ?, ?)";
                stmtReport = conn.prepareStatement(sqlReport);

                double totalWeight = 0;
                double totalVolume = 0;
                int rowsInserted = 0;

                while (rsProducts.next()) {
                    int orderNo = rsProducts.getInt("Orderno");

                    // Skip if Orderno is already processed
                    if (uniqueOrdernos.contains(orderNo)) {
                        continue;
                    }

                    uniqueOrdernos.add(orderNo);

                    String productId = rsProducts.getString("ProductID");
                    String productName = rsProducts.getString("ProductName");
                    int quantity = rsProducts.getInt("quantity");
                    int thicknessMm = rsProducts.getInt("Thickness(mm)");
                    double density = rsProducts.getDouble("density");
                    String binderType = rsProducts.getString("BinderType");
                    double binderAmount = rsProducts.getDouble("binder_amount(kg)");

                    // Convert thickness from mm to meters
                    double thicknessM = thicknessMm / 1000.0;

                    // Calculate volume in cubic meters
                    double volumeCuM = quantity * thicknessM / 1000.0; // Assuming 1 sqft area for simplicity

                    // Calculate weight in kilograms
                    double weightKg = volumeCuM * density;

                    totalWeight += weightKg;
                    totalVolume += volumeCuM;

                    stmtReport.setString(1, orderId);
                    stmtReport.setDouble(2, weightKg);
                    stmtReport.setDouble(3, volumeCuM);
                    stmtReport.setString(4, binderType);
                    stmtReport.setDouble(5, binderAmount);
                    stmtReport.setString(6, productId);
                    stmtReport.setString(7, productName);

                    rowsInserted += stmtReport.executeUpdate();
                }

                if (rowsInserted <= 0) {
                    response.getWriter().print("<html><body><script>alert('Report is not submitted successfully');</script></body></html>");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("ResourceAllocate.jsp");
                    dispatcher.include(request, response);
                } else {
                    response.getWriter().print("<html><body><script>alert('Report submitted successfully to admin');</script></body></html>");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("calculateResource.jsp?orderId =" + orderId);
                    dispatcher.include(request, response);
                }

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if (rsProducts != null) rsProducts.close();
                    if (stmtProducts != null) stmtProducts.close();
                    if (stmtReport != null) stmtReport.close();
                    if (conn != null) conn.close();
                } catch (SQLException se) {
                    se.printStackTrace();
                }
            }
        }
    }
}
