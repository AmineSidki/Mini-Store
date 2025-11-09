package org.aminesidki.ministore.servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.aminesidki.ministore.model.User;
import org.aminesidki.ministore.utility.DaoManager;
import org.mindrot.jbcrypt.BCrypt;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.HashMap;

@WebServlet(name= "login" , value = "/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("isInvalid" , "false");
        RequestDispatcher dispatcher = req.getRequestDispatcher("WEB-INF/views/auth/login.jsp");
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
                RequestDispatcher dispatcher = req.getRequestDispatcher("WEB-INF/views/auth/login.jsp");

                dispatcher.forward(req,resp);
            }else{
                claimMap.put(claim[0] , claim[1]);
            }
        }

        User user = DaoManager.userDao.getByUsername(claimMap.get("username"));
        if(user == null){
            req.setAttribute("isInvalid" , "true");
            req.setAttribute("Reason" , "Bad credentials !");
            RequestDispatcher dispatcher = req.getRequestDispatcher("WEB-INF/views/auth/login.jsp");

            dispatcher.forward(req , resp);
            return;
        }
        if(BCrypt.checkpw(claimMap.get("password"),user.getPasswordHash())){
            req.getSession(true);
        }else{
            req.setAttribute("isInvalid" , "true");
            req.setAttribute("Reason" , "Bad credentials !");
            RequestDispatcher dispatcher = req.getRequestDispatcher("WEB-INF/views/auth/login.jsp");

            dispatcher.forward(req , resp);
        }
    }
}
