package org.aminesidki.ministore.utility;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import org.aminesidki.ministore.dao.ProductDao;
import org.aminesidki.ministore.dao.UserDao;

import java.sql.Connection;
import java.sql.SQLException;

@WebListener
public class StartupManager implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("Web application started!");

        //Initialize the db connection :
        ConnectionManager.initializeConnection();

        //Initialize DAOs
        try {
            Connection con = ConnectionManager.getConnection();

            DaoManager.productDao = new ProductDao(con);
            DaoManager.userDao = new UserDao(con, DaoManager.salt);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("Web application shut down!");
    }
}
