package org.aminesidki.ministore.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebFilter(urlPatterns = "/*" , filterName = "sessionFilter")
public class AuthFilter implements Filter {
    private final ArrayList<String> excluded = new ArrayList<>(List.of("/login" , "/login.jsp" , "/register" , "/index.jsp" , "Mini_Store_war_exploded/"));

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        Filter.super.init(filterConfig);
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {

        var request = (HttpServletRequest) servletRequest;
        try{
            if( request.getSession(false) != null &&
                    request.getSession(false).getAttribute("Authenticated") != null &&
                    (request.getSession(false).getAttribute("Authenticated").equals("true"))){
                filterChain.doFilter(servletRequest,servletResponse);
                return;
            }
        }catch(Exception e){
            //No session -> forward to login page.
            System.out.println("An issue happened");
            e.printStackTrace();
        }
        String uri = request.getRequestURI();
        for(String s : excluded){
            if(uri.endsWith(s)){
                filterChain.doFilter(servletRequest,servletResponse);
                return;
            }
        }
        throw new RuntimeException("Unauthenticated request !");
    }

    @Override
    public void destroy() {
        Filter.super.destroy();
    }
}
