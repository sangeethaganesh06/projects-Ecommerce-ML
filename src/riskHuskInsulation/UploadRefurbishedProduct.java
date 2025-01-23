package riskHuskInsulation;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.opencsv.CSVReader;

@WebServlet("/UploadRefurbishedProduct")
@MultipartConfig
public class UploadRefurbishedProduct extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Define the date formats
    private static final String DATE_FORMAT_INPUT = "dd-MM-yyyy";
    private static final String DATE_FORMAT_OUTPUT = "yyyy-MM-dd";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Part filePart = request.getPart("file");

        InputStream fileContent = null;
        CSVReader reader = null;
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            fileContent = filePart.getInputStream();
            reader = new CSVReader(new InputStreamReader(fileContent));

            Class.forName("com.mysql.jdbc.Driver"); // Updated for newer versions
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/ricehuskinsulation", "root", "root");

            // Assuming your CSV file has a header row that needs to be skipped
            reader.readNext(); // Skip header row
            String[] line;
            int lineNumber = 0;

            // Prepare SQL statement
            String sql = "INSERT INTO refurbishedinsulationpanels (ProductID, ProductName, RefurbishmentDate, OriginalManufactureDate, Refurbisher, Thickness, Density, ThermalConductivity, InspectionStatus, CleaningMethod, RepairDetails, PreTestThermalConductivity, PostTestThermalConductivity, PreTestDensity, PostTestDensity, PreTestMoistureContent, PostTestMoistureContent, WarrantyPeriod, PackagingType, Notes) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            preparedStatement = connection.prepareStatement(sql);

            // Date format converters
            SimpleDateFormat inputFormat = new SimpleDateFormat(DATE_FORMAT_INPUT);
            SimpleDateFormat outputFormat = new SimpleDateFormat(DATE_FORMAT_OUTPUT);

            while ((line = reader.readNext()) != null) {
                lineNumber++;
                try {
                    preparedStatement.setInt(1, Integer.parseInt(line[0].trim())); // ProductID
                    preparedStatement.setString(2, line[1].trim()); // ProductName

                    try {
                        Date refurbishmentDate = inputFormat.parse(line[2].trim());
                        String formattedRefurbishmentDate = outputFormat.format(refurbishmentDate);
                        preparedStatement.setDate(3, java.sql.Date.valueOf(formattedRefurbishmentDate));
                    } catch (ParseException e) {
                        System.out.println("Error parsing RefurbishmentDate: " + line[2].trim() + " - " + e.getMessage());
                        preparedStatement.setNull(3, java.sql.Types.DATE); // Set NULL if parsing fails
                    }

                    try {
                        Date originalManufactureDate = inputFormat.parse(line[3].trim());
                        String formattedOriginalManufactureDate = outputFormat.format(originalManufactureDate);
                        preparedStatement.setDate(4, java.sql.Date.valueOf(formattedOriginalManufactureDate));
                    } catch (ParseException e) {
                        System.out.println("Error parsing OriginalManufactureDate: " + line[3].trim() + " - " + e.getMessage());
                        preparedStatement.setNull(4, java.sql.Types.DATE); // Set NULL if parsing fails
                    }

                    preparedStatement.setString(5, line[4].trim()); // Refurbisher
                    preparedStatement.setString(6, line[5].trim()); // Thickness
                    preparedStatement.setString(7, line[6].trim()); // Density
                    preparedStatement.setString(8, line[7].trim()); // ThermalConductivity
                    preparedStatement.setString(9, line[8].trim()); // InspectionStatus
                    preparedStatement.setString(10, line[9].trim()); // CleaningMethod
                    preparedStatement.setString(11, line[10].trim()); // RepairDetails
                    preparedStatement.setString(12, line[11].trim()); // PreTestThermalConductivity
                    preparedStatement.setString(13, line[12].trim()); // PostTestThermalConductivity
                    preparedStatement.setString(14, line[13].trim()); // PreTestDensity
                    preparedStatement.setString(15, line[14].trim()); // PostTestDensity
                    preparedStatement.setString(16, line[15].trim()); // PreTestMoistureContent
                    preparedStatement.setString(17, line[16].trim()); // PostTestMoistureContent
                    preparedStatement.setString(18, line[17].trim()); // WarrantyPeriod
                    preparedStatement.setString(19, line[18].trim()); // PackagingType
                    preparedStatement.setString(20, line[19].trim()); // Notes

                    preparedStatement.addBatch();
                } catch (NumberFormatException e) {
                    System.err.println("Error parsing line " + lineNumber + " of CSV file: " + e.getMessage());
                    // Optionally, handle or log the error as needed
                }
            }

            // Execute batch insert
            preparedStatement.executeBatch();

            // Redirect to a success page or include a success message
            response.getWriter().print("<html><body><script>alert('Refurbished products updated successfully');</script></body></html>");

            RequestDispatcher rd = request.getRequestDispatcher("PerformanaceEfficiencyPage.jsp");
            rd.include(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().print("<html><body><script>alert('Refurbished products are not updated ');</script></body></html>");
            RequestDispatcher rd = request.getRequestDispatcher("PerformanaceEfficiencyPage.jsp");
            rd.include(request, response);
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
