package riskHuskInsulation;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import com.opencsv.CSVReader;

@WebServlet("/MaterialRequirementUpload")
@MultipartConfig(maxFileSize = 1024 * 1024 * 10)
public class MaterialRequirementUpload extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Part filePart = request.getPart("file");
        InputStream fileContent = null;
        CSVReader reader = null;
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            fileContent = filePart.getInputStream();
            reader = new CSVReader(new InputStreamReader(fileContent));

            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/ricehuskinsulation", "root", "root");

            // Prepare SQL statements
            String insertSQL = "INSERT INTO material_requirement (ProductID, Type_of_Material, Material, Amount_per_sqft) VALUES (?, ?, ?, ?)";
            preparedStatement = connection.prepareStatement(insertSQL);

            // Assuming your CSV file has a header row that needs to be skipped
            reader.readNext(); // Skip header row
            String[] line;
            int lineNumber = 0;

            while ((line = reader.readNext()) != null) {
                lineNumber++;

                try {
                    int productID = Integer.parseInt(line[0]);
                    String typeOfMaterial = line[1];
                    String material = line[2];
                    float amountPerSqft = Float.parseFloat(line[3]);

                    // Check if the product already exists in product_catalog
                    String checkSQL = "SELECT COUNT(*) FROM product_catalog WHERE ProductID = ?";
                    try (PreparedStatement checkStmt = connection.prepareStatement(checkSQL)) {
                        checkStmt.setInt(1, productID);
                        ResultSet rs = checkStmt.executeQuery();
                        rs.next();
                        int count = rs.getInt(1);

                        if (count > 0) {
                            // Update existing record in material_requirement
                            String updateSQL = "UPDATE material_requirement SET Type_of_Material = ?, Material = ?, Amount_per_sqft = ? WHERE ProductID = ?";
                            try (PreparedStatement updateStmt = connection.prepareStatement(updateSQL)) {
                                updateStmt.setString(1, typeOfMaterial);
                                updateStmt.setString(2, material);
                                updateStmt.setFloat(3, amountPerSqft);
                                updateStmt.setInt(4, productID);
                                updateStmt.executeUpdate();
                            }
                        } else {
                            // Insert new record into material_requirement
                            preparedStatement.setInt(1, productID);
                            preparedStatement.setString(2, typeOfMaterial);
                            preparedStatement.setString(3, material);
                            preparedStatement.setFloat(4, amountPerSqft);
                            preparedStatement.addBatch();
                        }
                    }
                } catch (NumberFormatException e) {
                    System.err.println("Error parsing line " + lineNumber + " of CSV file: " + e.getMessage());
                    // Optionally, handle or log the error as needed
                }
            }

            // Execute batch insert for new records
            preparedStatement.executeBatch();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close resources in finally block
            if (reader != null) {
                try { reader.close(); } catch (IOException e) { e.printStackTrace(); }
            }
            if (fileContent != null) {
                try { fileContent.close(); } catch (IOException e) { e.printStackTrace(); }
            }
            if (preparedStatement != null) {
                try { preparedStatement.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            if (connection != null) {
                try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }

        // Provide feedback to the user
        response.getWriter().print("<html><body><script>alert('Stack material updated successfully');</script></body></html>");

        // Redirect to a page after processing (e.g., Resource Analyst page)
        RequestDispatcher rd = request.getRequestDispatcher("ResourceAnalystPage.html");
        rd.include(request, response);
    }
}
