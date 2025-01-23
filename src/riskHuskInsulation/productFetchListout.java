package riskHuskInsulation;


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/productFetchListout")
public class productFetchListout extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/ricehuskinsulation", "root", "root");
            String sql = "SELECT * FROM product_catalog";
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();

            out.println("<!DOCTYPE html>");
            out.println("<html lang=\"en\">");
            out.println("<head>");
            out.println("<meta charset=\"UTF-8\">");
            out.println("<title>Product List</title>");
            out.println("<link rel=\"stylesheet\" type=\"text/css\" href=\"styles.css\">"); // Link your CSS file here
            out.println("</head>");
            out.println("<body>");
            out.println("<header>");
            out.println("<h1>Product List</h1>");
            out.println("<nav>");
            out.println("<a href=\"product-list.html\">Home</a>");
            out.println("<a href=\"cart.html\">Cart</a>");
            out.println("<a href=\"orders.html\">Orders</a>");
            out.println("<a href=\"wishlist.html\">Wishlist</a>");
            out.println("</nav>");
            out.println("</header>");
            out.println("<main class=\"products\">");
            out.println("<div class=\"card\">");

            while (resultSet.next()) {
                String productId = resultSet.getString("ProductID");
                String productName = resultSet.getString("ProductName");
                String category = resultSet.getString("Category");
                String description = resultSet.getString("Description");
                float tensileStrength = resultSet.getFloat("TensileStrength");
                // Add more fields as necessary

                // Generate HTML for each product
                out.println("<div class=\"contenitore\">");
                out.println("<img src=\"product_images/" + productId + ".jpg\" alt=\"" + productName + "\">"); // Assuming images are stored with product IDs
                out.println("<h2 class=\"album\">" + productName + "</h2>");
                out.println("<h3 class=\"band-name\">" + category + "</h3>");
                out.println("<p class=\"details\">" + description + "</p>");
                out.println("<p class=\"prezzo\">$" + tensileStrength + "</p>"); // Example price field
                out.println("<a href=\"add-to-cart?productId=" + productId + "\" class=\"link\">🛒</a>"); // Example add to cart link
                out.println("</div>");
            }

            out.println("</div>"); // Close the card div
            out.println("</main>");
            out.println("</body>");
            out.println("</html>");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            try { if (resultSet != null) resultSet.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (preparedStatement != null) preparedStatement.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (connection != null) connection.close(); } catch (SQLException e) { e.printStackTrace(); }
            out.close();
        }
    }
}
