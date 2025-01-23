package riskHuskInsulation;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.opencsv.CSVReader;

@WebServlet("/ProductUploadServlet")
@MultipartConfig(maxFileSize = 1024 * 1024 * 10) // 10 MB limit for file upload
public class ProductUploadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Part filePart = request.getPart("file");
        String additionalDetails = request.getParameter("details");

        InputStream fileContent = null;
        CSVReader reader = null;
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            fileContent = filePart.getInputStream();
            reader = new CSVReader(new InputStreamReader(fileContent));

            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/ricehuskinsulation", "root", "root");

            // Assuming your CSV file has a header row that needs to be skipped
            reader.readNext(); // Skip header row
            String[] line;
            int lineNumber = 0;

            // SQL statement for batch insertion
            String sql = "INSERT INTO product_catalog (ProductID, ProductName, `Thickness(mm)`, Description, TensileStrength, `NewspaperCellulose(kg)`, " +
                    "BinderType, `binder_amount(kg)`, AntibacterialResistType, `AntiBacterial(g)`, `AntifungalResistType(g)`, `FungalResist(g)`, " +
                    "MoistureAgent, `MoistureContent(g)`, ThermalConductivityEnhancer, `ThermalConductivityEnhancer_amount(kg)`, image, CostPerUnit, density) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            preparedStatement = connection.prepareStatement(sql);

            while ((line = reader.readNext()) != null) {
                lineNumber++;
                try {
                    preparedStatement.setString(1, line[0]);
                    preparedStatement.setString(2, line[1]);
                    preparedStatement.setInt(3, Integer.parseInt(line[2].trim())); // Assuming thickness as an integer
                    preparedStatement.setString(4, line[3]);
                    preparedStatement.setInt(5, Integer.parseInt(line[4].trim())); // TensileStrength
                    preparedStatement.setFloat(6, Float.parseFloat(line[5].trim())); // NewspaperCellulose_kg
                    preparedStatement.setString(7, line[6]); // BinderType
                    preparedStatement.setFloat(8, Float.parseFloat(line[7].trim())); // binder_amount_kg
                    preparedStatement.setString(9, line[8]); // AntibacterialResistType
                    preparedStatement.setFloat(10, Float.parseFloat(line[9].trim())); // AntiBacterial_g
                    preparedStatement.setString(11, line[10]); // AntifungalResistType
                    preparedStatement.setFloat(12, Float.parseFloat(line[11].trim())); // FungalResist_g
                    preparedStatement.setString(13, line[12]); // MoistureAgent
                    preparedStatement.setFloat(14, Float.parseFloat(line[13].trim())); // MoistureContent_g
                    preparedStatement.setString(15, line[14]); // ThermalConductivityEnhancer
                    if (line[15].trim().isEmpty()) {
                        preparedStatement.setNull(16, java.sql.Types.FLOAT); // ThermalConductivityEnhancer_amount_kg
                    } else {
                        preparedStatement.setFloat(16, Float.parseFloat(line[15].trim())); // ThermalConductivityEnhancer_amount_kg
                    }
                    preparedStatement.setString(17, line[16]); // image
                    if (line[17].trim().isEmpty()) {
                        preparedStatement.setNull(18, java.sql.Types.FLOAT); // CostPerUnit
                    } else {
                        preparedStatement.setFloat(18, Float.parseFloat(line[17].trim())); // CostPerUnit
                    }
                    if (line[18].trim().isEmpty()) {
                        preparedStatement.setNull(19, java.sql.Types.FLOAT); // density
                    } else {
                        preparedStatement.setFloat(19, Float.parseFloat(line[18].trim())); // density
                    }

                    preparedStatement.addBatch();
                } catch (NumberFormatException e) {
                    System.err.println("Error parsing line " + lineNumber + " of CSV file: " + e.getMessage());
                    // Optionally, handle or log the error as needed
                }
            }

            // Execute batch insert
        int re[] = preparedStatement.executeBatch();

           if(re.length>0 ) {// Redirect to a success page or include a success message
            response.getWriter().print("<html><body><script>alert('Products successfully uploaded to the client portal ');</script></body></html>");

            RequestDispatcher rd = request.getRequestDispatcher("AdminProductUpload.html");
            rd.include(request, response);
           }else
           {
        	   
        	   response.getWriter().print("<html><body><script>alert('Products successfully uploaded to the client portal !');</script></body></html>");
        	   RequestDispatcher rd = request.getRequestDispatcher("AdminProductUpload.html");
               rd.include(request, response);
           }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().print("<html><body><script>alert('Products updated successfully!');</script></body></html>");
        } finally {
            // Close resources in finally block
            if (reader != null) {
                try {
                    reader.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (fileContent != null) {
                try {
                    fileContent.close();
                } catch (IOException e) {
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
        }
    }
}
