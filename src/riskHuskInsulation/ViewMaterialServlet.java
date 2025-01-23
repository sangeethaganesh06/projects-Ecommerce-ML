package riskHuskInsulation;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ViewMaterialServlet")
public class ViewMaterialServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String material = request.getParameter("material");
       
        if (material != null && !material.isEmpty()) {
            // Redirect to material_types.jsp with the selected material
            response.sendRedirect("material_types.jsp?material=" + material);
         
        } else {
            // Handle the case where no material was selected
            response.sendRedirect("durabilityTestResult.jsp"); // or show an error message
        }
    }
}
