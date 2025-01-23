package riskHuskInsulation;


import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productId = request.getParameter("productId");
        String productName = request.getParameter("productName");
        float costPerUnit = Float.parseFloat(request.getParameter("costPerUnit"));
        String userId = (String) request.getAttribute("userId");
        HttpSession session1 = request.getSession();
       request.setAttribute("userId", userId);
        // Create a product object
        Product product = new Product(productId, productName, costPerUnit);

        HttpSession session = request.getSession();
        List<Product> cart = (List<Product>) session.getAttribute("cart");
       
        if (cart == null) {
            cart = new ArrayList<>();
        }
        cart.add(product);

        session.setAttribute("cart", cart);
        response.sendRedirect("product-list.jsp");
    }
}
