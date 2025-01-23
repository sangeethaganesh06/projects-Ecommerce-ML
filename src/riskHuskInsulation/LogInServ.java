package riskHuskInsulation;

import java.io.IOException;
import java.io.PrintWriter;
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
import javax.servlet.http.HttpSession;

@WebServlet("/LogInServ")
public class LogInServ extends HttpServlet {
      protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
      
        String uname = request.getParameter("name");
        String pword = request.getParameter("password");
      
       	 PrintWriter out = response.getWriter();   
     //  	 String em = request.getParameter("email");
       //	 String pass = request.getParameter("password");
       	 String us = "admin";
       	 String pss = "adminpass";
       	
       	 if(uname.equalsIgnoreCase(us) && pword.equalsIgnoreCase(pss)) {
       		 out.print("<html><body><script>alert('Admin Login Successful');</script></body></html>");
       		 RequestDispatcher rs = request.getRequestDispatcher("adminPage.html");
       		 rs.include(request, response); 
       	 }else
       		{
       			out.print("<html><body><script>alert('Login Unsuccessful');</script></body></html>");
       			RequestDispatcher rs = request.getRequestDispatcher("AdminLogIn.html");
       			rs.include(request, response); 
       		}
       	}
      
      }


      