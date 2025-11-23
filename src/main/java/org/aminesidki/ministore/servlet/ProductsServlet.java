package org.aminesidki.ministore.servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.aminesidki.ministore.model.Product;
import org.aminesidki.ministore.utility.DaoManager;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;

@WebServlet(name = "products" , value = "/products/*")
public class ProductsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();

        if(path == null){
            var prodList = DaoManager.productDao.getAll();

            req.setAttribute("products" , prodList);
            RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/product/list.jsp");
            dispatcher.forward(req , resp);
            return;
        }

        switch(path){
            case "/new":
                returnForm(req , resp , Boolean.TRUE);
                return;
            case "/edit":
                returnForm(req , resp , Boolean.FALSE);
                return;
            default:
                resp.sendRedirect(req.getContextPath()+"/products");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();

        if(path == null){
            createNewProd(req , resp);
            return;
        }

        switch(path){
            case "/delete":
                deleteProd(req , resp);
                return;
            default:
                resp.sendRedirect(req.getContextPath() + "/products");
        }
    }

    private void createNewProd(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Product p = new Product(-1L,
                req.getParameter("name"),
                Float.parseFloat(req.getParameter("price")),
                req.getParameter("description"),
                Timestamp.valueOf(LocalDateTime.MIN));

        if (DaoManager.productDao.save(p) == null) {
            resp.sendRedirect("");
            return;
        }
        resp.sendRedirect(req.getContextPath()+"/products");
    }

    private void deleteProd(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Long id = Long.parseLong(req.getParameter("id"));
        DaoManager.productDao.delete(id);
        resp.sendRedirect(req.getContextPath() + "/products");
    }

    private void returnForm(HttpServletRequest req , HttpServletResponse resp , Boolean isNew) throws ServletException, IOException {
        req.setAttribute("isNew" , isNew);

        RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/product/form.jsp");
        dispatcher.forward(req , resp);
    }
}
