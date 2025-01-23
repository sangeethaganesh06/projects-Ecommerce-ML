package riskHuskInsulation;

import java.io.*;
import java.util.Arrays;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.opencsv.CSVWriter;

@WebServlet("/addProduct")
public class ProductAddServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Get the form data
        String empID = request.getParameter("EmpID");
        String empName = request.getParameter("EmpName");
        String productID = request.getParameter("ProductID");
        String productName = request.getParameter("ProductName");
        String thickness = request.getParameter("Thickness");
        String description = request.getParameter("Description"); // Assuming you have this field in the HTML form
        String tensileStrength = request.getParameter("TensileStrength");
        String newspaperCellulose = request.getParameter("NewspaperCellulose");
        String binderType = request.getParameter("BinderType");
        String binderAmount = request.getParameter("BinderAmount");
        String antibacterialResistType = request.getParameter("AntibacterialResistType");
        String antiBacterial = request.getParameter("AntiBacterial");
        String antifungalResistType = request.getParameter("AntifungalResistType");
        String fungalResist = request.getParameter("FungalResist");
        String moistureAgent = request.getParameter("MoistureAgent");
        String moistureContent = request.getParameter("MoistureContent");
        String thermalConductivityEnhancer = request.getParameter("ThermalConductivityEnhancer");
        String thermalConductivityEnhancerAmount = request.getParameter("ThermalConductivityEnhancerAmount");
        String image = request.getParameter("Image"); // Assuming you have this field in the HTML form
        String costPerUnit = request.getParameter("CostPerUnit"); // Assuming you have this field in the HTML form
        String density = request.getParameter("Density"); // Assuming you have this field in the HTML form

        // File path for the existing CSV file
        String csvFilePath = "D:/project-1/riskHuskInsulation/CSV Files/NewProductCatalog.csv";
       
        // Prepare the new product data
        String[] newProductData = {
            productID, productName, thickness, description, tensileStrength,
            newspaperCellulose, binderType, binderAmount, antibacterialResistType, antiBacterial,
            antifungalResistType, fungalResist, moistureAgent, moistureContent,
            thermalConductivityEnhancer, thermalConductivityEnhancerAmount, image, costPerUnit, density
        };

        // Write the new product data to the existing CSV file
        try (CSVWriter writer = new CSVWriter(new FileWriter(csvFilePath, true))) {
            writer.writeNext(newProductData);
            writer.flush();
            out.print("<html><body><script>alert('Product Successfully added');</script></body></html>");
            RequestDispatcher dispatcher = request.getRequestDispatcher("resourceUpdate.html");

            dispatcher.include(request, response);
        } catch (IOException e) {
            e.printStackTrace(out);  // Print stack trace to the response
            out.println("Error writing to CSV file: " + e.getMessage());
        }
      
    }
}
