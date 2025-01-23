package riskHuskInsulation;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.google.gson.Gson;

@WebServlet("/RemoveProductServlet")
public class RemoveProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productId = request.getParameter("productId");
        HttpSession session = request.getSession();
        List<Product> cart = (List<Product>) session.getAttribute("cart");

        if (cart != null) {
            // Remove the product from the cart
            cart.removeIf(product -> product.getProductId().equals(productId));
            
            // Recalculate total cost
            double totalCost = 0.0;
            for (Product product : cart) {
                totalCost += product.getCostPerUnit();
            }

            // Update the session attribute
            session.setAttribute("cart", cart);

            // Send the response back to the client
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(new Gson().toJson(new Response(true, totalCost)));
        } else {
            // Send failure response if the cart is null
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(new Gson().toJson(new Response(false, 0.0)));
        }
    }

    private class Response {
        boolean success;
        double totalCost;

        Response(boolean success, double totalCost) {
            this.success = success;
            this.totalCost = totalCost;
        }
    }
}
