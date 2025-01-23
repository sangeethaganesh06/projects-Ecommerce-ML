package riskHuskInsulation;

import java.io.FileWriter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/handleProductAction")
public class handleProductAction extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productID = request.getParameter("productID");
        String action = request.getParameter("action");

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/ricehuskinsulation", "root", "root");

            String sql = "";
            if ("Approve".equals(action)) {
                sql = "UPDATE Designed_product SET status1 = 'Approved' WHERE ProductID = ?";
            } else if ("Deny".equals(action)) {
                sql = "DELETE FROM Designed_product WHERE ProductID = ?";
            }

            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, productID);
            int rowsUpdated = preparedStatement.executeUpdate();

            if (rowsUpdated > 0) {
                if ("Approve".equals(action)) {
                // Send a success response
      response.getWriter().print("<html><body><script>alert('Add this Product to Client Portal? ');</script></body></html>");
               
      // Append product details to CSV file
                  appendProductDetailsToCSV(productID);
                  response.getWriter().print("<html><body><script>alert('Product added Successfully');</script></body></html>");
                } else if ("Deny".equals(action)) {
                    response.getWriter().print("<html><body><script>alert('Product Deleted Successfully');</script></body></html>");
                }

                RequestDispatcher dispatcher = request.getRequestDispatcher("SubmitProductToAdmin.jsp");
                dispatcher.include(request, response);

            } else {
                // Send a failure response
                response.getWriter().print("<html><body><script>alert('Product not found');</script></body></html>");
                RequestDispatcher dispatcher = request.getRequestDispatcher("SubmitProductToAdmin.jsp");
                dispatcher.include(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().print("<html><body><script>alert('Error processing action');</script></body></html>");
        } finally {
            if (preparedStatement != null) {
                try {
                    preparedStatement.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    private void appendProductDetailsToCSV(String productID) throws SQLException, IOException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        FileWriter csvWriter = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/ricehuskinsulation", "root", "root");

            String sql = "SELECT * FROM Designed_product WHERE ProductID = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, productID);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                String csvFilePath = "D:/project-1/riskHuskInsulation/CSV Files/product-11set - Sheet1.csv"; // Specify the path to your CSV file
                csvWriter = new FileWriter(csvFilePath, true); // true to append to the existing file

                csvWriter.append(resultSet.getString("ProductID")).append(",");
                csvWriter.append(resultSet.getString("ProductName")).append(",");
                csvWriter.append(String.valueOf(resultSet.getInt("Thickness(mm)"))).append(",");
                csvWriter.append(resultSet.getString("Description")).append(",");
                csvWriter.append(String.valueOf(resultSet.getInt("TensileStrength"))).append(",");
                csvWriter.append(String.valueOf(resultSet.getFloat("NewspaperCellulose(kg)"))).append(",");
                csvWriter.append(resultSet.getString("BinderType")).append(",");
                csvWriter.append(String.valueOf(resultSet.getFloat("binder_amount(kg)"))).append(",");
                csvWriter.append(resultSet.getString("AntibacterialResistType")).append(",");
                csvWriter.append(String.valueOf(resultSet.getFloat("AntiBacterial(g)"))).append(",");
                csvWriter.append(resultSet.getString("AntifungalResistType(g)")).append(",");
                csvWriter.append(String.valueOf(resultSet.getFloat("FungalResist(g)"))).append(",");
                csvWriter.append(resultSet.getString("MoistureAgent")).append(",");
                csvWriter.append(String.valueOf(resultSet.getFloat("MoistureContent(g)"))).append(",");
                csvWriter.append(resultSet.getString("ThermalConductivityEnhancer")).append(",");
                csvWriter.append(String.valueOf(resultSet.getFloat("ThermalConductivityEnhancer_amount(kg)"))).append(",");
                csvWriter.append(resultSet.getString("image")).append(",");
                csvWriter.append(String.valueOf(resultSet.getFloat("CostPerUnit"))).append(",");
                csvWriter.append(String.valueOf(resultSet.getFloat("density"))).append("\n");

                csvWriter.flush();
            
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (resultSet != null) {
                try {
                    resultSet.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (preparedStatement != null) {
                try {
                    preparedStatement.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (csvWriter != null) {
                try {
                    csvWriter.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
