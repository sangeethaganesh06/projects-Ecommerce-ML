package riskHuskInsulation;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/Uplot")
@MultipartConfig
public class UploadProductServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Part filePart = request.getPart("file");
        String fileName = getFileName(filePart);

        // Assuming the file is saved in a specific directory
        File file = new File("C:/Users/soft/Desktop/project-1/riskHuskInsulation/WebContent/ricehuskinsulation.csv" + fileName);
        filePart.write(file.getAbsolutePath());

        try (BufferedReader br = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] values = line.split(",");
                saveToDatabase(values[0], Double.parseDouble(values[1]), values[2], values[3], values[4]);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("AdminProductUpload.html");
    }

    private String getFileName(Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }

    private void saveToDatabase(String name, double price, String imageUrl, String type, String details) {
        String jdbcURL = "jdbc:mysql://localhost:3306/ecommerce_db";
        String dbUser = "root";
        String dbPassword = "password";

        String sql = "INSERT INTO product_catalog (name, price, image_url, type, details) VALUES (?, ?, ?, ?, ?)";

        try (Connection connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, name);
            statement.setDouble(2, price);
            statement.setString(3, imageUrl);
            statement.setString(4, type);
            statement.setString(5, details);

            statement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
