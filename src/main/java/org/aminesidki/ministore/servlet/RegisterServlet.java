package org.aminesidki.ministore.servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.aminesidki.ministore.model.User;
import org.aminesidki.ministore.utility.DaoManager;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.HashMap;

@WebServlet(name = "register" , value = "/register")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("isInvalid" , "false");
        RequestDispatcher dispatcher = req.getRequestDispatcher("WEB-INF/views/auth/register.jsp");
        dispatcher.forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        BufferedReader reader = req.getReader();
        StringBuilder sb = new StringBuilder();

        while(reader.ready()){
            sb.append(reader.readLine());
        }

        var claims = sb.toString().split("&");
        var claimMap = new HashMap<String , String>();

        for(String s : claims){
            var claim = s.split("=");
            if(claim.length < 2){
                req.setAttribute("isInvalid" , "true");
                req.setAttribute("Reason" , "Required fields not filled !");
                RequestDispatcher dispatcher = req.getRequestDispatcher("WEB-INF/views/auth/register.jsp");

                dispatcher.forward(req,resp);
            }else{
                claimMap.put(claim[0] , claim[1]);
            }
        }

        if(!claimMap.get("password").equals(claimMap.get("confirmedPassword"))){
                req.setAttribute("isInvalid" , "true");
                req.setAttribute("Reason" , "Passwords mismatch !");

                RequestDispatcher dispatcher = req.getRequestDispatcher("WEB-INF/views/auth/register.jsp");
                dispatcher.forward(req,resp);
        }

        User newUser = new User(null,
                                    claimMap.get("username") ,
                                    claimMap.get("email") , claimMap.get("password") ,
                                    null);

        if(DaoManager.userDao.save(newUser) == null){
            req.setAttribute("isInvalid" , "true");
            req.setAttribute("Reason" , "Email or Username is already in use !");

            RequestDispatcher dispatcher = req.getRequestDispatcher("WEB-INF/views/auth/register.jsp");
            dispatcher.forward(req , resp);
        }
        req.getSession(true);
        resp.sendRedirect("hello-servlet");
    }
}
